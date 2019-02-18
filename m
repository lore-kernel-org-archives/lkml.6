Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C01C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE6BB2146E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 18:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392167AbfBRSVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 13:21:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:45996 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392078AbfBRSVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 13:21:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27782AEBB;
        Mon, 18 Feb 2019 18:21:35 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 8F161E0122; Mon, 18 Feb 2019 19:21:34 +0100 (CET)
Message-Id: <2078f959ed3474c4228fd6016c892331f8e2c7b8.1550513384.git.mkubecek@suse.cz>
In-Reply-To: <cover.1550513384.git.mkubecek@suse.cz>
References: <cover.1550513384.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [RFC PATCH net-next v3 02/21] ethtool: move to its own directory
To:     netdev@vger.kernel.org
Cc:     David Miller <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Date:   Mon, 18 Feb 2019 19:21:34 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ethtool netlink interface is going to be split into multiple files so
that it will be more convenient to put all of them in a separate directory
net/ethtool. Start by moving current ethtool.c with ioctl interface into
this directory and renaming it to ioct.c.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 net/Makefile                            | 2 +-
 net/core/Makefile                       | 2 +-
 net/ethtool/Makefile                    | 3 +++
 net/{core/ethtool.c => ethtool/ioctl.c} | 0
 4 files changed, 5 insertions(+), 2 deletions(-)
 create mode 100644 net/ethtool/Makefile
 rename net/{core/ethtool.c => ethtool/ioctl.c} (100%)

diff --git a/net/Makefile b/net/Makefile
index bdaf53925acd..6c68520e5eb9 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_NET)		+= $(tmp-y)
 
 # LLC has to be linked before the files in net/802/
 obj-$(CONFIG_LLC)		+= llc/
-obj-$(CONFIG_NET)		+= ethernet/ 802/ sched/ netlink/ bpf/
+obj-$(CONFIG_NET)		+= ethernet/ 802/ sched/ netlink/ bpf/ ethtool/
 obj-$(CONFIG_NETFILTER)		+= netfilter/
 obj-$(CONFIG_INET)		+= ipv4/
 obj-$(CONFIG_TLS)		+= tls/
diff --git a/net/core/Makefile b/net/core/Makefile
index f97d6254e564..9ddc2f3ecd97 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -8,7 +8,7 @@ obj-y := sock.o request_sock.o skbuff.o datagram.o stream.o scm.o \
 
 obj-$(CONFIG_SYSCTL) += sysctl_net_core.o
 
-obj-y		     += dev.o ethtool.o dev_addr_lists.o dst.o netevent.o \
+obj-y		     += dev.o dev_addr_lists.o dst.o netevent.o \
 			neighbour.o rtnetlink.o utils.o link_watch.o filter.o \
 			sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
 			fib_notifier.o xdp.o flow_offload.o
diff --git a/net/ethtool/Makefile b/net/ethtool/Makefile
new file mode 100644
index 000000000000..3ebfab2bca66
--- /dev/null
+++ b/net/ethtool/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y		+= ioctl.o
diff --git a/net/core/ethtool.c b/net/ethtool/ioctl.c
similarity index 100%
rename from net/core/ethtool.c
rename to net/ethtool/ioctl.c
-- 
2.20.1

