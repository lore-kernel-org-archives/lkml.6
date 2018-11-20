Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC09CC4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1286920685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iqD/SGAn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1286920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbeKUDxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:53:23 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56974 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbeKUDxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:53:23 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181120172308euoutp01c0af0bbb3fcb9ac8187e648b8c532841~o5O8fHmvb1424414244euoutp01R
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 17:23:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181120172308euoutp01c0af0bbb3fcb9ac8187e648b8c532841~o5O8fHmvb1424414244euoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542734588;
        bh=LQ5GRkWWdcucMNEus98hND8MvakN7rBZmY7NyFw4kqc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=iqD/SGAnxCdGLL9RJ4KoFna80G8Xa9FnUvk7WHCqgaxSmLmJlvfb3G0y5qGm8VZQB
         QDNhBO9Mtoz6IpNKbCMjdW5ZuqXYqmH+/LMgApWWpHifn1vEeO79dYTZCd+L+R5iwJ
         V+64UN0bVMVJXlXkydTB7fySyKgniJU5HcVAu0jo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181120172307eucas1p141b9d8b0bfa220de5582ce5d2d0e4cae~o5O7w0Tpi1548915489eucas1p1g;
        Tue, 20 Nov 2018 17:23:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 31.3A.04441.AF244FB5; Tue, 20
        Nov 2018 17:23:06 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181120172305eucas1p2f0dc9364e02e1878c853dda886a86f9a~o5O6IYYIi2486624866eucas1p2B;
        Tue, 20 Nov 2018 17:23:05 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181120172305eusmtrp23b18c5e3371eb0f757efe7794471be76~o5O55OOvA3153831538eusmtrp2B;
        Tue, 20 Nov 2018 17:23:05 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-99-5bf442fa79d1
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B2.B7.04128.9F244FB5; Tue, 20
        Nov 2018 17:23:05 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181120172304eusmtip142d96d1ad528c5a8d28b2cefb9da2f56~o5O5YJ92j0739907399eusmtip1N;
        Tue, 20 Nov 2018 17:23:04 +0000 (GMT)
Subject: Re: Applied
 "regulator: wm8994: Pass descriptor instead of GPIO number" to the regulator
 tree
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <a67567d7-9081-a6e2-b1f5-a3bc07970d35@samsung.com>
Date:   Tue, 20 Nov 2018 18:23:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181120170332.GE16508@imbe.wolfsonmicro.main>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djP87q/nL5EG/Q1WllMffiEzeJK6yZG
        i/tfjzJafLvSwWQx5c9yJovLu+awWXx+v5/V4uKM88wOHB47Z91l99i0qpPN4861PWwe0+f8
        Z/T4vEkugDWKyyYlNSezLLVI3y6BK+P3+yNsBfd5KlZtmMTYwLiCq4uRk0NCwETi5f1Wli5G
        Lg4hgRWMEs+vHGSGcL4wSjzu/8wE4XxmlDj79gkjTMvPyaugWpYzSmxsa2WHcN4zSnyY+oMN
        pEpYIEvi6t9rYLaIQLLE9hXzwYqYBa4zSlyccgRsFJuAoUTX2y6wIl4BO4kd3w+xgtgsAqoS
        u4+D7ObkEBWIkTi28gYjRI2gxMmZT1hAbE4BG4kF1/+B2cwC8hLb385hhrDFJW49mQ92t4TA
        LnaJRbfOsUPc7SJxvOU1G4QtLPHq+BaouIzE/50wDc2MEu0zZrFDOD2MElvn7IDqsJY4fPwi
        0HkcQCs0Jdbv0ocIO0ocu3kHLCwhwCdx460gxBF8EpO2TWeGCPNKdLQJQVSrScw6vg5u7cEL
        l5gnMCrNQvLaLCTvzELyziyEvQsYWVYxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIEpqTT
        /45/2sH49VLSIUYBDkYlHt4E4S/RQqyJZcWVuYcYJTiYlUR4z2kBhXhTEiurUovy44tKc1KL
        DzFKc7AoifNWMzyIFhJITyxJzU5NLUgtgskycXBKNTA2Orc84btvyWbgsKXd4Hbn2sKsUwvr
        pFevuP4ofofo+2siLVwfXj22Ubn3lK/k01OX3Q/WF0ksXrM4rzh/hQqv6PMPMsubiiP/nChS
        37vqc0+IAJPRp/RgRm3hn+4Z5uytpkyxbgaKE/SVw+1NP5utPplfXdg/pSguVWatxF+l3R/D
        EmVb5JVYijMSDbWYi4oTASFAUMpFAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsVy+t/xu7o/nb5EG8zsYbWY+vAJm8WV1k2M
        Fve/HmW0+Halg8liyp/lTBaXd81hs/j8fj+rxcUZ55kdODx2zrrL7rFpVSebx51re9g8ps/5
        z+jxeZNcAGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqR
        vl2CXsbv90fYCu7zVKzaMImxgXEFVxcjJ4eEgInEz8mrWLoYuTiEBJYySuzZdpQJIiEjcXJa
        AyuELSzx51oXG0TRW0aJtgnngYo4OIQFMiTWba8FqRERSJZY3P6CFaSGWeA6o8SlKSfZIRq+
        s0jM+rIDbBKbgKFE11uQSZwcvAJ2Eju+HwKLswioSuw+/hlss6hAjETn9XlQNYISJ2c+YQGx
        OQVsJBZc/wdmMwuoS/yZd4kZwpaX2P52DpQtLnHryXymCYxCs5C0z0LSMgtJyywkLQsYWVYx
        iqSWFuem5xYb6RUn5haX5qXrJefnbmIERuC2Yz+37GDsehd8iFGAg1GJhzdB+Eu0EGtiWXFl
        7iFGCQ5mJRHec1pAId6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4HJoe8knhDU0NzC0tDc2Nz
        YzMLJXHe8waVUUIC6YklqdmpqQWpRTB9TBycUg2MlxXuLU+qeCvP476rPe6o3JSoSmmdsL85
        +jaTrk8s15A5P/WuqrZ4bUyT2UG9rO2s9ud+ixpqCezd52ElPbWyN3zRZ2fl6v0Hvk3d23t/
        6kbxnLTwaNuW4J3HK+ZF/nsY/eeXaIfRo6ePFin+bbrwNsHwpUGY5obvSZyxbr28B+Wb38c2
        hocosRRnJBpqMRcVJwIA1OnjwdYCAAA=
X-CMS-MailID: 20181120172305eucas1p2f0dc9364e02e1878c853dda886a86f9a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137
References: <CGME20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137@eucas1p2.samsung.com>
        <66d3b74c-0152-b17b-89d4-a21d33445b25@samsung.com>
        <20181120144700.GB16508@imbe.wolfsonmicro.main>
        <f1c7e9fe-aa57-c7c4-1c2f-02105a5a7474@samsung.com>
        <20181120153215.GC16508@imbe.wolfsonmicro.main>
        <20181120153610.GD16508@imbe.wolfsonmicro.main>
        <9314db6c-9498-579d-430c-5a2992fe513e@samsung.com>
        <59879030-93a4-f562-b03b-c5e579d44e89@opensource.cirrus.com>
        <772b6fdc-57af-fef2-0c85-78446bec2c2a@samsung.com>
        <ea2b959c-0d04-6a50-4d69-3f03576fdac9@opensource.cirrus.com>
        <20181120170332.GE16508@imbe.wolfsonmicro.main>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On 2018-11-20 18:03, Charles Keepax wrote:
> On Tue, Nov 20, 2018 at 04:57:16PM +0000, Richard Fitzgerald wrote:
>> On 20/11/18 16:34, Marek Szyprowski wrote:
>>> On 2018-11-20 17:16, Richard Fitzgerald wrote:
>>>> On 20/11/18 15:56, Marek Szyprowski wrote:
>>>>> On 2018-11-20 16:36, Charles Keepax wrote:
>>>>>> On Tue, Nov 20, 2018 at 03:32:15PM +0000, Charles Keepax wrote:
>>>>>>> On Tue, Nov 20, 2018 at 03:58:59PM +0100, Marek Szyprowski wrote:
>>>>>>>> On 2018-11-20 15:47, Charles Keepax wrote:
>>>>>>>>> On Tue, Nov 20, 2018 at 02:43:32PM +0100, Marek Szyprowski wrote:
>>>>>>>>>> On 2018-05-17 18:41, Mark Brown wrote:
>>>>>>>>>>> Subject: [PATCH] regulator: wm8994: Pass descriptor instead of
>>>>>>>>>>> GPIO number
>>>>>>>>>> This patch causes following kernel warning on Samsung Exynos4412
>>>>>>>>>> based
>> Sounds like all is ok and working as expected.
>> If this is causing you a problem you'll need to provide more explanation of
>> what problem you have so we can understand.
>>
> The problem looks to be that we shouldn't be using devm for the
> GPIO allocation because the device we want to allocate the memory
> against differs from the one that holds the OF node. Apologies
> for missing that in review of the patch.

No problem. That's why we have linux-next. This way such issues can be
noticed before they cause any real problems.

> I have sent a fix that hopefully should resolve the issue, if you
> could test it on you system that would be awesome.

I will check in a minute.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

