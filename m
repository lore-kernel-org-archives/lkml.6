Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932319AbeE3UXM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:23:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932202AbeE3UXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:23:09 -0400
Date: Wed, 30 May 2018 22:22:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc: lwn@lwn.net, Jiri Slaby <jslaby@suse.cz>
Subject: Re: Linux 3.18.112
Message-ID: <20180530202246.GB2585@kroah.com>
References: <20180530202240.GA2585@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530202240.GA2585@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index f67a2d997624..d4658bcd411e 100644
--- a/Makefile
+++ b/Makefile
@@ -1,6 +1,6 @@
 VERSION = 3
 PATCHLEVEL = 18
-SUBLEVEL = 111
+SUBLEVEL = 112
 EXTRAVERSION =
 NAME = Diseased Newt
 
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index a3df032522a9..c35e0aa57e66 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -365,6 +365,7 @@ static int vti_tunnel_init(struct net_device *dev)
 	memcpy(dev->dev_addr, &iph->saddr, 4);
 	memcpy(dev->broadcast, &iph->daddr, 4);
 
+	dev->mtu		= ETH_DATA_LEN;
 	dev->flags		= IFF_NOARP;
 	dev->iflink		= 0;
 	dev->addr_len		= 4;
