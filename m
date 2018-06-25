Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0B4C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347BC20844
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 347BC20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754682AbeFYV2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:28:34 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39235 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751979AbeFYV2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:28:33 -0400
Received: by mail-oi0-f68.google.com with SMTP id 18-v6so4445050oiq.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 14:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9MpB8km5zLBWYJTBJwKIb/7S5dCra4ZWknaW2P92BE4=;
        b=RXWc8fJZzOL4RBrUZ5P9MibT7m0YNmNtH++7tGAx7g+jhcxJwC76+om45YvujN4s6N
         snnLbgrl26NpiJ1mHOH0Hj3KcqIU/nV3w1670hI55DhsvPtPkrv1bex86XsIDjX+el9B
         4btgI+7uFsrR7rQeypEjvviFFM26lxToI4n1DyW57zRsUvxV1+jG0uoGbb7f0O/FCLXi
         SZj4VikHx/bq2FLY5gHTcyRwppnFxKfxg1wwiqtcS+XlfzI/PwtMXnBy992Ah3WkyBp2
         d+7VxI2SnQDRfuVp3+6hcJ03vrx6WGZeMRrMUCOVY1YG5yKlI7QJx7w4NUCXjdJ40+vG
         k8ow==
X-Gm-Message-State: APt69E0kmFlrR6h3YQ6G0UavEAW9eJ0w6DaQmXavZBfxqJ2UA05bA1YR
        TNNLLZuug6gz3SdMqbuDD6hNjzMhDTnLGp8KSXf61A==
X-Google-Smtp-Source: ADUXVKJtceH0n+oAkdl2Ddw/ZZhob/agWRzbB4A4m3luLOQ53CuLHabOAO/sg/VDUGIghYHvmcC5XRC5lMWAFcZtC3s=
X-Received: by 2002:aca:33d5:: with SMTP id z204-v6mr7461951oiz.184.1529962112569;
 Mon, 25 Jun 2018 14:28:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com>
 <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
 <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
 <20180611115255.GC22164@hmswarspite.think-freely.org> <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
 <20180612174535.GE19168@hmswarspite.think-freely.org> <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
 <CAOASepN9t3jF4ajfKLG_odTZddOvXjY_DqLQhRPWhJ-imtjkgg@mail.gmail.com>
 <e3f8e5b9-aa1e-20da-37ac-3c3caafa66bc@fortanix.com> <b5c81504-83cd-8150-ebe4-41355026590f@fortanix.com>
 <20180620210158.GA24328@linux.intel.com> <CAOASepN1AtgEhobJUVh=rcsQ_Qt8ujoEhnivV-29y=-AiyJwZQ@mail.gmail.com>
 <73b7e4e3712074b73f4ac8211699d24dfdced6bf.camel@linux.intel.com> <CALCETrXos3b-VJxLCb1nwP1x2s5jiDmuQDWVahTVdXGxhqqsDw@mail.gmail.com>
In-Reply-To: <CALCETrXos3b-VJxLCb1nwP1x2s5jiDmuQDWVahTVdXGxhqqsDw@mail.gmail.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Mon, 25 Jun 2018 17:28:20 -0400
Message-ID: <CAOASepNpj6fgvZGLT54Dr5cLkEsTufm8wb9uaoEyDZOWu0A58Q@mail.gmail.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
To:     luto@kernel.org
Cc:     jarkko.sakkinen@linux.intel.com, sean.j.christopherson@intel.com,
        jethro@fortanix.com, Neil Horman <nhorman@redhat.com>,
        x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        intel-sgx-kernel-dev@lists.01.org, hpa@zytor.com,
        dvhart@infradead.org, tglx@linutronix.de, andy@infradead.org,
        Peter Jones <pjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 11:45 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Mon, Jun 25, 2018 at 2:41 AM Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Thu, 2018-06-21 at 08:32 -0400, Nathaniel McCallum wrote:
> > > This implies that it should be possible to create MSR activation (and
> > > an embedded launch enclave?) entirely as a UEFI module. The kernel
> > > would still get to manage who has access to /dev/sgx and other
> > > important non-cryptographic policy details. Users would still be able
> > > to control the cryptographic policy details (via BIOS Secure Boot
> > > configuration that exists today). Distributions could still control
> > > cryptographic policy details via signing of the UEFI module with their
> > > own Secure Boot key (or using something like shim). The UEFI module
> > > (and possibly the external launch enclave) could be distributed via
> > > linux-firmware.
> > >
> > > Andy/Neil, does this work for you?
> >
> > Nothing against having UEFI module for MSR activation step.
> >
> > And we would move the existing in-kernel LE to firmware so that it is
> > avaible for locked-in-to-non-Intel-values case?
> >
>
> This is a hell of a lot of complexity.  To get it right we'd need an
> actual formal spec of what firmware is supposed to do and how it
> integrates with the kernel, and we'd need a reason why it's useful.

What do you want the kernel's behavior to be in the case where an FLC
CPU is present, but the MSRs have been locked by the BIOS? Because I
think the workflow for the UEFI module idea is the same.

> I'm personally rather strongly in favor of the vastly simpler model in
> which we first merge SGX without LE support at all.  Instead we use
> the approach where we just twiddle the MSRs to launch normal enclaves
> without an init token at all, which is probably considerably faster
> and will remove several thousand lines of code.  If and when a bona
> fide use case for LE support shows up, we can work out the details and
> merge it.

I'm also okay with an incremental approach, BTW. I just want us to
think through the issues. And I do think that SGX root kits are a
serious threat. But I'm willing to move in stages. In fact, if we can
merge something without any LE support faster, I'm in favor of doing
so.

> Right now, we're talking about a lot of design considerations, a lot
> of interoperability considerations, and a lot of code to support a use
> case that doesn't clearly exist.

I agree.
