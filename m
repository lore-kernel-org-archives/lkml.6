Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932389AbeE3Ui3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932206AbeE3UiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:38:25 -0400
Date: Wed, 30 May 2018 22:38:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 4.14.47
Message-ID: <20180530203804.GB28104@kroah.com>
References: <20180530203759.GA28104@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530203759.GA28104@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 3b1845f2b8f8..d6db01a02252 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 14
-SUBLEVEL = 46
+SUBLEVEL = 47
 EXTRAVERSION =
 NAME = Petit Gorille
 
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 5c5699c08575..00d4371d4573 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -396,6 +396,7 @@ static int vti_tunnel_init(struct net_device *dev)
 	memcpy(dev->dev_addr, &iph->saddr, 4);
 	memcpy(dev->broadcast, &iph->daddr, 4);
 
+	dev->mtu		= ETH_DATA_LEN;
 	dev->flags		= IFF_NOARP;
 	dev->addr_len		= 4;
 	dev->features		|= NETIF_F_LLTX;
