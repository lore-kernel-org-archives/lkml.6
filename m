Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED136C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2EDF2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="qCH/a4pL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2EDF2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbeKAGQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:16:00 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37195 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbeKAGQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:16:00 -0400
Received: by mail-ot1-f68.google.com with SMTP id o14so15951988oth.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 14:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jSG1Sq3A1EgvEmarNp8EWlQlPJ4cA9BSdkxAmrib9UY=;
        b=qCH/a4pL78K+KNeKMviB91GHvMb2yvfyfnzwD7+SEpSFqXpJT+XuU9ZAkZdDi71yn+
         blNTnBXpjOoiqFactuaxe+Si/wNk558aFD2KFZ6dyVcZPqIh2tDOmi6LOakGcUEvKcif
         KpbBzLVamPuiJk23k2/cZyt/jBrv6dHelXITQ9PrvCApV4mDiyugmr7Rrx9mrsz6+bmh
         XPOECbprQCSuSLEkoTUQeRzkSU8qILPxKuLFY5mweI7RhX+PaoEFNhv5abTQb8f9KxqV
         jw4Ix2i+69HtMj5mNzgVxUCA9gb+KztBjKSMexefuVPhcYrSXsCtP49y0X19wAKQqbmq
         resQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jSG1Sq3A1EgvEmarNp8EWlQlPJ4cA9BSdkxAmrib9UY=;
        b=gORj0FFHItrekRvVds4hrgOQDZF/6xdZ9eXFHSOlCoW3jXt8CsE7GQX9rUb/GTlYxI
         wIA7DakTcultrzAlIt2xgitBWW0AqEGKq6IZpR2UDeYVvWQrSYyqPoofDQoWXorLUAOo
         eXe280RaZBOtVlWpSmfQJxNnRRGQWQQ7hhlZ3I9bYPGTNVlo64hQZBRfEoxWO1D2Oqqt
         l9xqXiq4iviJG1wOktYZ53LskuDl8Tmb2ggpe6W20VaFmu9fiklLmGFkR0yL8uleiZ8O
         WqzxDUAUCnq92wAMDSKH0zAp0WJpqnAhO0uDa+g6CCww7tw/LoP9i5o9dPJ89xsPoD6H
         CyzQ==
X-Gm-Message-State: AGRZ1gK842V/uX6AqGw/NTv4lOq43lZ1aizQKAgSwTbeRWn9QOcC9mAW
        PLgVA73BIF5hU7lRn3TLpa7k+0yXOv1ZQsig1JY5rQ==
X-Google-Smtp-Source: AJdET5fh7LtbyAgne/mS+gK4QuqpUoBkKZQAeuOqv3+ZASsDVOH+TPIoPTwp4LmOjkcNSsJsmZkOBU8nEVkZffTC4HY=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr2549329oti.367.1541020572722;
 Wed, 31 Oct 2018 14:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181029210716.212159-1-brho@google.com> <CAPcyv4gJUjuSKwy7i2wuKR=Vz-AkDrxnGya5qkg7XTFxuXbtzw@mail.gmail.com>
 <e00c5f69-f4d7-859c-cbde-0392b0a5195c@redhat.com>
In-Reply-To: <e00c5f69-f4d7-859c-cbde-0392b0a5195c@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 31 Oct 2018 14:16:01 -0700
Message-ID: <CAPcyv4hqOhCBvYjxY31kc+BD+MraCBtou=MogApp_5wpz3W6Cw@mail.gmail.com>
Subject: Re: [RFC PATCH] kvm: Use huge pages for DAX-backed files
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Barret Rhoden <brho@google.com>, Dave Jiang <dave.jiang@intel.com>,
        zwisler@kernel.org, Vishal L Verma <vishal.l.verma@intel.com>,
        rkrcmar@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 1:52 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 29/10/2018 23:25, Dan Williams wrote:
> > I'm wondering if we're adding an explicit is_zone_device_page() check
> > in this path to determine the page mapping size if that can be a
> > replacement for the kvm_is_reserved_pfn() check. In other words, the
> > goal of fixing up PageReserved() was to preclude the need for DAX-page
> > special casing in KVM, but if we already need add some special casing
> > for page size determination, might as well bypass the
> > kvm_is_reserved_pfn() dependency as well.
>
> No, please don't.  The kvm_is_reserved_pfn() check is for correctness,
> the page-size check is for optimization.  In theory you could have a
> ZONE_DEVICE area that is smaller than 2MB and thus does not use huge pages.

To be clear, I was not suggesting that a ZONE_DEVICE check would be
sufficient to determine a 2MB page. I was suggesting that given there
is a debate about removing the "reserved" designation for dax pages
that debate is moot if kvm is going to add interrogation code to
figure out the size of dax mappings.
