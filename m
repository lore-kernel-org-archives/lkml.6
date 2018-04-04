Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbeDDPQL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:16:11 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:40014 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbeDDPQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:16:10 -0400
Date: Wed, 04 Apr 2018 11:16:07 -0400 (EDT)
Message-Id: <20180404.111607.1860127305837140688.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: b53: Fix sparse warnings in b53_mmap.c
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180402231701.17348-1-f.fainelli@gmail.com>
References: <20180402231701.17348-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon,  2 Apr 2018 16:17:01 -0700

> sparse complains about the following warnings:
> 
> drivers/net/dsa/b53/b53_mmap.c:33:31: warning: incorrect type in
> initializer (different address spaces)
> drivers/net/dsa/b53/b53_mmap.c:33:31:    expected unsigned char
> [noderef] [usertype] <asn:2>*regs
> drivers/net/dsa/b53/b53_mmap.c:33:31:    got void *priv
> 
> and indeed, while what we are doing is functional, we are dereferencing
> a void * pointer into a void __iomem * which is not great. Just use the
> defined b53_mmap_priv structure which holds our register base and use
> that.
> 
> Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied.
