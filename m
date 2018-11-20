Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5798C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D152087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JWCpHh6X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D152087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeKUC0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:26:49 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36089 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeKUC0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:26:49 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181120155658euoutp01b2d88c7bad3edbbc8cd7cedb30437fab~o4DuRO5VY0602906029euoutp01Q
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 15:56:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181120155658euoutp01b2d88c7bad3edbbc8cd7cedb30437fab~o4DuRO5VY0602906029euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1542729418;
        bh=D5z2dAnTYLs1MM4ThN9VyZYnnglBEQ/x9M1HKEHtQTM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=JWCpHh6X4FtsvwyQzstatVmhUvhfHNkHC2zvL0LkO4vtZCYBzjJonVpoWCdbtEayx
         sTbxWTuh75DCbPPIZiTj+LPhbkPGObypIMAfAeBKBObOcWldsTj2+bKTOJYJy/uKls
         +07kXlySip16qF/E2669fHEVWGW+4+ZxmA+YJ2c8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181120155657eucas1p1e65169a2959e22d3d8f75be96bd5ef5c~o4Ds_dnKZ0688106881eucas1p1o;
        Tue, 20 Nov 2018 15:56:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D4.52.04441.9CE24FB5; Tue, 20
        Nov 2018 15:56:57 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181120155656eucas1p1ea19b81ddf4c4fb1b4c5eced01e47446~o4DsN-II50873608736eucas1p1o;
        Tue, 20 Nov 2018 15:56:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181120155656eusmtrp232432636c3de530d8fcad5cddea55b3f~o4Dr-lBuR0798007980eusmtrp2B;
        Tue, 20 Nov 2018 15:56:56 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-44-5bf42ec9464a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id A0.FB.04284.8CE24FB5; Tue, 20
        Nov 2018 15:56:56 +0000 (GMT)
Received: from [106.116.147.30] (unknown [106.116.147.30]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181120155655eusmtip24bca4bd575d815e9608a2ee73c5dc138~o4DroycYp1233012330eusmtip2e;
        Tue, 20 Nov 2018 15:56:55 +0000 (GMT)
Subject: Re: Applied
 "regulator: wm8994: Pass descriptor instead of GPIO number" to the regulator
 tree
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <9314db6c-9498-579d-430c-5a2992fe513e@samsung.com>
Date:   Tue, 20 Nov 2018 16:56:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
        Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181120153610.GD16508@imbe.wolfsonmicro.main>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djP87on9b5EGzQ84rKY+vAJm8WV1k2M
        Fve/HmW0+Halg8liyp/lTBaXd81hs/j8fj+rA7vHzll32T02repk87hzbQ+bx/Q5/xk9Pm+S
        C2CN4rJJSc3JLEst0rdL4Mq4N2c2Y8EXzopTre8YGxj/sncxcnBICJhIHJgV2cXIxSEksIJR
        4viNZSwQzhdGiR+9fcwQzmdGiWWzbjJ1MXKCdTS9BukGSSxnlFjR9oENwnnPKPF01zUWkCph
        gSyJq3+vsYHYIgJGEh+P32ICKWIWuM4ocXHKEUaQBJuAoUTX2y6wIl4BO4kPV5vBbBYBVYnF
        d26D2aICMRLHVt5ghKgRlDg58wnYAk4BG4mrp7+B1TALyEtsfzuHGcIWl7j1ZD7YMgmBdewS
        334sZob41EVi8l4FiBeEJV4d38IOYctI/N8JU9/MKNE+YxY7hNPDKLF1zg42iCpricPHL7KC
        DGIW0JRYv0sfIuwocezmHVaI+XwSN94KQtzAJzFp23SotbwSHW1CENVqErOOr4Nbe/DCJeYJ
        jEqzkHw2C8k3s5B8Mwth7wJGllWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBSej0v+Of
        djB+vZR0iFGAg1GJhzdB+Eu0EGtiWXFl7iFGCQ5mJRHec1pAId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rzVDA+ihQTSE0tSs1NTC1KLYLJMHJxSDYwh3xlWKF6Knv9bPkY9x4A1zptBN+TU2Rc1
        D49yW1vX/13nyyxj+HrquXbjlM02lsJnEq/XyNw9tv/23zv/I/1Uu68kLNt++4CuQ+WGM5sy
        L9RIRccGPmh5Zu0p1t0azf9OuUPa45fJtOrXW9QqlrP6vWxjOOctwvIu//OSb4/myPy/Z3fb
        ZY8SS3FGoqEWc1FxIgD2X1cZPgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsVy+t/xe7on9L5EGzw5LWQx9eETNosrrZsY
        Le5/Pcpo8e1KB5PFlD/LmSwu75rDZvH5/X5WB3aPnbPusntsWtXJ5nHn2h42j+lz/jN6fN4k
        F8AapWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJdx
        b85sxoIvnBWnWt8xNjD+Ze9i5OSQEDCRaHoNYnNxCAksZZTombQNKiEjcXJaAyuELSzx51oX
        G0TRW0aJDS9eM3UxcnAIC2RIrNteC1IjImAk8fH4LSaQGmaB64wSl6achJo6i1li+5dXLCBV
        bAKGEl1vQSZxcvAK2El8uNoMZrMIqEosvnMbzBYViJHovD4PqkZQ4uTMJ2C9nAI2EldPfwOL
        MwuoS/yZd4kZwpaX2P52DpQtLnHryXymCYxCs5C0z0LSMgtJyywkLQsYWVYxiqSWFuem5xYb
        6hUn5haX5qXrJefnbmIExt22Yz8372C8tDH4EKMAB6MSD2+C8JdoIdbEsuLK3EOMEhzMSiK8
        57SAQrwpiZVVqUX58UWlOanFhxhNgZ6byCwlmpwPTAl5JfGGpobmFpaG5sbmxmYWSuK85w0q
        o4QE0hNLUrNTUwtSi2D6mDg4pRoYNfumh4RnHG2JL2tl5OmdqCgx8cyNNw/+VuexTpAMPqnx
        INJxYuS2voDsNgGT+7xBy9b7L9l18+CH2/7GPmVMm1P/vhdd4Opp/HRy5837cwoEjlbKJ1br
        sHUXMTf/+xItG/5knuJx3l7R/tuLg51+/Spc2N6ss4lttmjJwfWsn55kX5mid+qrEktxRqKh
        FnNRcSIArDpFatECAAA=
X-CMS-MailID: 20181120155656eucas1p1ea19b81ddf4c4fb1b4c5eced01e47446
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

On 2018-11-20 16:36, Charles Keepax wrote:
> On Tue, Nov 20, 2018 at 03:32:15PM +0000, Charles Keepax wrote:
>> On Tue, Nov 20, 2018 at 03:58:59PM +0100, Marek Szyprowski wrote:
>>> On 2018-11-20 15:47, Charles Keepax wrote:
>>>> On Tue, Nov 20, 2018 at 02:43:32PM +0100, Marek Szyprowski wrote:
>>>>> On 2018-05-17 18:41, Mark Brown wrote:
>>>>>> Subject: [PATCH] regulator: wm8994: Pass descriptor instead of GPIO number
>>>>> This patch causes following kernel warning on Samsung Exynos4412 based
>>>>> Trats2 board:
>>>>>
>>>>> wm8994 4-001a: Failed to get supply 'DBVDD1': -517
>>>>> wm8994 4-001a: Failed to get supplies: -517
>> This is really weird, because the error in your log relates to
>> DBVDD1 which is an independent regulator supplied by a separate
>> regulator. I am really having some difficulty seeing how the
>> patch interfers. It is definitely that patch which causes the
>> issue, like you revert it and things work again?
> Wait does the board still boot just you have an extra probe defer
> now? Or does it actually fail?

The board boots fine. The only new thing is the mentioned warning, which
I would

like to have fixed.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

