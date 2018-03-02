Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1165046AbeCBEeY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 23:34:24 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46346 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164424AbeCBEeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 23:34:18 -0500
X-Google-Smtp-Source: AG47ELsNFAj1UuC8vsUbEg1AA7GWF4+CgzsjJVO/vENVEg/saElKmRTtqe8/ew6jTIt/NpKS45g/vA==
Subject: Re: [PATCH net 0/4] net: dsa: Use strncpy() for ethtool::get_strings
To: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Woojung Huh <Woojung.Huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20180302002529.15226-1-f.fainelli@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <beeb4115-bdf7-176f-2ffb-24ebb5d02daa@gmail.com>
Date: Thu, 1 Mar 2018 20:34:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180302002529.15226-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 03/01/2018 04:25 PM, Florian Fainelli wrote:
> Hi all,
> 
> After turning on KASAN on one of my systems, I started getting lots of out of
> bounds errors while fetching a given port's statistics, and indeed using
> memcpy() is unsafe for copying strings, so let's use strncpy() instead.

Looks like only patch 1 is necessary, but there are more drivers with
the same pattern under drivers/net/phy: marvell.c, micrel.c and
bcm-phy-lib.c, so I will submit a v2 with those fixed.

> 
> Florian Fainelli (4):
>   net: dsa: b53: Use strncpy() for ethtool::get_strings
>   net: dsa: loop: Use strncpy() for ethtool::get_strings
>   net: dsa: microchip: Utilize strncpy() for ethtool::get_strings
>   net: dsa: mv88e6xxx: Utilize strncpy() for ethtool::get_strings
> 
>  drivers/net/dsa/b53/b53_common.c       | 4 ++--
>  drivers/net/dsa/dsa_loop.c             | 4 ++--
>  drivers/net/dsa/microchip/ksz_common.c | 4 ++--
>  drivers/net/dsa/mv88e6xxx/chip.c       | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 

-- 
Florian
