Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 508B7C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D30204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 11:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D30204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeKAUms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 16:42:48 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:35810 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727507AbeKAUms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 16:42:48 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id wA1BdPkR023127;
        Thu, 1 Nov 2018 06:40:04 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2ncmepdrtu-1;
        Thu, 01 Nov 2018 06:40:04 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id BC89F611CE60;
        Thu,  1 Nov 2018 06:43:07 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 1 Nov 2018
 11:40:03 +0000
Received: from [198.90.251.121] (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 wA1Be1tN023467;        Thu, 1 Nov 2018 11:40:01 GMT
Subject: Re: [PATCH v2 2/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
To:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     Mark Brown <broonie@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-2-ckeepax@opensource.cirrus.com>
 <20181025074459.GF4939@dell> <20181025082621.GD16508@imbe.wolfsonmicro.main>
 <b2f85f45-cbe9-5a27-e9e8-ad28f2bd9bd6@opensource.cirrus.com>
 <20181025114205.GC4870@dell>
 <33ea391c-aa6e-2709-6faf-4905e84229e4@opensource.cirrus.com>
 <20181026080051.GK4870@dell> <20181026203223.GC27137@sirena.org.uk>
 <20181029110439.GS4870@dell> <20181101102828.GM16508@imbe.wolfsonmicro.main>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <71938ce2-00da-8ee0-c010-58c2670ee327@opensource.cirrus.com>
Date:   Thu, 1 Nov 2018 11:40:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181101102828.GM16508@imbe.wolfsonmicro.main>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1811010104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11/18 10:28, Charles Keepax wrote:
> On Mon, Oct 29, 2018 at 11:04:39AM +0000, Lee Jones wrote:
>> On Fri, 26 Oct 2018, Mark Brown wrote:
>>> On Fri, Oct 26, 2018 at 09:00:51AM +0100, Lee Jones wrote:
>>>> On Thu, 25 Oct 2018, Richard Fitzgerald wrote:
> 
> I have re-ordered some of the quotes here for the benefit
> of clarity. I will start with the Lochnagar focused bits
> and then cover some of the more general regmap discussion.
> Apologies for the wall of text towards the end but it seemed
> wise to explore some of the why for parts of the current regmap
> implementation and some of the implications for changing it.
> 
>>> I think from the perspective of Richard and Charles who are just trying
>>> to get their driver merged this is something of an abstract distinction.
>>> If the driver were merged and this discussion were happening separately
>>> their perspective would most likely be different.
>>
>> Charles has already mentioned that he'd take a look at the current
>> *use* (not changing the API, but the way in which Lochnagar
>> *uses/consumes* it).  Actions which would be most welcomed.
>>
>>> I kind of said this above but just to be clear this driver seems to me
>>> like an idiomatic user of the regmap API as it is today.  My guess is
>>> that we could probably loose the defaults tables and not suffer too much
>>> but equally well they don't hurt from a regmap point of view.
>>
>> Perhaps Charles could elaborate on whether this is possible or not?
> 
> So on this front I have had a look through and we can drop the
> defaults tables for Lochnagar, although as I shall cover later
> Lochnagar is the exceptional case with respect to our normal
> devices.
> 
>> Utilising range support here would certainly help IMHO.
>>
> 
> I am rather hesitant to switch to the range API. Whilst it is
> significantly more clear in certain situations, such as say
> mapping out the memory for a DSP, where there exist large
> amorphis blobs of identical function registers. I am really
> not convinced it really suits something like the register map
> that controls Lochnagar. You have an intertwinned mix of
> various purpose registers, each with a clearly defined name
> and potentially with quite fine grained properties.
> 
> Certainly when working with the driver I want to be able to
> fairly quickly see what registers are marked as by name. The
> callbacks are very simple and I don't need to look up where
> register are in the regmap to be able check their attributes.
> But perhaps I have just got too used to seeing these callbacks,
> things do have a way of becoming normal after being exposed to
> them for a while.
> 
> What I will try for the next spin is to try to use as much:
> 
>    case REG1...REG2:
> 
> As I can without totally sacrificing grepability/clarity and
> hopefully that will get us to a compromise we can all live
> with at least for now. Lochnagar is a fairly small part so it
> feels like this should be doable.
> 
>>>>> +       ret = devm_of_platform_populate(dev);
>>>>> +       if (ret < 0) {
>>>>> +               dev_err(dev, "Failed to populate child
>>>>> nodes:
>>>>> %d\n", ret);
>>>>> +               return ret;
>>>>> +       }
>>>>
>>>> Please do not mix OF and MFD device registration
>>>> strategies.
>>>>
>>>> Pick one and register all devices through your chosen
>>>> method.
>>>
>>> Hmmm we use this to do things like register some fixed
>>> regulators
>>> and clocks that don't need any control but do need to be
>>> associated
>>> with the device. I could do that through the MFD although it
>>> is in
>>> direct conflict with the feedback on the clock patches I
>>> received
>>> to move the fixed clocks into devicetree rather than
>>> registering
>>> them manually (see v2 of the patch chain).
>>
>> The I suggest moving everything to DT.
> 
> So pulling this out from earlier discussions in this thread,
> it seems I can happily move all the child device registration
> into device tree. I will also try this for the next version of
> the patch, unless anyone wants to object? But it does change
> the DT binding quite a lot as the individual sub drivers now
> each require their own node rather than one single unified
> Lochnagar node.
> 

We went through this discussion with the Madera MFD patches. I had
originally implemented it using DT to register the child drivers and
it was nice in some ways each driver having its own node. But Mark
and Rob didn't like it so I went back to non-DT child registration with
all sharing the parent MFD node. It would be nice if we could stick to
one way of doing it so that Cirrus drivers don't flip-flop between
different styles of DT binding.

With the Madera MFD, since it now uses non-DT registration of children
if there was a reason we need to be able to register DT-defined children
(and there are potential uses like adding platform-specific virtual
regulators that are treated as a child) the bindings are now fixed so we
would end up having a mixed non-DT and DT registration.

<snip>

