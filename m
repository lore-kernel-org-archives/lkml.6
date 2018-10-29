Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2D1C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B1A720664
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B1A720664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeJ2VZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:25:34 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:46706 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729221AbeJ2VZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:25:32 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9TCXSe3025522;
        Mon, 29 Oct 2018 07:36:55 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2ncmep9wuy-1;
        Mon, 29 Oct 2018 07:36:55 -0500
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id B882D611C8B1;
        Mon, 29 Oct 2018 07:39:21 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Mon, 29 Oct 2018
 12:36:54 +0000
Received: from [198.90.251.121] (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w9TCar81029603;        Mon, 29 Oct 2018 12:36:53 GMT
Subject: Re: [PATCH v2 2/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
To:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>
CC:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-2-ckeepax@opensource.cirrus.com>
 <20181025074459.GF4939@dell> <20181025082621.GD16508@imbe.wolfsonmicro.main>
 <b2f85f45-cbe9-5a27-e9e8-ad28f2bd9bd6@opensource.cirrus.com>
 <20181025114205.GC4870@dell>
 <33ea391c-aa6e-2709-6faf-4905e84229e4@opensource.cirrus.com>
 <20181026080051.GK4870@dell> <20181026203223.GC27137@sirena.org.uk>
 <20181029110439.GS4870@dell>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <53bedd0a-da8e-0178-7d0d-e322542dba8d@opensource.cirrus.com>
Date:   Mon, 29 Oct 2018 12:36:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181029110439.GS4870@dell>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1810290119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/18 11:04, Lee Jones wrote:
> On Fri, 26 Oct 2018, Mark Brown wrote:
>> On Fri, Oct 26, 2018 at 09:00:51AM +0100, Lee Jones wrote:
>>> On Thu, 25 Oct 2018, Richard Fitzgerald wrote:
>>
>>>> Largely the point. How long do you think it would take to populate the
>>>> cache if you had to read thousands of registers over I2C? Boot time matters.
>>>> Deferring it until it's touched can create various unpredictable and
>>>> annoying behaviour later, for example if a lot of cache entries are
>>>> written while the chip is asleep and the initial values weren't known
>>>> then a suspend/resume cannot filter out writes that are setting the
>>>> register to its default (which regmap does to avoid unnecessary bus traffic).
>>>> So the resume could have a large amount of unnecessary overhead writing
>>>> registers to a value they already have or reading the initial values of
>>>> those registers.
>>
>>> One more register read when initially writing to a register and one
>>> more when resuming doesn't sound like a vast amount of over-head.
>>
>> Especially on resume extra register I/O really adds up - people really
>> care how long their system takes to come back from suspend, and how
>> quickly individual devices come back.  For devices that are on slow
>> buses like I2C this means that every register operation counts.  Boot
>> can be similarly pressured of course, though it's a less frequent issue
>> for these devices.
>>
>>> Not sure what you think I was suggesting above.  If the default values
>>> are actually non-zero that's fine - we'll either leave them as they
>>> are (if they are never changed, in which case Regmap doesn't even need
>>> to know about them), document only those (non-zero) ones or wait until
>>> they are read for the first time, then populate the cache.
>>
>> You can't assume that the device is in power on reset state unless the
>> driver reset it itself which may or may not be a good idea or even
>> possible, sometimes it's what you want but at other times even if it's
>> possible it can cause user visible disruption during the boot process
>> which is undesirable.
>>
>>> Setting up the cache manually also sounds like a vector for potential
>>> failure.  At least if you were to cache dynamically on first write
>>> (either on start-up or after sleep) then the actual value will be
>>> cached, rather than what a piece of C code says it should be.
>>
>> Even where there's no problem getting the hardware into a clean state it
>> can rapidly get very, very expensive to do this with larger register
>> sets on slow buses, and at the framework level we can't assume that
>> readback support is even present on the device (the earliest versions of
>> cache support were written to support such devices).  Some of the
>> userspaces that regmap devices get used with end up wanting to apply a
>> bunch of configuration at startup, if we can cut down on the amount of
>> I/O that's involved in doing that it can help them quite a bit.  You
>> also get userspaces that want to enumerate device state at startup,
>> that's a bit easier to change in userspace but it's not an unreasonable
>> thing to want to do and can also get very I/O heavy.
>>
>> There is some potential for errors to be introduced but equally these
>> tables can be both generated and verified mechanically, tasks that are
>> particularly straightforward for the device vendors to do.  There are
>> also potential risks in doing this at runtime if we didn't get the
>> device reset, if we don't accurately mark the volatile registers as
>> volatile or if there's otherwise bugs in the code.
>>
>>> Precisely my point.  Lochnagar is a small device yet it's required to
>>> submit hundreds of lines of Regmap tables.  Imagine what that would
>>> look like for a large device.
>>
>> There's no *requirement* to provide the data even if you're using the
>> cache (and the cache support is entirely optional), there's just costs
>> to not providing it in terms of what features you can get from the
>> regmap API and the performance of the system.  Not every device is going
>> to be bothered by those costs, many devices don't provide all of the
>> data they could.
> 
> So what do we do in the case where, due to the size of the device, the
> amount of lines required by these tables go from crazy to grotesque?
> 
>> I'm not clear to me that Lochnagar will particularly benefit from
>> providing the cache defaults but it sounds like you've raised concerns
>> about other devices which would, and it seems clear that the readability
>> information is very useful for this device if there's registers that
>> it's unsafe to try to read from.
> 
> Any reduction in lines would be a good thing.  Charles, could you
> please define what specific benefits you gain from providing providing
> the pre-cache data please?  With a particular emphasis on whether the
> trade-off is justified.
> 
>>>>> Even if it is absolutely critical that you have to supply these to
>>>>> Regmap up-front, instead of on first use/read, why can't you just
>>>>> supply the oddball non-zero ones?
>>
>> That doesn't work, we need to know both if the register has a default
>> value and what that value is - there's no great value in only supplying
>> the defaults for registers with non-zero values.
> 
> All registers have a default value.  Why can't we assume that if a
> register is writable and a default value was omitted then the default
> is zero?
> 
> Ah wait!  As I was typing the above, I just had a thought.  We don't
> actually provide a list of writable registers do we?  Only a the
> ability to verify if one is writable (presumably) before a write.
> 
> That's frustrating!
> 
>>>> If you aren't happy with the regmap subsystem you could send some
>>>> patches to change it to what you would be happy with (and patch the ~1300
>>>> drivers that use it)
>>
>>> That may well happen.  This is the pre-patch discussion.
>>
>>> Apologies that it had to happen on your submission, but this is that
>>> alerted me to the issue(s).
>>
>> The regmap cache API has been this way since it was introduced in 2011
>> FWIW, we did add range based support later which is purely data driven.
> 
> Utilising range support here would certainly help IMHO.
> 
>>>> Like any kernel subsystem it has an API that we have to obey to be able to
>>>> use it.
>>
>>> Again, this isn't about Lochnagar.
>>
>> I think from the perspective of Richard and Charles who are just trying
>> to get their driver merged this is something of an abstract distinction.
>> If the driver were merged and this discussion were happening separately
>> their perspective would most likely be different.
> 
> Charles has already mentioned that he'd take a look at the current
> *use* (not changing the API, but the way in which Lochnagar
> *uses/consumes* it).  Actions which would be most welcomed.
> 
>>>>> The API is obscene and needs a re-work IMHO.
>>
>>>>> I really hope we do not really have to list every register, but *if we
>>>>> absolutely must*, let's do it once:
>>
>>>>>     REG_ADDRESS, WRV, INITIAL_VALUE
>>
>> There is the option to specify range based access tables instead of a
>> function, for a lot of devices this is a nice, easy way to specify
>> things that makes more sense so we support it.  We don't combine the
>> tables because they're range based and if there is 100% overlap you can
>> always just point at the same table.
>>
>> We allow the functions partly because it lets people handle weird cases
>> but also because it turned out when I looked at this that a lot of the
>> time the compiler output for switch statements was pretty efficient with
>> sparse register maps and it makes the code incredibly simple, much
>> simpler than trying to parse access tables into a more efficient data
>> structure and IIRC more compact too.  It's possible that those tradeoffs
>> have changed since but at the time there was a class of devices where it
>> wasn't clear that putting more effort in would result in substantially
>> better outcomes.
>>
>>>> To re-iterate, regmap is a standard kernel subsystem. It's not owned by Cirrus,
>>>> so it's not our responsibility if you don't like it. Mark Brown is the maintainer.
>>
>>> Sounds very much like you are saying, "it's not Cirrus' fault,
>>> therefore it is not my problem"?  Which is a terrible attitude.
>>
>> I think from the perspective of Charles and Richard this is sounding an
>> awful lot like you want them (or someone else) to rewrite a very widely
>> used kernel API before they can get their driver merged.  To me that
>> would be a completely disproportionate amount of effort for their goal
>> but unfortunately people do get asked to do things like that so it's not
>> an unreasonable fear for them to have.
> 
> I would see that as an unreasonable request.
> 
> To be clear, that is *not* what I am asking.
> 
>>> Remember that the Linux kernel is an open community.  Anyone should be
>>> free to discuss any relevant issue.  If we decide to take this
>>> off-line, which is likely, then so be it.  In the mean time, as a
>>> contributor to this community project, it's absolutely your
>>> responsibly to help discuss and potentially solve wider issues than
>>> just your lines of code.
>>
>> It's also a community of people with differing amounts of ability to
>> contribute, due to things like time, energy and so on.  Not everyone can
>> work on everything they want to, let alone other things people ask them
>> to look at.
> 
> I'm not asking for code submission.  Merely contributing to this
> discussion, or simply allowing it to happen on the back of one of
> their submission is enough.
> 
> Denouncing all responsibility and a lack of care is not okay.
> 
>>>> As above, if one subsystem owner doesn't like another subsystem then those
>>>> subsystem owners should talk to each other and sort something out. It shouldn't
>>>> block patches that are just trying to use the subsystem as it currently exists
>>>> in the kernel.
>>
>>> Again, no one is blocking this patch.
>>
>>> This driver was submitted for review/discussion.  We are discussing.
>>
>> I kind of said this above but just to be clear this driver seems to me
>> like an idiomatic user of the regmap API as it is today.  My guess is
>> that we could probably loose the defaults tables and not suffer too much
>> but equally well they don't hurt from a regmap point of view.
> 
> Perhaps Charles could elaborate on whether this is possible or not?
> 
>> Reviwed-by: Mark Brown <broonie@kernel.org>
> 
> Thanks.
> 

If we're going to need to change regmap to get drivers that use regmap accepted into
MFD (at least without crippling them), can Lee or Mark please create a separate discussion
thread for that, and include the major contributors/users of regmap so Lee can air his
objections and proposals to a more appropriate group of people and we can get feedback
from the right people, and hopefully come to some sort of decision.

