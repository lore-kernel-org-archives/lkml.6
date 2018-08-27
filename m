Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A731C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E4B8208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 16:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4B8208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbeH0UbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:31:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727142AbeH0UbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:31:08 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7RGhgg9010568
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 12:43:46 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m4mb2hyhy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 12:43:46 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ivan@de.ibm.com>;
        Mon, 27 Aug 2018 17:43:42 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 Aug 2018 17:43:41 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7RGhe6U37814320
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Aug 2018 16:43:40 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD4AC5204E;
        Mon, 27 Aug 2018 19:43:37 +0100 (BST)
Received: from d06ml001.portsmouth.uk.ibm.com (unknown [9.149.76.127])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A1C2352050;
        Mon, 27 Aug 2018 19:43:37 +0100 (BST)
Received: from localhost.localdomain ([9.145.66.122])
          by d06ml001.portsmouth.uk.ibm.com (IBM Domino Release 9.0.1FP10HF192)
          with ESMTP id 2018082717433980-6096 ;
          Mon, 27 Aug 2018 17:43:39 +0100 
From:   Ivan Mikhaylov <ivan@de.ibm.com>
To:     netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        "Christian Lamparter" <chunkeey@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] net/ibm/emac: deletion of unneeded macros definitions
Date:   Mon, 27 Aug 2018 19:43:36 +0300
X-Mailer: git-send-email 2.15.1
X-MIMETrack: Itemize by SMTP Server on D06ML001/06/M/IBM(Release 9.0.1FP10HF192 | April
 16, 2018) at 27/08/2018 17:43:39,
        Serialize by Router on D06ML001/06/M/IBM(Release 9.0.1FP10HF192 | April 16, 2018) at
 27/08/2018 17:43:39,
        Serialize complete at 27/08/2018 17:43:39
X-TNEFEvaluated: 1
X-TM-AS-GCONF: 00
x-cbid: 18082716-0028-0000-0000-000002F06102
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082716-0029-0000-0000-000023A9B531
Message-Id: <20180827164336.8815-2-ivan@de.ibm.com>
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-27_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=955 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808270176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
---
 drivers/net/ethernet/ibm/emac/emac.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/emac.h b/drivers/net/ethernet/ibm/emac/emac.h
index e2f80cc..f541660 100644
--- a/drivers/net/ethernet/ibm/emac/emac.h
+++ b/drivers/net/ethernet/ibm/emac/emac.h
@@ -229,7 +229,6 @@ struct emac_regs {
 #define EMAC_STACR_PHYD_SHIFT		16
 #define EMAC_STACR_OC			0x00008000
 #define EMAC_STACR_PHYE			0x00004000
-#define EMAC_STACR_STAC_MASK		0x00003000
 #define EMAC_STACR_STAC_READ		0x00001000
 #define EMAC_STACR_STAC_WRITE		0x00000800
 #define EMAC_STACR_OPBC_MASK		0x00000C00
@@ -245,14 +244,8 @@ struct emac_regs {
 #define EMAC_STACR_PCDA_MASK		0x1f
 #define EMAC_STACR_PCDA_SHIFT		5
 #define EMAC_STACR_PRA_MASK		0x1f
-#define EMACX_STACR_STAC_MASK		0x00003800
 #define EMACX_STACR_STAC_READ		0x00001000
 #define EMACX_STACR_STAC_WRITE		0x00000800
-#define EMACX_STACR_STAC_IND_ADDR	0x00002000
-#define EMACX_STACR_STAC_IND_READ	0x00003800
-#define EMACX_STACR_STAC_IND_READINC	0x00003000
-#define EMACX_STACR_STAC_IND_WRITE	0x00002800
-

 /* EMACx_TRTR */
 #define EMAC_TRTR_SHIFT_EMAC4		24
--
1.7.1

