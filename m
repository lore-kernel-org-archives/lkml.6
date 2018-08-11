Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16E3C4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 06:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8842D223F6
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 06:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkvXlBJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8842D223F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbeHKJMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 05:12:52 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44527 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbeHKJMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 05:12:52 -0400
Received: by mail-oi0-f65.google.com with SMTP id s198-v6so19417384oih.11;
        Fri, 10 Aug 2018 23:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2H5V+MsyJWgmAHjUWpt5J9RUyXdh63HxS/RARgMFm7A=;
        b=GkvXlBJduwn/XOJ9Vnr3Lp7tzmLZCmgyci8F/CHBhwcJGgj7l+NPccKGYhntQaroNI
         AReBPsRhjC9pOr38P1mXyKfy+mk8EJhQxxmhHX/0ZU/gEGiKvljdK9TkEB690dB4RVfG
         Kv9vNROsD5000eP37d8N6HNxsOkwGH+w80HTLhX3KEkkeTQnmOAXU2yppTicSIWm8yZe
         JjztC1e6LJFc2CEArF6/9d1OT8Y7CXyqJzPethjw6sCdPhfcWeZdI1k+kmTDJK/0JXXP
         q2J/RSNHyHwCU14yYTnCu5csTGWVj7LHgOC1WNZSR2PRJNdv+KB5HeJyzZcFzFf4AmiY
         CNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2H5V+MsyJWgmAHjUWpt5J9RUyXdh63HxS/RARgMFm7A=;
        b=MMWqWh/FXjaA2IXneB05wQ94Vrd1E0EcqemVMVhCkCHb+6ut5c8Pbe+TEepXIEHI/Z
         UJwaWbDpdDqt5EqUJahwDIulj3p+xigjovFvtm7o6Qs4ODiM094nUEjugsR2V9iPhcga
         MlOKhikEKo5TP9m3Zz9rncWAu9HJgwJ4sYtvGxnaK5/kseMcc3fuL4BMg4E/vJEAZKxl
         SB/+YYqtyjmmQWFIyO2Veagy5lEON69uLrQ7WaVqD6BHSLRsrDeqHd7xD9W/1gL3DGXO
         gkSogltiwS3z204o0IfVg55vNBDfEsvXcycTK0BA1EYCHP0eoyCOyo9qatvrxQWtsKmD
         wihQ==
X-Gm-Message-State: AOUpUlF4iMqVKhCRcaCEHt3LMoyme9Kp5hNlma5k2j20pwUGaW2MKsVs
        V6VmCUG+OT9ru81KrSl++laVATK9Fmq5I0VgP9MKCg4K
X-Google-Smtp-Source: AA+uWPz9I3WHlX/6Y1+j8N1Og6yHQCqJV7uFuR+8EXXfv5Cce8F5ytnKC9FZfp/mnBlsTS2RyRE1DZQs/0EILFuSVrw=
X-Received: by 2002:aca:f516:: with SMTP id t22-v6mr10375330oih.56.1533969583667;
 Fri, 10 Aug 2018 23:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180806160933.6578-1-krzk@kernel.org>
In-Reply-To: <20180806160933.6578-1-krzk@kernel.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 11 Aug 2018 12:09:31 +0530
Message-ID: <CANAwSgTYviRnLjVU50w_o5k6=iMjxqU5qQ+7RW9K43KrrqRKPA@mail.gmail.com>
Subject: Re: [PATCH 1/4] ARM: dts: exynos: Add missing used PMIC regulators on
 Exynos5422 Odroid boards
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

These patches should also be ported to u-boot to enable PMIC.

I was just looking into S2MPS11B data sheet
According to the 1.2 Key Features of  S2MPS11

BUCK1, BUCK2, BUCK3, BUCK4, BUCK6 have (0.65 V to 1.6 V) min /max range.
BUCK5 have (0.65 V to 2.0 V) min /max range.
BUCK7 have (1.2 V to 1.5 V) min / max range.
BUCK8 have (1.8 V to 2.1 V) min / max range.
BUCK10 have (0.75 V to 1.4 V) min / max range.

BUCKBOST9 (3.0 V to 3.75 V) min / max range.

LDO1, LDO6, LDO11, LDO22, LDO23, LDO27, LDO35 (0.8 V to 2.375 V) min / max range

LDO2, LDO3, LDO5, LDO7, LDO9, LDO10, LD012, LDO13, LDO14, LDO15,
LDO16, LDO17, LDO18, LDO19, LDO20, LD021, LDO24, LDO25, LDO26,
LDO28, LDO29, LDO30, LDO31, LDO32, LDO33, LDO34, LDO36, LDO37, LDO38
(0.8 V to 3.95 V) min / max range

I am aware off we have configures the min/max range as per board schematics.
but each regulator support dynamic voltage scale and have different
turn on/off voltage and current rating.

So why are we not setting the regulator-min-microvolt /
regulator-max-microvolt as per datasheets.
Please correct me if I am wrong.

Best Regards
-Anand
