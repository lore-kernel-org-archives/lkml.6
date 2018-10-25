Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA090C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:40:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51B720831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 13:40:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51B720831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeJYWNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:13:43 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:45682 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727590AbeJYWNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:13:43 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9PDejGo031072;
        Thu, 25 Oct 2018 08:40:45 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0b-001ae601.pphosted.com with ESMTP id 2n80spenur-1;
        Thu, 25 Oct 2018 08:40:44 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id 02D64611C8AC;
        Thu, 25 Oct 2018 08:43:38 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 25 Oct 2018
 14:40:40 +0100
Received: from [198.90.251.121] (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w9PDed74011985;        Thu, 25 Oct 2018 14:40:39 +0100
Subject: Re: [PATCH v2 2/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
To:     Lee Jones <lee.jones@linaro.org>
CC:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <broonie@kernel.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-2-ckeepax@opensource.cirrus.com>
 <20181025074459.GF4939@dell> <20181025082621.GD16508@imbe.wolfsonmicro.main>
 <b2f85f45-cbe9-5a27-e9e8-ad28f2bd9bd6@opensource.cirrus.com>
 <20181025114205.GC4870@dell>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <33ea391c-aa6e-2709-6faf-4905e84229e4@opensource.cirrus.com>
Date:   Thu, 25 Oct 2018 14:40:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181025114205.GC4870@dell>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810250118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/18 12:42, Lee Jones wrote:
> On Thu, 25 Oct 2018, Richard Fitzgerald wrote:
>> On 25/10/18 09:26, Charles Keepax wrote:
>>> On Thu, Oct 25, 2018 at 08:44:59AM +0100, Lee Jones wrote:
>>>> On Mon, 08 Oct 2018, Charles Keepax wrote:
>>>>> From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
>>>>> +static const struct reg_default lochnagar1_reg_defaults[] = {
>>>>> +	{ LOCHNAGAR1_CDC_AIF1_SEL,    0x00 },
>>>>> +	{ LOCHNAGAR1_CDC_AIF2_SEL,    0x00 },
>>> ...
>>>>> +	{ LOCHNAGAR1_LED1,            0x00 },
>>>>> +	{ LOCHNAGAR1_LED2,            0x00 },
>>>>> +	{ LOCHNAGAR1_I2C_CTRL,        0x01 },
>>>>> +};
>>>>
>>>> Why do you need to specify each register value?
>>>
>>> The way regmap operates it needs to know the starting value of
>>> each register. It will use this to initialise the cache and to
>>> determine if writes need to actually update the hardware on
>>> cache_syncs after devices have been powered back up.
> 
> That sounds crazy to me.  Some devices have thousands of registers.

Largely the point. How long do you think it would take to populate the
cache if you had to read thousands of registers over I2C? Boot time matters.
Deferring it until it's touched can create various unpredictable and
annoying behaviour later, for example if a lot of cache entries are
written while the chip is asleep and the initial values weren't known
then a suspend/resume cannot filter out writes that are setting the
register to its default (which regmap does to avoid unnecessary bus traffic).
So the resume could have a large amount of unnecessary overhead writing
registers to a value they already have or reading the initial values of
those registers.

> At a line per register, that's thousands of lines of code/cruft.
> Especially seeing as most (sane?) register layouts I've seen default
> to zero.

Not a valid generalization. And it's not a question of sanity, the purpose
of the register and the overhead to setup a use-case also matter.
There are many reasons why the default of a register might not be zero.
Take a look at drivers/mfd/wm5110-tables.c, a lot of the registers don't
have a default of zero (and that's only the registers accessed by the driver.)
It's particularly true of registers that affect things like voltage and
current sources, zero might be a very inappropriate default - even dangerous.
Also enable bits, if some things must power-up enabled and others don't, unless
you want a chip that has a confusing mix of inverted and non-inverted enable
bits. Another side to this is to reduce the number of writes to enable _typical_
behaviour - if an IP block has say 100 registers and you have to write all of
them to make it work that's a lot of overhead compared to them defaulting to
typical values used 99.9% of the time and you only need to write one or two
registers to use it.

   Then default values can be changed at the leisure of the
> s/w.

Potentially with a lot of overhead, especially on those chips with thousands
of registers to set to useful non-zero values before you can use it.

Lochnagar doesn't have that many registers but convention and consistency also
comes into play. Regmap is used in a particular way and it helps people a lot
if every driver using it follows the convention.

> 
> Even if it is absolutely critical that you have to supply these to
> Regmap up-front, instead of on first use/read, why can't you just
> supply the oddball non-zero ones?
> 

If you aren't happy with the regmap subsystem you could send some
patches to change it to what you would be happy with (and patch the ~1300
drivers that use it)

Like any kernel subsystem it has an API that we have to obey to be able to
use it.

>>>>> +static const struct reg_sequence lochnagar1_patch[] = {
>>>>> +	{ 0x40, 0x0083 },
>>>>> +	{ 0x46, 0x0001 },
>>>>> +	{ 0x47, 0x0018 },
>>>>> +	{ 0x50, 0x0000 },
>>>>> +};
>>>>
>>>> I'm really not a fan of these so call 'patches'.
>>>>
>>>> Can't you set the registers up proper way?
>>>>
>>>
>>> I will see if we could move any out of here or define any of the
>>> registers but as we have discussed before it is not always possible.
>>>
>>
>> Also patches generally come out of hardware tuning/qualification/tools
>> as this list of address,value. So it's easy for people to dump an update
>> into the driver as a trivial copy-paste but more work if they have to
>> reverse-engineer the patch list from hardware/datasheet into what each
>> line "means" and then find the relevant lines of code to change. It's also
>> much easier to answer the question "Have these hardware patches been
>> applied to the driver?" if we have them in the original documented format.
>> It just makes people's lives more difficult if they have to search around
>> the code to try to find something that looks like the originally specified
>> patch list. We don't use them just as a lazy way to setup some registers.
> 
> I understand why they normally exist (sometimes people are just lazy
> too) (Mark: BTW chicken-bits sound delicious!).  They're just ugly
> from an Open Source PoV.
> 

In my opinion a lot of the source code in Linux is much uglier than
these tables.

>>>>> +static bool lochnagar2_readable_register(struct device *dev, unsigned int reg)
>>>>> +{
>>>>> +	switch (reg) {
>>>>> +	case LOCHNAGAR_SOFTWARE_RESET:
>>>>> +	case LOCHNAGAR_FIRMWARE_ID1:
>>>>> +	case LOCHNAGAR_FIRMWARE_ID2:
>>> ...
>>>>> +	case LOCHNAGAR2_MICVDD_CTRL2:
>>>>> +	case LOCHNAGAR2_VDDCORE_CDC_CTRL1:
>>>>> +	case LOCHNAGAR2_VDDCORE_CDC_CTRL2:
>>>>> +	case LOCHNAGAR2_SOUNDCARD_AIF_CTRL:
>>>>> +		return true;
>>>>> +	default:
>>>>> +		return false;
>>>>> +	}
>>>>> +}
>>>>> +
>>>>> +static bool lochnagar2_volatile_register(struct device *dev, unsigned int reg)
>>>>> +{
>>>>> +	switch (reg) {
>>>>> +	case LOCHNAGAR2_GPIO_CHANNEL1:
>>>>> +	case LOCHNAGAR2_GPIO_CHANNEL2:
>>>>> +	case LOCHNAGAR2_GPIO_CHANNEL3:
>>> ...
>>>>> +	case LOCHNAGAR2_GPIO_CHANNEL13:
>>>>> +	case LOCHNAGAR2_GPIO_CHANNEL14:
>>>>> +	case LOCHNAGAR2_GPIO_CHANNEL15:
>>>>> +	case LOCHNAGAR2_GPIO_CHANNEL16:
>>>>> +	case LOCHNAGAR2_ANALOGUE_PATH_CTRL1:
>>>>> +		return true;
>>>>> +	default:
>>>>> +		return false;
>>>>> +	}
>>>>> +}
>>>>
>>>> This is getting silly now.  Can't you use ranges?
>>>
>>> I can if you feel strongly about it? But it does make the drivers
>>> much more error prone and significantly more annoying to work
>>> with. I find it is really common to be checking that a register
>>> is handled correctly through the regmap callbacks and it is nice
>>> to just be able to grep for that. Obviously this won't work for
>>> all devices/regmaps as well since many will not have consecutive
>>> addresses on registers, for example having multi-byte registers
>>> that are byte addressed.
>>>
>>> How far would you like me to take this as well? Is it just the
>>> numeric registers you want ranges for ie.
>>>
>>> LOCHNAGAR2_GPIO_CHANNEL1...LOCHNAGAR_GPIO_CHANNEL16
>>>
>>> Or is it all consecutive registers even if they are unrelated
>>> (exmaple is probably not accurate as I haven't checked the
>>> addresses):
>>>
>>> LOCHNAGAR2_GPIO_CHANNEL1...LOCHNAGAR2_ANALOGURE_PATH_CTRL1
>>>
>>> I don't mind the first at all but the second is getting really
>>> horrible in my opinion.
> 
> My issue is that we have one end of the scale, where contributors are
> submitting patches, trying to remove a line of code here, a line of
> code there, then there are patches like this one which describe the
> initial value, readable status, writable status and volatile status of
> each and every register.
> 

If we could add support for new devices by removing lines of code that
would be cool :). Eventually Linux would support every piece of hardware
and be zero lines of code.

> The API is obscene and needs a re-work IMHO.
> 
> I really hope we do not really have to list every register, but *if we
> absolutely must*, let's do it once:
> 
>    REG_ADDRESS, WRV, INITIAL_VALUE
> 

To re-iterate, regmap is a standard kernel subsystem. It's not owned by Cirrus,
so it's not our responsibility if you don't like it. Mark Brown is the maintainer.

Submit your patches to Mark and the owners of those ~1300 drivers to propose
changes to regmap that you would be happy with.

>>>>> +static const struct reg_default lochnagar2_reg_defaults[] = {
>>>>> +	{ LOCHNAGAR2_CDC_AIF1_CTRL,         0x0000 },
>>>>> +	{ LOCHNAGAR2_CDC_AIF2_CTRL,         0x0000 },
>>>>> +	{ LOCHNAGAR2_CDC_AIF3_CTRL,         0x0000 },
>>>>> +	{ LOCHNAGAR2_DSP_AIF1_CTRL,         0x0000 },
>>> ...
>>>>> +	{ LOCHNAGAR2_MINICARD_RESETS,       0x0000 },
>>>>> +	{ LOCHNAGAR2_ANALOGUE_PATH_CTRL2,   0x0000 },
>>>>> +	{ LOCHNAGAR2_COMMS_CTRL4,           0x0001 },
>>>>> +	{ LOCHNAGAR2_SPDIF_CTRL,            0x0008 },
>>>>> +	{ LOCHNAGAR2_POWER_CTRL,            0x0001 },
>>>>> +	{ LOCHNAGAR2_SOUNDCARD_AIF_CTRL,    0x0000 },
>>>>> +};
>>>>
>>>> OMG!  Vile, vile vile!
>>>
>>> I really feel this isn't the driver you are objecting to as such
>>> but the way regmap operates and also we seem to always have the same
>>> discussions around regmap every time we push a driver.
> 
> Absolutely.  I didn't like it before.  I like it even less now.
> 
>>> Is there
>>> any way me, you and Mark could hash this out and find out a way to
>>> handle regmaps that is acceptable to you? I don't suppose you are
>>> in Edinburgh at the moment for ELCE?
> 
> I'm not at ELCE I'm afraid.
> 
>> I suppose if Mark was willing to promote the regmap drivers to be a
>> top-level subsystem that could contain the regmap definitions of devices
>> then we could dump our regmap definitions in there, where Mark can review
>> it as he's familiar with regmap and the chips and the reasons why things
>> are done the way they are, rather than Lee having to stress about it every
>> time we need to create an MFD device that uses regmap. Though that would
>> make the initialization of an MFD rather awkward with the code required
>> to init the MFD it not actually being in the MFD tree.
> 
> My issue isn't where all this bumph lives.
> 
> It's the fact that it's required (at least at this level) at all.
> 

As above, if one subsystem owner doesn't like another subsystem then those
subsystem owners should talk to each other and sort something out. It shouldn't
block patches that are just trying to use the subsystem as it currently exists
in the kernel.

>>>>> +	/* Wait for Lochnagar to boot */
>>>>> +	ret = lochnagar_wait_for_boot(lochnagar->regmap, &val);
>>>>> +	if (ret < 0) {
>>>>> +		dev_err(dev, "Failed to read device ID: %d\n", ret);
>>>>
>>>> Eh?
>>>>
>>>> So you read the LOCHNAGAR_SOFTWARE_RESET register and out pops the
>>>> device/revision IDs?  That's just random!
>>>
>>> I shall let the hardware guys know you don't approve of their
>>> life choices :-) and add some comments to the code.
> 
> Please do.  And tell them to stop drinking at lunch time. ;)
> 
>>>>> +	ret = devm_of_platform_populate(dev);
>>>>> +	if (ret < 0) {
>>>>> +		dev_err(dev, "Failed to populate child nodes: %d\n", ret);
>>>>> +		return ret;
>>>>> +	}
>>>>
>>>> Please do not mix OF and MFD device registration strategies.
>>>>
>>>> Pick one and register all devices through your chosen method.
>>>
>>> Hmmm we use this to do things like register some fixed regulators
>>> and clocks that don't need any control but do need to be associated
>>> with the device. I could do that through the MFD although it is in
>>> direct conflict with the feedback on the clock patches I received
>>> to move the fixed clocks into devicetree rather than registering
>>> them manually (see v2 of the patch chain).
> 
> The I suggest moving everything to DT.
> 
>>> I will have a look see if I can find any ideas that will make
>>> everyone happy but we might need to discuss with Mark and the
>>> clock guys.
>>>
>>>>> +	.probe_new = lochnagar_i2c_probe,
>>>>
>>>> Hasn't this been replaced yet?
>>>
>>> I will check, the patchset has been around internally for a while
>>> so it is possible this is no longer needed.
>>>
>>>>> +#ifndef CIRRUS_LOCHNAGAR_H
>>>>> +#define CIRRUS_LOCHNAGAR_H
>>>>> +
>>>>> +#include "lochnagar1_regs.h"
>>>>> +#include "lochnagar2_regs.h"
>>>>
>>>> Why are you including these here?
>>>>
>>>
>>> It is just a convenience so the drivers only need to include
>>> lochnagar.h rather than including all three headers manually.
> 
> That's against convention.
> 
> If a source file needs a head, it should include it explicitly.
> 
>>>>> diff --git a/include/linux/mfd/lochnagar1_regs.h b/include/linux/mfd/lochnagar1_regs.h
>>>>> diff --git a/include/linux/mfd/lochnagar2_regs.h b/include/linux/mfd/lochnagar2_regs.h
>>>>
>>>> So Lochnagar 1 and 2 are completely different devices?
>>>>
>>>> What do they do?
>>>
>>> Completely different devices is a bit strong, they are different
>>> versions of the same system. They have quite different register
>>> maps but provide very similar functionality.
>>
>> The register maps are different partly because some silicon
>> used on the V1 is no longer manufactured and partly because some
>> silicon added in V2 didn't fit into the older register map.
> 
> I just looked at the maps, which appeared to be vastly different.
> 

We said the maps are different.

>>> All the other comments I will get fixed up for the next spin of
>>> the patches.
> 

