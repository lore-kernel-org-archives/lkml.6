Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F2BECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18AC3208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sg4fCvho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18AC3208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbeGPNeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 09:34:13 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:57498 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbeGPNeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 09:34:13 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6GD3jiO165049;
        Mon, 16 Jul 2018 13:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2018-07-02;
 bh=4EKy6g6TrAsLRFR1R33z0pMExyWcnImK1KvCiY0iCj8=;
 b=Sg4fCvhoJN9AUAyJaUounxUG3H8l51KUrnoxtyVtWsULL5UcPWSLOPfw8vdhlJN3OwIH
 EFryczY4ut+sCFy+IOqACOMORwidrZu3OX4TZZxK/ozPSa4DlP//1CXz9sQGjtcxcEV1
 yP1Q98NCRrtRVK6jkJSRbMIFPHOI/lflbjouAXR3O896XYJjAvHN/xMOvvvDcMstab2B
 IFrfo2AYLhxZsMWnU1UTdmp+j4az7aFSyO7sx2G/aM9Z2HILduhhfSbg6KMudlmwO3Fx
 fwpfXTURxSldZUAX+cx9rBywkzb4p96BZhkUlbQPHukDzClUz2YOQbcx1xzCSc5uIvgx QQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2k7a3svane-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 13:06:49 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6GD6maA029047
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jul 2018 13:06:48 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6GD6mMt020977;
        Mon, 16 Jul 2018 13:06:48 GMT
Received: from lab02.no.oracle.com (/10.172.144.56)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Jul 2018 06:06:48 -0700
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <Haakon.Bugge@oracle.com>
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH] net/rds: Remove unnecessary variable
Date:   Mon, 16 Jul 2018 15:06:39 +0200
Message-Id: <20180716130639.1591990-1-Haakon.Bugge@oracle.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8955 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=832
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807160154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 net/rds/ib_recv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/rds/ib_recv.c b/net/rds/ib_recv.c
index b4e421aa9727..a720583542a1 100644
--- a/net/rds/ib_recv.c
+++ b/net/rds/ib_recv.c
@@ -1025,7 +1025,6 @@ int rds_ib_recv_path(struct rds_conn_path *cp)
 {
 	struct rds_connection *conn = cp->cp_conn;
 	struct rds_ib_connection *ic = conn->c_transport_data;
-	int ret = 0;
 
 	rdsdebug("conn %p\n", conn);
 	if (rds_conn_up(conn)) {
@@ -1034,7 +1033,7 @@ int rds_ib_recv_path(struct rds_conn_path *cp)
 		rds_ib_stats_inc(s_ib_rx_refill_from_thread);
 	}
 
-	return ret;
+	return 0;
 }
 
 int rds_ib_recv_init(void)
-- 
2.14.3

