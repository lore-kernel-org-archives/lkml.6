Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E69C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F18218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=plaes.org header.i=@plaes.org header.b="oVGtEs/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732951AbeLUJ3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:29:02 -0500
Received: from plaes.org ([188.166.43.21]:46856 "EHLO plaes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732235AbeLUJ3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:29:02 -0500
Received: from plaes.org (localhost [127.0.0.1])
        by plaes.org (Postfix) with ESMTPSA id 4FB6D402C1;
        Fri, 21 Dec 2018 09:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=plaes.org; s=mail;
        t=1545384539; bh=/S6BxI+GAK5WS0/EhA92uvgr6Ez3wigOIyqi8T73vGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oVGtEs/m2CLPOHpTekkyGPumMYiDSiQtTkwPBM+r82cOV7b8AkVbgkKKpZM9AzQB5
         9Y0DQt5Bc4awqotarB2BkL6HrZKNQKmW8U5o+Xvcy7MzxEIlxC9m16huRToHwIjYSi
         vVsAWyTO1MUhPODserRHrJoWHCY6kS+/lEEyaqta/i9TjI0yKa0+/pnZgIecy3kcOM
         2OCMTKlHa4Bv2VMq19w1tyOJNFxaQ8cOQQuurgK4rXw4XaebmCdASVOPuBVBm5V0Ja
         dhQ7yOyz9vTl7LLeskUX1sfop04pNjVPVmhOCzrqlnPpm7vx3ku7j/54UNP7iAE3wS
         YeD0FRQiJfPzw==
Date:   Fri, 21 Dec 2018 09:28:58 +0000
From:   Priit Laes <plaes@plaes.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Olliver Schinagl <oliver@schinagl.nl>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 1/8] mfd: axp20x: name voltage
 ramping define properly
Message-ID: <20181221092858.6koh5dkrlc7xhvbh@plaes.org>
References: <cover.923997dd7d7396bb4d71f8967698b58ca956b929.1544512919.git-series.plaes@plaes.org>
 <01367c4f4f1e174fefbef9aac645f6792bda07e5.1544512919.git-series.plaes@plaes.org>
 <20181221083927.GQ4497@dell>
 <20181221084246.myrtv6n4jrv6lajl@plaes.org>
 <20181221092658.GB13248@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181221092658.GB13248@dell>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 09:26:58AM +0000, Lee Jones wrote:
> On Fri, 21 Dec 2018, Priit Laes wrote:
> 
> > On Fri, Dec 21, 2018 at 08:39:27AM +0000, Lee Jones wrote:
> > > On Tue, 11 Dec 2018, Priit Laes wrote:
> > > 
> > > > From: Olliver Schinagl <oliver@schinagl.nl>
> > > > 
> > > > The current axp20x names the ramping register 'scal' which probably
> > > > means scaling. Since the register really has nothing to do with
> > > > scaling, but really is the voltage ramp we rename it appropriately.
> > > > 
> > > > Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> > > > Signed-off-by: Priit Laes <plaes@plaes.org>
> > > > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  include/linux/mfd/axp20x.h | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > I've lost track of what's happening with this set now.
> > > 
> > > Mark,
> > > 
> > > Did you take this patch in the end?
> > 
> > Yes, this is in linux-next.
> 
> I have no idea why Mark's tracker isn't mailing me (this is not the
> first time this has happened).
> 
> Could you please rebase this set and resubmit all of the patches which
> have not yet been applied?

Whole serie has been applied.

> Thank you.
> 
> > > > diff --git a/include/linux/mfd/axp20x.h b/include/linux/mfd/axp20x.h
> > > > index 2302b62..a353cd2 100644
> > > > --- a/include/linux/mfd/axp20x.h
> > > > +++ b/include/linux/mfd/axp20x.h
> > > > @@ -35,7 +35,7 @@ enum axp20x_variants {
> > > >  #define AXP152_ALDO_OP_MODE		0x13
> > > >  #define AXP152_LDO0_CTRL		0x15
> > > >  #define AXP152_DCDC2_V_OUT		0x23
> > > > -#define AXP152_DCDC2_V_SCAL		0x25
> > > > +#define AXP152_DCDC2_V_RAMP		0x25
> > > >  #define AXP152_DCDC1_V_OUT		0x26
> > > >  #define AXP152_DCDC3_V_OUT		0x27
> > > >  #define AXP152_ALDO12_V_OUT		0x28
> > > > @@ -53,7 +53,7 @@ enum axp20x_variants {
> > > >  #define AXP20X_USB_OTG_STATUS		0x02
> > > >  #define AXP20X_PWR_OUT_CTRL		0x12
> > > >  #define AXP20X_DCDC2_V_OUT		0x23
> > > > -#define AXP20X_DCDC2_LDO3_V_SCAL	0x25
> > > > +#define AXP20X_DCDC2_LDO3_V_RAMP	0x25
> > > >  #define AXP20X_DCDC3_V_OUT		0x27
> > > >  #define AXP20X_LDO24_V_OUT		0x28
> > > >  #define AXP20X_LDO3_V_OUT		0x29
> > > 
> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
