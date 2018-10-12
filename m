Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EF8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2882C2086A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2882C2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbeJLSNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 14:13:42 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:35955 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbeJLSNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 14:13:42 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MauJJ-1fes7e041z-00cTLa; Fri, 12 Oct 2018 12:41:45 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MauJJ-1fes7e041z-00cTLa; Fri, 12 Oct 2018 12:41:45 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Avri Altman <avri.altman@wdc.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     linux-scsi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: ufs: fix integer type usage in uapi header
Date:   Fri, 12 Oct 2018 12:41:28 +0200
Message-Id: <20181012104143.1931393-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:RpmlNXRZ1eGDPsL4xmG9LGqc8hOihdqy0zHaqzxuyfHzp9QObgX
 YRQvPpajbO8elCmgvDozxmROd40dvo/VeQrpvH7A0ypmoC7roacYn9cSG3fEq1pyOTvDeDn
 HmKPk5/l0cB4RZYXQY67tAzE5I9aTfZLOfd8sCUuTfMcYaCaI81ITIj2t7Mq1nfI4BCrFvu
 J+H4g1aqSHx8EVaq7ZB2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PRp9f2VvG4A=:E5/yilLsljnCBjIAFqKe1c
 8i0EoSfo2UxZ8VB8gkqZRn+H5AAHHqOcoVWwggqg4CNoTx8tJmCmUv5h0TY/nRAKh3Pmhhxmy
 qv4etUY5EHl73YU3rzum+KukmuteeHLnarDAN/13m5bqaQ7NRJEn4WhS4BmzJumywGyccG2q0
 I598KkBHUxOJvBD8JGCOUqFR7kGxG9suvsHNKdVf0oOUCqTPO8YlJANaUvy9yO8nkU3COkWRf
 nQZS2m4su+TT3TGa/Yn1Q0sPTnEncmKtgx1KS3L99tiEGIu+HU7yAHfJBsiOUbbX88Hm9DzbR
 wiQLceEbATA5Ehm0tNScTsKqw+1LuRayBTBsQlG9npKogN3XlFeupZbsGVPYUL5tUXV24Bh0f
 ZXSYK7grJzh+DY4CUA0j8EUy79TDqspsnx95lVV1AJRMDEv1YMpTfGVFhNBrpAmtqjECW48sH
 KbHFmNNSuWm1o7hvPibsszuJrXU3gHfiJI0GnAqoPsKVGZ5vTxLQ3/7lmPs5VkueERXBygnDh
 S7J9BBOYHiGFoLOcgTLF/CjmlYGFDj0hsBRYjTTfcBvbiaMwr6Efa4MWuVaadkj49GnRByQw0
 hWGcTYtz0eBJBB1vCYxDOxRLjZY4CdOx/V4ojh+cGxClI95tPiBIrLjhpSNA+pGdeC0ECjIyY
 odY3ynqEDml82c3ERs0Fbpe1aRVPThbbyTbv4Ox/GKZc02Rtwpbqw7FOPErwnXcbhoCs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get a warning from 'make headers_check' about a newly introduced
usage of integer types in the scsi/scsi_bsg_ufs.h uapi header:

usr/include/scsi/scsi_bsg_ufs.h:18: found __[us]{8,16,32,64} type without #include <linux/types.h>

Aside from the missing linux/types.h inclusion, I also noticed that it
uses the wrong types: 'u32' is not available at all in user space,
and 'uint32_t' depends on the inclusion of a standard header that
we should not include from kernel headers.

Change the all to __u32 and similar types here.

I also note the usage of '__be32' and '__be16' that seems unfortunate
for a user space API. I wonder if it would be better to define the
interface in terms of a CPU-endian structure and convert it in kernel
space.

Fixes: e77044c5a842 ("scsi: ufs-bsg: Add support for uic commands in ufs_bsg_request()")
Fixes: df032bf27a41 ("scsi: ufs: Add a bsg endpoint that supports UPIUs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/scsi/scsi_bsg_ufs.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/uapi/scsi/scsi_bsg_ufs.h b/include/uapi/scsi/scsi_bsg_ufs.h
index 1b25930688bc..17c7abd0803a 100644
--- a/include/uapi/scsi/scsi_bsg_ufs.h
+++ b/include/uapi/scsi/scsi_bsg_ufs.h
@@ -8,6 +8,7 @@
 #ifndef SCSI_BSG_UFS_H
 #define SCSI_BSG_UFS_H
 
+#include <linux/types.h>
 /*
  * This file intended to be included by both kernel and user space
  */
@@ -15,7 +16,7 @@
 #define UFS_CDB_SIZE	16
 #define UPIU_TRANSACTION_UIC_CMD 0x1F
 /* uic commands are 4DW long, per UFSHCI V2.1 paragraph 5.6.1 */
-#define UIC_CMD_SIZE (sizeof(u32) * 4)
+#define UIC_CMD_SIZE (sizeof(__u32) * 4)
 
 /**
  * struct utp_upiu_header - UPIU header structure
@@ -59,7 +60,7 @@ struct utp_upiu_query {
  */
 struct utp_upiu_cmd {
 	__be32 exp_data_transfer_len;
-	u8 cdb[UFS_CDB_SIZE];
+	__u8 cdb[UFS_CDB_SIZE];
 };
 
 /**
@@ -81,7 +82,7 @@ struct utp_upiu_req {
 
 /* request (CDB) structure of the sg_io_v4 */
 struct ufs_bsg_request {
-	uint32_t msgcode;
+	__u32 msgcode;
 	struct utp_upiu_req upiu_req;
 };
 
@@ -95,10 +96,10 @@ struct ufs_bsg_reply {
 	 * msg and status fields. The per-msgcode reply structure
 	 * will contain valid data.
 	 */
-	uint32_t result;
+	__u32 result;
 
 	/* If there was reply_payload, how much was received? */
-	uint32_t reply_payload_rcv_len;
+	__u32 reply_payload_rcv_len;
 
 	struct utp_upiu_req upiu_rsp;
 };
-- 
2.18.0

