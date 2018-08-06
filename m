Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B8CC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F4B219DA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 07:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dAqHOfMz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F4B219DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbeHFJX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 05:23:27 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50436 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbeHFJX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 05:23:27 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180806071544euoutp022b6a9116b8d5e81893ea09f99a7dd79c~IOkXP620z1135211352euoutp027
        for <linux-kernel@vger.kernel.org>; Mon,  6 Aug 2018 07:15:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180806071544euoutp022b6a9116b8d5e81893ea09f99a7dd79c~IOkXP620z1135211352euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533539744;
        bh=G+f9kCoy3qcjDA2KiP29J1+uTiu++x/CMWSXQAIkgJM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=dAqHOfMzjDiVt2rPJ1fjNc6AeiBXLpHOY2k8Y5lQqxM4dGHDKKTKUh4YLulIgNgPc
         V1mwxoC/+6gXNUQ9viFylsXV2FJv+7YrO0VK2q03quUFM+A8iwPFOwa5KZBt8u+k4W
         5BFJg7LRC6Gm4D3Kd5DBY0Zl/sL6CgJ9JpmDy0gc=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180806071544eucas1p144a47e269f7945c74afec96259012b60~IOkW18Sey1125111251eucas1p1a;
        Mon,  6 Aug 2018 07:15:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 7C.30.04294.F95F76B5; Mon,  6
        Aug 2018 08:15:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180806071543eucas1p233ac5016e1a586594cf8ecd1fe3214b0~IOkV1Zt7j2129321293eucas1p20;
        Mon,  6 Aug 2018 07:15:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180806071543eusmtrp12837b23c4ba359ead558dd43399ac162~IOkV0Uh5r2397323973eusmtrp1r;
        Mon,  6 Aug 2018 07:15:43 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-80-5b67f59f51bc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 12.4C.04284.F95F76B5; Mon,  6
        Aug 2018 08:15:43 +0100 (BST)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180806071542eusmtip1a45dfaaee3afa52e61f8f71fa0290fa2~IOkVdAjzJ1959119591eusmtip12;
        Mon,  6 Aug 2018 07:15:42 +0000 (GMT)
Subject: Re: [PATCH] Input: cros_ec_keyb: Remove check before calling
 pm_wakeup_event.
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@google.com>,
        Todd Broch <tbroch@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Mon, 6 Aug 2018 09:15:42 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKdAkRSvLq-L3FrODUqxXqDs2FymM9k5dZRxnOpc44rFiHaWAQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHe3fOtqO28ToNnzQ1hgmKuQyhgZEWXWYQWNoFF+TK07S2aTtu
        aR9CMiyGlJfysgnKMBI/TBBzOprRpIZILa1gGQrRwgutmbdSS/J4svz2e//P//9c4KUISRs/
        kirUldB6nUojFQSTPS+XPLtbFtTKPaMTqfIB6ySSf5hd5MvfOpoF8kZPP09uu72I5B7/Cl9u
        /fGJnyFUWMqHSUWfeUyoaO0yKOa6YrLI3OD9+bSm0EjrZQfygguck+OoeEpcev+nVVCOvoeY
        UBAFOBVa6h4KTSiYkuB2BAuT0yT3mEcw+rFZyLokeA5Bpz1pI2H7+g5xpscIFvtq/iYCCPo8
        4wTrCsPnIFDVvp4OxzKwW5bXEwSu4YHTW4XYggCngMlvErBM4jjwvfas6RS1DZ+HFUcaK4tw
        KAw2+UiWg/BJsAWq13sSOBbs/maC4wgY9bXw2P6AbUJ4NdKEuLAR6j93I27tw+Duf0pwHAbT
        7m4hxztgqK6K5MIVCO40moXcowrBk+ZeAedKgwH3MJ/djsAJ0OmQsQj4IPyuBQ7F4PWHcvuI
        obangeBkEdytlHA94sHstv2b+vzNCFGNpOZNV5o3XWbedJn5/9hWRHagCNrAaNU0s1dHX09m
        VFrGoFMnXyrSdqG1vzO06p7vRY5fF10IU0i6VZRFq5USvsrIlGldCChCGi5qt6xJonxV2Q1a
        X3RBb9DQjAtFUaQ0QiROvKyUYLWqhL5K08W0fqPKo4Iiy5FlIrfalqpJHDTWH8mYgTyR68XI
        bJoj/kzcFafvdEj/WH5oZXUg8mZ929T4qanMEHdbffizwezeconmy5Zvq/wTh9LvLR2Lmcnf
        Xhqb9P5sYcU1WzQa8lnVroachPkoe6QyfTlaxn/kzAzbtfNB13HZLcorNnXU7dM2WXKyvUel
        JFOgSkkk9IzqDxWKG5Y3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBIsWRmVeSWpSXmKPExsVy+t/xu7rzv6ZHG/y7yWxxeNELRoubn76x
        WlzeNYfNYsb5fUwW61q+MVqcf/ub1WLR94esDuwesxsusnjsnHWX3WPBplKPz5vkAlii9GyK
        8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DL2vrjHWPCS
        r6L/xyK2BsaP3F2MnBwSAiYS695cYexi5OIQEljKKPFi7X8miISMxMlpDawQtrDEn2tdbBBF
        bxklpp66wAiSEBaIkHjfs4IdxBYR0JfYPvsX2CRmgclMEjd3nGKF6Ohglfh6ch8bSBWbgKFE
        11uQURwcvAJ2En/ba0DCLAIqEk/OnQcbKioQI3F0cgtYOa+AoMTJmU9YQGxOgUCJde8ngC1j
        FjCTmLf5ITOELS+x/e0cKFtc4taT+UwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbU
        K07MLS7NS9dLzs/dxAiMtW3Hfm7ewXhpY/AhRgEORiUe3hXp6dFCrIllxZW5hxglOJiVRHhX
        zAYK8aYkVlalFuXHF5XmpBYfYjQFem4is5Rocj4wDeSVxBuaGppbWBqaG5sbm1koifOeN6iM
        EhJITyxJzU5NLUgtgulj4uCUamCc23a6f4FUmC/bQd9VD3693OS3hFs2alHJlZtzXFvNHkRl
        Pd+R4P396PbIEFaeHfWnF+m+quTIWMUn+9g6u9g4tlX+0w0BzoMin2JF5h7Vc9By3HutyD+7
        e/ZFb4arORNSMjzYK0JnqDx9/d/qi8C2Gpnl5d+Mug+lLs78+PvMC45pXMX7syKVWIozEg21
        mIuKEwEFdeYhywIAAA==
Message-Id: <20180806071543eucas1p233ac5016e1a586594cf8ecd1fe3214b0~IOkV1Zt7j2129321293eucas1p20@eucas1p2.samsung.com>
X-CMS-MailID: 20180806071543eucas1p233ac5016e1a586594cf8ecd1fe3214b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180803072628eucas1p26abe0cb121b974401759502f8807bb96
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180803072628eucas1p26abe0cb121b974401759502f8807bb96
References: <CGME20180803072628eucas1p26abe0cb121b974401759502f8807bb96@eucas1p2.samsung.com>
        <20180605224458.62692-1-ravisadineni@chromium.org>
        <20180803072628eucas1p26abe0cb121b974401759502f8807bb96~HTx4BGQjl1119311193eucas1p2U@eucas1p2.samsung.com>
        <CAEZbON7qLheHFuU6zwArCz=CG03JvnFjcehBGjE4RqROYrMLhQ@mail.gmail.com>
        <CAKdAkRQG08d_duPiKFi_=xUNO93c0Rcw9kpaYFFJahjJM-NdGw@mail.gmail.com>
        <CAEZbON4O0X8Fo6eAbmPOSiB1_Tw7x+Ox3ROoGfZQn72uQGQLkg@mail.gmail.com>
        <20180806052949eucas1p2483800c02730febd03d4a661a25fa405~INH40XvCx2719627196eucas1p2X@eucas1p2.samsung.com>
        <CAKdAkRSvLq-L3FrODUqxXqDs2FymM9k5dZRxnOpc44rFiHaWAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry

On 2018-08-06 08:16, Dmitry Torokhov wrote:
> On Sun, Aug 5, 2018 at 10:29 PM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> Hi Ravi,
>>
>> On 2018-08-03 18:53, Ravi Chandra Sadineni wrote:
>>> Understood. I am trying to reproduce this issue locally. Wanted to
>>> know the version of the kernel so I can give a try. Marek, can you
>>> please confirm the kernel version.
>>>
>> Yes, sorry for the missing context, I was in hurry writing the report and
>> I wanted to send it before leaving the office. I'm testing mainline on Snow
>> with exynos_defconfig.
>>
>> Suspend/resume is partially broken already with mainline, but if you disable
>> CPUfreq support, it works fine on Linux v4.17.
>>
>> I've posted CPUfreq related fixes here if you are interested:
>> https://patchwork.kernel.org/patch/10554607/
>> https://patchwork.kernel.org/patch/10554603/
>>
>> The issue with cros_ec_keyb patch appears first on Linux v4.18-rc1, which is
>> the first release with that patch.
> Marek, this patch should only be in -next, I do not believe I sent it
> to Linus just yet. If mainline is broken for you it can't be caused by
> this patch.

Aaahh. My fault then. The suspend/resume issue is cause by commit
38ba34a43dbc ("Input: cros_ec_keyb - mark cros_ec_keyb driver as wake
enabled device."), which has been merged to v4.18-rc1.

It looks that I've downloaded wrong patch from the patchwork to reply it
with a a bug report. :( I'm really sorry for the noise in the wrong thread.

Ravi: please let me know how can I help you to debug this issue.

>
>> Linux -next from 20180803, which has a few
>> more patches for cros_ec_keyb suffers from the same issue.
> Just to confirm, if you revert only this patch from -next you get
> suspend/resume back?
>
> Thanks.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

