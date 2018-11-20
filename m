Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B231C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB735206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 17:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Z7tpImpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB735206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbeKUDnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:43:14 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:51303 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeKUDnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:43:13 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181120171301euoutp02ee746c5b1533f986c63d32daa1155d69~o5GHk4oWn1659116591euoutp02E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 17:13:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181120171301euoutp02ee746c5b1533f986c63d32daa1155d69~o5GHk4oWn1659116591euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542733981;
        bh=vM1dJk6WwLQRo0LDWdnHkumPY9LJ8NFWWhB9g4B12/Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Z7tpImpuU+SXp6JAIWjg39uWJPCUBidXjU/H8Oq2uJSV6dwlBuuPJHLSPI5jmKpyo
         KLWHOtKUDbZYspsSAOYRgJ8GnvCeJ/0F8Wam8hPwQYFgenxrWyycBC7K0sJBGR+Ql+
         a2+R4J5AMgGRpBBNAFufM0g+nP3dKBKeRdZM5pH0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181120171300eucas1p2371ccfd006a9dedbac9c20afb644547a~o5GG9Y6393242032420eucas1p2o;
        Tue, 20 Nov 2018 17:13:00 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id B9.1B.04294.C9044FB5; Tue, 20
        Nov 2018 17:13:00 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181120171259eucas1p26dbb3058de06193c43689f612d23a1a9~o5GF9LqLL2762827628eucas1p2-;
        Tue, 20 Nov 2018 17:12:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181120171259eusmtrp2f04a3683a0a6ac6b169f2b780ebc4034~o5GFu0yFK2879828798eusmtrp2S;
        Tue, 20 Nov 2018 17:12:59 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-94-5bf4409cd42e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A7.92.04284.B9044FB5; Tue, 20
        Nov 2018 17:12:59 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181120171259eusmtip2b6ac77ce12f1a911c358241a2f75a4e7~o5GFVZKWu0044900449eusmtip20;
        Tue, 20 Nov 2018 17:12:59 +0000 (GMT)
Subject: Re: Applied
 "regulator: wm8994: Pass descriptor instead of GPIO number" to the regulator
 tree
To:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <b7edc4cc-c433-a154-3d70-d13d930f6278@samsung.com>
Date:   Tue, 20 Nov 2018 18:12:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <ea2b959c-0d04-6a50-4d69-3f03576fdac9@opensource.cirrus.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87pzHL5EGzTOkreY+vAJm8WV1k2M
        Fve/HmW0+Halg8liyp/lTBaXd81hs/j8fj+rxcUZ55kdODx2zrrL7rFpVSebx51re9g8ps/5
        z+jxeZNcAGsUl01Kak5mWWqRvl0CV8aLPR3sBVvEKx7OZm1gfC/UxcjJISFgIjHn4Gv2LkYu
        DiGBFYwSX048hXK+MEp8/vaYBcL5zCgx/fxXoAwHWMudt4oQ8eWMEh0L9rCDjBISeA/UsYsH
        xBYWyJK4+vcaG4gtIpAscezUalaQBmaB64wSF6ccYQRJsAkYSnS97QIr4hWwkzi/YjsTiM0i
        oCrxoncNmC0qECNxbOUNRogaQYmTM5+wgNicAp4SW9/sAIszC8hLNG+dzQxhi0vcejKfCWSZ
        hMAudomJX+8zQTzqIjGpq4MFwhaWeHV8CzuELSPxfydMQzOjRPuMWewQTg+jxNY5O9ggqqwl
        Dh+/yAryP7OApsT6XfoQYUeJYzfvsEKChU/ixltBiCP4JCZtm84MEeaV6GiDhrWaxKzj6+DW
        HrxwiXkCo9IsJK/NQvLOLCTvzELYu4CRZRWjeGppcW56arFRXmq5XnFibnFpXrpecn7uJkZg
        Mjr97/iXHYy7/iQdYhTgYFTi4U0Q/hItxJpYVlyZe4hRgoNZSYT3nBZQiDclsbIqtSg/vqg0
        J7X4EKM0B4uSOG81w4NoIYH0xJLU7NTUgtQimCwTB6dUA6POeoHN2d9faa+om9garl9z0Xv3
        s5VT9Wa4zXlfLNr/sHLuw/XGEwoCSu23V7qZ3353Q/GXbWJVTuzvud8CPH4fOSPvviLXJWLt
        chbXqpMm60Jrqp6piERkTu/dJqC0ezEv+57UFflqLv/jIlk2pWQuFGT41bP1jVnL8asaiTGf
        1CycNyQ/L1BiKc5INNRiLipOBACD/puFQgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsVy+t/xe7qzHb5EG3QflraY+vAJm8WV1k2M
        Fve/HmW0+Halg8liyp/lTBaXd81hs/j8fj+rxcUZ55kdODx2zrrL7rFpVSebx51re9g8ps/5
        z+jxeZNcAGuUnk1RfmlJqkJGfnGJrVK0oYWRnqGlhZ6RiaWeobF5rJWRqZK+nU1Kak5mWWqR
        vl2CXsaLPR3sBVvEKx7OZm1gfC/UxcjBISFgInHnrWIXIxeHkMBSRombh1+ydDFyAsVlJE5O
        a2CFsIUl/lzrYoMoesso8ebRTiaQZmGBDIl122tBTBGBZIl3nakgJcwC1xklLk05yQ5R38Qq
        sWVqAzvIIDYBQ4mutyCDODl4Bewkzq/YzgRiswioSrzoXQNmiwrESHRenwdVIyhxcuYTsIM4
        BTwltr7ZwQhiMwuoS/yZd4kZwpaXaN46G8oWl7j1ZD7TBEahWUjaZyFpmYWkZRaSlgWMLKsY
        RVJLi3PTc4sN9YoTc4tL89L1kvNzNzECY2/bsZ+bdzBe2hh8iFGAg1GJhzdB+Eu0EGtiWXFl
        7iFGCQ5mJRHec1pAId6UxMqq1KL8+KLSnNTiQ4ymQM9NZJYSTc4HpoW8knhDU0NzC0tDc2Nz
        YzMLJXHe8waVUUIC6YklqdmpqQWpRTB9TBycUg2Mnt9TjvA8k2TYfzJgf8S0l+o3Iu7LX6vh
        LxN4bTb/9zrRkLTa7sTeldUvJN9du+V3893pV8zZxcwWzR7VN3NXWLe9+TxVW/5K5S3p0Ep5
        Hc9VejYXrkVcvuwb4fN7/VeuY1LBtW7BzLZSW/fPtTHRWZ0wc3Jmxl/9b/+nnJkg2Zm0T+HH
        s1gdJZbijERDLeai4kQAVd5POtMCAAA=
X-CMS-MailID: 20181120171259eucas1p26dbb3058de06193c43689f612d23a1a9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137
References: <20180517164120.485F844007E@finisterre.ee.mobilebroadband>
        <CGME20181120134333eucas1p27a19912dddf4b9b34da505e0973c9137@eucas1p2.samsung.com>
        <66d3b74c-0152-b17b-89d4-a21d33445b25@samsung.com>
        <20181120144700.GB16508@imbe.wolfsonmicro.main>
        <f1c7e9fe-aa57-c7c4-1c2f-02105a5a7474@samsung.com>
        <20181120153215.GC16508@imbe.wolfsonmicro.main>
        <20181120153610.GD16508@imbe.wolfsonmicro.main>
        <9314db6c-9498-579d-430c-5a2992fe513e@samsung.com>
        <59879030-93a4-f562-b03b-c5e579d44e89@opensource.cirrus.com>
        <772b6fdc-57af-fef2-0c85-78446bec2c2a@samsung.com>
        <ea2b959c-0d04-6a50-4d69-3f03576fdac9@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On 2018-11-20 17:57, Richard Fitzgerald wrote:
> On 20/11/18 16:34, Marek Szyprowski wrote:
>> Hi Richard,
>>
>> On 2018-11-20 17:16, Richard Fitzgerald wrote:
>>> On 20/11/18 15:56, Marek Szyprowski wrote:
>>>> Hi Charles,
>>>>
>>>> On 2018-11-20 16:36, Charles Keepax wrote:
>>>>> On Tue, Nov 20, 2018 at 03:32:15PM +0000, Charles Keepax wrote:
>>>>>> On Tue, Nov 20, 2018 at 03:58:59PM +0100, Marek Szyprowski wrote:
>>>>>>> On 2018-11-20 15:47, Charles Keepax wrote:
>>>>>>>> On Tue, Nov 20, 2018 at 02:43:32PM +0100, Marek Szyprowski wrote:
>>>>>>>>> On 2018-05-17 18:41, Mark Brown wrote:
>>>>>>>>>> Subject: [PATCH] regulator: wm8994: Pass descriptor instead of
>>>>>>>>>> GPIO number
>>>>>>>>> This patch causes following kernel warning on Samsung Exynos4412
>>>>>>>>> based
>>>>>>>>> Trats2 board:
>>>>>>>>>
>>>>>>>>> wm8994 4-001a: Failed to get supply 'DBVDD1': -517
>>>>>>>>> wm8994 4-001a: Failed to get supplies: -517
>>>>>> This is really weird, because the error in your log relates to
>>>>>> DBVDD1 which is an independent regulator supplied by a separate
>>>>>> regulator. I am really having some difficulty seeing how the
>>>>>> patch interfers. It is definitely that patch which causes the
>>>>>> issue, like you revert it and things work again?
>>>>> Wait does the board still boot just you have an extra probe defer
>>>>> now? Or does it actually fail?
>>>>
>>>> The board boots fine. The only new thing is the mentioned warning,
>>>> which
>>>> I would
>>>>
>>>> like to have fixed.
>>>>
>>>>
>>>> Best regards
>>>>
>>>
>>> -517 is EPROBE_DEFER. This isn't something  that needs "fixing" unless
>>> the
>>> driver is never able to probe.
>>>
>>> If the wm8994 eventually probes ok after retries it's not a problem,
>>> it's normal kernel behaviour.
>>>
>>> If the wm8994 driver never manages to probe successfully it should
>>> mean that
>>> the driver which supplies DBVDD1 isn't available.
>>
>> Deferred probe was there already. This patch however introduced the
>> warning from gpiolib and I would like to have it fixed somehow. In both
>
> I don't follow what it is you want, are you asking that it shouldn't
> probe
> defer, or that it shouldn't log the reason why it deferred?
>
>> cases (with this patch and before it) the wm8994 driver probes okay -
>> when the required regulators are finally available.
>
> Sounds like all is ok and working as expected.
> If this is causing you a problem you'll need to provide more
> explanation of
> what problem you have so we can understand.


I'm asking for fixing the code (or giving a hint how to fix it) in a way
that gpiolib will not complain. My initial reply [1] had a gpiolib
warning, which is the issue. Deferred probe is the way to trigger it. My
fault that I didn't explain it literally what is the issue.

[1] https://lkml.org/lkml/2018/11/20/997

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

