Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeCWVpH (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:45:07 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33908 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751504AbeCWVpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:45:05 -0400
X-Google-Smtp-Source: AG47ELsDyVlP3Z7/Ux415Bmwa4MBiKM+MAfXll068ZEPvWunLix2pBvMb3VnAzia8oj4nPM1RzzEjg==
Subject: Re: [PATCH net-next 6/8] MIPS: mscc: Add switch to ocelot
To: Andrew Lunn <andrew@lunn.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
References: <20180323201117.8416-1-alexandre.belloni@bootlin.com>
 <20180323201117.8416-7-alexandre.belloni@bootlin.com>
 <e488fd29-0094-d005-a078-873f6f5add13@gmail.com>
 <20180323212230.GA12808@piout.net> <20180323213344.GV24361@lunn.ch>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <dcac43b7-2eb7-d409-a77c-4f671a8cfc3d@gmail.com>
Date: Fri, 23 Mar 2018 14:44:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323213344.GV24361@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/2018 02:33 PM, Andrew Lunn wrote:
> On Fri, Mar 23, 2018 at 10:22:30PM +0100, Alexandre Belloni wrote:
>> On 23/03/2018 at 14:17:48 -0700, Florian Fainelli wrote:
>>> On 03/23/2018 01:11 PM, Alexandre Belloni wrote:
>>>> +
>>>> +			phy0: ethernet-phy@0 {
>>>> +				reg = <0>;
>>>> +			};
>>>> +			phy1: ethernet-phy@1 {
>>>> +				reg = <1>;
>>>> +			};
>>>> +			phy2: ethernet-phy@2 {
>>>> +				reg = <2>;
>>>> +			};
>>>> +			phy3: ethernet-phy@3 {
>>>> +				reg = <3>;
>>>> +			};
>>>
>>> These PHYs should be defined at the board DTS level.
>>
>> Those are internal PHYs, present on the SoC, I doubt anyone will have
>> anything different while using the same SoC.
> 
> With DSA, there is no need to list internal PHYs.
> 
> That is the trade off of having a standalone MDIO bus driver.  Maybe
> add a phandle to the internal MDIO bus? The switch driver could then
> follow the phandle, and direct connect the internal PHYs?

This is more or less what patch 7 does, right?
-- 
Florian
