Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeCWWLj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 18:11:39 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:39217 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751677AbeCWWLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 18:11:36 -0400
X-Google-Smtp-Source: AG47ELsWAr1y8MRgpQkuIq3ZvcX8VRW4uoDmBNNQHr4qpPZdoHY9Jkzf3f25U7Z7LvTM0Awp43rIyw==
Subject: Re: [PATCH net-next 6/8] MIPS: mscc: Add switch to ocelot
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-7-alexandre.belloni@bootlin.com>
 <e488fd29-0094-d005-a078-873f6f5add13@gmail.com>
 <20180323212230.GA12808@piout.net> <20180323213344.GV24361@lunn.ch>
 <dcac43b7-2eb7-d409-a77c-4f671a8cfc3d@gmail.com>
 <20180323220657.GY24361@lunn.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <171fb3db-70f4-4818-9390-8164fab5adca@gmail.com>
Date: Fri, 23 Mar 2018 15:11:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323220657.GY24361@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/2018 03:06 PM, Andrew Lunn wrote:
>>> That is the trade off of having a standalone MDIO bus driver.  Maybe
>>> add a phandle to the internal MDIO bus? The switch driver could then
>>> follow the phandle, and direct connect the internal PHYs?
>>
>> This is more or less what patch 7 does, right?
> 
> Patch 7 does it in DT. I'm suggesting it could be done in C. It is
> hard wired, so there is no need to describe it in DT. Use the phandle
> to get the mdio bus, mdiobus_get_phy(, port) to get the phydev and
> then use phy_connect().

That does not sound like a great idea. And to go back to your example
about DSA, it is partially true, you will see some switch bindings
defining the internal PHYs (e.g: qca8k), and most not doing it (b53,
mv88e6xxx, etc.). In either case, this resolves to the same thing
though. Being able to parse a phy-handle property is a lot more
flexible, and if it does matter that the PHY truly is internal, then the
'phy-mode' property can help reflect that.
-- 
Florian
