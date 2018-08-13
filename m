Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2D5C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99CA20685
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:13:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQUxk0rd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99CA20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbeHMJy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:54:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726704AbeHMJy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:54:29 -0400
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com [74.125.82.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B36921834;
        Mon, 13 Aug 2018 07:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534144411;
        bh=TK1/mfdmnFRbnq1msxDHxVDyTJhU7I5h2Az6/V2GkWc=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=bQUxk0rdogg9HNcGUuPSzRfNWaaC0j7HGNjA6gM2hc6/3bh0TQwjEOaFenGqxGQqn
         aN5tCfeWPLBgtBmxwxhFXTxyCVbnrfG6/bzAH5CTJdKJx3hreExTsJrZcA5yJXhy4N
         38NTZ7jBBHrntkOX83wH/AJT8eY9pHgSqfnUwTH4=
Received: by mail-wm0-f46.google.com with SMTP id t25-v6so7712578wmi.3;
        Mon, 13 Aug 2018 00:13:31 -0700 (PDT)
X-Gm-Message-State: AOUpUlEW+m9cBR39pNEEYaky0jhsiVf+fowUKiAQcCdSTDdVsO3uObtk
        6eBLZmGdcwNWvx0qpNUd6oILLGQ/LBO2HORn5r0=
X-Google-Smtp-Source: AA+uWPwjeTnxaQWWycI4Jebj3o1XDyCrbpi0ewZL+jluSu1XzcSEbfonDfEMvaPi+ASdNK3Z+1tktmzRnHJPhZ8htHM=
X-Received: by 2002:a1c:9c56:: with SMTP id f83-v6mr6820845wme.135.1534144409782;
 Mon, 13 Aug 2018 00:13:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Mon, 13 Aug 2018 00:13:29
 -0700 (PDT)
In-Reply-To: <CANAwSgQBthsKMKBBnKBnCJdKwKOMm0XKRn5r=gnpdbC6Eu9=ag@mail.gmail.com>
References: <20180806160933.6578-1-krzk@kernel.org> <CANAwSgTYviRnLjVU50w_o5k6=iMjxqU5qQ+7RW9K43KrrqRKPA@mail.gmail.com>
 <CAJKOXPds5s8omeR7UOB4u4HrYCZBTJX3t4YU4PSWBGb-9MG7iw@mail.gmail.com> <CANAwSgQBthsKMKBBnKBnCJdKwKOMm0XKRn5r=gnpdbC6Eu9=ag@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 13 Aug 2018 09:13:29 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdcyRavWHEowbg3Ob=55F5ta6xRUb9_A_e7sG_MFy-k7w@mail.gmail.com>
Message-ID: <CAJKOXPdcyRavWHEowbg3Ob=55F5ta6xRUb9_A_e7sG_MFy-k7w@mail.gmail.com>
Subject: Re: [PATCH 1/4] ARM: dts: exynos: Add missing used PMIC regulators on
 Exynos5422 Odroid boards
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 August 2018 at 08:37, Anand Moon <linux.amoon@gmail.com> wrote:
> Hi Krzysztof,
>
> On Sun, 12 Aug 2018 at 18:55, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 11 August 2018 at 08:39, Anand Moon <linux.amoon@gmail.com> wrote:
>> > Hi Krzysztof,
>> >
>> > These patches should also be ported to u-boot to enable PMIC.
>> >
>> > I was just looking into S2MPS11B data sheet
>> > According to the 1.2 Key Features of  S2MPS11
>> >
>> > BUCK1, BUCK2, BUCK3, BUCK4, BUCK6 have (0.65 V to 1.6 V) min /max range.
>> > BUCK5 have (0.65 V to 2.0 V) min /max range.
>> > BUCK7 have (1.2 V to 1.5 V) min / max range.
>> > BUCK8 have (1.8 V to 2.1 V) min / max range.
>> > BUCK10 have (0.75 V to 1.4 V) min / max range.
>> >
>> > BUCKBOST9 (3.0 V to 3.75 V) min / max range.
>> >
>> > LDO1, LDO6, LDO11, LDO22, LDO23, LDO27, LDO35 (0.8 V to 2.375 V) min / max range
>> >
>> > LDO2, LDO3, LDO5, LDO7, LDO9, LDO10, LD012, LDO13, LDO14, LDO15,
>> > LDO16, LDO17, LDO18, LDO19, LDO20, LD021, LDO24, LDO25, LDO26,
>> > LDO28, LDO29, LDO30, LDO31, LDO32, LDO33, LDO34, LDO36, LDO37, LDO38
>> > (0.8 V to 3.95 V) min / max range
>> >
>> > I am aware off we have configures the min/max range as per board schematics.
>> > but each regulator support dynamic voltage scale and have different
>> > turn on/off voltage and current rating.
>> >
>> > So why are we not setting the regulator-min-microvolt /
>> > regulator-max-microvolt as per datasheets.
>> > Please correct me if I am wrong.
>>
>> Which regulators are not configured as in datasheet?
>>
>> Best regards,
>> Krzysztof
>
> Almost all the regulator have some miss default match of min/max setting.
> I have tried to adjust the setting on top your above patches.
>
> I am attaching my patch diff for testing.
> I have have perform some stress testing and found no issue at my end.

All the regulators you touched in this patch have proper setting of
min and max values. They are configured to the values required by
hardware, as in schematics.

Best regards,
Krzysztof
