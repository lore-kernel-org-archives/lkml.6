Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25480C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC32B206BB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 02:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC32B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbeIJHZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 03:25:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47897 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbeIJHZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 03:25:22 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fz81O-0006kl-Qu; Sun, 09 Sep 2018 22:17:34 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: message: fusion: fix a few trivial spelling mistakes
Date:   Sun,  9 Sep 2018 23:17:34 +0100
Message-Id: <20180909221734.8047-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trival fix to spelling mistakes:
PrimativeSeqErrCount -> PrimitiveSeqErrCount
Broadcase -> Broadcast
Primative -> Primitive

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/message/fusion/lsi/mpi_cnfg.h | 2 +-
 drivers/message/fusion/mptbase.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/message/fusion/lsi/mpi_cnfg.h b/drivers/message/fusion/lsi/mpi_cnfg.h
index 059997f8ebce..178f414ea8f9 100644
--- a/drivers/message/fusion/lsi/mpi_cnfg.h
+++ b/drivers/message/fusion/lsi/mpi_cnfg.h
@@ -2004,7 +2004,7 @@ typedef struct _CONFIG_PAGE_FC_PORT_6
     U64                     LinkFailureCount;           /* 50h */
     U64                     LossOfSyncCount;            /* 58h */
     U64                     LossOfSignalCount;          /* 60h */
-    U64                     PrimativeSeqErrCount;       /* 68h */
+    U64                     PrimitiveSeqErrCount;       /* 68h */
     U64                     InvalidTxWordCount;         /* 70h */
     U64                     InvalidCrcCount;            /* 78h */
     U64                     FcpInitiatorIoCount;        /* 80h */
diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index e6b4ae558767..2b1ea7f8031d 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -7572,7 +7572,7 @@ mpt_display_event_info(MPT_ADAPTER *ioc, EventNotificationReply_t *pEventReply)
 		u8 port_width = (u8)(evData0 >> 16);
 		u8 primative = (u8)(evData0 >> 24);
 		snprintf(evStr, EVENT_DESCR_STR_SZ,
-		    "SAS Broadcase Primative: phy=%d port=%d "
+		    "SAS Broadcast Primitive: phy=%d port=%d "
 		    "width=%d primative=0x%02x",
 		    phy_num, port_num, port_width, primative);
 		break;
-- 
2.17.1

