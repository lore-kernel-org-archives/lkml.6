Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C1BC32789
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1190420684
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1190420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbeKUD1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:27:31 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:51541 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbeKUD1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:27:30 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wAKGsZes011325;
        Tue, 20 Nov 2018 10:57:19 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0a-001ae601.pphosted.com with ESMTP id 2nth984p3s-1;
        Tue, 20 Nov 2018 10:57:19 -0600
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 86EC6611E128;
        Tue, 20 Nov 2018 10:57:18 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Tue, 20 Nov 2018
 16:57:18 +0000
Received: from [198.90.251.121] (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 wAKGvGhI006712;        Tue, 20 Nov 2018 16:57:16 GMT
Subject: Re: Applied "regulator: wm8994: Pass descriptor instead of GPIO
 number" to the regulator tree
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
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
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <ea2b959c-0d04-6a50-4d69-3f03576fdac9@opensource.cirrus.com>
Date:   Tue, 20 Nov 2018 16:57:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <772b6fdc-57af-fef2-0c85-78446bec2c2a@samsung.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=846 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1811200150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/18 16:34, Marek Szyprowski wrote:
> Hi Richard,
> 
> On 2018-11-20 17:16, Richard Fitzgerald wrote:
>> On 20/11/18 15:56, Marek Szyprowski wrote:
>>> Hi Charles,
>>>
>>> On 2018-11-20 16:36, Charles Keepax wrote:
>>>> On Tue, Nov 20, 2018 at 03:32:15PM +0000, Charles Keepax wrote:
>>>>> On Tue, Nov 20, 2018 at 03:58:59PM +0100, Marek Szyprowski wrote:
>>>>>> On 2018-11-20 15:47, Charles Keepax wrote:
>>>>>>> On Tue, Nov 20, 2018 at 02:43:32PM +0100, Marek Szyprowski wrote:
>>>>>>>> On 2018-05-17 18:41, Mark Brown wrote:
>>>>>>>>> Subject: [PATCH] regulator: wm8994: Pass descriptor instead of
>>>>>>>>> GPIO number
>>>>>>>> This patch causes following kernel warning on Samsung Exynos4412
>>>>>>>> based
>>>>>>>> Trats2 board:
>>>>>>>>
>>>>>>>> wm8994 4-001a: Failed to get supply 'DBVDD1': -517
>>>>>>>> wm8994 4-001a: Failed to get supplies: -517
>>>>> This is really weird, because the error in your log relates to
>>>>> DBVDD1 which is an independent regulator supplied by a separate
>>>>> regulator. I am really having some difficulty seeing how the
>>>>> patch interfers. It is definitely that patch which causes the
>>>>> issue, like you revert it and things work again?
>>>> Wait does the board still boot just you have an extra probe defer
>>>> now? Or does it actually fail?
>>>
>>> The board boots fine. The only new thing is the mentioned warning, which
>>> I would
>>>
>>> like to have fixed.
>>>
>>>
>>> Best regards
>>>
>>
>> -517 is EPROBE_DEFER. This isn't something  that needs "fixing" unless
>> the
>> driver is never able to probe.
>>
>> If the wm8994 eventually probes ok after retries it's not a problem,
>> it's normal kernel behaviour.
>>
>> If the wm8994 driver never manages to probe successfully it should
>> mean that
>> the driver which supplies DBVDD1 isn't available.
> 
> Deferred probe was there already. This patch however introduced the
> warning from gpiolib and I would like to have it fixed somehow. In both

I don't follow what it is you want, are you asking that it shouldn't probe
defer, or that it shouldn't log the reason why it deferred?

> cases (with this patch and before it) the wm8994 driver probes okay -
> when the required regulators are finally available.

Sounds like all is ok and working as expected.
If this is causing you a problem you'll need to provide more explanation of
what problem you have so we can understand.

> 
> Best regards
> 

