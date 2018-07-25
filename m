Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93759C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5804520852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5804520852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbeGYPsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:48:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727881AbeGYPsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:48:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6PEXx6u086301
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 10:36:07 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ket5yk65r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 10:35:46 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ubraun@linux.ibm.com>;
        Wed, 25 Jul 2018 15:35:42 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Jul 2018 15:35:41 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w6PEZeBT40763560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 25 Jul 2018 14:35:40 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5B6C11C054;
        Wed, 25 Jul 2018 17:35:53 +0100 (BST)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9528611C04A;
        Wed, 25 Jul 2018 17:35:53 +0100 (BST)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Jul 2018 17:35:53 +0100 (BST)
From:   Ursula Braun <ubraun@linux.ibm.com>
To:     davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        raspl@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/4] net/smc: fewer parameters for smc_llc_send_confirm_link()
Date:   Wed, 25 Jul 2018 16:35:30 +0200
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180725143533.7082-1-ubraun@linux.ibm.com>
References: <20180725143533.7082-1-ubraun@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18072514-4275-0000-0000-0000029D7EC8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18072514-4276-0000-0000-000037A5BC48
Message-Id: <20180725143533.7082-2-ubraun@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-25_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807250157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link confirmation will always be sent across the new link being
confirmed. This allows to shrink the parameter list.
No functional change.

Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/af_smc.c  | 10 ++--------
 net/smc/smc_llc.c |  9 +++++----
 net/smc/smc_llc.h |  2 +-
 3 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 7fc810ec31c5..7883f70f7c6d 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -352,10 +352,7 @@ static int smc_clnt_conf_first_link(struct smc_sock *smc)
 		return SMC_CLC_DECL_INTERR;
 
 	/* send CONFIRM LINK response over RoCE fabric */
-	rc = smc_llc_send_confirm_link(link,
-				       link->smcibdev->mac[link->ibport - 1],
-				       &link->smcibdev->gid[link->ibport - 1],
-				       SMC_LLC_RESP);
+	rc = smc_llc_send_confirm_link(link, SMC_LLC_RESP);
 	if (rc < 0)
 		return SMC_CLC_DECL_TCL;
 
@@ -951,10 +948,7 @@ static int smc_serv_conf_first_link(struct smc_sock *smc)
 		return SMC_CLC_DECL_INTERR;
 
 	/* send CONFIRM LINK request to client over the RoCE fabric */
-	rc = smc_llc_send_confirm_link(link,
-				       link->smcibdev->mac[link->ibport - 1],
-				       &link->smcibdev->gid[link->ibport - 1],
-				       SMC_LLC_REQ);
+	rc = smc_llc_send_confirm_link(link, SMC_LLC_REQ);
 	if (rc < 0)
 		return SMC_CLC_DECL_TCL;
 
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index b7944aa1ffc3..f2ba99c2e69a 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -182,8 +182,7 @@ static int smc_llc_add_pending_send(struct smc_link *link,
 }
 
 /* high-level API to send LLC confirm link */
-int smc_llc_send_confirm_link(struct smc_link *link, u8 mac[],
-			      union ib_gid *gid,
+int smc_llc_send_confirm_link(struct smc_link *link,
 			      enum smc_llc_reqresp reqresp)
 {
 	struct smc_link_group *lgr = smc_get_lgr(link);
@@ -202,8 +201,10 @@ int smc_llc_send_confirm_link(struct smc_link *link, u8 mac[],
 	confllc->hd.flags |= SMC_LLC_FLAG_NO_RMBE_EYEC;
 	if (reqresp == SMC_LLC_RESP)
 		confllc->hd.flags |= SMC_LLC_FLAG_RESP;
-	memcpy(confllc->sender_mac, mac, ETH_ALEN);
-	memcpy(confllc->sender_gid, gid, SMC_GID_SIZE);
+	memcpy(confllc->sender_mac, link->smcibdev->mac[link->ibport - 1],
+	       ETH_ALEN);
+	memcpy(confllc->sender_gid, &link->smcibdev->gid[link->ibport - 1],
+	       SMC_GID_SIZE);
 	hton24(confllc->sender_qp_num, link->roce_qp->qp_num);
 	confllc->link_num = link->link_id;
 	memcpy(confllc->link_uid, lgr->id, SMC_LGR_ID_SIZE);
diff --git a/net/smc/smc_llc.h b/net/smc/smc_llc.h
index 65c8645e96a1..9a29fcbbcea8 100644
--- a/net/smc/smc_llc.h
+++ b/net/smc/smc_llc.h
@@ -36,7 +36,7 @@ enum smc_llc_msg_type {
 };
 
 /* transmit */
-int smc_llc_send_confirm_link(struct smc_link *lnk, u8 mac[], union ib_gid *gid,
+int smc_llc_send_confirm_link(struct smc_link *lnk,
 			      enum smc_llc_reqresp reqresp);
 int smc_llc_send_add_link(struct smc_link *link, u8 mac[], union ib_gid *gid,
 			  enum smc_llc_reqresp reqresp);
-- 
2.16.4

