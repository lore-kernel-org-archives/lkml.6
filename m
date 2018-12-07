Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD25C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8457520838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8457520838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbeLGH6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 02:58:42 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44863 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeLGH6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 02:58:41 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so2319645lfe.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 23:58:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EYy9TBfFrEAGPk+yYPkpbje77dDKce4fdb9CwTGMY1g=;
        b=eo1KVOeqUaGda3WMD8rggve4dy7DKUEnqYNb41TAtD2Z8jo7QkKCBdN8K7lhqM0v2+
         mWTLTavrL252viwYgGJxbgRBLIkJHuWkxH1zDKb0e218UKfOyVY0jpQdZ/AoDBtg1+jz
         k3Y4Tah9cg28SFu+vH/hcHzJ+2DGRuJJxlurZEroeeIrmWfROiSkHs3rhQFNza1kbxap
         ouRVtkGzfW9i5T2UeuWw9a3EAD9UwmlmjAy708LHmgIMcj18PIhYJRczqHaz5WQr3VRX
         XF/Y4wPQfwjL7YUgHEXCgsbYFhSR/SYqrwXuIDkPV33FwcRvZ9qR9Oox1tuM8fEs3O8J
         DrdA==
X-Gm-Message-State: AA+aEWb3+deFrX2pKGfDhyop3+3tQ2LwSGD1rLW0hHeIy4ZPQ69Hwgyd
        kzOWztyFrLaKsTv2Rf2x6c6ZQEoN
X-Google-Smtp-Source: AFSGD/UTNLrvRsKccT4+lNfkSdrssURAG4S71boZVKzONVOgXpk6hr2Eao8tqHejrActp6rpPz2U4w==
X-Received: by 2002:a19:5a05:: with SMTP id o5mr739004lfb.140.1544169518082;
        Thu, 06 Dec 2018 23:58:38 -0800 (PST)
Received: from localhost.localdomain (84-253-205-125.bb.dnainternet.fi. [84.253.205.125])
        by smtp.gmail.com with ESMTPSA id p10-v6sm450167ljg.19.2018.12.06.23.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 23:58:36 -0800 (PST)
Date:   Fri, 7 Dec 2018 09:58:29 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] regmap-irq: add "main register" and level-irq support
Message-ID: <20181207075829.GA24940@localhost.localdomain>
References: <20181130085908.GA24983@localhost.localdomain>
 <20181204172137.GE6809@sirena.org.uk>
 <20181205082251.GE31204@localhost.localdomain>
 <20181205172701.GH6205@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205172701.GH6205@sirena.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Again Mark,

On Wed, Dec 05, 2018 at 05:27:01PM +0000, Mark Brown wrote:
> On Wed, Dec 05, 2018 at 10:22:51AM +0200, Matti Vaittinen wrote:
> > On Tue, Dec 04, 2018 at 05:21:37PM +0000, Mark Brown wrote:
> > > On Fri, Nov 30, 2018 at 10:59:08AM +0200, Matti Vaittinen wrote:
> 
> > > This sounds exactly like the wm831x which uses cascaded irqchips for
> > > this, though not regmap-irq.
> 
> > Yep. I guess I could do cascaded chips - but I would like to use the
> > regmap-irq for this driver. Maybe we could change regmap-irq so that it
> > would be possible to not give the DT node from regmap for this chip?
> > This was actually my first thought - but then I felt that having two irq
> > chips for one device is a bit hacky - and hence I decided to see how
> > regmap-irq could be changed to support the 'main irq status' register
> > usage. I think this 'main register' setup is pretty common design.
> 
> I'm not sure I see it as particularly hacky - it's using features that
> the frameworks provide to do the fan out, that just seems like making
> use of existing framework features.
> 
> > > I suspect the idiomatic way to handle this in DT is to make DT nodes
> > > (and devices) for the subfunction interrupt controllers and expose the
> > > internal structure of the chip to the DT.
> 
> > Yes. This would be one approach - but I am not sure how DT guys see
> > this. I may be wrong but I have a feeling Rob prefers having only one DT
> > node describing single device. But for me it would make sense to have
> > own node for GPIO - especially because the GPIO is only IRQ controller
> 
> Well, it kind of depends if you see the sub-interrupt controllers as
> independent devices or not (at the hardware level they will be).
> 
> > which really is visible outside the chip. But here we still hit the same
> > problem if we want to use regmap-irq. Regmap-irq still knows only the
> > i2c device DT node. Currently there is no way to tell regmap-irq to use
> > the sub-node.
> 
> If they're full subdevices you'd be pointing at the relevant platform
> device anyway.

I am not sure if I have explained me well enough =) When we look at
regmap_add_irq_chip we see that it creates the IRQ domains. And we
further see:

		d->domain = irq_domain_add_linear(map->dev->of_node,
						  chip->num_irqs,
						  &regmap_domain_ops, d);

where map->dev->of_node points the node added to regmap. And as we
really want to use the i2c to access registers, we should have done the
regmap using:

devm_regmap_init_i2c(i2c, &regmap);


where the i2c is the struct i2c_client *. The dev in i2c_client is the
i2c device - which has of_node pointing at the "main i2c node" - not the
sub block nodes. Hence all irq chips created by regmap_add_irq_chip for
this physical i2c slave device will point to the same DT node. 

> > >  This does make some sense as
> > > the individual interrupt controllers within the chip are clearly
> > > reusable IP blocks though it means that the chip starts looking a bit
> > > weird externally so perhaps that's not ideal and your suggestion makes
> > > sense.
> 
> > So I take this as a suggestion to continue tinkering with the 'main irq
> > register support'. Or how do you see my suggestion of making iot
> > possible to instruct the regmap-irq to not use DT for 'main irq
> > controller'? Then we could probably do cascaded controllers where only
> > the controller handling the externally visible 'sub-irqs' would be
> > bound to DT? The pitfall here is case where more than one sub-irq
> > controllers needs to be exposed to other devices. In that sense the
> > 'main irq thing' would have better 'case coverage' =) (Wow, what a fancy
> > words, maybe I am turning into a manager here :p )
> 
> I'm on the fence about the main controller idea

So am I. But I still would like to use regmap-irq no matter if I create
one or many irq chips. So please allow me to present the other idea:

Would it work if we add someting like

struct regmap_irq_chip {
	const char *name;

	unsigned int status_base;
	unsigned int mask_base;
	unsigned int unmask_base;
	unsigned int ack_base;
	unsigned int wake_base;
	unsigned int type_base;
	unsigned int irq_reg_stride;
	bool mask_writeonly:1;
+	bool no_of:1;

and in the regmap_add_irq_chip do:

		node = (chip->no_of) ? NULL : map->dev->of_node;
		d->domain = irq_domain_add_linear(node, chip->num_irqs,
						  &regmap_domain_ops, d);

Then we could have chip->no_of set for the 'main irq chip' and for those
chips we don't wan't to expose via DT. In my case I would leave no_of
unset only for the irq-chip which I created for the GPIO? Is this a
silly idea?

> > > > + * @main_status: Base main status register address. For chips which have
> > > > + *		 interrupts arranged in separate sub-irq blocks with own IRQ
> > > > + *		 registers and which have a main IRQ registers indicating
> > > > + *		 sub-irq blocks with unhandled interrupts. For such chips fill
> > > > + *		 sub-irq register information in status_base, mask_base and
> > > > + *		 ack_base.
> > > > + * @sub_reg_offsets: arrays of mappings from main register bits to sub irq
> > > > + *		 registers. First item in array describes the registers
> > > > + *		 for first main status bit. Second array for second bit etc.
> > > > + *		 Offset is given as sub register status offset to status_base.
> > > > + *		 Should contain num_regs arrays. Can be provided for chips with
> > > > + *		 more complex mapping than 1.st bit to 1.st sub-reg, 2.nd bit to
> > > > + *		 2.nd sub-reg, ...
> 
> > > This interface feels a little awkward in that we define the sub
> > > interrupts in this separate array and require them all to be in separate
> > > single registers which probably won't be true in general (IIRC it wasn't
> > > how the wm831x worked).
> 
> > So my implementation here was just the simplest solution to 'glue' the
> > main status register on top of existing implementation. If we do it this
> > way, then the 'main status register' is completely optional - chip would
> > work just fine even without the 'main register' - main register only
> > saves some reads as subregisters with no irqs can be left unread. But
> > you are correct - this only supports limited amount of HWs. Many chips I
> > have seen (prior to the one I am now working with) actually require
> > acking also the main status register. They also may support masking the
> > main status register. But I guess trying to support all such cases would
> > make the regmap-irq really complex and hard to understand.
> 
> Right, it's that sort of thing that makes me want to just cascade the
> interrupt controllers - at some point you just end up with as fully
> featured an interrupt controller distributing to other fully featured
> interrupt controllers.

Yes. Question is whether we should support getting rid of extra irq
register reads if HW provides the 'main status' register. I would not
support main irq acking/masking (at least not for now).

> > > How about instead we have the individual
> > > interrupts mark which main status bits flag them, then build up a
> > > mapping in the other direction during init of subregisters to read?
> 
> > I am not sure if I understand your idea correctly - but for me it feels
> > that the 'main status register' is only benefical when we can do direct
> > mapping from main register bit/value to sub-register(s). 
> 
> The mapping isn't guaranteed to be a 1:1 mapping - one way this hardware
> gets structured is that the central interrupt controller is saying which
> IP block is flagging an interrupt rather than which register has an
> interrupt set in it.  You can then have either more than one detailed
> status register for that IP

Correct. But I guess the IP blocks often have limited set of registers for the
"sub interrupts". For such cases my idea would work, right. My RFC
handled case where there is many 'sub registers' to read for one 'main
bit.

> or several smaller IPs reporting through a
> single detailed status register.

I think that if we have more than two layers of irqs (main and sub) -
then we should do cascaded controllers.

>  I've also seen some interrupts
> represented directly in the main status if there's some need for a fast
> path.

Right. This is not covered by my 'RFC'. And here the flagging from
individual irq to main status bit would be usefull. But I am a bit
afraid of complexity supporting this adds - as well as the overhead of
describing 'main status bits' for all interrupts in cases where we don't
have such fast-path bits. Besides, adding the main status handling does
not force one to use it if existing mechanisms work well =)

> > But as we must really read whole sub register at once, it really does
> > not matter which interrupts inside the sub register did activate the
> > main status - we go through all bits in the sub register anyways. Hence
> > it may not be needed to have mapping from individual interrupts to the
> > main status register value? I guess looping through all the sub
> > register bits is negligible source of latency compared to the time the
> > register access takes. So identifying the sub register(s) based on main
> > status is the thing - not mapping the individual interrupts in sub
> > register(s), right? I think that having to specify the main status
> > register value for each interrupt would be quite a overkill.
> 
> Right, it's about working out which subregister to read - the point is
> you can do this by adding a link in either direction, I'm suggesting
> doing it from the individual interrupt to the main register since we
> already have individual data structures for those and it feels less
> likely to run into hard to represent corner cases.

I see your point now. But as I said, I am not sure we should add the
overhead of 'main irq bit description' for simple cases just to cover
the corner cases. Yet I can try seeing what I can come up with if you
think this is the way to go.

> >  * @main_status: Optional base main status register address. Some chips have
> >  *		 "main status register(s)" which indicate actual irq registers
> >  *		 with unhandled interrupts. Provide main status register
> >  *		 address here to avoid reading irq registers with no
> >  *		 active interrupts. Mapping from main status value to
> >  *		 interrupt register can be provided in sub_reg_offsets.
> 
> > Perhaps this would clarify that the status_base, mask_base, ack_base,
> > etc. should still be used normally?
> 
> Probably.

I am not sure this means I was able to convince you or if this is the
polite way to tell me not to bother =) I am Finnish guy who does not
understand small talk or polite hints ;)

Best Regards
	Matti Vaittinen

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
