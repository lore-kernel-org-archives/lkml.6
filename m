Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD83EC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B2120882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfA3JqM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:46:12 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:60355 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbfA3JqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:46:11 -0500
Received: from xps13 (aaubervilliers-681-1-27-226.w90-88.abo.wanadoo.fr [90.88.147.226])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id B1D82100007;
        Wed, 30 Jan 2019 09:46:07 +0000 (UTC)
Date:   Wed, 30 Jan 2019 10:46:06 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vivien Didelot <vivien.didelot@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: Save switch rules
Message-ID: <20190130104606.31639abb@xps13>
In-Reply-To: <20190129104613.GC20920@t480s.localdomain>
References: <20190125095507.29334-1-miquel.raynal@bootlin.com>
        <20190125095507.29334-2-miquel.raynal@bootlin.com>
        <c1421a5d-5f92-bb86-b5cc-9fa19a1c8d9f@gmail.com>
        <20190128152456.212ae5ac@xps13>
        <20190128144417.GG4765@lunn.ch>
        <20190128165749.6abf2dc4@xps13>
        <20190128174246.GD28759@lunn.ch>
        <20190129100117.5ef6774c@xps13>
        <20190129145157.GK4765@lunn.ch>
        <20190129104613.GC20920@t480s.localdomain>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vivien & Andrew,

Vivien Didelot <vivien.didelot@gmail.com> wrote on Tue, 29 Jan 2019
10:46:13 -0500:

> Hi Miquèl,
> 
> On Tue, 29 Jan 2019 15:51:57 +0100, Andrew Lunn <andrew@lunn.ch> wrote:
> 
> > > Today, there is no S2RAM support for switches. First, I proposed to add
> > > suspend/resume callbacks to the mv88e6xxx driver - just enough to avoid
> > > crashing the kernel.  
> > 
> > Then i would suggest the mv88e6xxx refuses the suspend. Actually that
> > probably is the first correct step. We don't have suspend support, so
> > stop the suspend happening, so preventing the kernel crash.  
>  
> I am not confortable with adding support for S2RAM in mv88e6xxx yet because
> as it was explained, we are aware of much complicated scenarios out there
> to pretend that DSA /partly/ supports suspend-resume. The prefered approach
> for the moment is to keep things simple and not supporting this feature yet,
> especially at the mv88e6xxx driver level.
> 
> However crashing is unacceptable so I'm backing Andrew's point here, please
> submit a fix to prevent the suspend (and crash) for the moment.
> 
> Sorry if you felt that your work is being delayed, it is much appreciated!

Thanks for the more detailed explanation, I got your point and I better
understand your reluctance.

So your proposal is to refuse suspending when using a mv88e6xxx switch.
What about the current situation where suspending is allowed, but all
the configuration gone? As long as all the ports are disabled during
suspend, it should not hurt anything, right? Plus, this is what the
bcm_sf2 and qca8k drivers are doing. I can even add an error message in
the resume path to warn about this drawback.


Thanks,
Miquèl
