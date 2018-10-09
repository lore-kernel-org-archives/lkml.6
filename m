Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DE8C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3A521479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 14:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oFuSkNWI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3A521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbeJIVpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:45:04 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39490 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbeJIVpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:45:03 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w99ERZT5183070;
        Tue, 9 Oct 2018 14:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=szqIYAdIyT0GpUL2dyMKu4SbCLSsnAk/u7zaUcvIa6Q=;
 b=oFuSkNWIs7vI3Koz6Z2yLzJJIR7AN2DVgygOgp3fk09tHU09mdSgmW/W5aWKl/PFuQ0i
 rt6c8AXc/eMqM8U1RA+6hiiVfVcltEjAcMWNV36AigoLQyliGfNpCBPrV1OcZiQQrXV+
 p1WtY9MG9yzTSytj5q6DuArzMhr26OlyYvRT1dXeNRnMOQbHA7rD/8N+t94PyZuLHaG/
 uQuXV1KXu2p781AAtz5yON85RM/LuTIHuTM2GtCcV0JcMkg63QzEzGoMgR3GRjFQExGB
 eHJttmDkmhmj+ykEwemtyqlrJSPQWgl4GikC7qkQrbZsbtv6+hsTYnrRO/rG776g41pW 4A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mxmftnrr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Oct 2018 14:27:38 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w99ERbvv004314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Oct 2018 14:27:37 GMT
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w99ERaXT007545;
        Tue, 9 Oct 2018 14:27:36 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Oct 2018 14:27:36 +0000
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <Haakon.Bugge@oracle.com>
To:     netdev@vger.kernel.org
Cc:     stephen@networkplumber.org,
        "David S . Miller" <davem@davemloft.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH  v2 2/2] net: if_arp: use define instead of hard-coded value
Date:   Tue,  9 Oct 2018 16:27:24 +0200
Message-Id: <20181009142724.2213012-3-Haakon.Bugge@oracle.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181009142724.2213012-1-Haakon.Bugge@oracle.com>
References: <20181009142724.2213012-1-Haakon.Bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9040 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=423
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810090142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let uapi/linux/if_arp.h include uapi/linux/if.h, where IFNAMSIZ is
defined. Then, use it in this file instead of hard-coded value.

This way, we are using an uapi defined constant, and as such,
user-space should be good.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
Tested-by: Stephen Hemminger <stephen@networkplumber.org>

---

v1 -> v2:
   * Include uapi/linux/if.h
   * Add Stephen's t-b
---
 include/uapi/linux/if_arp.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
index b68b4b3d9172..f5d2dab3f610 100644
--- a/include/uapi/linux/if_arp.h
+++ b/include/uapi/linux/if_arp.h
@@ -24,6 +24,7 @@
 #ifndef _UAPI_LINUX_IF_ARP_H
 #define _UAPI_LINUX_IF_ARP_H
 
+#include <linux/if.h>
 #include <linux/netdevice.h>
 
 /* ARP protocol HARDWARE identifiers. */
@@ -118,7 +119,7 @@ struct arpreq {
 	struct sockaddr	arp_ha;		/* hardware address		 */
 	int		arp_flags;	/* flags			 */
 	struct sockaddr arp_netmask;    /* netmask (only for proxy arps) */
-	char		arp_dev[16];
+	char		arp_dev[IFNAMSIZ];
 };
 
 struct arpreq_old {
-- 
2.14.3

