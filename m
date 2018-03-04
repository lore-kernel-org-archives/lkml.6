Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbeCDPlX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 10:41:23 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:46736 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752606AbeCDPlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 10:41:21 -0500
Date: Sun, 4 Mar 2018 16:40:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev@vger.kernel.org, david.laight@aculab.com,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        open list <linux-kernel@vger.kernel.org>, opendmb@gmail.com,
        davem@davemloft.net
Subject: Re: [PATCH v2 0/4] net: Use strlcpy() for ethtool::get_strings
Message-ID: <20180304154054.GB19623@lunn.ch>
References: <20180302230839.31468-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302230839.31468-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 03:08:35PM -0800, Florian Fainelli wrote:
> Hi all,
> 
> After turning on KASAN on one of my systems, I started getting lots of out of
> bounds errors while fetching a given port's statistics, and indeed using
> memcpy() is unsafe for copying strings which have not been declared as an array
> of ETH_GSTRING_LEN bytes, so let's use strlcpy() instead. This allows the best
> of both worlds: we still keep the efficient memory usage of variably sized
> strings, but we don't copy more than we need to.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
