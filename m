Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A6AECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6F720873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp7NIh54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6F720873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbeGMLh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:37:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46286 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbeGMLh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:37:58 -0400
Received: by mail-ed1-f68.google.com with SMTP id r17-v6so24328366edo.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6uNmLbMbWJwBhNPSaWkG89SDsE82jzU9BDWsoR3GhSA=;
        b=kp7NIh54rUYJOxbov7VDseA14wAvm+HGQjUQ4ZTu1QT1ZS//0tvqUCPfvJQIIS9DTO
         QdKAO7c9EDSvsFNtBtFYJi4aKOd/fyIJ3hAjjXdg1VyLvN+JKGvhclpsXuhCbUB0dgv9
         5/YuVBML1Df9OH6yK0cyif73aoMKB8aH+G920qy2blN6Waq6O8R9oPBhfpZ4UrVtxVo6
         S+M6iwIUbGzEGfVTMKVsSKrfSiLSJjKId0zIWJCfNckjQdWlG2FJfRI2rPn/3e9opQOz
         dhnunXCsDmbsb0P4neNJvCQAPfvMvsvMez4DRcKwHxqwvZWG087p/Qt9jGHlOA389HvP
         lKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6uNmLbMbWJwBhNPSaWkG89SDsE82jzU9BDWsoR3GhSA=;
        b=fBQjA8u8NdPBMOlMzNdWdZGY700TjbAXRlVJ1vLr8rB82qmjwIHGLzgjEcpE4TvW1R
         jMpdDZQYmUNTp2eZxvR9Fx7HFfRzO8xgHOcOADqAU6/Kz9B8EC9ofOF0daoorATYtA/r
         d6MT6fYNJPgkrjsvpoTUn72aONDZrhRwOeNrKoxeYZ3n51CXyvheYIA/sxL0wvPH1mpI
         K9unI0J+xRApzk5fqT0rwJlai5MJnS76I5amdv3I30BRD34UdBOHiBX2mOftyK73FAUo
         G1AhvH2QynDQXrXmwq2nvzZyv49na4aFPnnrhaD0WeerAuTMMok7UjmKpLH5GQ9djS1j
         8/OA==
X-Gm-Message-State: AOUpUlHnOonR5okymlG+uMS+K5qvvhBu4E1gqsdDonm57FL9aSO8VjQK
        tY+VO1cNasBmNMZMlZonXm14PFHj
X-Google-Smtp-Source: AAOMgpcL792XwrdiOPPCSXcJK77362X6zMjt1gUmEGfkQYM8aQFCVn20oRrx0uP9er+o2ljSYiOBGw==
X-Received: by 2002:a50:ae98:: with SMTP id e24-v6mr6431154edd.16.1531481021942;
        Fri, 13 Jul 2018 04:23:41 -0700 (PDT)
Received: from localhost.localdomain ([109.78.208.2])
        by smtp.gmail.com with ESMTPSA id r25-v6sm9392868edb.45.2018.07.13.04.23.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 04:23:41 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 01/13] staging:rtl8192u: remove typedef of enumeration SwChnlCmdID - Style
Date:   Fri, 13 Jul 2018 12:22:59 +0100
Message-Id: <20180713112311.544-2-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713112311.544-1-johnfwhitmore@gmail.com>
References: <20180713112311.544-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To clear a checkpatch issue removed the typedef of the enumeration SwChnlCmdID
this should not impact runtime code as it's only a coding style change.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c |  2 +-
 drivers/staging/rtl8192u/r819xU_phy.h | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 98cfc222e241..bc86e6bfb8f5 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1221,7 +1221,7 @@ bool rtl8192_SetRFPowerState(struct net_device *dev,
  * notice:
  ******************************************************************************/
 static u8 rtl8192_phy_SetSwChnlCmdArray(SwChnlCmd *CmdTable, u32 CmdTableIdx,
-					u32 CmdTableSz, SwChnlCmdID CmdID,
+					u32 CmdTableSz, enum SwChnlCmdID CmdID,
 					u32 Para1, u32 Para2, u32 msDelay)
 {
 	SwChnlCmd *pCmd;
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index d2e69228ac8a..4471a0e00936 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -7,7 +7,7 @@
 #define MAX_RFDEPENDCMD_CNT 16
 #define MAX_POSTCMD_CNT 16
 
-typedef enum _SwChnlCmdID {
+enum SwChnlCmdID {
 	CmdID_End,
 	CmdID_SetTxPowerLevel,
 	CmdID_BBRegWrite10,
@@ -15,15 +15,15 @@ typedef enum _SwChnlCmdID {
 	CmdID_WritePortUshort,
 	CmdID_WritePortUchar,
 	CmdID_RF_WriteReg,
-} SwChnlCmdID;
+};
 
 /* -----------------------Define structure---------------------- */
 /* 1. Switch channel related */
 typedef struct _SwChnlCmd {
-	SwChnlCmdID	CmdID;
-	u32		Para1;
-	u32		Para2;
-	u32		msDelay;
+	enum SwChnlCmdID	CmdID;
+	u32		        Para1;
+	u32		        Para2;
+	u32		        msDelay;
 } __packed SwChnlCmd;
 
 extern u32 rtl819XMACPHY_Array_PG[];
-- 
2.18.0

