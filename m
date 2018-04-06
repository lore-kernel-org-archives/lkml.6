Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752397AbeDFRLH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:11:07 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35337 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbeDFRLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:11:02 -0400
X-Google-Smtp-Source: AIpwx4+1Ymiv5YjfoxsF5cwyU2NsIij+fRRPHgQN8+LOsEm1kC1hIKNjRGQTJ3vBRrK31hLMWXu5bg==
From: Esben Haabendal <esben.haabendal@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Bhadram Varka <vbhadram@nvidia.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH] net: phy: marvell: Enable interrupt function on LED2 pin
References: <20180405133504.12257-1-esben.haabendal@gmail.com>
        <4d9e0665abf7408988fc4ce20c26a08f@bgmail102.nvidia.com>
        <20180405144355.GB32663@lunn.ch>
Date: Fri, 06 Apr 2018 19:10:58 +0200
In-Reply-To: <20180405144355.GB32663@lunn.ch> (Andrew Lunn's message of "Thu,
        5 Apr 2018 16:43:55 +0200")
Message-ID: <871sfs1crh.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Lunn <andrew@lunn.ch> writes:

>> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c index
>> 0e0978d8a0eb..f03a510f1247 100644
>> --- a/drivers/net/phy/marvell.c
>> +++ b/drivers/net/phy/marvell.c
>> @@ -457,6 +457,21 @@ static int marvell_of_reg_init(struct phy_device
>> *phydev) } #endif /* CONFIG_OF_MDIO */
>>  
>> +static int m88e1318_config_intr(struct phy_device *phydev) {
>> +	int err;
>> +
>> +	err = marvell_config_intr(phydev);
>> +	if (err)
>> +		return err;
>> +
>> +	/* Setup LED[2] as interrupt pin (active low) */
>> +	return phy_modify(phydev, MII_88E1318S_PHY_LED_TCR,
>> +			  MII_88E1318S_PHY_LED_TCR_FORCE_INT,
>> +			  MII_88E1318S_PHY_LED_TCR_INTn_ENABLE |
>> +			  MII_88E1318S_PHY_LED_TCR_INT_ACTIVE_LOW);
>> 
>> Can we move this part of the code to m88e1121_config_init() ?
>> 
>> Every time whether we disable or enable the interrupts this part of code
>> will execute.
>
> Yes, doing this once would be better. But please allow the LED pin to
> be used as an LED when not using interrupts. phy_interrupt_is_valid()
> should be involved somehow.

This should be addressed in v2 of the patch which I have already posted.

/Esben
