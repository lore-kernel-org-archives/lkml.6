Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FC6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908E92156B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:15:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 908E92156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbeI0OcH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:32:07 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44906 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbeI0OcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:32:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 6A31520737; Thu, 27 Sep 2018 10:15:03 +0200 (CEST)
Received: from localhost (nat-240.udc.es [193.144.61.240])
        by mail.bootlin.com (Postfix) with ESMTPSA id 0DB1720379;
        Thu, 27 Sep 2018 10:14:52 +0200 (CEST)
Date:   Thu, 27 Sep 2018 10:14:53 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Frieder Schrempf <frieder.schrempf@exceet.de>,
        ulf.hansson@linaro.org, quentin.schulz@free-electrons.com,
        gregkh@linuxfoundation.org, linus.walleij@linaro.org,
        shawn.lin@rock-chips.com, adrian.hunter@intel.com,
        baolin.wang@linaro.org, thomas.petazzoni@free-electrons.com,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devel@driverdev.osuosl.org, icenowy@aosc.xyz, wens@csie.org
Subject: Re: [PATCH 2/2] mmc: Add mmc_force_detect_change_begin / _end
 functions
Message-ID: <20180927081452.a2xw25sdoqtadntu@flea>
References: <CAPDyKFqDrdD+N+foLCwsVABtboz1Vn=OtJs14gp07zJfXHVKSA@mail.gmail.com>
 <f9028dcb-c217-4efc-60a7-d0a2c1804a08@exceet.de>
 <d9795fde-6bdd-b6fa-da41-839d44df6435@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <d9795fde-6bdd-b6fa-da41-839d44df6435@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:19:22PM +0200, Hans de Goede wrote:
> On 26-09-18 16:44, Frieder Schrempf wrote:
> > Hi,
> > 
> > On Fri, Feb 09, 2018 at 03:01:00PM +0100, Ulf Hansson wrote:
> > > [...]
> > > 
> > > >> > I'd like to know if any progress has been made on that problem
> > (I may
> > > >> > have missed patches).
> > > >> > Had you had the time to look at the issue?
> > > >>
> > > >> I have looked at the issue, but not manage to cook some patches
> > for it.
> > > >>
> > > >> However, it's on my top of my TODO list for mmc. No promises, but
> > > >> perhaps and hopefully I manage to get something posted during the
> > > >> coming release cycle.
> > 
> > I would be interested in a ESP8089 driver in mainline and that's why I want to pick up this discussion.
> > 
> > What is the current status of the "mmc_reprobe_device" implementation, that Hans was explaining and Ulf wanted to provide some months ago?
> 
> Ulf did eventually write a new way to deal with this and then Quentin
> did manage to get the esp8089 driver to work with it, the new function
> to use for this is added by this commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/core?id=1433269c4d2461be1f36db5dbb453976b38996ff
> 
> I'm not sure what the status of upstreaming the ep8089 driver is now
> that we've this in place.
> 
> Quentin, do you have a version of the esp8089 driver somewhere
> which will work correctly with the new mmc_sw_reset() function?
> 
> Also what is the status of adding this driver to say staging?

IIRC, we tried to get it into staging, and we got told that it was too
nice for staging at this point. So we're basically stuck somewhere
between staging and !staging, with the driver being too nice for the
former, and not nice enough for the latter :)

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
