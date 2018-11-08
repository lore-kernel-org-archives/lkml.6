Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D260ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF722086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 14:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Bq8s5GUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF722086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbeKIAOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:14:52 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44761 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeKIAOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:14:51 -0500
Received: by mail-ot1-f68.google.com with SMTP id z33so18177801otz.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 06:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YgxYL/otD3J6IANYJXOckMzLDWpELq85An6LxdjCHE8=;
        b=Bq8s5GURcI+alhbv1MWJs00RrXOaq3AMgM9u5pnjr4l5k1P7e6PvC+KiTWTuyF/ohL
         KK5FWmVITRgbfRJkCfKDZ4QkwMQQEE+BCbbp57KSwXW6fWlVCmboPWhFa1It2RBycPhZ
         jz+gV6y72MERRocdkGqHdsERnzBeO9uPqjfco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YgxYL/otD3J6IANYJXOckMzLDWpELq85An6LxdjCHE8=;
        b=Ljsbq8NL9AZy+tC+rlooPHbD2sTsef651FDEm0MkEcivcmraEgAYpwpEmCvzZrG+ad
         AGhi3W5qmr9pGSeqzexMJ0YorOVlyW/qAgFIe0LLzSIpPNzLw6xMLILk1qdu4ha3WM2r
         7DrPXMj1m1/EzOlZij18a3taDv2LefqjkFUxEc41k86Kff/6SRGF0ViJz3n2s4D984m8
         NO92W5Rj9vD9P41PbuaW3lh9vi+zh/eLizBHzJKspU4JFLF5APKfMkpg8xK/uchwjnmi
         gFuSLD3GWk+ouPsUYDm+BPA0bLUVZQbc9xXJvONEEj6o6YAu0wBdPV75RAWMbv2eYNob
         1XMg==
X-Gm-Message-State: AGRZ1gI1CXD1zcZQwBdTB4fkzIbMT4RXnUCVql1NXuIKqT8YjCABejbT
        oXd4Xz1A+BSjdGQ3wUNQMLD71LyBotNDW8gI5sRkoA==
X-Google-Smtp-Source: AJdET5cey94twv8LRC0l8y4pG+Sk4WVCZvthvmAPYyP3nlwonOC4kz6yhHLDeEZkCsrYLp6ZkKFXSAkGgI/Cb9ZQfpk=
X-Received: by 2002:a9d:5617:: with SMTP id e23mr2619379oti.151.1541687944071;
 Thu, 08 Nov 2018 06:39:04 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:4b0e:0:0:0:0:0 with HTTP; Thu, 8 Nov 2018 06:38:43 -0800 (PST)
In-Reply-To: <87pnvf63u2.fsf@linaro.org>
References: <20181107171031.22573-1-alex.bennee@linaro.org>
 <20181107180120.urnvkcrkh46ytsdb@lakrids.cambridge.arm.com>
 <20181107180829.sex54bxhd5wyqvan@lakrids.cambridge.arm.com>
 <87r2fv68us.fsf@linaro.org> <20181108135122.llmfsel32dbe2q7o@lakrids.cambridge.arm.com>
 <87pnvf63u2.fsf@linaro.org>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Thu, 8 Nov 2018 14:38:43 +0000
Message-ID: <CAFEAcA9v+XvAJBWpDMvEQPeJ7ALM15Yz5KY+wfGPmLG2a8yPRQ@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: arm64: don't single-step for non-emulated faults
To:     =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        kvm-devel <kvm@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        kvmarm@lists.cs.columbia.edu,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 November 2018 at 14:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Mark Rutland <mark.rutland@arm.com> writes:
>> One problem is that I couldn't spot when we advance the PC for an MMIO
>> trap. I presume we do that in the kernel, *after* the MMIO trap, but I
>> can't see where that happens.
>
> Nope it gets done before during decode_hsr in mmio.c:
>
>         /*
>          * The MMIO instruction is emulated and should not be re-executed
>          * in the guest.
>          */
>         kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));

I think that this attempt to do the PC-advance early is
probably an underlying problem that is not helping the
code structure here.

An enhancement that's been floated previously is that the
MMIO emulation in userspace should be able to report back
to KVM "nope, that access should generate a guest synchronous
external abort (with ESR_EL1.EA =3D 0/1)".
If we have that, then we definitely need to not advance the
PC until after userspace has done the emulation and told
us whether the memory access succeeded or not...

thanks
-- PMM
