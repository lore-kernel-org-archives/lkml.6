Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E676EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA60F20855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfBUKYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:24:52 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:59841 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfBUKYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:24:51 -0500
X-Originating-IP: 90.88.23.190
Received: from aptenodytes (aaubervilliers-681-1-81-190.w90-88.abo.wanadoo.fr [90.88.23.190])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 322E94000B;
        Thu, 21 Feb 2019 10:24:47 +0000 (UTC)
Message-ID: <adbb183836e22dfc4558beaa818677c24bacf3a8.camel@bootlin.com>
Subject: Re: [PATCH RESEND net] net: phy: xgmiitorgmii: Support generic PHY
 status read
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Michal Simek <michal.simek@xilinx.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Date:   Thu, 21 Feb 2019 11:24:47 +0100
In-Reply-To: <f0020e39-7ace-e1e0-e629-b84d6f92b841@xilinx.com>
References: <20190215163220.20041-1-paul.kocialkowski@bootlin.com>
         <387ed483-b205-beda-319d-6f2b8ea55601@gmail.com>
         <38f6708476e9beca4583ccc2a62e238a4981b735.camel@bootlin.com>
         <958bb823-3dc8-607f-3c38-3d902acb85a8@gmail.com>
         <b0f700f85cd35bf26a97280f3bef7c4e87102d63.camel@bootlin.com>
         <20190219172515.GC13075@lunn.ch>
         <f0020e39-7ace-e1e0-e629-b84d6f92b841@xilinx.com>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2019-02-20 at 07:58 +0100, Michal Simek wrote:
> Hi,
> 
> On 19. 02. 19 18:25, Andrew Lunn wrote:
> > > Thanks for the suggestion! So I had a closer look at that driver to try
> > > and see what could go wrong and it looks like I found a few things
> > > there.
> > 
> > Hi Paul
> > 
> > Yes, this driver has issues. If i remember correctly, it got merged
> > while i was on vacation. I pointed out a few issues, but the authors
> > never responded. Feel free to fix it up.
> 
> Will be good to know who was that person.
> 
> I can't do much this week with this because responsible person for this
> driver is out of office this week. That's why please give us some time
> to get back to this.

Understood. I think we need to start a discussion about how the general
design of this driver can be improved.

In particular, I wonder if it could work better to make this driver a
PHY driver that just redirects all its ops to the actual PHY driver,
except for read_status where it should also add some code.

Maybe we could also manage to expose a RGMII PHY mode to the actual PHY
this way. Currently, the PHY mode has to be set to GMII for the MAC to
be configured correctly, but the PHY also gets this information while
it should be told that RGMII is in use. This doesn't seem to play a big
role in PHY configuration though, but it's still inadequate.

What do you think?

-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

