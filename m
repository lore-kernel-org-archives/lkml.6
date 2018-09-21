Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE9BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA7021477
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eM+epkaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA7021477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389896AbeIUQ23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:28:29 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50668 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbeIUQ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:28:28 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w8LAdOXX085658;
        Fri, 21 Sep 2018 10:39:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=ss57p42t8UirbBSWqennPNnvYLEGIe8oJhOEsYZkpH4=;
 b=eM+epkaRz5lpYrq9fdj885geBGsI/vZJM9sFpQIMW2lE0rUkO6Y5taYViYpfPMurjttr
 hGEgIsrSh2IEPLb6J/nXOg6om09eX2E1mq/iYu4vtaErfFIqbQADrR6WQM2fBxIsgHr1
 qoNQtwxffw0WsnsumgqsRgo6Fm0kJ9JEtGQtvmcKbaCWfraAU6Drb1VMHhNB7NfWjV1m
 kFEhP2Ai4byf60xn39qGH+GWrbTsu7I+TDuc2m/SyKxxnfLyBn4KqVd3HF2VPXarnikm
 MUXbcgTv2vCplV9yOb/5R4b34U9XCTbNzyKFFdrlypO+C9GqHPkjP1SPhEQKpOlRQ/Pe RA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2mmkm22cuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 10:39:45 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w8LAdhaX014073
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Sep 2018 10:39:44 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w8LAdhIo011992;
        Fri, 21 Sep 2018 10:39:43 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Sep 2018 03:39:43 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <Haakon.Bugge@oracle.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 2/2] net: if_arp: use define instead of hard-coded value
Date:   Fri, 21 Sep 2018 12:39:30 +0200
Message-Id: <20180921103930.1420679-3-Haakon.Bugge@oracle.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180921103930.1420679-1-Haakon.Bugge@oracle.com>
References: <20180921103930.1420679-1-Haakon.Bugge@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9022 signatures=668707
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=508
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1809210112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uapi/linux/if_arp.h includes linux/netdevice.h, which uses
IFNAMSIZ. Hence, use it instead of hard-coded value.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 include/uapi/linux/if_arp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
index b68b4b3d9172..c3cc5a9e5eaf 100644
--- a/include/uapi/linux/if_arp.h
+++ b/include/uapi/linux/if_arp.h
@@ -118,7 +118,7 @@ struct arpreq {
 	struct sockaddr	arp_ha;		/* hardware address		 */
 	int		arp_flags;	/* flags			 */
 	struct sockaddr arp_netmask;    /* netmask (only for proxy arps) */
-	char		arp_dev[16];
+	char		arp_dev[IFNAMSIZ];
 };
 
 struct arpreq_old {
-- 
2.14.3

