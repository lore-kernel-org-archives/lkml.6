Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeBHUOd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:14:33 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:48866 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeBHUOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:14:31 -0500
Date: Thu, 08 Feb 2018 15:14:29 -0500 (EST)
Message-Id: <20180208.151429.32851294514008981.davem@davemloft.net>
To: malat@debian.org
Cc: trivial@kernel.org, andrew@lunn.ch, privat@egil-hjelmeland.no,
        vivien.didelot@savoirfairelinux.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Extra '_get' in declaration of
 arch_get_platform_mac_address
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180207193501.25446-1-malat@debian.org>
References: <20180207193501.25446-1-malat@debian.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w18KEbnK005182

From: Mathieu Malaterre <malat@debian.org>
Date: Wed,  7 Feb 2018 20:35:00 +0100

> In commit c7f5d105495a ("net: Add eth_platform_get_mac_address() helper."),
> two declarations were added:
> 
>   int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr);
>   unsigned char *arch_get_platform_get_mac_address(void);
> 
> An extra '_get' was introduced in arch_get_platform_get_mac_address, remove
> it. Fix compile warning using W=1:
> 
>   CC      net/ethernet/eth.o
> net/ethernet/eth.c:523:24: warning: no previous prototype for ¡arch_get_platform_mac_address¢ [-Wmissing-prototypes]
>  unsigned char * __weak arch_get_platform_mac_address(void)
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   AR      net/ethernet/built-in.o
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

I'm very surprised this warning didn't get triggered before.

That's really weird!

Applied, thank you.
