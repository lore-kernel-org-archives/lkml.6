Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CECECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED2E21523
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 08:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eoKqfn3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ED2E21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbeJQQSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 12:18:39 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53870 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQQSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 12:18:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181017082404euoutp02b53188f19ca1cbf5099e9bebfca81c28~eV8lENIFT3211332113euoutp02n
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 08:24:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181017082404euoutp02b53188f19ca1cbf5099e9bebfca81c28~eV8lENIFT3211332113euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539764644;
        bh=WXaBUM+ssPhyogHJL2wsWQez7by6v/IiKeMvwwxqZQw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=eoKqfn3db4wp6hjFvBPSkds57qMfDFe1Vd4QBzx3HnOHC1QOKmqDOxfx1Ht7CFEe4
         3Gvu0Ag5V1aZas4veoAkRJLJmek7ldRx1Poei/plOYf5HWH6sYcE5trokDA7MYkSYo
         bOIOrbNFsIefkVOsZiYunZb06a0vcGqdlc7Hykzc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181017082403eucas1p25405c2283e5a8b89e6b643a7c4f5b343~eV8kPzOcR1253312533eucas1p2Z;
        Wed, 17 Oct 2018 08:24:03 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 03.5D.04441.3A1F6CB5; Wed, 17
        Oct 2018 09:24:03 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181017082402eucas1p1088cde8bb32592e96decd0075ecc055a~eV8jZImjv1752717527eucas1p1K;
        Wed, 17 Oct 2018 08:24:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181017082402eusmtrp197d628ff89ce4a85199b564ccf3e3ac3~eV8jIqYkl2109221092eusmtrp1b;
        Wed, 17 Oct 2018 08:24:02 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-58-5bc6f1a3ffeb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 67.13.04128.2A1F6CB5; Wed, 17
        Oct 2018 09:24:02 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181017082401eusmtip294579bdc3706b72fbab6af57571b9dfd~eV8iiw_8x3275932759eusmtip2V;
        Wed, 17 Oct 2018 08:24:01 +0000 (GMT)
Subject: Re: [PATCH 00/11] thermal: add new flag irq-mode for trip point
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>
From:   Lukasz Luba <l.luba@partner.samsung.com>
Date:   Wed, 17 Oct 2018 10:24:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPd4=hvowfkEJbfX_BXf_PEjxuKxn7dxy7cb=G59a8+GOw@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3cuOxvNjvP2oF1kkFqUJWWctMIg4nysIKz8UEsPam2zdtJK
        BDXxkpnkvZY5deZlWqZOm5kgtrxgZRfRsAulI1FTWmolpOY8Vn77vc/7e3j/f3gpTD5AuFOR
        mgucVqNUKUgp3tQx27vVYOsI2W5IcWPqbtYSjLUtFTFFU+sYveUFwej7+gmmt/eBmKkfXqSS
        lDKcefOokGSmrlsQc3fglYhJbrWIGevnTDJIxtYU1SC2WfdBzBoej4rYeuNVkn3f/5hkG8ri
        WUNmDsFmmoyInapff0hyQronjFNFxnDabftOSSOGTO/E52bkl56NeiWgqjXpSEIBvROq+qqw
        dCSl5HQlgjHDbSQcphF0Nc+I7JacnkKQnfpvo7FlgRSkCgRJ4xmEcJhAUD0whNktJ5qF2q4R
        ZGdnehMMzP1ckjDaJoIP97rF6YiiSNoXzMbzdsTpjVA8HmTXXehjYPlUsrQqox2h+5YVt7OE
        PgzDv7KWAmG0Gwxa9cu8AZIaby9VAHpWDLn6HyJhOQYeDhUSQuoDkFv9nRTYCcY6TWKB10JP
        TgYuMA/P04zLThykdpuXnUB40vmKsOfEFrvUPtomjPdDy+RzzD4G2gHeTjgKcRwgu6lgeSyD
        tBS5YPuAKeOlSGBXqKjJF99ACt2KkroVxXQriun+v1uMcCNy46J5dTjH+2m4i768Us1Ha8J9
        Q6PU9Wjxu/XMd343o5nXp9sRTSHFapnZtSNETihj+MvqdgQUpnCWRRoWR7Iw5eVYTht1Uhut
        4vh25EHhCjdZeVFdiJwOV17gznLcOU7791ZESdwTkNOIzX2L2ZTTPK9qsL70SD4YWknm2VTe
        Xpr7V9yP55be+Tosad3FbW9T7W18QQYXuKQF276lx3kG+Gu9LU6fQ9MKE79I4z1j8hb8m2yx
        Lnhp4rTzkaddcV929OXPeYbJi49GfRS1uP5WzyjP+JdnXSNkAZODjS7RgaODq1ou7vZR4HyE
        0m8zpuWVfwDcZf1GagMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsVy+t/xe7qLPh6LNrjXKWaxccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLc6f38BusekxkLWwbQmLxeVdc9gsPvceYbRYev0ik0Xr3iPsFk8e
        9rE58HqsmbeG0WPnrLvsHov3vGTy2LSqk83jzrU9bB6bl9R7LO6bzOrRt2UVo8fnTXIBnFF6
        NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GY+23GYv
        +CpUcealWgPjSv4uRk4OCQETia27/7N1MXJxCAksZZT4uXEjI0RCTGLSvu3sELawxJ9rXVBF
        rxklnq47ygySEBbwkFh/4jlYg4iApsT1v99ZQYqYBT4ySSzbvo8douMos8SaL7+Yuhg5ONgE
        9CR2rCoEaeAVcJOYs+4kM0iYRUBVYsFrB5CwqECExOrlL1ghSgQlTs58wgJicwoESjz+MZEJ
        xGYWMJOYt/khM4QtLnHryXyouLxE89bZzBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8t
        NtIrTswtLs1L10vOz93ECIzpbcd+btnB2PUu+BCjAAejEg/vDrFj0UKsiWXFlbmHGCU4mJVE
        eDMXA4V4UxIrq1KL8uOLSnNSiw8xmgL9NpFZSjQ5H5hu8kriDU0NzS0sDc2NzY3NLJTEec8b
        VEYJCaQnlqRmp6YWpBbB9DFxcEo1MK7gT8tsKKo9fd9o2TRGQ/0qvqed1RGnJTym3DB+WTN5
        t+We5pD5Wv6dPYvZp3OoR9Y2Hv12M2JT/vm641uLZtpU3ClxO/JS0P615WO2Ip3qynk5W1xU
        wuS+161NmvPuS6PMcuYe5y8rxI9+LvDSmFmj7Vn/Q2DHpK9dJ1ILK77FG/hPmTyDWYmlOCPR
        UIu5qDgRAGZ0e3v/AgAA
Message-Id: <20181017082402eucas1p1088cde8bb32592e96decd0075ecc055a~eV8jZImjv1752717527eucas1p1K@eucas1p1.samsung.com>
X-CMS-MailID: 20181017082402eucas1p1088cde8bb32592e96decd0075ecc055a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485
References: <CGME20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485@eucas1p2.samsung.com>
        <20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485~eHqCoEO-42133821338eucas1p2F@eucas1p2.samsung.com>
        <CAJKOXPei6b7TnOnG7DUMNm+xEUsMxqcMOfbG10cJbrNROXLN2w@mail.gmail.com>
        <20181017074244eucas1p2487ff3bccf50d6f4fd7a99cd7d8d2bb4~eVYe84jXW0904509045eucas1p2q@eucas1p2.samsung.com>
        <CAJKOXPd4=hvowfkEJbfX_BXf_PEjxuKxn7dxy7cb=G59a8+GOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2018 09:52 AM, Krzysztof Kozlowski wrote:
> On Wed, 17 Oct 2018 at 09:42, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> Hi Krzysztof,
>>
>> On 10/17/2018 09:03 AM, Krzysztof Kozłowski wrote:
>>> On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>>>
>>>> Hi all,
>>>>
>>>> This patch set adds new flag and mechanism in thermal trip point in DT.
>>>> The current situation with 'passive' (passive cooling - DVFS)
>>>> trip point is that it enables polling mode in thermal framework.
>>>
>>> For DT platform, I checked it some months ago... and that time I was
>>> pretty sure - passive mode does not enable polling (unless you tell it
>>> explicitly with "polling-delay-passive"). Maybe something changed...
>>> but quick look at the code tell me that not. Passive does not indicate
>>> polling mode.
>>>
>>> Why do you think that passive enables polling?
>> Please check dt file which implements 2 more trip points that HW
>> supports:
>> arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>>
>> In that file we have this trick with 'active' present.
>> Yes, you are right, 'polling-delay-passive' enables it in
>> the thermal code (for whole thermal zone).
>> Unfortunately, if you change the bellow 'active' to 'passive'
>> in that file, they will start polling, which is not what we want.
> 
> Yes but this looks different than what you explained at the beginning.
> You said that passive enables polling mode... which is not true. You
> can have active with or without polling. You can have passive with or
> without polling. But the real problem you described now is that given
> polling/IRQ mode applies to entire thermal zone, not to a specific
> trip point.
> 
> I agree with this problem but you need to clearly mark it in cover
> letter and description of other commits because really from existing
> explanation I understood something completely different. You simply
> want to configure IRQ or polling per trip-point, not per thermal zone.
Thank you for your feedback, I will rewrite the cover letter and
descriptions.
I will add that the thermal zone polling settings are for all it's trip
points, which has some implications. Therefore, trying to work around,
might cause confusion due to misalignment with trip point documentation
and old assumptions.

Regards,
Lukasz

> 
> Best regards,
> Krzysztof
> 
