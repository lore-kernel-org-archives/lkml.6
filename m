Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164516AbeCBDIM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 22:08:12 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:42761 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163239AbeCBDIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 22:08:10 -0500
Date: Fri, 2 Mar 2018 04:08:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Woojung Huh <Woojung.Huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net 4/4] net: dsa: mv88e6xxx: Utilize strncpy() for
 ethtool::get_strings
Message-ID: <20180302030804.GB12656@lunn.ch>
References: <20180302002529.15226-1-f.fainelli@gmail.com>
 <20180302002529.15226-5-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302002529.15226-5-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 04:25:29PM -0800, Florian Fainelli wrote:
> Do not use memcpy() which is not safe, but instead use strncpy() which
> will make sure that the string is NUL terminated (in the Linux
> implementation) if the string is smaller than the length specified. This
> fixes KASAN out of bounds warnings while fetching port statistics.
> 
> Fixes: f5e2ed022dff ("dsa: mv88e6xxx: Add Second back of statistics")

I'm sure it goes back much further than that.

> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
