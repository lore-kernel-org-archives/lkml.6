Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF9BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B05222DE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 21:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388361AbfBOVyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 16:54:19 -0500
Received: from gateway22.websitewelcome.com ([192.185.46.156]:27308 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730709AbfBOVyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 16:54:17 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 19B9C8E2C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 15:54:16 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ulR2gSJoB2qH7ulR2gzquL; Fri, 15 Feb 2019 15:54:16 -0600
X-Authority-Reason: nr=8
Received: from [189.250.119.20] (port=58134 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gulR1-000xaO-5v; Fri, 15 Feb 2019 15:54:15 -0600
Date:   Fri, 15 Feb 2019 15:54:14 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] scsi: mpt3sas: Add missing breaks in switch statements
Message-ID: <20190215215414.GA10944@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.20
X-Source-L: No
X-Exim-ID: 1gulR1-000xaO-5v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.20]:58134
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warnings by adding the proper missing breaks:

drivers/scsi/mpt3sas/mpt3sas_base.c: In function ‘_base_display_OEMs_branding’:
drivers/scsi/mpt3sas/mpt3sas_base.c:3548:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
    switch (ioc->pdev->subsystem_device) {
    ^~~~~~
drivers/scsi/mpt3sas/mpt3sas_base.c:3566:3: note: here
   case MPI2_MFGPAGE_DEVID_SAS2308_2:
   ^~~~
drivers/scsi/mpt3sas/mpt3sas_base.c:3567:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
    switch (ioc->pdev->subsystem_device) {
    ^~~~~~
drivers/scsi/mpt3sas/mpt3sas_base.c:3601:3: note: here
   case MPI25_MFGPAGE_DEVID_SAS3008:
   ^~~~
drivers/scsi/mpt3sas/mpt3sas_base.c:3735:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
    switch (ioc->pdev->subsystem_device) {
    ^~~~~~
drivers/scsi/mpt3sas/mpt3sas_base.c:3745:3: note: here
   case MPI2_MFGPAGE_DEVID_SAS2308_2:
   ^~~~
drivers/scsi/mpt3sas/mpt3sas_base.c:3746:4: warning: this statement may fall through [-Wimplicit-fallthrough=]
    switch (ioc->pdev->subsystem_device) {
    ^~~~~~
drivers/scsi/mpt3sas/mpt3sas_base.c:3768:3: note: here
   default:
   ^~~~~~~

Warning level 3 was used: -Wimplicit-fallthrough=3

This patch is part of the ongoing efforts to enable
-Wimplicit-fallthrough.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 0a6cb8f0680c..e57774472e75 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3563,6 +3563,7 @@ _base_display_OEMs_branding(struct MPT3SAS_ADAPTER *ioc)
 					 ioc->pdev->subsystem_device);
 				break;
 			}
+			break;
 		case MPI2_MFGPAGE_DEVID_SAS2308_2:
 			switch (ioc->pdev->subsystem_device) {
 			case MPT2SAS_INTEL_RS25GB008_SSDID:
@@ -3598,6 +3599,7 @@ _base_display_OEMs_branding(struct MPT3SAS_ADAPTER *ioc)
 					 ioc->pdev->subsystem_device);
 				break;
 			}
+			break;
 		case MPI25_MFGPAGE_DEVID_SAS3008:
 			switch (ioc->pdev->subsystem_device) {
 			case MPT3SAS_INTEL_RMS3JC080_SSDID:
@@ -3742,6 +3744,7 @@ _base_display_OEMs_branding(struct MPT3SAS_ADAPTER *ioc)
 					 ioc->pdev->subsystem_device);
 				break;
 			}
+			break;
 		case MPI2_MFGPAGE_DEVID_SAS2308_2:
 			switch (ioc->pdev->subsystem_device) {
 			case MPT2SAS_HP_2_4_INTERNAL_SSDID:
@@ -3765,6 +3768,7 @@ _base_display_OEMs_branding(struct MPT3SAS_ADAPTER *ioc)
 					 ioc->pdev->subsystem_device);
 				break;
 			}
+			break;
 		default:
 			ioc_info(ioc, "HP SAS HBA: Subsystem ID: 0x%X\n",
 				 ioc->pdev->subsystem_device);
-- 
2.20.1

