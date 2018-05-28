Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163903AbeE1Kvy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:51:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163869AbeE1Kvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:51:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 234/496] hv_netvsc: fix filter flags
Date: Mon, 28 May 2018 12:00:19 +0200
Message-Id: <20180528100329.769235339@linuxfoundation.org>
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

From: Stephen Hemminger <stephen@networkplumber.org>

[ Upstream commit de3d50aadd40bf68614db9fd157b275ce9c2d467 ]

The recent change to not always enable all multicast and broadcast
was broken; meant to set filter, not change flags.

Fixes: 009f766ca238 ("hv_netvsc: filter multicast/broadcast")
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/hyperv/rndis_filter.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -857,9 +857,9 @@ static void rndis_set_multicast(struct w
 		filter = NDIS_PACKET_TYPE_PROMISCUOUS;
 	} else {
 		if (flags & IFF_ALLMULTI)
-			flags |= NDIS_PACKET_TYPE_ALL_MULTICAST;
+			filter |= NDIS_PACKET_TYPE_ALL_MULTICAST;
 		if (flags & IFF_BROADCAST)
-			flags |= NDIS_PACKET_TYPE_BROADCAST;
+			filter |= NDIS_PACKET_TYPE_BROADCAST;
 	}
 
 	rndis_filter_set_packet_filter(rdev, filter);
