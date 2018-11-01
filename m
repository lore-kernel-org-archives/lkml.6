Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8E6ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A1120820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 10:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A1120820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeKATbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 15:31:02 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:58576 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726520AbeKATbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 15:31:02 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id wA1AO11C002052;
        Thu, 1 Nov 2018 05:28:30 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2ncmepdq16-1;
        Thu, 01 Nov 2018 05:28:29 -0500
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id A85F1611C8AF;
        Thu,  1 Nov 2018 05:30:58 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 1 Nov 2018
 10:28:28 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id wA1ASSfC005723; Thu,
 1 Nov 2018 10:28:28 GMT
Date:   Thu, 1 Nov 2018 10:28:28 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Mark Brown <broonie@kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linus.walleij@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>, <linux-clk@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] mfd: lochnagar: Add support for the Cirrus Logic
 Lochnagar
Message-ID: <20181101102828.GM16508@imbe.wolfsonmicro.main>
References: <20181008132542.19775-1-ckeepax@opensource.cirrus.com>
 <20181008132542.19775-2-ckeepax@opensource.cirrus.com>
 <20181025074459.GF4939@dell>
 <20181025082621.GD16508@imbe.wolfsonmicro.main>
 <b2f85f45-cbe9-5a27-e9e8-ad28f2bd9bd6@opensource.cirrus.com>
 <20181025114205.GC4870@dell>
 <33ea391c-aa6e-2709-6faf-4905e84229e4@opensource.cirrus.com>
 <20181026080051.GK4870@dell>
 <20181026203223.GC27137@sirena.org.uk>
 <20181029110439.GS4870@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181029110439.GS4870@dell>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1811010092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:04:39AM +0000, Lee Jones wrote:
> On Fri, 26 Oct 2018, Mark Brown wrote:
> > On Fri, Oct 26, 2018 at 09:00:51AM +0100, Lee Jones wrote:
> > > On Thu, 25 Oct 2018, Richard Fitzgerald wrote:

I have re-ordered some of the quotes here for the benefit
of clarity. I will start with the Lochnagar focused bits
and then cover some of the more general regmap discussion.
Apologies for the wall of text towards the end but it seemed
wise to explore some of the why for parts of the current regmap
implementation and some of the implications for changing it.

> > I think from the perspective of Richard and Charles who are just trying
> > to get their driver merged this is something of an abstract distinction.
> > If the driver were merged and this discussion were happening separately
> > their perspective would most likely be different.
>
> Charles has already mentioned that he'd take a look at the current
> *use* (not changing the API, but the way in which Lochnagar
> *uses/consumes* it).  Actions which would be most welcomed.
>
> > I kind of said this above but just to be clear this driver seems to me
> > like an idiomatic user of the regmap API as it is today.  My guess is
> > that we could probably loose the defaults tables and not suffer too much
> > but equally well they don't hurt from a regmap point of view.
>
> Perhaps Charles could elaborate on whether this is possible or not?

So on this front I have had a look through and we can drop the
defaults tables for Lochnagar, although as I shall cover later
Lochnagar is the exceptional case with respect to our normal
devices.

> Utilising range support here would certainly help IMHO.
>

I am rather hesitant to switch to the range API. Whilst it is
significantly more clear in certain situations, such as say
mapping out the memory for a DSP, where there exist large
amorphis blobs of identical function registers. I am really
not convinced it really suits something like the register map
that controls Lochnagar. You have an intertwinned mix of
various purpose registers, each with a clearly defined name
and potentially with quite fine grained properties.

Certainly when working with the driver I want to be able to
fairly quickly see what registers are marked as by name. The
callbacks are very simple and I don't need to look up where
register are in the regmap to be able check their attributes.
But perhaps I have just got too used to seeing these callbacks,
things do have a way of becoming normal after being exposed to
them for a while.

What I will try for the next spin is to try to use as much:

  case REG1...REG2:

As I can without totally sacrificing grepability/clarity and
hopefully that will get us to a compromise we can all live
with at least for now. Lochnagar is a fairly small part so it
feels like this should be doable.

> > > > +       ret = devm_of_platform_populate(dev);
> > > > +       if (ret < 0) {
> > > > +               dev_err(dev, "Failed to populate child
> > > > nodes:
> > > > %d\n", ret);
> > > > +               return ret;
> > > > +       }
> > >
> > > Please do not mix OF and MFD device registration
> > > strategies.
> > >
> > > Pick one and register all devices through your chosen
> > > method.
> >
> > Hmmm we use this to do things like register some fixed
> > regulators
> > and clocks that don't need any control but do need to be
> > associated 
> > with the device. I could do that through the MFD although it
> > is in 
> > direct conflict with the feedback on the clock patches I
> > received
> > to move the fixed clocks into devicetree rather than
> > registering
> > them manually (see v2 of the patch chain).
>
> The I suggest moving everything to DT.

So pulling this out from earlier discussions in this thread,
it seems I can happily move all the child device registration
into device tree. I will also try this for the next version of
the patch, unless anyone wants to object? But it does change
the DT binding quite a lot as the individual sub drivers now
each require their own node rather than one single unified
Lochnagar node.

> > > Precisely my point.  Lochnagar is a small device yet it's required to
> > > submit hundreds of lines of Regmap tables.  Imagine what that would
> > > look like for a large device.
> >
> > There's no *requirement* to provide the data even if you're using the
> > cache (and the cache support is entirely optional), there's just costs
> > to not providing it in terms of what features you can get from the
> > regmap API and the performance of the system.  Not every device is going
> > to be bothered by those costs, many devices don't provide all of the
> > data they could.
>
> So what do we do in the case where, due to the size of the device, the
> amount of lines required by these tables go from crazy to grotesque?
>

Ultimately, I guess I have always just viewed it as just data
tables. Its a lot of lines of source but its not complicated,
and complexity has really always been the thing I try to avoid.

> > > > > Even if it is absolutely critical that you have to supply these to
> > > > > Regmap up-front, instead of on first use/read, why can't you just
> > > > > supply the oddball non-zero ones?
> > 
> > That doesn't work, we need to know both if the register has a default
> > value and what that value is - there's no great value in only supplying
> > the defaults for registers with non-zero values.
> 
> All registers have a default value.  Why can't we assume that if a
> register is writable and a default value was omitted then the default
> is zero?

Defaults basically serve two purposes in regmap:

 1) Initialise the register cache.

    There are basically three ways you could handle this
    (at least that I can think of) and regmap supports all
    three. Obviously each with their own pros and cons:

     1.1) Table of default values
          + Fast boot time
          - Uses some additional memory
     1.2) Read all the registers from the device on boot
          + Uses less memory
          - Potentially very slow boot time
     1.3) Only read values as you touch registers
          + Uses less memory
          + Usually no significant impact on boot time
          - Can't do read or read/write/modify operations on
            previously untouched registers whilst chip is off

    1.3 does probably make sense here for Lochnagar since we
    don't currently power things down. However, it is worth
    noting that such an approach is extremely challenging for many
    devices. For example the CODECs generally have all sorts of
    actual user-facing interface that needs to be accessible
    regardless of if the CODEC is powered up or down and powering it
    up to access registers would end up being either horrific on
    power consumption and/or horrific in terms of code complexity.

    1.1 and 1.2 are basically a straight trade off. Generally
    for our devices we talking loads of registers and
    potentially connected over I2C. Our customers care deeply
    about device boot time, Android has specs for such things
    and often it is tight for a system to make those specs.
    Conversly, generally the products we integrate into have
    a fairly large amount of memory. As such this is a no
    brainer of a choice for most of our devices.

 2) Determine what registers should be synchronised on a cache
    sync.

    A cache sync is usually done when pulling a device out of
    low power mode to reapply the currently desired register
    settings. As discussed in 1) we don't currently do cache
    syncs on Lochnagar, but this would affect most of our
    parts. Again I can see three approaches to synchronising
    the cache:

     2.1) Sync out registers that arn't at their default value
          + Only syncs register that are actually needed
          - Requires a table of defaults to work
     2.2) Store a per register dirty flag in the cache
          + No up front table required in the driver
          + Potentially less memory as only a single bit required
            per register, although realising that saving might be
            very hard on some cache types
          - May sync registers that arn't required
     2.3) Sync all registers from the cache
          + No memory usage
          - Potentially large penalty for cache sync

    Regmap has options to do 2.3, however for most of our
    devices that would be totally unacceptable. Our parts have
    a lot of registers most of which are cacheable and for
    power reasons cache syncs happen as the audio path is being
    brought up. Again Android has targets here and they are
    in low 10's of millseconds so bus accesses really do matter.

    2.1 is the normal proceedure in regmap, although this
    is defined on a per cache implementation basis, with the
    core providing 2.1 as a default.

    Again it's a bit of a trade off between 2.1 and 2.2, but
    given 1 pretty much requires us to know the defaults
    anyway, 2.1 will in general make the most sense, at least
    for Cirrus parts.

So I would conclude, certainly for most Cirrus devices, we
do need to know the defaults at least for the vast majority
of registers. I guess the next question would be could we
generate some of the defaults table to reduce the table size
in the driver. I would agree with you that the only sensible
approach to reducing the defaults table size I can see would be
to not have to specify defaults for registers with a default
of zero. As an example to set expectations cs47l90, probably
the largest CODEC we have made, has 1357 defaults of which
693 are zero so ~50%.

The issue really boils down to how do we tell the difference
between a register that has no default, and one that has a default
of zero? There are a few problems I can foresee on this front:

 1) There are occasions where people use a readable,
    non-volatile register with no default for things like
    device ID or revision. The idea being it can be read once
    which will populate it into the cache then it never needs
    to be read from the hardware again. Especially useful if
    this information might be required whilst the hardware
    is powered down.

    We could potentially update such drivers to mark the
    register as volatile and then store the value explicitly
    in the drivers data structures?

 2) There are occasions where a readable, writeable,
    non-volatile register cannot be given a fixed default.
    Usually this will be registers that are configured by
    firmware or hardware during boot but then have control
    passed to the kernel.

    For example a couple of registers on Lochnagar will be
    configured by the board controller itself depending on
    the CODEC that is attached, mostly regulators that are
    enabled during boot being set to appropriate voltages to
    avoid hardware damage. To handle these we don't give them
    defaults which forces a read from the device but then after
    that we can use the cache.

    For this one would probably have to add a new register
    property (in addition to the existing readable, writeable,
    volatile, and precious) for no default. Which would require
    an additional callback. Although I guess that would cover 1
    as well, and normally there would be very few registers in
    this catagory.

 3) Rather nervous there are other issues I am not currently
    thinking of this is a widely used API and I am mostly
    familiar only with the style of devices I work with.

    We could potentially add an assume zero defaults flag,
    that would at least then only apply the change to devices
    that opt in?

One other related thing that rests on my mind is that creating
the defaults table is going to be a little intensive. I guess
it is not so bad if using the ranges API, so perhaps we would
need to tie it in with that. Although it is still a little
fiddly as you need to work out overlaps between the ranges for
different properties to be more efficient than just checking
each register.  For the callback based systems though you
would have to check each register and for example coming
back to cs47l90, the highest register address is 0x3FFE7C
which means you would need to call over 4 million callbacks
probably multiple times whilst constructing your defaults table.

> Ah wait!  As I was typing the above, I just had a thought.  We don't
> actually provide a list of writable registers do we?  Only a the
> ability to verify if one is writable (presumably) before a write.

You can mark registers as writable. Its just that most drivers
don't bother to define the writable registers, there isn't
presently a great reason to do so and in that case the core
defaults to all register addresses being writable. I guess if
we added the automatic zero defaults you might well want to
start adding this callback though.

> > > > > The API is obscene and needs a re-work IMHO.
> > 
> > > > > I really hope we do not really have to list every register, but *if we
> > > > > absolutely must*, let's do it once:
> > 
> > > > >    REG_ADDRESS, WRV, INITIAL_VALUE
> > 
> > There is the option to specify range based access tables instead of a
> > function, for a lot of devices this is a nice, easy way to specify
> > things that makes more sense so we support it.  We don't combine the
> > tables because they're range based and if there is 100% overlap you can
> > always just point at the same table.
> > 
> > We allow the functions partly because it lets people handle weird cases
> > but also because it turned out when I looked at this that a lot of the
> > time the compiler output for switch statements was pretty efficient with
> > sparse register maps and it makes the code incredibly simple, much
> > simpler than trying to parse access tables into a more efficient data
> > structure and IIRC more compact too.  It's possible that those tradeoffs
> > have changed since but at the time there was a class of devices where it
> > wasn't clear that putting more effort in would result in substantially
> > better outcomes.
> > 

Exactly this, the regmap core makes a lot of readable/volatile
checks and the callbacks with switch statements are a very
runtime efficient way to implement those, in addition to the
code clarity.

I guess historically we have tried to be verbose as it
really made things very simple for us. We have scripts that
can generate the defaults and callbacks from outputs of the
hardware design giving us a very high degree of confidence in
them. Range based approaches always result in a bit of manual
work, unless we just literally pulled sequential ranges but that
results in code that is really not friendly when developing
the driver. But maybe that is the point we need to budge on
from the Cirrus side.

I think this really the crux of my concerns here about updating
the regmap API are that it feels like almost any path we take
from here results in worse runtime performance and probably
equal or worse memory usage. In return we gain a reduction of
some, whilst admittedly large, very simple data tables from
the driver. Which is a trade it feels hard to get invested in.

Anyway, well done to anyone who made it this far. I will
keep pondering on the issue, hopefully we can fudge things
for Lochnagar. But maybe we can come up with some longer term
compromise that devolves more of the regmap stuff through the
driver, hopefully reducing both the central data tables and the
large register include files both of which seem to be constant
pain points with review of parts. Although I am not sure how
much we can do for Arizona/Madera at this point but the parts
after that change the regmap quite dramatically so will need
a new driver so perhaps that is the point to look at things.

Thanks,
Charles
