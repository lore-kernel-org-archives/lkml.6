Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1544FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E575F21773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfBRTQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:16:54 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44402 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbfBRTQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:16:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id r21so10596266qkl.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 11:16:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sbcG1BDuWi1Ss3pG7QOT/FVWLP6SwaeDik62YJgOYLQ=;
        b=G7Azln4pmw4y6Y6I6bTJB7e1iQpBUHwPIlwUY3aInWF1BJPUQJOuxuWQOxfdIvFVFL
         ZtgMu223czvKB0y/G7/weI3Q0R9taS999tfpIPQ00StJIEloYDIXFj1PoOGHcYp9oOrL
         alTx+ujzKKScVVcSZXLTCJjBFpjBoka8CgL+SmyDuiPZoikM08fdwY2BswpqNXE7oMPC
         GoxvTX7EAjWo0HBxexu04zMTePgn8As1JsrhBMuYdrTkwPa8tLVh32I4aJZRyZRwiB6A
         HLNAO5dexpCrxohyqmk662WkEaWstxbjx6xK8w68QegGlGfZdSKam5QRfD3OmD+crfrX
         DqKw==
X-Gm-Message-State: AHQUAuZqj9bClVPWZjjQ8Zj5KGbcw0Gh9onx8t8Wexzw50rmjYbyoYAo
        jvjHaG2YrgJeTyw9b3Bu73hDrA==
X-Google-Smtp-Source: AHgI3IYIWzZAcM9RP9F39THpg34fbdQLguqdRZ0rro2GPMfTcszbKgCAonjyGm/qXJkZso5oVd8VmQ==
X-Received: by 2002:a37:4c0f:: with SMTP id z15mr17997220qka.180.1550517412544;
        Mon, 18 Feb 2019 11:16:52 -0800 (PST)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net. [173.76.246.42])
        by smtp.gmail.com with ESMTPSA id j66sm4809388qkj.27.2019.02.18.11.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:16:51 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:16:49 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com,
        yang.zhang.wz@gmail.com, riel@surriel.com, dodgen@google.com,
        konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC][Patch v8 0/7] KVM: Guest Free Page Hinting
Message-ID: <20190218140947-mutt-send-email-mst@kernel.org>
References: <20190204201854.2328-1-nitesh@redhat.com>
 <af4430fd-0a2c-8f35-b767-3f93fc6db270@redhat.com>
 <20190218114601-mutt-send-email-mst@kernel.org>
 <44740a29-bb14-e6e6-2992-98d0ae58e994@redhat.com>
 <20190218122636-mutt-send-email-mst@kernel.org>
 <f396836d-9bbd-e3e2-c7b0-d921bf1c9ed1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f396836d-9bbd-e3e2-c7b0-d921bf1c9ed1@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 07:29:44PM +0100, David Hildenbrand wrote:
> > 
> >>>
> >>> But really what business has something that is supposedly
> >>> an optimization blocking a VCPU? We are just freeing up
> >>> lots of memory why is it a good idea to slow that
> >>> process down?
> >>
> >> I first want to know that it is a problem before we declare it a
> >> problem. I provided an example (s390x) where it does not seem to be a
> >> problem. One hypercall ~every 512 frees. As simple as it can get.
> >>
> >> No trying to deny that it could be a problem on x86, but then I assume
> >> it is only a problem in specific setups.
> > 
> > But which setups? How are we going to identify them?
> 
> I guess is simple (I should be carefuly with this word ;) ): As long as
> you don't isolate + pin your CPUs in the hypervisor, you can expect any
> kind of sudden hickups. We're in a virtualized world. Real time is one
> example.
> 
> Using kernel threads like Nitesh does right now? It can be scheduled
> anytime by the hypervisor on the exact same cpu. Unless you isolate +
> pin in the hypervor. So the same problem applies.

Right but we know how to handle this. Many deployments already use tools
to detect host threads kicking VCPUs out.
Getting VCPU blocked by a kfree call would be something new.


...

> > So I'm fine with a simple implementation but the interface needs to
> > allow the hypervisor to process hints in parallel while guest is
> > running.  We can then fix any issues on hypervisor without breaking
> > guests.
> 
> Yes, I am fine with defining an interface that theoretically let's us
> change the implementation in the guest later.
> I consider this even a
> prerequisite. IMHO the interface shouldn't be different, it will be
> exactly the same.
> 
> It is just "who" calls the batch freeing and waits for it. And as I
> outlined here, doing it without additional threads at least avoids us
> for now having to think about dynamic data structures and that we can
> sometimes not report "because the thread is still busy reporting or
> wasn't scheduled yet".

Sorry I wasn't clear. I think we need ability to change the
implementation in the *host* later. IOW don't rely on
host being synchronous.


-- 
MST
