Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932332AbeDXKLD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 06:11:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:30578 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932342AbeDXKK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 06:10:59 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,322,1520924400";
   d="scan'208";a="222904822"
Date: Tue, 24 Apr 2018 18:10:23 +0800
From: kbuild test robot <lkp@intel.com>
To: Ahmed Abdelsalam <amsalam20@gmail.com>
Cc: kbuild-all@01.org, davem@davemloft.net, dav.lebrun@gmail.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ahmed Abdelsalam <amsalam20@gmail.com>
Subject: [RFC PATCH] ipv6: sr: seg6_make_flowlabel() can be static
Message-ID: <20180424101023.GA158507@lkp-ib03.lkp.intel.com>
References: <1524519420-1612-2-git-send-email-amsalam20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524519420-1612-2-git-send-email-amsalam20@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 484c5b41c685 ("ipv6: sr: Compute flowlabel of outer IPv6 header for seg6 encap mode")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 seg6_iptunnel.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index bf76c59..d2ff788 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -92,8 +92,8 @@ static void set_tun_src(struct net *net, struct net_device *dev,
 }
 
 /* Compute flowlabel for outer IPv6 header */
-__be32 seg6_make_flowlabel(struct net *net, struct sk_buff *skb,
-			   struct ipv6hdr *inner_hdr)
+static __be32 seg6_make_flowlabel(struct net *net, struct sk_buff *skb,
+				  struct ipv6hdr *inner_hdr)
 {
 	int do_flowlabel = net->ipv6.sysctl.seg6_flowlabel;
 	__be32 flowlabel = 0;
