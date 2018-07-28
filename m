Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B07C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE12C20842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICsSqpwS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE12C20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731679AbeG2Ab1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:31:27 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53905 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731559AbeG2AbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:31:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id s9-v6so9078607wmh.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wjqr9oW2v98Sh4Pkw8ZVY9CuXao3Z4EK2O6ZSMuHy6I=;
        b=ICsSqpwSHh0VFUa586VaiY9f1ISNW+SfEmsaloijUFlDg9zjzt12EKpPNH5pMutkuM
         /cHdCWF9wxhSFxC0YTglxLLoBgQ6EofWjMXLg2Gguh6AcMp9O10OmK74pUX3o98mJHco
         +kD3gsC12upvYNGDdPxJ6/W8iiJknlZkGvsOPb3VbGhedCPjhUbdji9I8hZJ3cGlaLf1
         jNpAaf8myexeGCHbSXUlY9GXUnNB8IB0lQefC5EMQEJtNQZDN+VMshztENCBXQa4IAoH
         T6egafPJKTYoALnAhzFSEw6n2KZrYJ6xq/ZLLF7k0gx5kyGJho7tkZa3sKlzy+OMIbGy
         ePVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wjqr9oW2v98Sh4Pkw8ZVY9CuXao3Z4EK2O6ZSMuHy6I=;
        b=pk4IaKsXCBQ/gCkDTxvXIS1+plBJL3q4UUe/IsXk8PCSpjydYH1UgrI2ESlcoFbMsZ
         Y699NGm1JeWVVzAFjwIBkf+IjfYl48w1CENypndHQE7ud3GQk3sT8un06eItSHafs7K3
         M0lPmuTLQzg/LgDoV/u2TJMw5rz36IyPUc0kDwyTRz9YJa1vopvcOTHnkuA6fwPVw0eH
         gTJOZCNGZOVW0Sv3V9ma4lFsqEMRyoaDM9pi7nG6KZh0a+QVokhkxjPpdvduSVy3E1xE
         6IYfSf9mBUy03vK8U2p6KQy3ls2mkCAtwg9uldPts2AdUZ8lMze5DxIoAUSVtSM5c5RO
         2rXA==
X-Gm-Message-State: AOUpUlH6JRm77fIEbxfYH47zRrNVNL1inaob1uI4ob/Z8QMO5V94vs11
        jE/T4vHLK95gGE9kt5Sl44eeJYPb
X-Google-Smtp-Source: AAOMgpflarYnenK8PzvHv+Noa70eE3pu0Yskh2eWaTsXlR1eDOamfN/KArqnbtyi3RpfWW0bbe5pZw==
X-Received: by 2002:a1c:b9cf:: with SMTP id j198-v6mr9728927wmf.93.1532818995648;
        Sat, 28 Jul 2018 16:03:15 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m207-v6sm11490569wma.31.2018.07.28.16.03.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:03:14 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/12] staging:rtl8192u: Rename union QOS_TSINFO - Style
Date:   Sun, 29 Jul 2018 00:02:59 +0100
Message-Id: <20180728230300.19732-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728230300.19732-1-johnfwhitmore@gmail.com>
References: <20180728230300.19732-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The union QOS_TSINFO, as a type, should have a lowercase name. The
union has therefore been renamed to qos_tsinfo. Additionally the
'typedef' directive has been removed to clear the checkpatch issue
with defining new types.

These are coding style changes which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h    | 6 +++---
 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 428a8c4cebf1..17b676b0ed8b 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -42,7 +42,7 @@ enum direction_value {
 //	1. WMM spec 2.2.11: WME TSPEC Element, p.18.
 //	2. 8185 QoS code: QOS_TSINFO [def. in QoS_mp.h]
 //
-typedef union _QOS_TSINFO {
+union qos_tsinfo {
 	u8		charData[3];
 	struct {
 		u8		ucTrafficType:1;			//WMM is reserved
@@ -56,7 +56,7 @@ typedef union _QOS_TSINFO {
 		u8		ucSchedule:1;			//WMM is reserved
 		u8		ucReserved:7;
 	} field;
-} QOS_TSINFO, *PQOS_TSINFO;
+};
 
 //
 // WMM TSPEC Body.
@@ -66,7 +66,7 @@ typedef union _TSPEC_BODY {
 	u8		charData[55];
 
 	struct {
-		QOS_TSINFO	TSInfo;	//u8	TSInfo[3];
+		union qos_tsinfo	TSInfo;	//u8	TSInfo[3];
 		u16	NominalMSDUsize;
 		u16	MaxMSDUsize;
 		u32	MinServiceItv;
diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
index 79c96da41d8b..4d92b97a1521 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
@@ -355,7 +355,7 @@ bool GetTs(
 			// For HCCA or WMMSA, TS cannot be addmit without negotiation.
 			//
 			TSPEC_BODY	TSpec;
-			PQOS_TSINFO		pTSInfo = &TSpec.f.TSInfo;
+			union qos_tsinfo	*pTSInfo = &TSpec.f.TSInfo;
 			struct list_head	*pUnusedList =
 								(TxRxSelect == TX_DIR)?
 								(&ieee->Tx_TS_Unused_List):
-- 
2.18.0

