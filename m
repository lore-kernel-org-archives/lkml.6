Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C02C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642DC2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcu0KVkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642DC2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbeKHDZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:25:09 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45191 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731459AbeKHDZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:25:08 -0500
Received: by mail-ot1-f67.google.com with SMTP id g10so15549990otl.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 09:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7alyjK2h82VBXpRkR+UDz3WifDdbEuYo5P0F+e+rox0=;
        b=jcu0KVkqywPUWoedZFwe8Zh2RHuc3dGzxZMfmVThsh8dRP2fig+NvPN3EUVdW5VKH9
         bqzGdFsBcN3zsq+OWAv4z2JHZ2BKEX4jJJmfu3u8FluVMbiV7acFIhEsFX8V0KE2qByV
         izZ+cE+W4Tangyucyw4q4cmtCJvAVdg2kwkWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7alyjK2h82VBXpRkR+UDz3WifDdbEuYo5P0F+e+rox0=;
        b=rKTzAxaHiZv3VWScN3dTC3UJlThTtk2A2gwhPDUNGkKPQisEE+eSGIDoxR62juCewm
         Me38ul744CI2vUVQRazMwDN+qYtqOG9utyTaeMOy2iB48C2loO5k2eCSg2SXH0iNFbcU
         0MGJzj0nSmvp2cuc3h6p95GfIODjT+cAHL5EqY0HEeQyWEW5bOTo+z47Nt1Uc6STx6W4
         KCGllObJ/thOwFLCzPtviYhdHpelsAM1o10AlcqWEye5jv4ASu8CX5cTbU9hLVvCLuG1
         6jOSAQRZEBR2CfonN8SDpVvJPHWSnb9qMF60VgUiakfw0YiVT504r5XwNp7qFZnAh+Eo
         6clw==
X-Gm-Message-State: AGRZ1gLiOO/ydXft8wY9yuqlmGgL64xazPlQ4L/BmYniH9yrcer3qVlg
        77m07lhvgaTAm7iSI3zv747UwcNpieA1eSAesxa6EA==
X-Google-Smtp-Source: AJdET5eL0Usjt9H9sraIaQWwrMDO9W4GgSvI2Z/dRc5cvCu5S8kOuQ0t61KtjNCoexpD8iKxp7T2j2X3aoJ39xMHldI=
X-Received: by 2002:a9d:12d:: with SMTP id 42mr688427otu.352.1541613220630;
 Wed, 07 Nov 2018 09:53:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:4b0e:0:0:0:0:0 with HTTP; Wed, 7 Nov 2018 09:53:20 -0800 (PST)
In-Reply-To: <CAFEAcA8LL0uC6o1V3W2T=2P47xZ0zGhMR5mEE+x=8qwmDKZL_g@mail.gmail.com>
References: <20181107171031.22573-1-alex.bennee@linaro.org> <CAFEAcA8LL0uC6o1V3W2T=2P47xZ0zGhMR5mEE+x=8qwmDKZL_g@mail.gmail.com>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Wed, 7 Nov 2018 17:53:20 +0000
Message-ID: <CAFEAcA8mKCTeswpiznVWR3kSfVfjbot1aTSfemFVNjzXYdSJwA@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: arm64: don't single-step for non-emulated faults
To:     =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc:     kvm-devel <kvm@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 November 2018 at 17:39, Peter Maydell <peter.maydell@linaro.org> wrote=
:
> On 7 November 2018 at 17:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>> Not all faults handled by handle_exit are instruction emulations. For
>> example a ESR_ELx_EC_IABT will result in the page tables being updated
>> but the instruction that triggered the fault hasn't actually executed
>> yet. We use the simple heuristic of checking for a changed PC before
>> seeing if kvm_arm_handle_step_debug wants to claim we stepped an
>> instruction.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> What's the rationale for this change? Presumably it's fixing
> something, but the commit message doesn't really say what...
>
> This feels to me like it's working around the fact that
> we've separated two things ("advance pc (or set it if we're
> going to make the guest take an exception)" and "notice that
> we have completed a single step") that should be handled
> at one point in the code.

...so for instance if your guest PC is at the entrypoint for
an exception, and you singlestep and take the same exception
again, this should count as a single step completed, even
though the PC has not changed. Granted, that's a little
contrived, but it can happen in cases where the guest gets
completely confused and is sitting in a tight loop taking
exceptions because there's no ram at the vector table
address, or whatever.

thanks
-- PMM
