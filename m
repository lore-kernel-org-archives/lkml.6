Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC18ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D17214AB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GbF/XWK9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D17214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbeIRHZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:25:34 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35398 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeIRHZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:25:33 -0400
Received: by mail-ot1-f65.google.com with SMTP id j9-v6so353280otl.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 18:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PDgkR5lgd0P1pd/DomTxnOnMi2SGfT6/lbvhCFAe+vI=;
        b=GbF/XWK98rQR0rts1vC6J63ppDi1yYUReCvTsZOg/T1tF1mtEAo+miK94aRmsKVwkU
         VzbaAJnuz9Q/2PK26z4b/H+3TRP1qiKNwERSrz0YHtp7KGNMbGFgGNoV938yWM+Vm3ST
         1/+APD+f2uxoilCFflpn7aVG3k4i04JaGW9Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PDgkR5lgd0P1pd/DomTxnOnMi2SGfT6/lbvhCFAe+vI=;
        b=Mg1mQl5iOe6UiOvx1VoriLwl8OHiIOFPlisGfuEqbSC2Qt4bkB/471shI7pBNbMJ2d
         MJcB8e0E34HCYWKn6Pql12y2zS45I8qFSrS8tHYuy//nvyvKHgxCJA29cTQJpY8+ft65
         fj1sbZoJb0veYje8F+z4m225SgauaUbxnwBbCpCDxQCVZRanM8DbngvHhd/ZNhmgnS+4
         lXr5Q+Odtr4k02inbiFGugKPte0z0fFKUN7dHCsjBmasLzs+6T7i7MYLOQzY82QTNpdU
         nEeUgdgWNJ9LoeSLWmfLp9wD8g2J7ISK3Tigqz38d/D33xn3B2yjfdY9BeCNA/C3+5r+
         fH5g==
X-Gm-Message-State: APzg51AfOwuforEAoGXn2ktVp+a3j8RKu0zEHU82C6gD3w2hzdKZvIDV
        JD5kzaoSiJ17EEWsLcqwU9O8SKuJ65lkbAXtFehDAQ==
X-Google-Smtp-Source: ANB0VdZCCKiC9ZOQqsbcwAB2mznnaNZpO2jFgM+1l9GI3rPsLZJg48zXbglL6tnvSoWJ5ukmVh+VjgItaH0N2J6R2z4=
X-Received: by 2002:a9d:7395:: with SMTP id j21-v6mr14982917otk.203.1537235725791;
 Mon, 17 Sep 2018 18:55:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e3:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 18:55:05
 -0700 (PDT)
In-Reply-To: <20180917104144.19188-19-suzuki.poulose@arm.com>
References: <20180917104144.19188-1-suzuki.poulose@arm.com> <20180917104144.19188-19-suzuki.poulose@arm.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Tue, 18 Sep 2018 02:55:05 +0100
Message-ID: <CAFEAcA8eWYkzwFYHyP49dasK-NDVbbm=6DbEFNNPq9ZAdUM7JQ@mail.gmail.com>
Subject: Re: [PATCH v5 18/18] kvm: arm64: Allow tuning the physical address
 size for VM
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu, kvm-devel <kvm@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <cdall@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Dave P Martin <dave.martin@arm.com>, julien.grall@arm.com,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 September 2018 at 11:41, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -122,6 +122,14 @@ the default trap & emulate implementation (which changes the virtual
>  memory layout to fit in user mode), check KVM_CAP_MIPS_VZ and use the
>  flag KVM_VM_MIPS_VZ.
>
> +To configure the physical address space size for a VM (IPA size) on arm64,
> +check KVM_CAP_ARM_VM_PHYS_SHIFT (which returns the maximum limit for the
> +IPA shift) and use KVM_VM_TYPE_ARM_PHYS_SHIFT(PHYS_SHIFT). Bits[7-0] of the
> +machine type has been reserved for specifying the PHYS_SHIFT.
> +The supported range is [32...IPA_LIMIT], where IPA_LIMIT could be
> +identified by checking KVM_CAP_ARM_VM_PHYS_SHIFT. For backward compatibility
> +a value of 0 selects 40bits.
> +

Given this as the API documentation, I don't think I could figure out
what I as a userspace user of it need to do without looking at the
kernel code. Could I ask you to expand it so that it is a bit less
terse and a bit more detailed? (For instance, what is a PHYS_SHIFT
and why do I have to specify it rather than just telling the kernel
I want a 48 bit guest address space?)

thanks
-- PMM
