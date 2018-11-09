Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFB9C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC7B2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EsR3rr+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFC7B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbeKIWhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:37:46 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42589 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbeKIWhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:37:45 -0500
Received: by mail-oi1-f194.google.com with SMTP id x63-v6so1345397oix.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 04:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yDn9ONY159qDhkGpErdgo9aiZ+9sFsf7vC33KsLlIaU=;
        b=EsR3rr+yQi8RnTOb63Nsnd0KawNl8Aq69twqd24qYfmXL5abQmno1kQcDM5XwHNtrw
         L+NWPNhxAHoqZCMInUVI3+lbR5U0Bb+ce1scphvP2HyCTj9po3quLQsLlGtABc8qzVoJ
         stblN49hH0KZgxrcvv6ZpYHSpLggtrw4WChPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yDn9ONY159qDhkGpErdgo9aiZ+9sFsf7vC33KsLlIaU=;
        b=RReeYoMiqk8uNtYwF0ZHw5//6VrUaq9EG88kngAIihPJPsvOOcJps0hGJDOrtXg1YT
         d5ZM/Aulz3IdtPj5fhlw8hnvt8nCUqg37rD0jMcB7TAj8NzFUBrZAmnMcykzPGaE1MY6
         Fpxdbt/2b31vmdlH0blf/pZJI6+cjUDf/A0HR3tq84T39w5YCw6LlMT5BTaiPGthnntK
         JTeNh0OB/CDGsy6VonDzGKtVlRfA76cn8EYn3tNSiS5hpGeoEmdyrgNfQF8fJw5GmBhd
         54SKkrxd48aAZT1Ygj6ckIHyhsT9AGRubZWMZVw/8Ae0DXeUQRwB6R5ZytQyJQmK4OAI
         iqmg==
X-Gm-Message-State: AGRZ1gLAU1PE/DadLCrdyY6JY/hhmjySCwKOun6YNQI9oVO48XTYqK5Y
        uqoduYk7jrxsE78JYcAf91gUS3YjF73bzH5k0v8scg==
X-Google-Smtp-Source: AJdET5d5KKuRgG/xS8/1ooa5OSJuP0xyuxyjPQS7jyO6rvkHqxQbrM6LgDWgXpNaLcTgt4ZaWHkLVUm6UHQ/qBW6nZE=
X-Received: by 2002:aca:f1d6:: with SMTP id p205-v6mr5135282oih.332.1541768234955;
 Fri, 09 Nov 2018 04:57:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:4b0e:0:0:0:0:0 with HTTP; Fri, 9 Nov 2018 04:56:54 -0800 (PST)
In-Reply-To: <20181109124930.axelmyohmrcb63b4@lakrids.cambridge.arm.com>
References: <20181107171031.22573-1-alex.bennee@linaro.org>
 <20181107180120.urnvkcrkh46ytsdb@lakrids.cambridge.arm.com>
 <20181107180829.sex54bxhd5wyqvan@lakrids.cambridge.arm.com>
 <87r2fv68us.fsf@linaro.org> <20181108135122.llmfsel32dbe2q7o@lakrids.cambridge.arm.com>
 <87pnvf63u2.fsf@linaro.org> <CAFEAcA9v+XvAJBWpDMvEQPeJ7ALM15Yz5KY+wfGPmLG2a8yPRQ@mail.gmail.com>
 <20181109115644.f4qjqnv2kogoke42@lakrids.cambridge.arm.com>
 <87lg625th2.fsf@linaro.org> <20181109124930.axelmyohmrcb63b4@lakrids.cambridge.arm.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Fri, 9 Nov 2018 12:56:54 +0000
Message-ID: <CAFEAcA-xuUPukf9EPeetr_+RSU7FPDMXmyk3zbjY=FcV65CF=g@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: arm64: don't single-step for non-emulated faults
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        kvm-devel <kvm@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        kvmarm@lists.cs.columbia.edu,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 November 2018 at 12:49, Mark Rutland <mark.rutland@arm.com> wrote:
> I'm not saying anything about *decisions*. I'm saying that we can make
> the state consistent by advancing the singlestep state in the same way
> that HW does, at the instant it advances the PC.
>
> i.e. do that in kvm_skip_instr(), as I've done in my local tree.
>
> That mirrors the HW, and we don't need to special-case any handling for
> emulated vs non-emulated instructions.

You also need to do it in the "set PC because we're making the guest
take an exception" code path, which doesn't go through kvm_skip_instr().
This corresponds to the two kinds of "step completed" in hardware as
noted in DDI0487D.a D2.12.3 fig D2-3 footnote b:
 * executing the instruction to be stepped without taking an exception
 * taking an exception to an exception level that debug exceptions
   are enabled from [ie guest EL1 in our case]

thanks
-- PMM
