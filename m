Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C012CC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE3125D21
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 15:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKtCRV/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE3125D21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934790AbeFYPps (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 11:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:44924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752564AbeFYPpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 11:45:45 -0400
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1241825D32
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 15:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529941545;
        bh=LJwOq8gz2zs4btoUt0VoqtmOCNU45pg/YNKK+XUUgxI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cKtCRV/PUCTt7mPfGuYL50AtoJCZy6affn7lyJZ58l/pTBQww18jzUw6ovA7CEksE
         7iDHHoS/lKCUocnWJiRNxs9TZ5HUB9jDnjCnCfo0uK/aZ0TVT1/XywE+Hw2r3m87FJ
         svvaAM/C1HDzjVKnq2SZJG/M7nMh6RfPrD3yY94E=
Received: by mail-wm0-f42.google.com with SMTP id z13-v6so4384417wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 08:45:44 -0700 (PDT)
X-Gm-Message-State: APt69E2nE0kQ9QQPVGqwR2p8ppn2WS2ko2axpkF60ZiiS0P8jP/q5qop
        ZhUrmRC6QAAqJyu9BeK+vxPmvkawrMPWfLzST8a4/A==
X-Google-Smtp-Source: AAOMgpfd5dS6RyHjvmQJ9gaKAR7d7tbu3ZTdnMKDFZL+0V8IUcqQE1BQ6JE4jnmd9gxsAPEFcxIYea0QwiCk3lRoT9U=
X-Received: by 2002:a1c:4a9d:: with SMTP id n29-v6mr1364207wmi.46.1529941543460;
 Mon, 25 Jun 2018 08:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com>
 <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
 <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
 <20180611115255.GC22164@hmswarspite.think-freely.org> <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
 <20180612174535.GE19168@hmswarspite.think-freely.org> <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
 <CAOASepN9t3jF4ajfKLG_odTZddOvXjY_DqLQhRPWhJ-imtjkgg@mail.gmail.com>
 <e3f8e5b9-aa1e-20da-37ac-3c3caafa66bc@fortanix.com> <b5c81504-83cd-8150-ebe4-41355026590f@fortanix.com>
 <20180620210158.GA24328@linux.intel.com> <CAOASepN1AtgEhobJUVh=rcsQ_Qt8ujoEhnivV-29y=-AiyJwZQ@mail.gmail.com>
 <73b7e4e3712074b73f4ac8211699d24dfdced6bf.camel@linux.intel.com>
In-Reply-To: <73b7e4e3712074b73f4ac8211699d24dfdced6bf.camel@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 Jun 2018 08:45:31 -0700
X-Gmail-Original-Message-ID: <CALCETrXos3b-VJxLCb1nwP1x2s5jiDmuQDWVahTVdXGxhqqsDw@mail.gmail.com>
Message-ID: <CALCETrXos3b-VJxLCb1nwP1x2s5jiDmuQDWVahTVdXGxhqqsDw@mail.gmail.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     npmccallum@redhat.com,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Andrew Lutomirski <luto@kernel.org>, nhorman@redhat.com,
        X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        intel-sgx-kernel-dev@lists.01.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, andy@infradead.org,
        Peter Jones <pjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 2:41 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, 2018-06-21 at 08:32 -0400, Nathaniel McCallum wrote:
> > This implies that it should be possible to create MSR activation (and
> > an embedded launch enclave?) entirely as a UEFI module. The kernel
> > would still get to manage who has access to /dev/sgx and other
> > important non-cryptographic policy details. Users would still be able
> > to control the cryptographic policy details (via BIOS Secure Boot
> > configuration that exists today). Distributions could still control
> > cryptographic policy details via signing of the UEFI module with their
> > own Secure Boot key (or using something like shim). The UEFI module
> > (and possibly the external launch enclave) could be distributed via
> > linux-firmware.
> >
> > Andy/Neil, does this work for you?
>
> Nothing against having UEFI module for MSR activation step.
>
> And we would move the existing in-kernel LE to firmware so that it is
> avaible for locked-in-to-non-Intel-values case?
>

This is a hell of a lot of complexity.  To get it right we'd need an
actual formal spec of what firmware is supposed to do and how it
integrates with the kernel, and we'd need a reason why it's useful.

I'm personally rather strongly in favor of the vastly simpler model in
which we first merge SGX without LE support at all.  Instead we use
the approach where we just twiddle the MSRs to launch normal enclaves
without an init token at all, which is probably considerably faster
and will remove several thousand lines of code.  If and when a bona
fide use case for LE support shows up, we can work out the details and
merge it.

Right now, we're talking about a lot of design considerations, a lot
of interoperability considerations, and a lot of code to support a use
case that doesn't clearly exist.

--Andy
