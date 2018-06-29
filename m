Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECD1C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647B527F61
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 13:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647B527F61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936591AbeF2Nmh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 09:42:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57344 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935525AbeF2Nmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 09:42:36 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5TDcgFN090296
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 09:42:35 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jwnb89wks-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 09:42:35 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Fri, 29 Jun 2018 14:42:33 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Jun 2018 14:42:32 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5TDgVqD41746492
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Jun 2018 13:42:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E2EA52054;
        Fri, 29 Jun 2018 14:42:20 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.81])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id D2CEE52050;
        Fri, 29 Jun 2018 14:42:18 +0100 (BST)
Received: by rapoport-lnx (sSMTP sendmail emulation); Fri, 29 Jun 2018 16:42:29 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH] arc/Kconfig: include mm/Kconfig inside "ARC system configuration"
Date:   Fri, 29 Jun 2018 16:42:27 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18062913-4275-0000-0000-000002935B27
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062913-4276-0000-0000-0000379ACC57
Message-Id: <1530279747-25320-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-29_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=918 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806290147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise mm configuration options show up in the top level menu.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 arch/arc/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index e81bcd271be7..92cf06b354a8 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -554,8 +554,6 @@ menu "Executable file formats"
 source "fs/Kconfig.binfmt"
 endmenu
 
-endmenu	 # "ARC Architecture Configuration"
-
 source "mm/Kconfig"
 
 config FORCE_MAX_ZONEORDER
@@ -563,6 +561,8 @@ config FORCE_MAX_ZONEORDER
 	default "12" if ARC_HUGEPAGE_16M
 	default "11"
 
+endmenu	 # "ARC Architecture Configuration"
+
 source "net/Kconfig"
 source "drivers/Kconfig"
 
-- 
2.7.4

