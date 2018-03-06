Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753837AbeCFQNk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 11:13:40 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:39752 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752055AbeCFQNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 11:13:37 -0500
Date: Tue, 06 Mar 2018 11:13:35 -0500 (EST)
Message-Id: <20180306.111335.666760211356084355.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, david.laight@aculab.com, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, linux-kernel@vger.kernel.org,
        opendmb@gmail.com
Subject: Re: [PATCH v2 0/4] net: Use strlcpy() for ethtool::get_strings
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180302230839.31468-1-f.fainelli@gmail.com>
References: <20180302230839.31468-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri,  2 Mar 2018 15:08:35 -0800

> After turning on KASAN on one of my systems, I started getting lots of out of
> bounds errors while fetching a given port's statistics, and indeed using
> memcpy() is unsafe for copying strings which have not been declared as an array
> of ETH_GSTRING_LEN bytes, so let's use strlcpy() instead. This allows the best
> of both worlds: we still keep the efficient memory usage of variably sized
> strings, but we don't copy more than we need to.
> 
> Changes in v2:
> - dropped the 3 other patches that were not necessary
> - use strlcpy() instead of strncpy()

Series applied, thanks Florian.
