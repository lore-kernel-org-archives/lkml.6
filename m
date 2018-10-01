Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E8FC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB027208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB027208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbeJBBVX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 21:21:23 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42298 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbeJBBVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 21:21:23 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id CE45D20798; Mon,  1 Oct 2018 20:42:12 +0200 (CEST)
Received: from localhost (LFbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.bootlin.com (Postfix) with ESMTPSA id 9BD102039F;
        Mon,  1 Oct 2018 20:42:12 +0200 (CEST)
Date:   Mon, 1 Oct 2018 17:44:17 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jorik Jonker <jorik@kippendief.biz>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] dts: sun8i-h3: add sy8106a to orange pi plus
Message-ID: <20181001154417.joccdlvxoee6pvic@flea>
References: <20180927083636.5415-1-jorik@kippendief.biz>
 <20180928135516.jxhnsgaa3s2nagv7@flea>
 <20180929131617.GA7940@carbon.kippendief.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180929131617.GA7940@carbon.kippendief.biz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorik,

On Sat, Sep 29, 2018 at 03:16:17PM +0200, Jorik Jonker wrote:
> Hi,
> 
> On Fri, Sep 28, 2018 at 03:55:16PM +0200, Maxime Ripard wrote:
> > The prefix of your commit title should be "ARM: dts: ..."
> 
> Sure, will fix it in v2.
> 
> > > I have tested this on two Orange Pi Plus boards, and they run stable
> > > across a range of voltages (and frequencies).
> > 
> > How was this tested?
> 
> Basically using intermittent cpuburn runs and monitor freq/voltage/temp.
> I've included a description of my test in the v2 commit log.

You just missed the 4.20 merge window, unfortunately, but ideally,
having cpufreq-ljt-stress-test from
https://github.com/ssvb/cpuburn-arm would be great.

That won't prevent your patch from going in, but it would be great if
you could test this at some point during the 4.20-rc phase, and fix
things if they are broken.

> > > +		/*
> > > +		 * The datasheet uses 1.1V as the minimum value of VDD-CPUX,
> > > +		 * however both the Armbian DVFS table and the official one
> > > +		 * have operating points with voltage under 1.1V, and both
> > > +		 * DVFS table are known to work properly at the lowest
> > > +		 * operating point.
> > > +		 *
> > > +		 * Use 1.0V as the minimum voltage instead.
> > > +		 */
> > 
> > There's not much point to that comment, since it's been that way for
> > all the other SoCs from Allwinner. However, that would be great to
> > have it in the commit log.
> 
> Totally agree, but I thought: there must be a good reason this text is in
> the PC dts, so let's put it in the Plus dts as well. I've moved it from the
> patch to the log in the v2 patch, which I will send right away.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
