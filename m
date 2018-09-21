Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04EDECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6C721477
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cKc+i9Mc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6C721477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389856AbeIUQ22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:28:28 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50670 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeIUQ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:28:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8LAdQYc085663;
        Fri, 21 Sep 2018 10:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=0L10St+lienYN6LhonwsS65SroB5R3YqXBF6JDo9OGE=;
 b=cKc+i9McStG5ljlEhSvUdleiEApefw5HXpZ66gBG/KkpoLcIltjpx9RdbRjoIEWal7q4
 bIGkJmgVPydQbcz33etTD3HfIzY72wMW51FNjeGBTGXlxmDSWLUlTlbpUTuaAzTJ6Puk
 bx0z3gR/+FMtKew59828Y61yp3C2Ix9RdQrK8xOixlUadiVxKXu5yBtEVbM3imUzTQZq
 51Qpssid6NHeahy7yGwLkMZc2gr0B/bQFUV+j9Vqz848G8Z2xlPb4w83GjskewX923V8
 UhR5LXmmc6ey3/msIe0nU/RAaImNJHSxNd2pyFVA1cN2nmsCCA+uDRFlIM5DfBmVsx8s ww== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mmkm22cuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 10:39:43 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8LAdglK014046
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 10:39:42 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8LAdff4031856;
        Fri, 21 Sep 2018 10:39:42 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Sep 2018 03:39:41 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <Haakon.Bugge@oracle.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 1/2] net: if_arp: Fix incorrect indents
Date:   Fri, 21 Sep 2018 12:39:29 +0200
Message-Id: <20180921103930.1420679-2-Haakon.Bugge@oracle.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180921103930.1420679-1-Haakon.Bugge@oracle.com>
References: <20180921103930.1420679-1-Haakon.Bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9022 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=731
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809210112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing incorrect indents and align comments.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 include/uapi/linux/if_arp.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
index 4605527ca41b..b68b4b3d9172 100644
--- a/include/uapi/linux/if_arp.h
+++ b/include/uapi/linux/if_arp.h
@@ -114,18 +114,18 @@
 
 /* ARP ioctl request. */
 struct arpreq {
-  struct sockaddr	arp_pa;		/* protocol address		*/
-  struct sockaddr	arp_ha;		/* hardware address		*/
-  int			arp_flags;	/* flags			*/
-  struct sockaddr       arp_netmask;    /* netmask (only for proxy arps) */
-  char			arp_dev[16];
+	struct sockaddr	arp_pa;		/* protocol address		 */
+	struct sockaddr	arp_ha;		/* hardware address		 */
+	int		arp_flags;	/* flags			 */
+	struct sockaddr arp_netmask;    /* netmask (only for proxy arps) */
+	char		arp_dev[16];
 };
 
 struct arpreq_old {
-  struct sockaddr	arp_pa;		/* protocol address		*/
-  struct sockaddr	arp_ha;		/* hardware address		*/
-  int			arp_flags;	/* flags			*/
-  struct sockaddr       arp_netmask;    /* netmask (only for proxy arps) */
+	struct sockaddr	arp_pa;		/* protocol address		 */
+	struct sockaddr	arp_ha;		/* hardware address		 */
+	int		arp_flags;	/* flags			 */
+	struct sockaddr	arp_netmask;    /* netmask (only for proxy arps) */
 };
 
 /* ARP Flag values. */
-- 
2.14.3

