Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C565AC2F421
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C25B20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 16:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbfAUQUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 11:20:17 -0500
Received: from mail.bootlin.com ([62.4.15.54]:35384 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728915AbfAUQUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 11:20:16 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id BF9A4206DC; Mon, 21 Jan 2019 17:20:14 +0100 (CET)
Received: from bootlin.com (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 512BB20397;
        Mon, 21 Jan 2019 17:20:04 +0100 (CET)
Date:   Mon, 21 Jan 2019 17:20:04 +0100
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net-next 1/7] net: phy: Extract
 genphy_c45_read_abilities from marvell10g
Message-ID: <20190121172004.78a341f7@bootlin.com>
In-Reply-To: <20190120185107.GA19714@lunn.ch>
References: <20190118152352.26417-1-maxime.chevallier@bootlin.com>
        <20190118152352.26417-2-maxime.chevallier@bootlin.com>
        <20190120185107.GA19714@lunn.ch>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On Sun, 20 Jan 2019 19:51:07 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

>On Fri, Jan 18, 2019 at 04:23:46PM +0100, Maxime Chevallier wrote:
>> Marvell 10G PHY driver has a generic way of initializing the supported
>> link modes by reading the PHY's C45 PMA abilities. This can be made
>> generic, since these registers are part of the 802.3 specifications.
>> 
>> This commit extracts the config_init link_mode initialization code from
>> marvell10g and uses it to introduce the genphy_c45_read_abilities
>> function.  
>
>Hi Maxime
>
>I think the idea is good. I just have a few English language
>issues/questions.

Thanks for the review.

>Capabilities is more often used than abilities. I just wondered if
>abilities is taken from the 802.3 specifications?

Yes, the term 'Ability' is used in the 802.3 specifications, both in
the register names and the descriptions.

>Also, i wonder if we should include _pma_ in the name? At some point
>we might want to do something similar for other sublayers.

You're right, we do read only from the PMA and I see that we could also
to similar thing for the PCS layer, I'll rename the function.

>> +/**
>> + * genphy_c45_read_abilities - read supported link modes from PMA
>> + * @phydev: target phy_device struct
>> + *
>> + * Read the supported link modes from the PMA Status 2 (1.8) register. If bit
>> + * 1.8.9 is set, the list of supported modes is completed with the values in the  
>
>completed is not the right word. 'is build using the values in the' ?

That's better indeed, I'll correct that sentence.

>> + * PMA Extended Abilities (1.11) register, indicating 1000BASET an 10G related
>> + * modes. If bit 1.11.14 is set, then the list is also completed with the modes  
>
>list is also extended with the modes

And that one too.

>> + * in the 2.5G/5G PMA Extended register (1.21), indicating if 2.5GBASET and
>> + * 5GBASET are supported.
>> + */  
>

Thanks,

Maxime
