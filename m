Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753679AbeDEUfD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 16:35:03 -0400
Received: from mailrelay2-3.pub.mailoutpod1-cph3.one.com ([46.30.212.11]:14577
        "EHLO mailrelay2-3.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753391AbeDEUfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 16:35:02 -0400
X-HalOne-Cookie: 19a17deb6af7882b0e130400a84ee0213d86c1c1
X-HalOne-ID: 911c3cbc-390e-11e8-bb6c-d0431ea8a290
From: Esben Haabendal <esben@haabendal.dk>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
        "open list\:ETHERNET PHY LIBRARY" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH 1/2] net: phy: Helper function for reading strapped configuration values
References: <20180405114424.8519-1-esben.haabendal@gmail.com>
        <49448b00-e3fd-25df-580e-c02428f1bfe6@gmail.com>
Date: Thu, 05 Apr 2018 22:18:55 +0200
In-Reply-To: <49448b00-e3fd-25df-580e-c02428f1bfe6@gmail.com> (Florian
        Fainelli's message of "Thu, 5 Apr 2018 09:00:13 -0700")
Message-ID: <87h8opjtjk.fsf@haabendal.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
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
