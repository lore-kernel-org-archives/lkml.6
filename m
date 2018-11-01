Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36F9C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C9A32064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 14:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9A32064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbeKAXUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:20:43 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:53652 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728016AbeKAXUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:20:43 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id wA1EFOtb009420;
        Thu, 1 Nov 2018 09:17:26 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail4.cirrus.com ([87.246.98.35])
        by mx0a-001ae601.pphosted.com with ESMTP id 2ncne2x72s-1;
        Thu, 01 Nov 2018 09:17:25 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail4.cirrus.com (Postfix) with ESMTP id B1BA4611CE60;
        Thu,  1 Nov 2018 09:20:29 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 1 Nov 2018
 14:17:25 +0000
Received: from [198.90.251.121] (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 wA1EHNhI027096;        Thu, 1 Nov 2018 14:17:23 GMT
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
Message-ID: <b5dd5b3f-929a-d9be-1d43-36c2f087179c@opensource.cirrus.com>
Date:   Thu, 1 Nov 2018 14:17:23 +0000
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
 definitions=main-1811010124
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

<snip>

>>>> Precisely my point.  Lochnagar is a small device yet it's required to
>>>> submit hundreds of lines of Regmap tables.  Imagine what that would
>>>> look like for a large device.
>>>
>>> There's no *requirement* to provide the data even if you're using the
>>> cache (and the cache support is entirely optional), there's just costs
>>> to not providing it in terms of what features you can get from the
>>> regmap API and the performance of the system.  Not every device is going
>>> to be bothered by those costs, many devices don't provide all of the
>>> data they could.
>>
>> So what do we do in the case where, due to the size of the device, the
>> amount of lines required by these tables go from crazy to grotesque?
>>
> 
> Ultimately, I guess I have always just viewed it as just data
> tables. Its a lot of lines of source but its not complicated,
> and complexity has really always been the thing I try to avoid.
>

Again my question is why does it matter how many lines of source the tables
take? Unlike actual code, reducing the number of lines in a table doesn't
mean its more efficient. The tables aren't even particularly large when
compiled, a few kilobytes for CS47L90, which the users of that codec don't
care about compared to speed.

I can give a size comparison based on the Madera patches. When built as
modules for 32-bit ARM, the pinctrl driver for the (very simple) GPIOs on
those codecs builds to 22kB. All the regmap tables for the CS47L90
(the largest codec), including the defaults and all the readable/volatile
functions, builds to 23kB, and the smaller (but still quite big) CS47L35
to 16kB. So we're talking <= a trivial pinctrl driver even for a big
complex device like a CS47L90 with >1350 registers. For another comparison
the bulk of the CS47L90 object is the audio driver, which is ~2.2MB. So
the regmap tables are < 0.1%.

>>>>>> Even if it is absolutely critical that you have to supply these to
>>>>>> Regmap up-front, instead of on first use/read, why can't you just
>>>>>> supply the oddball non-zero ones?
>>>
>>> That doesn't work, we need to know both if the register has a default
>>> value and what that value is - there's no great value in only supplying
>>> the defaults for registers with non-zero values.
>>
>> All registers have a default value.  Why can't we assume that if a
>> register is writable and a default value was omitted then the default
>> is zero?
> 
> Defaults basically serve two purposes in regmap:
> 
>   1) Initialise the register cache.
> 
>      There are basically three ways you could handle this
>      (at least that I can think of) and regmap supports all
>      three. Obviously each with their own pros and cons:
> 
>       1.1) Table of default values
>            + Fast boot time
>            - Uses some additional memory
>       1.2) Read all the registers from the device on boot
>            + Uses less memory
>            - Potentially very slow boot time
>       1.3) Only read values as you touch registers
>            + Uses less memory
>            + Usually no significant impact on boot time
>            - Can't do read or read/write/modify operations on
>              previously untouched registers whilst chip is off
> 
>      1.3 does probably make sense here for Lochnagar since we
>      don't currently power things down. However, it is worth
>      noting that such an approach is extremely challenging for many
>      devices. For example the CODECs generally have all sorts of
>      actual user-facing interface that needs to be accessible
>      regardless of if the CODEC is powered up or down and powering it
>      up to access registers would end up being either horrific on
>      power consumption and/or horrific in terms of code complexity.
> 
>      1.1 and 1.2 are basically a straight trade off. Generally
>      for our devices we talking loads of registers and
>      potentially connected over I2C. Our customers care deeply
>      about device boot time, Android has specs for such things
>      and often it is tight for a system to make those specs.
>      Conversly, generally the products we integrate into have
>      a fairly large amount of memory. As such this is a no
>      brainer of a choice for most of our devices.
> 
>   2) Determine what registers should be synchronised on a cache
>      sync.
> 
>      A cache sync is usually done when pulling a device out of
>      low power mode to reapply the currently desired register
>      settings. As discussed in 1) we don't currently do cache
>      syncs on Lochnagar, but this would affect most of our
>      parts. Again I can see three approaches to synchronising
>      the cache:
> 
>       2.1) Sync out registers that arn't at their default value
>            + Only syncs register that are actually needed
>            - Requires a table of defaults to work
>       2.2) Store a per register dirty flag in the cache
>            + No up front table required in the driver
>            + Potentially less memory as only a single bit required
>              per register, although realising that saving might be
>              very hard on some cache types
>            - May sync registers that arn't required
>       2.3) Sync all registers from the cache
>            + No memory usage
>            - Potentially large penalty for cache sync
> 
>      Regmap has options to do 2.3, however for most of our
>      devices that would be totally unacceptable. Our parts have
>      a lot of registers most of which are cacheable and for
>      power reasons cache syncs happen as the audio path is being
>      brought up. Again Android has targets here and they are
>      in low 10's of millseconds so bus accesses really do matter.
> 
>      2.1 is the normal proceedure in regmap, although this
>      is defined on a per cache implementation basis, with the
>      core providing 2.1 as a default.
> 
>      Again it's a bit of a trade off between 2.1 and 2.2, but
>      given 1 pretty much requires us to know the defaults
>      anyway, 2.1 will in general make the most sense, at least
>      for Cirrus parts.
> 
> So I would conclude, certainly for most Cirrus devices, we
> do need to know the defaults at least for the vast majority
> of registers. I guess the next question would be could we
> generate some of the defaults table to reduce the table size
> in the driver. I would agree with you that the only sensible
> approach to reducing the defaults table size I can see would be
> to not have to specify defaults for registers with a default
> of zero. As an example to set expectations cs47l90, probably
> the largest CODEC we have made, has 1357 defaults of which
> 693 are zero so ~50%.
> 
> The issue really boils down to how do we tell the difference
> between a register that has no default, and one that has a default
> of zero? There are a few problems I can foresee on this front:
> 
>   1) There are occasions where people use a readable,
>      non-volatile register with no default for things like
>      device ID or revision. The idea being it can be read once
>      which will populate it into the cache then it never needs
>      to be read from the hardware again. Especially useful if
>      this information might be required whilst the hardware
>      is powered down.
> 
>      We could potentially update such drivers to mark the
>      register as volatile and then store the value explicitly
>      in the drivers data structures?
> 
>   2) There are occasions where a readable, writeable,
>      non-volatile register cannot be given a fixed default.
>      Usually this will be registers that are configured by
>      firmware or hardware during boot but then have control
>      passed to the kernel.
> 
>      For example a couple of registers on Lochnagar will be
>      configured by the board controller itself depending on
>      the CODEC that is attached, mostly regulators that are
>      enabled during boot being set to appropriate voltages to
>      avoid hardware damage. To handle these we don't give them
>      defaults which forces a read from the device but then after
>      that we can use the cache.
> 
>      For this one would probably have to add a new register
>      property (in addition to the existing readable, writeable,
>      volatile, and precious) for no default. Which would require
>      an additional callback. Although I guess that would cover 1
>      as well, and normally there would be very few registers in
>      this catagory.
> 
>   3) Rather nervous there are other issues I am not currently
>      thinking of this is a widely used API and I am mostly
>      familiar only with the style of devices I work with.
> 
>      We could potentially add an assume zero defaults flag,
>      that would at least then only apply the change to devices
>      that opt in?
> 
> One other related thing that rests on my mind is that creating
> the defaults table is going to be a little intensive. I guess
> it is not so bad if using the ranges API, so perhaps we would
> need to tie it in with that. Although it is still a little
> fiddly as you need to work out overlaps between the ranges for
> different properties to be more efficient than just checking
> each register.  For the callback based systems though you
> would have to check each register and for example coming
> back to cs47l90, the highest register address is 0x3FFE7C
> which means you would need to call over 4 million callbacks
> probably multiple times whilst constructing your defaults table.
>

Part of the point of the cache is that you can read and write non-volatile
register values without powering up the hardware. For that to work for
registers with zero defaults you have 3 options:

1) Add extra conditionals into the regmap cache code so that if a register
is accessed and a default hasn't been declared, check (using some other
configuration table or function) whether this is one that must be populated
from the hardware or can be assumed to be zero.
   + would work
   - it's more overhead in the cache code paths and the caching code is
     already adding code path overhead. It's not safe to assume "well we
     only need to do this once so it's ok", what if a time-critical block
     of code accesses a large sequence of registers that all invoke this
     extra code path?

2) Power-up the hardware during boot and touch all the registers with
zero values.
   + ensures the cache is pre-populated with all defaults so no deferred
     overhead that could happen at an inconvenient time as (1) would.
   - adds boot time overhead.
   - if the registers are sparse (as on Cirrus codecs) this can't be a
     simple loop, it would need a table and we were trying to avoid
     tabulating registers that have a zero default

3) Regmap initializes to zero all cache entries where the register default
wasn't given and the register is not in the list "non-volatile registers that
must be populated from the real hardware value"
   + as (2) it avoids the potential of a large deferred cache initialization
     at an inconvenient time.
   - a missing address in the defaults table could be
        i.   a register with a zero default,
        ii.  a register that must be initialized from the hardware,
        iii. an unused address.
     The only way regmap could decide would be to check the readable/writable
     definitions and a new table of "non-volatile registers that must be
     populated from the real hardware value" to decide whether the address
     is a register or not. For a very large sparse register map there could
     be a huge number of addresses that have to be checked. We can get some
     idea how long this might take, regmap's debugfs builds a table this way
     and for the largest Cirrus codec (not upstream yet) we've seen this take
     up to 2 minutes (on an ARM CPU). While that's a maximum it gives some
     idea - even if we added only 10 seconds to boot time that's 10 seconds
     to long for most users of our codecs.

4) Regmap pre-populates the entire cache with zeros and then fills in any
non-zero defaults from the provided defaults table.
    + simpler to implement in regmap than (3)
    - more overhead than (3), you have to fill the whole cache so you're
      invoking the full 2 minute overhead that I mentioned in (3).

In practice (1) is feasible and could be acceptable for some devices
(but those are quite likely also devices where the current defaults table
isn't large anyway). It would have to be an option flag because it could
break the behaviour of existing regmap clients. But the potential for a
deferred overhead popping up at bad times might not always be acceptable.
One particular bad place is syncing the cache around a suspend/resume to
know the default values to eliminate useless writes so effectively (1) is
turning into (3). As a suspend/resume can be subject to tight OS limits
on time to setup a use-case it's not something we want to be bloating,
even if it's only on the first invocation.

In fact if there was anything we really wanted to contribute to regmap it
would be things that makes it faster. There don't seem to be any options
for shortening the data tables that don't also make regmap slower in some
way. I suppose if someone could make regmap faster we'd then have some
extra leeway to put in things that add overhead but then it's a shame to
have gained some speed and then take it away.

<snip>
