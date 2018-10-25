Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F76DC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A8120840
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A8120840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727595AbeJYWU7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:20:59 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:36706 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727308AbeJYWU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:20:58 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9PDkPsi009409;
        Thu, 25 Oct 2018 08:48:01 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2n81s36vbg-1;
        Thu, 25 Oct 2018 08:48:01 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 9BBB9611C8AC;
        Thu, 25 Oct 2018 08:50:57 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 25 Oct 2018
 14:47:59 +0100
Received: from [198.90.251.121] (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w9PDlx9M019462;        Thu, 25 Oct 2018 14:47:59 +0100
Subject: Re: [PATCH v2 2/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <broonie@kernel.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-2-ckeepax@opensource.cirrus.com>
 <20181025074459.GF4939@dell> <20181025082621.GD16508@imbe.wolfsonmicro.main>
 <b2f85f45-cbe9-5a27-e9e8-ad28f2bd9bd6@opensource.cirrus.com>
 <20181025114205.GC4870@dell> <20181025124905.GF16508@imbe.wolfsonmicro.main>
 <20181025132043.GG16508@imbe.wolfsonmicro.main>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <d0e76752-1b31-e9e3-d684-9d78ddc98172@opensource.cirrus.com>
Date:   Thu, 25 Oct 2018 14:47:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181025132043.GG16508@imbe.wolfsonmicro.main>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=992 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810250119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/18 14:20, Charles Keepax wrote:
> On Thu, Oct 25, 2018 at 01:49:05PM +0100, Charles Keepax wrote:
>> On Thu, Oct 25, 2018 at 12:42:05PM +0100, Lee Jones wrote:
>>> On Thu, 25 Oct 2018, Richard Fitzgerald wrote:
>>>> On 25/10/18 09:26, Charles Keepax wrote:
>>>>> On Thu, Oct 25, 2018 at 08:44:59AM +0100, Lee Jones wrote:
>>>>>> On Mon, 08 Oct 2018, Charles Keepax wrote:
>>>>>>> From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
>>>>> I really feel this isn't the driver you are objecting to as such
>>>>> but the way regmap operates and also we seem to always have the same
>>>>> discussions around regmap every time we push a driver.
>>>
>>> Absolutely.  I didn't like it before.  I like it even less now.
>>>
>>
>> I guess the question from my side becomes do you want to block
>> this driver pending on major refactoring to regmap? I will have a
>> think about what I can do but its going to affect a LOT of drivers.
>>
> 
> Actually one more thought, perhaps as a halfway for now i could
> look into removing the readables

Be careful with that, there are some addresses that are illegal to
access. What does regmap debugfs do if you don't have a readables
list? Just reading a debugfs shouldn't be able to kill the hardware.
You might need to add a precious list which is more error prone
than listing the valid readables we are using.

  and defaults. We lose some things
> like error checking that we are reading real registers but as
> this driver doesnt currently do cache syncs we might be able to
> get away with this for now.
> 
> Unless anyone strenuously objects i will have a look at the
> options there. As well as looking at wider refactoring but aiming
> further out.
> 
> Thanks,
> Charles
> 

