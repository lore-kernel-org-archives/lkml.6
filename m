Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8034ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A0921526
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L+LoXm+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A0921526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbeJQPhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:37:12 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56904 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbeJQPhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:37:10 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181017074246euoutp0124bf9d80a47c66c386341733a1f72a73~eVYgxynHu1009710097euoutp01V
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 07:42:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181017074246euoutp0124bf9d80a47c66c386341733a1f72a73~eVYgxynHu1009710097euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539762166;
        bh=j4SQJ9VsTeMrPh2VksxZC1FqU5eBAu9JCpV/+zpvtZ0=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=L+LoXm+2dY8sVxtwcWpaQ2Si3vjL9fvx9BEsru3S5yw+QDsDRW8DUMMv3sMSx3WKA
         X1iH920O7l76C5SMetB4f5bSNDm4isZFlqIDzb9gAoPwPpuvYpLNvr3so8ST0jEMjY
         l82+LX2rvzBIMXvSGSHP7xpJ3QZs534a94nDZGb8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181017074245eucas1p2c48edf221c1e028227961813be366b22~eVYf4xyJK2023320233eucas1p2w;
        Wed, 17 Oct 2018 07:42:45 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 3B.56.04441.4F7E6CB5; Wed, 17
        Oct 2018 08:42:44 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181017074244eucas1p2487ff3bccf50d6f4fd7a99cd7d8d2bb4~eVYe84jXW0904509045eucas1p2q;
        Wed, 17 Oct 2018 07:42:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181017074243eusmtrp16ccb0d3b3a3010349729a360d94191d8~eVYesb-eU0953109531eusmtrp1V;
        Wed, 17 Oct 2018 07:42:43 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-23-5bc6e7f4199a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 04.FB.04284.3F7E6CB5; Wed, 17
        Oct 2018 08:42:43 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181017074243eusmtip2b9cefd6d465f0d0100268048838507f9~eVYeLtl032237622376eusmtip2A;
        Wed, 17 Oct 2018 07:42:43 +0000 (GMT)
Subject: Re: [PATCH 00/11] thermal: add new flag irq-mode for trip point
To:     =?UTF-8?Q?Krzysztof_Koz=c5=82owski?= <k.kozlowski.k+lkml@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>
From:   Lukasz Luba <l.luba@partner.samsung.com>
Date:   Wed, 17 Oct 2018 09:42:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPei6b7TnOnG7DUMNm+xEUsMxqcMOfbG10cJbrNROXLN2w@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+XYuO1qT4zR98ZIxSjTwhoUHKikIO1BG/WORhU09OUun7aRm
        VAqat0xCpdnKGzOVociWLl3e0OEtLC0tsYLClRUtsxlkYuU8Sv73e5/3eb/nfeGjMOk04UEl
        Ki9xKqU8SUY64saBxWcBC7MD0cFjlSGMvqKFYCy9+Yipsnkz1eanBFM98ZJgWmcXScYws0K1
        eXU488J0n2Rst8yIefBqXMTc6DKLGcv7EnK/hG2qakJsh+atmNV2fhaxBl0hyb552UmyD+uy
        WG1JGcGWtOoQazNsPeZwynFvPJeUmM6pgsLPOiq0E5Vk6lzo5cZBK5aNen2KkAMF9C4YmrOK
        i5AjJaUbEeTUfhIJxQKC8cLGtcKGYGlqhlgfMd43EUKjAcHXaSMpFFYE7+ZLkd3lQrPQMjS7
        yq70IVDnjuJ2E0bPi+Bt8/BKIkWRdCC06y7aPTi9A/6qi1YTttAnwfyudnVWQjvD8F0LbmcH
        +jjMvVlc9WC0O0xbqkUC+0BO2z3M/j7Qy2JoNhkJYTgdRnImkbD2Qaio1GMCu8CXwVaxwF7w
        pKwYF5iH0QIdKfBVyB9uX/Psgf7BccK+M0b7Q4spSJAPwONvo5hdBtoJpqzOwjpOUGpUr8kS
        KMiTCm4/aC0eEwnsBg1Nd8S3kUyz4UjNhsM0Gw7T/M+tQbgOuXNpfHICx4couYxAXp7MpykT
        AuNSkg1o5cc9+TP4ox39fB7bh2gKyTZL2t0GoqWEPJ3PTO5DQGEyV0midkWSxMszr3CqlBhV
        WhLH9yFPCpe5S+qr9NFSOkF+ibvAcamcar0rohw8slFWUzOhvxYdNm+Zn6waWSg/dsSg1XuE
        BofXRVzw9x33LNgeYb15Lg56I8uj9pVWnh8eyyRyA5RxXj1s1K+a190ZYb8jP54+XL/UrUj7
        3mbShJmXP5xIzYidUsckXL/qG2xLeSERHcX8eq498g7ZtulMV39tn7Ejb1nRWcTsVhSoZTiv
        kIfsxFS8/B+LM3N/bQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsVy+t/xe7qfnx+LNmjeom+xccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLbY8/8lmsekxkLWwbQmLxeVdc9gsPvceYbRYev0ik0Xr3iPsFk8e
        9rE58HqsmbeG0WPnrLvsHov3vGTy2LSqk83jzrU9bB6bl9R7LO6bzOrRt2UVo8fnTXIBnFF6
        NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GYuvzGUr
        eG9cseL4W+YGxgPyXYycHBICJhLb5uxi7WLk4hASWMoocenNUUaIhJjEpH3b2SFsYYk/17rY
        IIpeM0p8bm9jAUkIC3hIrD/xHKxBRMBdYnrLWRaQImaBj0wSy7bvY4fomMgkcfPHcuYuRg4O
        NgE9iR2rCkEaeAXcJP5suc8EYrMIqEr8n97FCmKLCkRIrF7+ghWiRlDi5MwnYMs4BQIl3t/5
        CRZnFjCTmLf5ITOELS5x68l8JghbXqJ562zmCYxCs5C0z0LSMgtJyywkLQsYWVYxiqSWFuem
        5xYb6hUn5haX5qXrJefnbmIExvW2Yz8372C8tDH4EKMAB6MSD+8OsWPRQqyJZcWVuYcYJTiY
        lUR4MxcDhXhTEiurUovy44tKc1KLDzGaAj03kVlKNDkfmHLySuINTQ3NLSwNzY3Njc0slMR5
        zxtURgkJpCeWpGanphakFsH0MXFwSjUwyjKzVxXOOm1xq/vxm7i4kIN36gQt5Tv++ZzX+8Sq
        fjtzqs6lqT7S7a97Kudv2bQ2vqk5en0wy2IP9tb6fLP92btnMPm3OvYdmHb//NJ8+cYFR2yW
        H2sOLv98yrTc/bXInIjwmtmh4q+aTFP4HEtiD59/JhQ772LZUeX29A8RDFs6E6SYbJ2UWIoz
        Eg21mIuKEwFEIEArAQMAAA==
Message-Id: <20181017074244eucas1p2487ff3bccf50d6f4fd7a99cd7d8d2bb4~eVYe84jXW0904509045eucas1p2q@eucas1p2.samsung.com>
X-CMS-MailID: 20181017074244eucas1p2487ff3bccf50d6f4fd7a99cd7d8d2bb4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485
References: <CGME20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485@eucas1p2.samsung.com>
        <20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485~eHqCoEO-42133821338eucas1p2F@eucas1p2.samsung.com>
        <CAJKOXPei6b7TnOnG7DUMNm+xEUsMxqcMOfbG10cJbrNROXLN2w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 10/17/2018 09:03 AM, Krzysztof Kozłowski wrote:
> On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Hi all,
>>
>> This patch set adds new flag and mechanism in thermal trip point in DT.
>> The current situation with 'passive' (passive cooling - DVFS)
>> trip point is that it enables polling mode in thermal framework.
> 
> For DT platform, I checked it some months ago... and that time I was
> pretty sure - passive mode does not enable polling (unless you tell it
> explicitly with "polling-delay-passive"). Maybe something changed...
> but quick look at the code tell me that not. Passive does not indicate
> polling mode.
> 
> Why do you think that passive enables polling?
Please check dt file which implements 2 more trip points that HW
supports:
arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi

In that file we have this trick with 'active' present.
Yes, you are right, 'polling-delay-passive' enables it in
the thermal code (for whole thermal zone).
Unfortunately, if you change the bellow 'active' to 'passive'
in that file, they will start polling, which is not what we want.
--------8<-------------------------
         thermal-zones {
                 cpu0_thermal: cpu0-thermal {
                         thermal-sensors = <&tmu_cpu0 0>;
                         polling-delay-passive = <250>;
                         polling-delay = <0>;
                         trips {
                                 cpu0_alert0: cpu-alert-0 {
                                         temperature = <50000>; /* 
millicelsius */
                                         hysteresis = <5000>; /* 
millicelsius */
                                         type = "active";
                                 };
                                 cpu0_alert1: cpu-alert-1 {
                                         temperature = <60000>; /* 
millicelsius */
                                         hysteresis = <5000>; /* 
millicelsius */
                                         type = "active";
                                 };
                                 cpu0_alert2: cpu-alert-2 {
                                         temperature = <70000>; /* 
millicelsius */
                                         hysteresis = <5000>; /* 
millicelsius */
                                         type = "active";
                                 };
                                 cpu0_crit0: cpu-crit-0 {
                                         temperature = <120000>; /* 
millicelsius */
                                         hysteresis = <0>; /* 
millicelsius */
                                         type = "critical";
                                 };
                                 /*
                                  * Exynos542x supports only 4 trip-points
                                  * so for these polling mode is required.
                                  * Start polling at temperature level 
of last
                                  * interrupt-driven trip: cpu0_alert2
                                  */
                                 cpu0_alert3: cpu-alert-3 {
                                         temperature = <70000>; /* 
millicelsius */
                                         hysteresis = <10000>; /* 
millicelsius */
                                         type = "passive";
                                 };
                                 cpu0_alert4: cpu-alert-4 {
                                         temperature = <85000>; /* 
millicelsius */
                                         hysteresis = <10000>; /* 
millicelsius */
                                         type = "passive";
                                 };
                         };
---------------->8-----------------------------

If you have some other ideas how to handle this case,
I am happy to discuss.

Regards,
Lukasz
> 
> Best regards
> 
> 
>> If the device supports irqs fired when the desired temerature is met,
>> thermal framwork should be notifed from driver's irq routine.
>> This is sufficent and there is no need of polling.
>> As a workaround, people declare trip point as 'active'
>> (active cooling, i.e. fan) to bypass polling mode setup in thermal
>> framework.
>>
>> With this patch set trip point 'passive' declared in DT with explicit flag:
>> 'irq-mode;' will not register itself as polling mode.
>>
>> A good example is Exynos4 SoC family, where there is 4 HW supported
>> trip points and there is a need of 6. The rest 2 are declared as 'passive'
>> without 'irq-mode;' flag, thus polling needed.
>>
>> It does not break existing design for trip points which do not have 'irq-mode'
>> flag - they will use polling.
>>
>> For consistency this flag should be added to all trip point types('active',
>> 'passive', 'hot', 'critical') when need (meaning, when irq will notify thermal
>> framework).
>>
>> Regards,
>> Lukasz Luba
>>
>> Lukasz Luba (11):
>>    thermal: remove unused function parameter
>>    thermal: add irq-mode configuration for trip point
>>    thermal: add new sysfs file for irq-mode
>>    Doc: thermal: new irq-mode for trip point
>>    Doc: DT: thermal: new irq-mode for trip point
>>    DT: arm64: exynos: add support for thermal trip irq-mode
>>    DT: arm64: exynos7: add support for thermal trip irq-mode
>>    DT: arm: exynos4: add support for thermal trip irq-mode
>>    DT: arm: exynos: add support for thermal trip irq-mode
>>    DT: arm: exynos: add support for thermal trip irq-mode
>>    DT: arm: exynos: add support for thermal trip irq-mode
>>
>>   .../devicetree/bindings/thermal/thermal.txt        |   7 ++
>>   Documentation/thermal/sysfs-api.txt                |   9 ++
>>   arch/arm/boot/dts/exynos4-cpu-thermal.dtsi         |  10 +-
>>   arch/arm/boot/dts/exynos5410-odroidxu.dts          |  10 +-
>>   arch/arm/boot/dts/exynos5420-trip-points.dtsi      |  10 +-
>>   arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  40 +++++---
>>   arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi     | 105 ++++++++++++++-------
>>   .../arm64/boot/dts/exynos/exynos7-trip-points.dtsi |   8 ++
>>   drivers/thermal/of-thermal.c                       |  17 ++++
>>   drivers/thermal/thermal_core.c                     |  16 ++--
>>   drivers/thermal/thermal_sysfs.c                    |  53 ++++++++++-
>>   include/linux/thermal.h                            |   5 +
>>   12 files changed, 226 insertions(+), 64 deletions(-)
>>
>> --
>> 2.7.4
>>
> 
> 
