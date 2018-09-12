Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D00EC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC9120866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 06:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC9120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeILLkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 07:40:55 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34170 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbeILLkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 07:40:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id c29-v6so680874lfj.1;
        Tue, 11 Sep 2018 23:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iS8T2yjXyD/NUT6gKIPU/3zqYVlh2S0T/AkJntmleUc=;
        b=djdLlq0w2MWjXJaAwukUbRP1J89pr3UITQOLxxDMrImsAxoP/+3/djmi8w86w+OK3r
         5QydbzK17Ev9YV1fy79j38BTOJpOMhUqlLGpwvu/rSwIB5UQzTZrX0InNRk0n2Yc0aiu
         aBTvyK0eQ8tPOoQqW59lpd80krjySAUGSnVWU9BJWfnd4OVnJ8l6bl99G3wGP75kLty+
         QBtEtU0e14Py5ae1+D6GW8tcfFN5VFRb8clNwAIdGDnCSCsVNHKf1EeUa65F8SkEtMmz
         cIpHO4F/Hya4hYYVpxRMUoo7VwOCbINB4e7aaEB2pKoOHwev0iCvbMdt2ReNErSdA8C9
         euzQ==
X-Gm-Message-State: APzg51DB1dj0aEqFq5nVe8CEOMlt4v6nmHCWEHTbAf9QEsDojUhsEChL
        HoDPXeJCDqxqQKj4fv+Qb44=
X-Google-Smtp-Source: ANB0VdYrH5pNxHlQ8V3ioAGBQbrnC81ajFsLHujbyDKKtAmsNAS55330mZ1d28Ru3/bmXFn5dnmabQ==
X-Received: by 2002:a19:a0a:: with SMTP id 10-v6mr345034lfk.112.1536734270521;
        Tue, 11 Sep 2018 23:37:50 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id q16-v6sm19477ljj.68.2018.09.11.23.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 23:37:49 -0700 (PDT)
Date:   Wed, 12 Sep 2018 09:37:41 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        heikki.haikola@fi.rohmeurope.com, mikko.mutanen@fi.rohmeurope.com
Subject: Re: [PATCH 2/8] regulator: Support ROHM BD71847 power management IC
Message-ID: <20180912062201.GA2381@localhost.localdomain>
References: <cover.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <9fa1da19c69d3dab33234d8f06ffae91fb56672f.1535545377.git.matti.vaittinen@fi.rohmeurope.com>
 <20180911134808.GP4185@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911134808.GP4185@dell>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lee,

Thanks again for the review! I see you did bunch of them... I really
admire your devotion. For me reviewing is hard work. I do appreciate
it. So nice to see you're back in the business =)

On Tue, Sep 11, 2018 at 02:48:08PM +0100, Lee Jones wrote:
> On Wed, 29 Aug 2018, Matti Vaittinen wrote:
> 
> > +static const u8 bd71837_supported_revisions[] = { 0xA2 };
> > +static const u8 bd71847_supported_revisions[] = { 0xA0 };
> 
> I haven't seen anything like this before.
> 
> Is this really required?
> 
> Especially since you only have 1 of each currently.

Valid question. I did ask the same thing myself. Reason why I ended up
doing this is simple though. I have no idea what may change if "chip
revision" is changed. I only know that I have chip(s) with these
revisions on my table - and I have a data sheet which mentions these
revisions. So I can only test that driver works with these revisions. I
however assume there will be new revisions and I thought that with this
approach marking them as supported will only require adding the revisio
to these arrays.

But as you have said - this makes code slightly more complex - even if I
disagree with you regarding how complex is too complex =) The use case
and intention of tables is quite obvious, right? That makes following
the loops in probe pretty easy after all...

But I won't start arguing with you - let's assume the register interface
won't get changed - and if it does, well, let's handle that then. So
I'll drop whole revision check.

> 
> > -static const u8 supported_revisions[] = { 0xA2 /* BD71837 */ };
> > +struct known_revisions {
> > +	const u8 (*revisions)[];
> > +	unsigned int known_revisions;
> 
> I didn't initially know what this was at first glance.
> 
> Please re-name it to show that it is the number of stored revisions.

This will be fixed as I'll drop the revision check

> > +static const struct known_revisions supported_revisions[BD718XX_TYPE_AMNT] = {
> > +	[BD718XX_TYPE_BD71837] = {
> > +		.revisions = &bd71837_supported_revisions,
> > +		.known_revisions = ARRAY_SIZE(bd71837_supported_revisions),
> > +	},
> > +	[BD718XX_TYPE_BD71847] = {
> > +		.revisions = &bd71847_supported_revisions,
> > +		.known_revisions = ARRAY_SIZE(bd71847_supported_revisions),
> > +	},
> > +};
> >  
> > @@ -91,13 +104,19 @@ static int bd71837_i2c_probe(struct i2c_client *i2c,
> >  {
> >  	struct bd71837 *bd71837;
> >  	int ret, i;
> > +	const unsigned int *type;
> >  
> > +	type = of_device_get_match_data(&i2c->dev);
> > +	if (!type || *type >= BD718XX_TYPE_AMNT) {
> > +		dev_err(&i2c->dev, "Bad chip type\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	bd71837->chip_type = *type;

> > +	ret = regmap_read(bd71837->regmap, BD718XX_REG_REV, &bd71837->chip_rev);

> > +	for (i = 0;
> > +	     i < supported_revisions[bd71837->chip_type].known_revisions; i++)
> > +		if ((*supported_revisions[bd71837->chip_type].revisions)[i] ==
> > +		    bd71837->chip_rev)
> >  			break;
> >  
> > +	if (i == supported_revisions[bd71837->chip_type].known_revisions) {
> > +		dev_err(&i2c->dev, "Unrecognized revision 0x%02x\n",
> > +			bd71837->chip_rev);
> > +		return -EINVAL;
> >  	}
> 
> This has become a very (too) elaborate way to see if the current
> running version is supported.  Please find a way to solve this (much)
> more succinctly.  There are lots of examples of this.

I cut out pieces of quoted patch to shorten it to relevant bits.

As I said above - I think this is not as bad as you say - it is quite
obvious what it does after all. And adding new revision would be just
adding new entry to the revision array. But yes, I am not sure if this
is needed so I'll drop this. Let's work the compatibility issues between
revisions only if such ever emerge =)
> 
> In fact, since you are using OF, it is not possible for this driver to
> probe with an unsupported device.  You can remove the whole lot.
> 
I don't really see how the OF helps me with revisions - as chip revision
is not presented in DT. The type of chip of course is. So you're right.
Check for invalid chip_type can be dropped.

> > +static const unsigned int chip_types[] = {
> > +	[BD718XX_TYPE_BD71837] = BD718XX_TYPE_BD71837,
> > +	[BD718XX_TYPE_BD71847] = BD718XX_TYPE_BD71847,
> > +};
> >  
> >  static const struct of_device_id bd71837_of_match[] = {
> > -	{ .compatible = "rohm,bd71837", },
> > +	{
> > +		.compatible = "rohm,bd71837",
> > +		.data = &chip_types[BD718XX_TYPE_BD71837]
> > +	},
> > +	{
> > +		.compatible = "rohm,bd71847",
> > +		.data = &chip_types[BD718XX_TYPE_BD71847]
> 
> Again, way too complex.  Why not simply:
> 
>        .data = (void *)BD718XX_TYPE_BD71847?
> 

Ugh. That's horrible on my eyes. I dislike delivering data in addresses.
That's why I rather did array with IDs and used pointer to array member
here. But this is again not the battle I must win - so I'll do as you
suggested even if it looks ugly to me. I think we alreadt  had discussion
about vomitting on keyboard last summer - so let's not go back to that
now. ;)

> [...]
> 
> > -	BD71837_REGULATOR_CNT,
> > +	BD718XX_TYPE_BD71837,
> > +	BD718XX_TYPE_BD71847,
> > +	BD718XX_TYPE_AMNT // Keep this as last item
> 
> No C++ comments please.
> 
> What does AMNT mean?  I'm guessing it means amount, which isn't a
> valid type. I suggest MAX_BOARD_TYPES or similar instead.

You're not bad at guessing! =)

Well, what I like here is keeping the beginning of enum member the same.
When you see BD718XX_TYPE_AMNT used in driver you know that the enum value
belongs to this enum defining all BD718XX_TYPEs. And I like the amount
rather than MAX because MAX suggests that the value is last valid value.
Which is not the case here. And as the numbering begins from zero, this
enum really is amount of valid types. Thus I like the amount. Do you
think BD718XX_TYPE_AMOUNT would do? I know it is a bit Yodaish language
but it still should be clear enough and it would maintain the same enum
name prefix as other members in this enum.

> > +	BD718XX_LDO7,
> > +	BD718XX_REGULATOR_MAX,
> 
> Closer.
> 
> Whatever you choose to use, please ensure the last entries of the
> enums use a similar format.

Fair point. I'll cook new patch which fixes the define naming (just please
give me your opinion on using "BD718XX_TYPE_AMOUNT") and drops the
revision check from probe. Oh, and uses the .data pointer to contain the
chip type and not location where chip type is stored (even if my heart
burns, eyes bleed and <invent more things here by yourself>) ;)

Br,
	Matti Vaittinen
