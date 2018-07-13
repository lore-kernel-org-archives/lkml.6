Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D44ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34DA208E3
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 08:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34DA208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbeGMIoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 04:44:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51957 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbeGMIoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 04:44:22 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1fdtTM-0000aG-Tl; Fri, 13 Jul 2018 10:30:40 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1fdtTL-0003LM-SU; Fri, 13 Jul 2018 10:30:39 +0200
Date:   Fri, 13 Jul 2018 10:30:39 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        fabio.estevam@nxp.com, Anson.Huang@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pfuze100: add optional pfuze-disable-sw
 binding
Message-ID: <20180713083039.4z3ulwtg2ekx5n23@pengutronix.de>
References: <20180712110240.3006-1-m.felsch@pengutronix.de>
 <20180712110240.3006-2-m.felsch@pengutronix.de>
 <20180712153121.GF10369@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712153121.GF10369@sirena.org.uk>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:01:31 up 203 days, 20:39, 58 users,  load average: 0.05, 0.06,
 0.02
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 18-07-12 16:31, Mark Brown wrote:
> On Thu, Jul 12, 2018 at 01:02:39PM +0200, Marco Felsch wrote:
> 
> > +Optional properties:
> > +- pfuze-disable-sw: Disable all unused switch regulators to save power
> > +  consumption. Attention, some platforms are using the switch regulators as DDR
> > +  ref or supply voltage. Mark these regulators as "regulator-always-on" to skip
> > +  disabling these regulators. If not specified, the driver simualtes the
> > +  disabling. This means the state of the regulator is set to 'disabled' but the
> > +  driver don't disable the regulator.
> 
> This is a bit of a confused way of specifying things that depends on the
> Linux implementation, and the property sounds like a double negative
> too.  I'd say something like "pfuze-support-disable" and then explicitly
> say that this is a workaround for backwards compatibility.

I can't find the double negative. Anyway your binding sounds better. So
I will use yours. Should we add a vendor prefix too to be clear? I will
also add some more informations to mark it as workaround.

> I'd also recommend changing the implementation patch to just register a
> different version of the desc and ops that just doesn't have the disable
> operation so that the framework knows what's going on.  While the
> current implementation works now there's the possibility that at some
> point in the future we might start relying on the disable actually
> having taken effect somehow and will get confused.  There's some
> existing drivers that optimize their resume paths if they know power
> wasn't removed.

Okay I will change that too. I didn't know that there are drivers with
optimized resume paths.

Thanks for your feedback.

Regards,
Marco
