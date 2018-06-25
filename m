Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC901C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EF85262C7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0iLKy9dj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF85262C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933214AbeFYXkS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754207AbeFYXkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:40:15 -0400
Received: from mail-wr0-f169.google.com (mail-wr0-f169.google.com [209.85.128.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 105BB262CE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 23:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529970015;
        bh=jF7NBFN9OcdwvKdfgwjdCrQpFGv98WityIPdadvSZeE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0iLKy9djDQXmK5rZT+LAh2wTv5OjYunA3JIDljcJYF/b9EPSCP574BdORAXkGDEZW
         3AOgk/iWMrwIcT0wkSieFDIJ1OzgDGG1gsPHDWcddutRse0LLdEPgkjdzG7V5KUblS
         RF9IJlVQJbiVN4gElsvNfff5pSPrqI4qkEyAMLPo=
Received: by mail-wr0-f169.google.com with SMTP id e18-v6so15311830wrs.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 16:40:14 -0700 (PDT)
X-Gm-Message-State: APt69E2wKwM3duI5yMfoVN3k+kMbY/1c3dd7IGPtDrWK0HjXRHMZhckx
        2Kv4gANeMKR9s0GmoJcHxmRrBG+Cip4WZZfLiRpbcQ==
X-Google-Smtp-Source: ADUXVKLHALTOz4mGYgeJfReYygH/MKDoa2H6uC5HI/IbwyZA5SDzkOO1FTYBJMrBzvOR207XAUv0dLUr9zoFyW9Qgj0=
X-Received: by 2002:adf:85ec:: with SMTP id 41-v6mr11600297wru.120.1529970013465;
 Mon, 25 Jun 2018 16:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
 <20180611115255.GC22164@hmswarspite.think-freely.org> <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
 <20180612174535.GE19168@hmswarspite.think-freely.org> <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
 <CAOASepN9t3jF4ajfKLG_odTZddOvXjY_DqLQhRPWhJ-imtjkgg@mail.gmail.com>
 <e3f8e5b9-aa1e-20da-37ac-3c3caafa66bc@fortanix.com> <b5c81504-83cd-8150-ebe4-41355026590f@fortanix.com>
 <20180620210158.GA24328@linux.intel.com> <CAOASepN1AtgEhobJUVh=rcsQ_Qt8ujoEhnivV-29y=-AiyJwZQ@mail.gmail.com>
 <20180621152903.GB1324@hmswarspite.think-freely.org> <CAOASepOPxte6aDHQB2dsd+VMPqWOuZZH4j8OKoqaHZ2cBsc38g@mail.gmail.com>
 <CALCETrVCVeen+foJbW-yXgg2ivkPNmUx31tPT8rV4cYOAqcSfQ@mail.gmail.com> <CAOASepPb5zKz_HDyM+s8wLmaN3oN7+OtuDLmocP_9w5Hdq3c6A@mail.gmail.com>
In-Reply-To: <CAOASepPb5zKz_HDyM+s8wLmaN3oN7+OtuDLmocP_9w5Hdq3c6A@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 Jun 2018 16:40:01 -0700
X-Gmail-Original-Message-ID: <CALCETrVrBsQr7GetUbbXmn=2HXc4mGOH2e+Mc22pU2Q8tpBnXQ@mail.gmail.com>
Message-ID: <CALCETrVrBsQr7GetUbbXmn=2HXc4mGOH2e+Mc22pU2Q8tpBnXQ@mail.gmail.com>
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
To:     npmccallum@redhat.com
Cc:     Andrew Lutomirski <luto@kernel.org>, nhorman@redhat.com,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
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

On Mon, Jun 25, 2018 at 2:06 PM Nathaniel McCallum
<npmccallum@redhat.com> wrote:
>
> On Thu, Jun 21, 2018 at 6:49 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Thu, Jun 21, 2018 at 12:11 PM Nathaniel McCallum
> > <npmccallum@redhat.com> wrote:
> > >
> > > If this is acceptable for everyone, my hope is the following:
> > >
> > > 1. Intel would split the existing code into one of the following
> > > schemas (I don't care which):
> > >   A. three parts: UEFI module, FLC-only kernel driver and user-space
> > > launch enclave
> > >   B. two parts: UEFI module (including launch enclave) and FLC-only
> > > kernel driver
> > >
> > > 2. Intel would release a reproducible build of the GPL UEFI module
> > > sources signed with a SecureBoot trusted key and provide an
> > > acceptable[0] binary redistribution license.
> > >
> > > 3. The kernel community would agree to merge the kernel driver given
> > > the above criteria (and, obviously, acceptable kernel code).
> > >
> > > The question of how to distribute the UEFI module and possible launch
> > > enclave remains open. I see two options: independent distribution and
> > > bundling it in linux-firmware. The former may be a better
> > > technological fit since the UEFI module will likely need to be run
> > > before the kernel (and the boot loader; and shim). However, the latter
> > > has the benefit of already being a well-known entity to our downstream
> > > distributors. I could go either way on this.
> >
> > This is a lot of complication and effort for a gain that is not
> > entirely clear.
>
> Root kits and evil maid attacks are two worth considering.
>

I think that SGX malware is a real issue.  I'm less convinced that SGX
root kits and SGX evil maid attacks are particularly interesting,
except insofar as SGX can be used to make a root kit's behavior harder
to reverse engineer.  Can you explain exactly what type of attack you
have in mind and exactly how all this complexity helps?

(Keep in mind that SGX, by itself, cannot actually obfuscate malware.
SGX plus a command-and-control system that uses remote attestation
*can* obfuscate malware, but Intel has tight [0], online controls to
protect against *that*, and they have nothing to do with launch
control [1].)

> > I really really really do *not* want to see Intel or
> > anyone else start enforcing policy on which programs can and cannot
> > run using this mechanism.
>
> We already do this. It is called SecureBoot.

And we have a mechanism for letting people run whatever OS they want
on a SecureBoot system, and if you can get your favorite Linux to boot
on a Secure Boot machine, it's fully functional.  SGX, not so much.

>
> > (This is exactly why non-FLC systems aren't
> > about to be supported upstream.)  So my preference is to not merge
> > anything that supports this type of use case unless there is
> > compelling evidence that it is (a) genuinely useful, (b) will be used
> > to improve security and (c) won't be abused for, say, revenue
> > purposes.
>
> I think there are benefits for (a) and (b). I agree with you about
> (c). But, again, we already have SecureBoot.

And Secure Boot is great (aside from being overcomplicated, using SMM
in ridiculous ways, and having some misguided OEMs providing buggy
implementations).  And Secure Boot, applied correctly, is decent
protection against root kits independently of SGX.

[0] Well, maybe they're tight.  I don't know whether Intel pays
adequate attention.  Also, IIRC, you need an NDA to even learn the
rules about Intel's attestation service.

[1] I'd need to reread the SDM, but it's possible that a buggy
signed-by-Intel launch enclave would break attestation.  But a
not-signed-by-Intel enclave can't have any particular effect on
attestation, because the *attestation* root of trust involves Intel
knowing the provisioning keys of all the genuine SGX CPUs in the
world, and Intel is the only party with that information, so a
third-party provisioning enclave signed by a third party can't
actually root its trust anywhere.  This situation is somewhat
analogous to how TPM-based DRM used to be impossible but is not
sort-of-possible even though TPMs have never had any equivalent of
launch control.
