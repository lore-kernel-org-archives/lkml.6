Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164305AbeE1NCl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1164096AbeE1KxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:53:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 265/496] vti4: Dont override MTU passed on link creation via IFLA_MTU
Date: Mon, 28 May 2018 12:00:50 +0200
Message-Id: <20180528100331.027308221@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>

[ Upstream commit 03080e5ec72740c1a62e6730f2a5f3f114f11b19 ]

Don't hardcode a MTU value on vti tunnel initialization,
ip_tunnel_newlink() is able to deal with this already. See also
commit ffc2b6ee4174 ("ip_gre: fix IFLA_MTU ignored on NEWLINK").

Fixes: 1181412c1a67 ("net/ipv4: VTI support new module for ip_vti.")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Acked-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_vti.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -396,7 +396,6 @@ static int vti_tunnel_init(struct net_de
 	memcpy(dev->dev_addr, &iph->saddr, 4);
 	memcpy(dev->broadcast, &iph->daddr, 4);
 
-	dev->mtu		= ETH_DATA_LEN;
 	dev->flags		= IFF_NOARP;
 	dev->addr_len		= 4;
 	dev->features		|= NETIF_F_LLTX;
