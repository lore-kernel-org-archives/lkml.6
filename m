Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbeC3Viy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 17:38:54 -0400
Received: from gateway30.websitewelcome.com ([192.185.179.30]:24599 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752203AbeC3Vix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 17:38:53 -0400
Date: Fri, 30 Mar 2018 16:18:44 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] PM / QoS: mark expected switch fall-throughs
Message-ID: <20180330211844.GA23072@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f21Q5-001Bja-BE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.145.54.187]:45392
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 16
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
This code was compiled with GCC 7.3.0

 kernel/power/qos.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 9d75039..fa39092 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -295,6 +295,7 @@ int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_node *node,
 		 * changed
 		 */
 		plist_del(node, &c->list);
+		/* fall through */
 	case PM_QOS_ADD_REQ:
 		plist_node_init(node, new_value);
 		plist_add(node, &c->list);
@@ -367,6 +368,7 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 		break;
 	case PM_QOS_UPDATE_REQ:
 		pm_qos_flags_remove_req(pqf, req);
+		/* fall through */
 	case PM_QOS_ADD_REQ:
 		req->flags = val;
 		INIT_LIST_HEAD(&req->node);
-- 
2.7.4
