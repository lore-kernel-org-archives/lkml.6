Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4299DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87CB21527
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="gFUMLDxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D87CB21527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeI0Daj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 23:30:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51272 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbeI0Dai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 23:30:38 -0400
Received: by mail-wm1-f67.google.com with SMTP id y25-v6so3722615wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vB9H8DI5c82WYVgZLb6GEiLg+wrZiqn30NWEudnbjPs=;
        b=gFUMLDxSv5gRT88t1k2giXCLrJrkciyzX0JSeL5QRR2staTRXhAp2fnX41vxXoHhIJ
         xGhVbr14nRq7ETNuAdPZwsOupiRO2c6VP/zUSFkP61Z1A3waX0ftt3UL71pumwoWNaeT
         Ylyi4lJcRNfIjvlDuVOACwK0bS2Pd5qjhZGT3aC70ETpZt+aweRSHEWDbn6R3soX8eQy
         v6ZQaOWYmMzyn1xleNDd141BA4a5uY80tCkOceDeAsQXbglkl2VRD3Kzht8TJIMXu+Hi
         r/Eoiu8B/XfhdpPKaQjwdtwQE3YDAisIn/ixCzWM4+aQVMuVhWwd+OTjM80hxDFVGvvH
         WtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vB9H8DI5c82WYVgZLb6GEiLg+wrZiqn30NWEudnbjPs=;
        b=CqfgnRSlk8ON0WRr1f4vF2d2Kftrh+odgc6qNPiV5IPtP7F5vn+6YjOU68h0djh74+
         UopubAxgTysUmb4u+BFJAe6Xnba/tmDv40KRgKaWcWVZNlKKWt0jb6a4LxxpXRe/Hsvf
         WV8Dxy5WBmjt1aYEZ2ICzb8vfRbpBseQOp+iF9MDW7QULLCrwAkkMUhHJgJPw7gMtAa3
         krXOLlbTO7ysBfz1ORpPSsBkmYBNq2nsNe/7xLopRGrTs/vQQvdOuTBNcQne9WmOFdAI
         gQAq8i7FSVCIwLWsdla9lAY4yo1pK7QQbvN52srTLMHp+euMP4u6plrtcEpoqIUyPXKC
         YA2Q==
X-Gm-Message-State: ABuFfogv3kn+BGVVdIScTSrFYaNC60n8h4DobMXbzqcJqFezYCBYoYde
        33D3Lhk7aLKmxHsDNkcaJ+T0ZETkpYcuI8PzXQIHVA==
X-Google-Smtp-Source: ACcGV60nknvhhQqCvhrTSVRNdELIsZHKbZjTT96WWM1gR/5zZgG5chqSumUnz6HfwgXD3AV4sFvtgRw4pbno4hGW3jQ=
X-Received: by 2002:a1c:9ad2:: with SMTP id c201-v6mr5578309wme.14.1537996545401;
 Wed, 26 Sep 2018 14:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com>
 <20180925130845.9962-10-jarkko.sakkinen@linux.intel.com> <CALCETrVAhiwv+g5fzVO3ZSHZgcQKbeeG8r3HUcXO9k7Gi94NdQ@mail.gmail.com>
 <20180926173516.GA10920@linux.intel.com> <2D60780F-ADB4-48A4-AB74-15683493D369@amacapital.net>
 <9835e288-ba98-2f9e-ac73-504db9512bb9@intel.com> <20180926204400.GA11446@linux.intel.com>
 <b7e14c6e-fc05-93fa-eef9-5e3f06ab4729@intel.com>
In-Reply-To: <b7e14c6e-fc05-93fa-eef9-5e3f06ab4729@intel.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 26 Sep 2018 14:15:31 -0700
Message-ID: <CALCETrXByb2UVuZ6AXUeOd8y90NAikbZuvdN3wf_TjHZ+CxNhA@mail.gmail.com>
Subject: Re: [PATCH v14 09/19] x86/mm: x86/sgx: Signal SEGV_SGXERR for #PFs w/ PF_SGX
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        nhorman@redhat.com, npmccallum@redhat.com,
        "Ayoun, Serge" <serge.ayoun@intel.com>, shay.katz-zamir@intel.com,
        linux-sgx@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 1:55 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 09/26/2018 01:44 PM, Sean Christopherson wrote:
> > On Wed, Sep 26, 2018 at 01:16:59PM -0700, Dave Hansen wrote:
> >> We also need to clarify how this can happen.  Is it through something
> >> than an app does, or is it solely when the hardware does something under
> >> the covers, like suspend/resume.
> >
> > Are you looking for something in the changelog, the comment, or just
> > a response?  If it's the latter...
>
> Comments, please.
>
> > On bare metal with a bug-free kernel, the only scenario I'm aware of
> > where we'll encounter these faults is when hardware pulls the rug out
> > from under us.  In a virtualized environment all bets are off because
> > the architecture allows VMMs to silently "destroy" the EPC at will,
> > e.g. KVM, and I believe Hyper-V, will take advantage of this behavior
> > to support live migration.  Post migration, the destination system
> > will generate PF_SGX because the EPC{M} can't be migrated between
> > system, i.e. the destination EPCM sees all EPC pages as invalid.
>
> OK, cool.
>
> That's good background fodder for the changelog.
>
> But, for the comment, I'm happy with something like this:
>
>         /*
>          * The fault resulted from violation of SGX-specific access-
>          * controls.  This is expected to be the result of some lower
>          * layer action (CPU suspend/resume, VM migration) and is
>          * not related to anything the OS did.  Treat it as an access
>          * error to ensure it is passed up to the app via a signal where
>          * it can be handled.
>          */
>
> I really don't think we need to delve too deeply into the relationship
> between EPCM and PTEs or anything.  Let's just say, "it's not the
> kernel's fault, it's not the app's fault, so throw up our hands".

There is a non-nitpicky consideration here.  Logically, user code is
going to do this (totally made-up pseudocode):

enclave_t enclave = load_and_init_enclave(...);
int ret = sgx_run(enclave, some pointers to non-enclave-memory buffers, ...);

and, with the code in this patch, a correct implementation of
sgx_run() requires installing a signal handler.  This is nasty, since
signal handlers, expecially for something like SIGSEGV or SIGBUS, are
not fantastic to say the least in libraries.

Could we perhaps have a little vDSO entry (or syscall, I suppose) that
runs an enclave an returns an error code, and rig up the #PF handler
to check if the error happened in the vDSO entry and fix it up rather
than sending a signal?

On Windows, this is much less of a concern, because Windows has real
scoped fault handling. But Linux doesn't, at least not yet.


--
Andy Lutomirski
AMA Capital Management, LLC
