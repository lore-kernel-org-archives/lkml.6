Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A02C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A44620870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfAWHnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:43:35 -0500
Received: from gateway20.websitewelcome.com ([192.185.60.19]:15333 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbfAWHne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:43:34 -0500
X-Greylist: delayed 1235 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jan 2019 02:43:34 EST
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 199BC4010DC31
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 01:22:59 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id mCsEg1rPf90onmCsFgTGRE; Wed, 23 Jan 2019 01:22:59 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=46276 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gmCps-0038sJ-9x; Wed, 23 Jan 2019 01:22:58 -0600
Date:   Wed, 23 Jan 2019 01:20:31 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH net-next] Bluetooth: Mark expected switch fall-throughs
Message-ID: <20190123072031.GA9678@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gmCps-0038sJ-9x
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.130.205]:46276
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 24
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

This patch fixes the following warnings:

net/bluetooth/rfcomm/core.c:479:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
net/bluetooth/l2cap_core.c:4223:6: warning: this statement may fall through [-Wimplicit-fallthrough=]

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enabling
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/bluetooth/l2cap_core.c  | 1 +
 net/bluetooth/rfcomm/core.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2a7fb517d460..a5b76e24940a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -4244,6 +4244,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
 				goto done;
 			break;
 		}
+		/* fall through */
 
 	default:
 		l2cap_chan_set_err(chan, ECONNRESET);
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 1a635df80643..3a9e9d9670be 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -483,6 +483,7 @@ static int __rfcomm_dlc_close(struct rfcomm_dlc *d, int err)
 		/* if closing a dlc in a session that hasn't been started,
 		 * just close and unlink the dlc
 		 */
+		/* fall through */
 
 	default:
 		rfcomm_dlc_clear_timer(d);
-- 
2.20.1

