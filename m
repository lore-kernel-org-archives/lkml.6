Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3C3C32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF98820831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RN6FjDH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF98820831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbeKUDE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:04:56 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:46987 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeKUDE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:04:56 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181120163454euoutp01844d3418eac2dd622f44c47dbb972d64~o4k1nWQAq2570725707euoutp01a
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 16:34:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181120163454euoutp01844d3418eac2dd622f44c47dbb972d64~o4k1nWQAq2570725707euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542731694;
        bh=9TWIwEwuZOV/yNNOoNSOdRdWDoLy71iwqu6gfA8HnEs=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=RN6FjDH51HIRlPlUF8fMJ2Dmg3WMWRj9pDdno4mh4DIHoRqnnJn4mLJcRi/pZEYJG
         7+KCWIakaX/Vx1lSaigAuLwUeyvD6btZS+WuXpdITY0FFjI745T5XSA6at9x6WaOEQ
         T9spQS/Ug2nh/dNfg0yskc766ySvbgukWnRQs1Fs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181120163453eucas1p2c6333671e820f7a395dbc8183e73b110~o4k084-YB1119611196eucas1p20;
        Tue, 20 Nov 2018 16:34:53 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 39.24.04806.DA734FB5; Tue, 20
        Nov 2018 16:34:53 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181120163452eucas1p2cddc5831a5ce4115c487b5415e0cb3a3~o4k0IPf9f0931409314eucas1p29;
        Tue, 20 Nov 2018 16:34:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181120163452eusmtrp230813fc12ad63f2de864df43e2b3bd1f~o4kz54SzZ1869318693eusmtrp2C;
        Tue, 20 Nov 2018 16:34:52 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-6b-5bf437adfd2d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 46.AF.04284.CA734FB5; Tue, 20
        Nov 2018 16:34:52 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181120163452eusmtip280a40fc13725d458250e83e1cbc79247~o4kzeemI72155521555eusmtip2X;
        Tue, 20 Nov 2018 16:34:52 +0000 (GMT)
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
Message-ID: <772b6fdc-57af-fef2-0c85-78446bec2c2a@samsung.com>
Date:   Tue, 20 Nov 2018 17:34:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <59879030-93a4-f562-b03b-c5e579d44e89@opensource.cirrus.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djP87przb9EG3w5JWkx9eETNosrrZsY
        Le5/Pcpo8e1KB5PFlD/LmSwu75rDZvH5/X5Wi4szzjM7cHjsnHWX3WPTqk42jzvX9rB5TJ/z
        n9Hj8ya5ANYoLpuU1JzMstQifbsEroxF7b9YCg4JVKw7N5GpgXElbxcjJ4eEgInEqZ6NLF2M
        XBxCAisYJbZs3cEM4XxhlNj38RwrhPOZUaL5+XdGmJb1j26wQySWM0pc757HDJIQEnjPKPFm
        cTWILSyQJXH17zU2EFtEIFni2KnVYJOYBa4zSlyccgRsEpuAoUTX2y6wIl4BO4mNG7ewg9gs
        AqoS+zb9BhsqKhAjcWzlDUaIGkGJkzOfsIDYnAKeEtuf7GQFsZkF5CWat85mhrDFJW49mc8E
        skxCYBe7xI6zZ1kgznaROD+jkRXCFpZ4dRximYSAjMT/nTANzYwS7TNmsUM4PYwSW+fsYIOo
        spY4fPwiUDcH0ApNifW79CHCjhLHbt4BC0sI8EnceCsIcQSfxKRt05khwrwSHW1CENVqErOO
        r4Nbe/DCJeYJjEqzkLw2C8k7s5C8Mwth7wJGllWM4qmlxbnpqcXGeanlesWJucWleel6yfm5
        mxiBCen0v+NfdzDu+5N0iFGAg1GJhzdB+Eu0EGtiWXFl7iFGCQ5mJRHec1pAId6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJMHJxSDYyt0Rw7v34uMA074/NJ/13h
        9jr2D64RXxUEGDcp2S629Gqpe742qPif5KGyEJfXRe2Sm3Q/K0zl38Ez8Yf6kducsp0b3mu8
        3Se6tXn9Ac6oxZFTRA1uHvj/e6rK0xuxQc+++6y5927R9tPerEUrrV1TgjdF8B23OlzpEHOs
        J+LtosNHDsW51iUpsRRnJBpqMRcVJwIAQ8l7JkQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsVy+t/xe7przL9EG/xapWAx9eETNosrrZsY
        Le5/Pcpo8e1KB5PFlD/LmSwu75rDZvH5/X5Wi4szzjM7cHjsnHWX3WPTqk42jzvX9rB5TJ/z
        n9Hj8ya5ANYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQi
        fbsEvYxF7b9YCg4JVKw7N5GpgXElbxcjJ4eEgInE+kc32LsYuTiEBJYySjy49psVIiEjcXJa
        A5QtLPHnWhcbiC0k8JZR4kWDZxcjB4ewQIbEuu21IKaIQLLEu85UkDHMAtcZJS5NOQk1s49F
        YtKsr2C9bAKGEl1vIebwCthJbNy4hR3EZhFQldi36TcziC0qECPReX0eVI2gxMmZT1hAbE4B
        T4ntT3aC3cMsoC7xZ94lZghbXqJ562woW1zi1pP5TBMYhWYhaZ+FpGUWkpZZSFoWMLKsYhRJ
        LS3OTc8tNtQrTswtLs1L10vOz93ECIy+bcd+bt7BeGlj8CFGAQ5GJR7eBOEv0UKsiWXFlbmH
        GCU4mJVEeM9pAYV4UxIrq1KL8uOLSnNSiw8xmgI9N5FZSjQ5H5gY8kriDU0NzS0sDc2NzY3N
        LJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1MKqari1ZY9yytN3gUrXCHsmZ28pt60QEn9j/
        WjI1coHvR5sAo5zCKX3Cffafp604N2nNF/F9XuY1jlnXDVgWTLrw31aT0/50Q3iD+Xz7LwIn
        X27f45jVJR6b/Pf49Hefkr7G/Funs8ZadtJ5qT8Nc55/5diWEVwSf3fzqvbmv7vP3NDr/Mqd
        JKPEUpyRaKjFXFScCAAhPuI51AIAAA==
X-CMS-MailID: 20181120163452eucas1p2cddc5831a5ce4115c487b5415e0cb3a3
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On 2018-11-20 17:16, Richard Fitzgerald wrote:
> On 20/11/18 15:56, Marek Szyprowski wrote:
>> Hi Charles,
>>
>> On 2018-11-20 16:36, Charles Keepax wrote:
>>> On Tue, Nov 20, 2018 at 03:32:15PM +0000, Charles Keepax wrote:
>>>> On Tue, Nov 20, 2018 at 03:58:59PM +0100, Marek Szyprowski wrote:
>>>>> On 2018-11-20 15:47, Charles Keepax wrote:
>>>>>> On Tue, Nov 20, 2018 at 02:43:32PM +0100, Marek Szyprowski wrote:
>>>>>>> On 2018-05-17 18:41, Mark Brown wrote:
>>>>>>>> Subject: [PATCH] regulator: wm8994: Pass descriptor instead of
>>>>>>>> GPIO number
>>>>>>> This patch causes following kernel warning on Samsung Exynos4412
>>>>>>> based
>>>>>>> Trats2 board:
>>>>>>>
>>>>>>> wm8994 4-001a: Failed to get supply 'DBVDD1': -517
>>>>>>> wm8994 4-001a: Failed to get supplies: -517
>>>> This is really weird, because the error in your log relates to
>>>> DBVDD1 which is an independent regulator supplied by a separate
>>>> regulator. I am really having some difficulty seeing how the
>>>> patch interfers. It is definitely that patch which causes the
>>>> issue, like you revert it and things work again?
>>> Wait does the board still boot just you have an extra probe defer
>>> now? Or does it actually fail?
>>
>> The board boots fine. The only new thing is the mentioned warning, which
>> I would
>>
>> like to have fixed.
>>
>>
>> Best regards
>>
>
> -517 is EPROBE_DEFER. This isn't something  that needs "fixing" unless
> the
> driver is never able to probe.
>
> If the wm8994 eventually probes ok after retries it's not a problem,
> it's normal kernel behaviour.
>
> If the wm8994 driver never manages to probe successfully it should
> mean that
> the driver which supplies DBVDD1 isn't available.

Deferred probe was there already. This patch however introduced the
warning from gpiolib and I would like to have it fixed somehow. In both
cases (with this patch and before it) the wm8994 driver probes okay -
when the required regulators are finally available.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

