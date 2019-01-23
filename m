Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B03C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1D8218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 18:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QY1mE+9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfAWSZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 13:25:51 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41305 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbfAWSZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 13:25:50 -0500
Received: by mail-pg1-f194.google.com with SMTP id m1so1430300pgq.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 10:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bb8meiKX5UXwfPsIYWEkYs0yO3FDiFHyANgVbs990ww=;
        b=QY1mE+9+b1mCNCD9b+247xj3qBpAhD43W1bw+JIabtY9bUOgnwZI+Tg5wY/m85XpPR
         3KmKAbmhm2In9V9WnozM8mxvFWD+9mslGK5ejcA2lWA+cF92FURB8PqIoUPUIf2SpJN4
         n5cV0myv1V4MUsM113hLBkYO3LICHsC0t16rVTi4vzVexFRp100UUN3jyoGa/0atHrOM
         ZpbVjr23pWx/pb2txXfcn44nde/fDfJFYqNRYcNwpTxPaK0MwE0HJ9ziizEBu92bNWrc
         G7QHfzOrOv+YsW3p3T8Q3j+kxn1Cm4paDDdxJk+qEb66RSKDvA/juYvh4XNgPb8wWKVQ
         oU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bb8meiKX5UXwfPsIYWEkYs0yO3FDiFHyANgVbs990ww=;
        b=On/0Qb+1Jaa7RbhDSShHrsmP27hZTOtVgzMTK4rpVzgQDPhMM9Wi785RagQGEYRrdL
         okIrWiGkZqlkFCHpCYkPe2x337jAy1Jf/4juokGlcdWliEq0IFNRWKEf5Wah/UbyidNX
         pFd36MUXt/R3idcCKXtwYDiWQAv1aCfLA7UYL2baI6kaukzecUXn9mMUcMmKi7R3QD9y
         br8C5R2B78mGa2XPuWDUdQdNfCsYKcdcJ7GkLXcRsNlzLXaXF81krkwkEQ36rO3wH0fc
         GfqhI4LeWDmS80r31dTCE5He5iJoqmqJpjkvFQqdnutJsxsnhQ1wiQ86+65UnU9w5QN1
         Rf8Q==
X-Gm-Message-State: AJcUukeYkfe0L1It5ncd9nR6eJjDYZCrOJMis6JaEl6Y//C/y7rR/Xuz
        RCY4+Hd9o+TjsdFhIJuqcdwLgQ==
X-Google-Smtp-Source: ALg8bN6Jm4ZIubHzEJTEqz7TcVV/X/Q0aGgk2CflsYk/5xn0/BPXft2ouu7aedG5jsYFVUmMhp5AYQ==
X-Received: by 2002:a63:fc05:: with SMTP id j5mr3014517pgi.434.1548267949323;
        Wed, 23 Jan 2019 10:25:49 -0800 (PST)
Received: from google.com ([2620:15c:17:4:f0b1:8ff5:16a0:5f15])
        by smtp.gmail.com with ESMTPSA id h185sm28003115pfg.143.2019.01.23.10.25.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 10:25:48 -0800 (PST)
Date:   Wed, 23 Jan 2019 10:25:40 -0800
From:   Tom Roeder <tmroeder@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+ded1696f6b50b615b630@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH] kvm: x86/vmx: Use kzalloc for cached_vmcs12
Message-ID: <20190123182540.GA160275@google.com>
References: <6f79d9be-fa76-3a06-2612-f44f3a18ece7@redhat.com>
 <20190114234728.49239-1-tmroeder@google.com>
 <20190115024304.GD5141@linux.intel.com>
 <2177074d-f610-0d86-7399-e63ba851346c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2177074d-f610-0d86-7399-e63ba851346c@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 11:15:51AM +0100, Paolo Bonzini wrote:
> On 15/01/19 03:43, Sean Christopherson wrote:
> >> -	vmx->nested.cached_vmcs12 = kmalloc(VMCS12_SIZE, GFP_KERNEL);
> >> +	vmx->nested.cached_vmcs12 = kzalloc(VMCS12_SIZE, GFP_KERNEL);
> >>  	if (!vmx->nested.cached_vmcs12)
> >>  		goto out_cached_vmcs12;
> > Obviously not your code, but why do we allocate VMCS12_SIZE instead of
> > sizeof(struct vmcs12)?  I get why we require userspace to reserve the
> > full 4k, but I don't understand why KVM needs to allocate the reserved
> > bytes internally.
> 
> It's just cleaner and shorter code to copy everything in and out,
> instead of having to explicitly zero the slack.

Could you please clarify? I don't see code that copies everything in and
out, but it depends on what you mean by "everything". In the context of
this email exchange, I assumed that "everything" was "all 4k
(VMCS12_SIZE)".

But it looks to me like the code doesn't copy 4k in and out, but rather
only ever copies sizeof(struct vmcs12) in and out. The copy_from_user
and copy_to_user cases in nested.c use sizeof(*vmcs12), which is
sizeof(struct vmcs12).

So maybe can switch to allocating sizeof(struct vmcs12). Is this
correct, or is there some other reason to allocate the larger size?
