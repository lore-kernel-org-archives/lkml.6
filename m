Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F54FC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F7D22173B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 12:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfADMOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 07:14:41 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41896 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfADMOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 07:14:40 -0500
Received: by mail-lj1-f195.google.com with SMTP id k15-v6so32266668ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 04:14:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hufe3xua0LKt4fgqQjf9Hh4jDybyj1PfyNQVFFeOUCM=;
        b=ZOz1FBRIENIyZVdIzclFApyVSrDLl5heeXNvOvG5t9IImn4sBwFZ3I1FWLWdBG9qkk
         xvGYor6aBzxmOOlCYj1dZkdtvT+m7KpsZdP+qLsgOuTz5f5rFIKko6H9QHeRd7LFOfv1
         J0e7wtQ4za94MhUyfGDppGAJLxRZorSGEw6jZ5l2wmZCfxqr4EVWdkGwHXZPzaf+NL18
         wVD1sDasDaBWnDr1lpqLFBQjtCYBTNMebc7M2aFy3HLed0buT9CIclG/1M5UXhRZiVBj
         9wtcxobQd3xNYFg2i1OB8q2Eke5Jm2yeKCMpVlsYbp/BFdQpzLU5LAELFf/2QgfUK+TE
         ksFQ==
X-Gm-Message-State: AJcUukeH89PAU6ZiGkelLsYjkkq47d4X1Ov6rlJ1KOc2upDcrHKw7FfF
        WxWq1AgrqpmtfG/O8JYc6D9D29/G
X-Google-Smtp-Source: ALg8bN7jOVpBI8jXzjpKlwtupBNS05E2cUghqY4Ob0Pt0vMm1SJOAH4zk+PHtbCpoduXXN/P/t997g==
X-Received: by 2002:a2e:88cf:: with SMTP id a15-v6mr27898299ljk.76.1546604077721;
        Fri, 04 Jan 2019 04:14:37 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id v17-v6sm12172409ljg.32.2019.01.04.04.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 04:14:37 -0800 (PST)
Date:   Fri, 4 Jan 2019 14:14:34 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     mazziesaccount@gmail.com, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org
Subject: Re: [PATCH] regmap: regmap-irq: Make irq-type callbak optional
Message-ID: <20190104121434.GC8865@localhost.localdomain>
References: <20190104103115.GA10043@localhost.localdomain>
 <20190104111443.GS16508@imbe.wolfsonmicro.main>
 <20190104113207.GT16508@imbe.wolfsonmicro.main>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104113207.GT16508@imbe.wolfsonmicro.main>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Big thanks for testing this so early Charles =) It's nice to get this
report before I broke things more widely!

On Fri, Jan 04, 2019 at 11:32:07AM +0000, Charles Keepax wrote:
> On Fri, Jan 04, 2019 at 11:14:43AM +0000, Charles Keepax wrote:
> > On Fri, Jan 04, 2019 at 12:31:15PM +0200, Matti Vaittinen wrote:
> > > +	if (num_type_reg)
> > > +		d->irq_chip.irq_set_type = regmap_irq_set_type;
> > > +
> > 
> > Afraid this also causes regressions at my end, still having a bit
> > of a look but it looks like some how this prevents properties of the
> > IRQ getting passed along which causes my system to not probe
> > properly with:
> > 
> > genirq: Flags mismatch irq 58. 00002088 (cs35l35) vs. 00002088 (cs35l35)
> > cs35l35 0-0041: Failed to request IRQ: -16
> > 
> 
> My case is a shared IRQ with 2 amps (cs35l35) connected to a CODEC
> (wm8280).
> 
> So looks like the issue is if you don't have a set_type callback
> then the IRQ ends up as IRQF_TRIGGER_NONE, which causes the
> second IRQ to fail the middle check here in __setup_irq:
> 
> 		if (!((old->flags & new->flags) & IRQF_SHARED) ||
> 		    (oldtype != (new->flags & IRQF_TRIGGER_MASK)) ||
> 		    ((old->flags ^ new->flags) & IRQF_ONESHOT)) {

Right. Thanks for pinpointing the issue. This thing is a bit fishy.
There should not be a need for a 'fake type setting callback' when we
have shared IRQ with two or more devices who actually agree on IRQ type
- assuming the HW default irq type is correct.

For me the correct thing would that the HW default type should be
stored in desc and returned by irqd_get_trigger_type instead of
IRQF_TRIGGER_NONE. But I have no idea how that would be nicely
implemented w/o going trough all the irqchips.

The other option would be being more permissive when IRQF_TRIGGER_NONE
is set as oldtype. But I am not feeling like an expert on this area.

> Kinda inclined to just leave the fix as currently submitted and
> just drop this patch? But I can do more testing etc. if we want
> to push further down this road.

Huge thanks for the offer Charles - I do really appreciate the testing.
Touching the IRQ core sounds quite scary to me. Changing it feels risky
and would probably involve bunch of other people too. 10-years ago I
would have taken the challenge and tried to get this "correct" - but
nowadays I have learned to accept some small shortcuts :p

I will gladly follow things and participate the discussions/development
if someone wants to see how this should be done - but I don't think I
have the energy and time to drive this change further... So Mark, please
just drop this patch and keep the original fix unless you want to drive
this further yourself =)


Br,
	Matti Vaittinen

> 
> Thanks,
> Charles

-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
