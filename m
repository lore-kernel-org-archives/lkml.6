Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753763AbeDEUe2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:34:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52626 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbeDEUeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:34:22 -0400
X-Google-Smtp-Source: AIpwx48UmqBfGbbbb/FNMb7yq7OYmLkaormvoWpMeey8WSWH4fpnIi1m58jT1LFU0B2gB22RRaAzbQ==
From: Esben Haabendal <esben.haabendal@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
        "open list\:ETHERNET PHY LIBRARY" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH 1/2] net: phy: Helper function for reading strapped configuration values
In-Reply-To: <49448b00-e3fd-25df-580e-c02428f1bfe6@gmail.com> (Florian
        Fainelli's message of "Thu, 5 Apr 2018 09:00:13 -0700")
References: <20180405114424.8519-1-esben.haabendal@gmail.com>
        <49448b00-e3fd-25df-580e-c02428f1bfe6@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
Date: Thu, 05 Apr 2018 22:34:18 +0200
Message-ID: <87a7uhjstx.fsf@haabendal.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Fainelli <f.fainelli@gmail.com> writes:

> On 04/05/2018 04:44 AM, esben.haabendal@gmail.com wrote:
>> From: Esben Haabendal <eha@deif.com>
>> 
>> Add a function for use in PHY driver probe functions, reading current
>> autoneg, speed and duplex configuration from BMCR register.
>> 
>> Useful for PHY that supports hardware strapped configuration, enabling
>> Linux to respect that configuration (i.e. strapped non-autoneg
>> configuration).
>> 
>> Signed-off-by: Esben Haabendal <eha@deif.com>
>> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>> ---
>>  drivers/net/phy/phy_device.c | 41 +++++++++++++++++++++++++++++++++++++++++
>>  include/linux/phy.h          |  1 +
>>  2 files changed, 42 insertions(+)
>> 
>> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
>> index 74664a6c0cdc..cc52ff2a2344 100644
>> --- a/drivers/net/phy/phy_device.c
>> +++ b/drivers/net/phy/phy_device.c
>> @@ -1673,6 +1673,47 @@ int genphy_config_init(struct phy_device *phydev)
>>  }
>>  EXPORT_SYMBOL(genphy_config_init);
>>  
>> +/**
>> + * genphy_read_config - read configuration from PHY
>> + * @phydev: target phy_device struct
>> + *
>> + * Description: Reads MII_BMCR and sets phydev autoneg, speed and duplex
>> + * accordingly.  For use in driver probe functions, to respect strapped
>> + * configuration settings.
>> + */
>> +int genphy_read_config(struct phy_device *phydev)
>
> This duplicates what already exists, in part at least within
> genphy_read_status() can you find a way to use that?

Make a small static function for updating duplex and speed fields from a
BMCR value.  It will not be big re-use, but it would make sense.  I will
do that in next patch version.

/Esben
