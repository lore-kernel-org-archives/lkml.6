Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F17C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78232086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:11:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78232086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeIJOEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:04:12 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52769 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeIJOEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:04:12 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fzIDr-0004NE-T8; Mon, 10 Sep 2018 09:11:07 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] scsi: message: fusion: fix a few trivial spelling mistakes
Date:   Mon, 10 Sep 2018 10:11:07 +0100
Message-Id: <20180910091107.26366-1-colin.king@canonical.com>
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
 Primative -> Primitive
 primative -> primitive
 mptsas_broadcast_primative_work -> mptsas_broadcast_primitive_work
 Broadcase -> Broadcast

Signed-off-by: Colin Ian King <colin.king@canonical.com>

---

V2: fix a few more mistakes as spotted by Julia Lawall

---
 drivers/message/fusion/lsi/mpi_cnfg.h | 2 +-
 drivers/message/fusion/mptbase.c      | 8 ++++----
 drivers/message/fusion/mptsas.c       | 8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

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
index e6b4ae558767..dc1e43a02599 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -7570,11 +7570,11 @@ mpt_display_event_info(MPT_ADAPTER *ioc, EventNotificationReply_t *pEventReply)
 		u8 phy_num = (u8)(evData0);
 		u8 port_num = (u8)(evData0 >> 8);
 		u8 port_width = (u8)(evData0 >> 16);
-		u8 primative = (u8)(evData0 >> 24);
+		u8 primitive = (u8)(evData0 >> 24);
 		snprintf(evStr, EVENT_DESCR_STR_SZ,
-		    "SAS Broadcase Primative: phy=%d port=%d "
-		    "width=%d primative=0x%02x",
-		    phy_num, port_num, port_width, primative);
+		    "SAS Broadcast Primitive: phy=%d port=%d "
+		    "width=%d primitive=0x%02x",
+		    phy_num, port_num, port_width, primitive);
 		break;
 	}
 
diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index b8cf2658649e..9b404fc69c90 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -129,7 +129,7 @@ static void mptsas_expander_delete(MPT_ADAPTER *ioc,
 static void mptsas_send_expander_event(struct fw_event_work *fw_event);
 static void mptsas_not_responding_devices(MPT_ADAPTER *ioc);
 static void mptsas_scan_sas_topology(MPT_ADAPTER *ioc);
-static void mptsas_broadcast_primative_work(struct fw_event_work *fw_event);
+static void mptsas_broadcast_primitive_work(struct fw_event_work *fw_event);
 static void mptsas_handle_queue_full_event(struct fw_event_work *fw_event);
 static void mptsas_volume_delete(MPT_ADAPTER *ioc, u8 id);
 void	mptsas_schedule_target_reset(void *ioc);
@@ -1665,7 +1665,7 @@ mptsas_firmware_event_work(struct work_struct *work)
 		mptsas_free_fw_event(ioc, fw_event);
 		break;
 	case MPI_EVENT_SAS_BROADCAST_PRIMITIVE:
-		mptsas_broadcast_primative_work(fw_event);
+		mptsas_broadcast_primitive_work(fw_event);
 		break;
 	case MPI_EVENT_SAS_EXPANDER_STATUS_CHANGE:
 		mptsas_send_expander_event(fw_event);
@@ -4826,13 +4826,13 @@ mptsas_issue_tm(MPT_ADAPTER *ioc, u8 type, u8 channel, u8 id, u64 lun,
 }
 
 /**
- *	mptsas_broadcast_primative_work - Handle broadcast primitives
+ *	mptsas_broadcast_primitive_work - Handle broadcast primitives
  *	@work: work queue payload containing info describing the event
  *
  *	this will be handled in workqueue context.
  */
 static void
-mptsas_broadcast_primative_work(struct fw_event_work *fw_event)
+mptsas_broadcast_primitive_work(struct fw_event_work *fw_event)
 {
 	MPT_ADAPTER *ioc = fw_event->ioc;
 	MPT_FRAME_HDR	*mf;
-- 
2.17.1

