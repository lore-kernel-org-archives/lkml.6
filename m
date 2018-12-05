Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CBAC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4733E2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s1ErGYnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4733E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbeLEPdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:33:45 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59079 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbeLEPdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:33:43 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181205153341euoutp01829532a0d3dd87df341fb62a009490ce~teaq75X5e0045600456euoutp01k
        for <linux-kernel@vger.kernel.org>; Wed,  5 Dec 2018 15:33:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181205153341euoutp01829532a0d3dd87df341fb62a009490ce~teaq75X5e0045600456euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1544024021;
        bh=NIIayDVnsscvK2KS6LhVsZsJnl1s/5/jFldtqUDvwWw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=s1ErGYnHxYvGnMmaBb+9PMJD0LI/6+IhY0OMYpQ1UqZJL24R18b6jtjew9GyK+yer
         POBsb5n2ODoB6kkKMshVlmq0QXtzvkKxODLe9YPdq/MrBZkxuF4k6w7tzvf43hCSk9
         OzU2S2FPSlseoOYs3xPnBILMhZNy8EOz1kTwIVTQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181205153340eucas1p2ccb9dab1ab5e42f55f33a1f399ad8058~teaqKfvQm2703327033eucas1p2h;
        Wed,  5 Dec 2018 15:33:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3C.D2.04294.4DFE70C5; Wed,  5
        Dec 2018 15:33:40 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181205153339eucas1p25e35fee10542f5bd1d5e3d1d36122d58~teapcTFhG3067030670eucas1p2r;
        Wed,  5 Dec 2018 15:33:39 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181205153339eusmtrp1a32f41be35599c7cd8a2799400d5370c~teapNfuR30905509055eusmtrp1c;
        Wed,  5 Dec 2018 15:33:39 +0000 (GMT)
X-AuditID: cbfec7f4-c77a99c0000010c6-d7-5c07efd49a68
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4D.48.04128.3DFE70C5; Wed,  5
        Dec 2018 15:33:39 +0000 (GMT)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181205153339eusmtip2767744ec18d2587d3ce185a33ab62f89~teaop8au03260132601eusmtip2H;
        Wed,  5 Dec 2018 15:33:38 +0000 (GMT)
Subject: Re: [PATCH v2 00/11] thermal: add new flag irq-mode for trip point
To:     Zhang Rui <rui.zhang@intel.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     edubezval@gmail.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        krzk@kernel.org
From:   Lukasz Luba <l.luba@partner.samsung.com>
Message-ID: <ffca9e30-7a7c-7f61-24a1-016c9ea1e611@partner.samsung.com>
Date:   Wed, 5 Dec 2018 16:33:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544022486.2841.42.camel@intel.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOKsWRmVeSWpSXmKPExsWy7djP87pX3rPHGEzfJWKxccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLc6f38BusekxkLWwbQmLxeVdc9gsPvceYbRYev0ik0Xr3iPsFk8e
        9rE58HqsmbeG0WPnrLvsHov3vGTy2LSqk83jzrU9bB6bl9R7LO6bzOrRt2UVo8fnTXIBnFFc
        NimpOZllqUX6dglcGWePf2YpOKBScXhOSAPjIrkuRk4OCQETiX2TzrOC2EICKxgl/t+Q6mLk
        ArK/MEr8brjDDuF8ZpTYu3wWC0zHzM2vmSASy4Gqlk1nhHDeMkocvPGSHaRKWMBb4uD/aWC2
        iMAeRonz33VAipgFZjNKdC2fC9TOwcEmoCexY1UhSA2vgJvE4XvTwepZBFQktkz9yQhiiwpE
        SHTcX80GUSMocXLmE7ArOAUMJXZen8oEYjMLiEvcejIfypaXaN46mxlkl4TAT3aJ/d/a2SHO
        dpF4dvgdE4QtLPHq+BaouIzE6ck9UK8VS5ztWMUGYddItJ/cAVVjLXH4+EVWkJuZBTQl1u/S
        BzElBBwlPq62hjD5JG68FYS4gE9i0rbpzBBhXomONiGIGRoSW3ouQO0Xk1i+Zhr7BEalWUj+
        moXkl1lIfpmFsHYBI8sqRvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwOR2+t/xLzsYd/1J
        OsQowMGoxMP74gF7jBBrYllxZe4hRgkOZiUR3hU2QCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8
        1QwPooUE0hNLUrNTUwtSi2CyTBycUg2MwktiKtvWN81yd/FVWLS9S2vd/iotXZXX5/P9XA+4
        5TPsu7CYR54lKPmFCJvrPCUnhttGmk7H4q0jS9Ye9FGzsmp73WieWn0jX1tc6TPXNFepHUv/
        Sk5isf75uef4qjVx7/bwW81NPVSwdsuXRDNr8yevgtesO899XHUdp6LAZb/QgjaPmmtKLMUZ
        iYZazEXFiQBGZohGagMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsVy+t/xe7qX37PHGBzfrmCxccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLc6f38BusekxkLWwbQmLxeVdc9gsPvceYbRYev0ik0Xr3iPsFk8e
        9rE58HqsmbeG0WPnrLvsHov3vGTy2LSqk83jzrU9bB6bl9R7LO6bzOrRt2UVo8fnTXIBnFF6
        NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GWePf2Yp
        OKBScXhOSAPjIrkuRk4OCQETiZmbXzN1MXJxCAksZZT49nIiI0RCTGLSvu3sELawxJ9rXWwQ
        Ra+Bih6fZQJJCAt4Sxz8Pw2sSERgD6PEo9WaIEXMArMZJT68Ogo19iijxNQNL4DaOTjYBPQk
        dqwqBGngFXCTOHxvOlgzi4CKxJapP8E2iwpESJx9uY4RokZQ4uTMJywgNqeAocTO61PBFjML
        mEnM2/yQGcIWl7j1ZD5UXF6ieets5gmMQrOQtM9C0jILScssJC0LGFlWMYqklhbnpucWG+kV
        J+YWl+al6yXn525iBEb1tmM/t+xg7HoXfIhRgINRiYf3xQP2GCHWxLLiytxDjBIczEoivCts
        gEK8KYmVValF+fFFpTmpxYcYTYGem8gsJZqcD0w4eSXxhqaG5haWhubG5sZmFkrivOcNKqOE
        BNITS1KzU1MLUotg+pg4OKUaGANO//jAPmtLtenvp090FfXyMi5P31f36d2PCb4TThQ3HpN7
        Nn/dc66aWe5LNi44Y7a5S/lP1zt97vlT3rpFfqzSvln+e+Kl7BSRaQsE96eVMoZ/nHWHbR7z
        kc3f5h75YmnAfuTEp8PT1swyuOD29YVF3ErueRIqsxpO3M9jeLb9q7yrB9uap/t2KLEUZyQa
        ajEXFScCACbHJ8UAAwAA
X-CMS-MailID: 20181205153339eucas1p25e35fee10542f5bd1d5e3d1d36122d58
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181107171019eucas1p1fcb1f44e00265434548d901479f2ea94
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181107171019eucas1p1fcb1f44e00265434548d901479f2ea94
References: <CGME20181107171019eucas1p1fcb1f44e00265434548d901479f2ea94@eucas1p1.samsung.com>
        <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <1544022486.2841.42.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rui,

On 12/5/18 4:08 PM, Zhang Rui wrote:
> On 三, 2018-11-07 at 18:09 +0100, Lukasz Luba wrote:
>> Hi all,
>>
>> This patch set adds a new flag and mechanism in thermal trip points
>> in
>> DT.  The old implementation in thermal zone in DT sets the same
>> configuration for all internal trip points. It does not work for all
>> HW.  There are SoCs which support IRQs for some trip points (i.e.
>> Exynos 4 has 4 trip points with IRQs). For additional one defined
>> inside the thermal zone there is a need of 'polling'. When developer
>> adds polling mode settings inside the thermal zone, all the trip
>> points will be registered for polling, even those supporting IRQs,
>> which does not make sense.
> 
> we have two timers, one for polling, and one for passive cooling.
> I think we are talking about passive cooling timer only, right?
> And the real problem is that we have multiple passive trip points and
> only part of them support irq_mode, and we don't want to start the
> passive polling timer for all of the passive trip points.
Yes exactly, we don't want to poll all of them by starting 'passive 
polling timer'.

Regards,
Lukasz
> 
> thanks,
> rui
> 
>>   Thus, developers create workarounds, which
>> are confusing for some other developers.  To workaround,
>> people declare some trip points as 'active' (those with IRQ support).
>> It allows to bypass polling mode in thermal framework applied for
>> all thermal zone's trip points.
>>
>> Thermal framework defines 4 types of trip points. The 'passive' means
>> passive cooling using DVFS, 'active' is designed for fan and other
>> devices actively changing the outside conditions. Therefore, a
>> workaround
>> mentioned earlier is confusing when someone does not know about the
>> framework limitations.
>>
>> This patch set tries to solve the issue by adding one flag inside the
>> trip point: 'irq-mode;'.  The trip point 'passive' declared in DT
>> with
>> explicit flag 'irq-mode;' will not register itself as polling mode.
>> Thermal framework will skip it during scheduling next read out work.
>> The old global-polling-mode-configuration-inside-thermal-zone is
>> still
>> valid.  Patch set does not break existing design for trip points
>> which
>> do not have 'irq-mode' flag - they will use polling.
>>
>> As an example please check patch #10 for Exynos4 SoC family, where
>> there
>> is 4 HW supported trip points and there is a need of 6. The rest 2
>> are
>> declared as 'passive' without 'irq-mode;' flag, which means polling
>> mode needed for them.
>>
>> Patch #1 is a small cleanup in thermal framework.
>>
>> Change log:
>> v2
>> - changed description in cover letter
>> - change commit messages according to Krzysztof comments
>> - rebase on top of current mainline (v4.20-rc1)
>>
>> Regards,
>> Lukasz Luba
>>
>> Lukasz Luba (11):
>>    thermal: remove unused function parameter
>>    thermal: add irq-mode configuration for trip point
>>    thermal: add new sysfs file for irq-mode
>>    Doc: thermal: new irq-mode for trip point
>>    Doc: DT: thermal: new irq-mode for trip point
>>    arm64: dts: exynos5433: add support for thermal trip irq-mode
>>    arm64: dts: exynos7: add support for thermal trip irq-mode
>>    arm: dts: exynos4: add support for thermal trip irq-mode
>>    arm: dts: exynos5420: add support for thermal trip irq-mode
>>    arm: dts: exynos5422: add support for thermal trip irq-mode
>>    arm: dts: exynos5410: add support for thermal trip irq-mode
>>
>>   .../devicetree/bindings/thermal/thermal.txt        |   7 ++
>>   Documentation/thermal/sysfs-api.txt                |   9 ++
>>   arch/arm/boot/dts/exynos4-cpu-thermal.dtsi         |  10 +-
>>   arch/arm/boot/dts/exynos5410-odroidxu.dts          |  10 +-
>>   arch/arm/boot/dts/exynos5420-trip-points.dtsi      |  10 +-
>>   arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  40 +++++---
>>   arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi     | 105
>> ++++++++++++++-------
>>   .../arm64/boot/dts/exynos/exynos7-trip-points.dtsi |   8 ++
>>   drivers/thermal/of-thermal.c                       |  17 ++++
>>   drivers/thermal/thermal_core.c                     |  16 ++--
>>   drivers/thermal/thermal_sysfs.c                    |  53 ++++++++++-
>>   include/linux/thermal.h                            |   5 +
>>   12 files changed, 226 insertions(+), 64 deletions(-)
>>
> 
> 
