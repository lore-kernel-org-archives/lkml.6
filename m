Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188EAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E216B214C1
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E216B214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbeK1E1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:27:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55708 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbeK1E1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:27:53 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wARHT8na006018
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 12:29:16 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2p17j38ee2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 12:29:16 -0500
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <pfsmorigo@linux.vnet.ibm.com>;
        Tue, 27 Nov 2018 17:29:16 -0000
Received: from b03cxnp08026.gho.boulder.ibm.com (9.17.130.18)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 27 Nov 2018 17:29:12 -0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wARHTB4519988524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Nov 2018 17:29:11 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B27BD7805E;
        Tue, 27 Nov 2018 17:29:11 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 923767805C;
        Tue, 27 Nov 2018 17:29:08 +0000 (GMT)
Received: from dublin.ltc.br.ibm.com (unknown [9.85.175.111])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 27 Nov 2018 17:29:08 +0000 (GMT)
From:   Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, Breno Leitao <leitao@debian.org>,
        Nayna Jain <nayna@linux.ibm.com>,
        Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] MAINTAINERS: change NX/VMX maintainers
Date:   Tue, 27 Nov 2018 15:27:21 -0200
X-Mailer: git-send-email 2.14.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18112717-0004-0000-0000-000014B9308C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010131; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123586; UDB=6.00583293; IPR=6.00903715;
 MB=3.00024356; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-27 17:29:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112717-0005-0000-0000-000089A73AD0
Message-Id: <20181127172739.24621-1-pfsmorigo@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-27_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=871 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811270149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Breno and Nayna as NX/VMX crypto driver maintainers. Also change my
email address to my personal account and remove Leonidas since he's not
working with the driver anymore.

Signed-off-by: Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
---
 MAINTAINERS | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 380e43f585d3..b7a4da8f2e33 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7017,8 +7017,9 @@ F:	crypto/842.c
 F:	lib/842/
 
 IBM Power in-Nest Crypto Acceleration
-M:	Leonidas S. Barbosa <leosilva@linux.vnet.ibm.com>
-M:	Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
+M:	Breno Leitão <leitao@debian.org>
+M:	Nayna Jain <nayna@linux.ibm.com>
+M:	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
 L:	linux-crypto@vger.kernel.org
 S:	Supported
 F:	drivers/crypto/nx/Makefile
@@ -7084,8 +7085,9 @@ S:	Supported
 F:	drivers/scsi/ibmvscsi_tgt/
 
 IBM Power VMX Cryptographic instructions
-M:	Leonidas S. Barbosa <leosilva@linux.vnet.ibm.com>
-M:	Paulo Flabiano Smorigo <pfsmorigo@linux.vnet.ibm.com>
+M:	Breno Leitão <leitao@debian.org>
+M:	Nayna Jain <nayna@linux.ibm.com>
+M:	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
 L:	linux-crypto@vger.kernel.org
 S:	Supported
 F:	drivers/crypto/vmx/Makefile
-- 
2.14.4

