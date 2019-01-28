Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B162C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0338C2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbfA1P55 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:57:57 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48417 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729597AbfA1P5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:57:54 -0500
X-Originating-IP: 90.88.29.206
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B583BE000A;
        Mon, 28 Jan 2019 15:57:50 +0000 (UTC)
Date:   Mon, 28 Jan 2019 16:57:49 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: Save switch rules
Message-ID: <20190128165749.6abf2dc4@xps13>
In-Reply-To: <20190128144417.GG4765@lunn.ch>
References: <20190125095507.29334-1-miquel.raynal@bootlin.com>
        <20190125095507.29334-2-miquel.raynal@bootlin.com>
        <c1421a5d-5f92-bb86-b5cc-9fa19a1c8d9f@gmail.com>
        <20190128152456.212ae5ac@xps13>
        <20190128144417.GG4765@lunn.ch>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Thanks for helping!

Andrew Lunn <andrew@lunn.ch> wrote on Mon, 28 Jan 2019 15:44:17 +0100:

> > I don't see where VLAN and bridge information are cached, can you point
> > me to the relevant locations?  
> 
> Miquèl
> 
> The bridge should have all that information. You need to ask it to
> enumerate the current configuration and replay it to the switch.
> 
> There might be something in the Mellanox driver you can copy? But i've
> not looked, i'm just guessing.

I am still searching but so far I did not find a mechanism reading the
configuration of the bridge out of a 'net' object. Indeed there are
multiple lists with the configuration but they are all 'mellanox'
objects, they do not belong to the core.

Maybe I don't find this configuration because I don't know what it is.
I imagine this configuration being one (or multiple) list(s), stored
somewhere in a net_device being a bridge. Am I on the wrong path?

Otherwise I might just save my own structures in net/dsa/switch.c like
I did for the mv88e6xx driver, and once this works, net-folks might
want to optimize the memory consumption and re-use the bridge
configuration directly?

> We also need to think about how we are going to test this. There is a
> lot of state information in a switch. So we are going to need some
> pretty good tests to show we have recreated all of it.

My understanding of all this is rather short, until know I used what
you proposed in the v1 of this series but I am all ears if I need to
add anything to my test list.


Thanks,
Miquèl
