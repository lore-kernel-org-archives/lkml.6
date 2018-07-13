Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B21ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72AD20873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXKlYufE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C72AD20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbeGMLiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:38:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41138 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbeGMLiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:38:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id s24-v6so8125596edr.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PGkcUDLWmblRxx77POK9CvA4NWL9WKf3gEJezIgCYZM=;
        b=dXKlYufEWz97UYV4tL/3+WjSL5FC3/ytKbsY+/LnGiQnJpvOSXdJgZ9oVJHsKVGNpD
         9kwY6f71bFapTIrtS6IawqgYvmZtFeAazaJbTBhUVDUHN/98upSQ8GzT/bL3gsSSQ8NV
         k+xJLPHDmLO20xs/HhYkVWbzYTYIjUubYEqW58YCGzg1cyAzfkEBRumIEaTEZfwMaMNj
         d05N31pMk4xrMZ0GiJYKBurGX+yygwnCqMlAQjjoVz8vvY7IdDfB3gMjKybxddAIOsBO
         OykZsCNMhoneBR+fEtjL5DfG5Ivfz4kAvWZgM63nHIjzqfHRHp0tS996z4wneyej9z7f
         7sPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PGkcUDLWmblRxx77POK9CvA4NWL9WKf3gEJezIgCYZM=;
        b=YN2p/YXfIWDW7m0T5pw0sTYHQ27+IcQr4jD7Jb3AGGhxZNZMbBn1jKKeMmYnY4cR30
         d6iB1B0FG4Vqsq78mcZZqEGGni7ogd/JRvCpzUs+tiPGTULseLF+YTgLkVDbCDcZOFlM
         7S92eS5BiLV+ftpGk7W1xGd8rMccRC5FTCLPsL5WmMwDyP+jrwT0lFZ+RqUUB+nuUzCm
         uNFazCo9NB+5b8vbBRQ5RSUUYlQ4vRFY3IB/YGPdkgVJGpo7VURjzf2hGFTK2KffZB1/
         QdLn32BrICbNpmO636eol68eI0a/Bw7KGaNfZWtH8JXdStu+fNlkPS7rnl2rhVO8f8ZK
         E8Og==
X-Gm-Message-State: AOUpUlHhhYEomaJ7nVl0FKgXOVuTvWAK+tcqYfrTQCfbOHbAXbxDJSe+
        Jl7Zl/8JoXAYfLkxhL+XkWS59wIQ
X-Google-Smtp-Source: AAOMgpdIOUWz0xBTiqZ65uHPmG3i1kwcT+SLHuJGRRtOXJQiVPKJIlWhu/uB4ijlna55MXFKJHn4Kw==
X-Received: by 2002:a50:ae98:: with SMTP id e24-v6mr6431566edd.16.1531481029368;
        Fri, 13 Jul 2018 04:23:49 -0700 (PDT)
Received: from localhost.localdomain ([109.78.208.2])
        by smtp.gmail.com with ESMTPSA id r25-v6sm9392868edb.45.2018.07.13.04.23.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 04:23:48 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 05/13] staging:rtl8192u: Rename SwChnlCmdID > switch_chan_cmd_id - Coding Style
Date:   Fri, 13 Jul 2018 12:23:03 +0100
Message-Id: <20180713112311.544-6-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713112311.544-1-johnfwhitmore@gmail.com>
References: <20180713112311.544-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename enumerated type to clear a CamelCase warning from checkpatch. The
change is style only. No impact on run time execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 4 ++--
 drivers/staging/rtl8192u/r819xU_phy.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index d88f6c3ed46f..c373dbe06154 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1219,7 +1219,7 @@ bool rtl8192_SetRFPowerState(struct net_device *dev,
  * input:     SwChnlCmd      *CmdTable    //table to be set
  *            u32            CmdTableIdx  //variable index in table to be set
  *            u32            CmdTableSz   //table size
- *            SwChnlCmdID    CmdID        //command ID to set
+ *            switch_chan_cmd_id    CmdID        //command ID to set
  *            u32            Para1
  *            u32            Para2
  *            u32            msDelay
@@ -1228,7 +1228,7 @@ bool rtl8192_SetRFPowerState(struct net_device *dev,
  * notice:
  ******************************************************************************/
 static u8 rtl8192_phy_SetSwChnlCmdArray(struct SwChnlCmd *CmdTable, u32 CmdTableIdx,
-					u32 CmdTableSz, enum SwChnlCmdID CmdID,
+					u32 CmdTableSz, enum switch_chan_cmd_id CmdID,
 					u32 Para1, u32 Para2, u32 msDelay)
 {
 	struct SwChnlCmd *pCmd;
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index a02e1e0ea643..0c63c646b625 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -7,7 +7,7 @@
 #define MAX_RFDEPENDCMD_CNT 16
 #define MAX_POSTCMD_CNT 16
 
-enum SwChnlCmdID {
+enum switch_chan_cmd_id {
 	CmdID_End,
 	CmdID_SetTxPowerLevel,
 	CmdID_BBRegWrite10,
@@ -20,7 +20,7 @@ enum SwChnlCmdID {
 /* -----------------------Define structure---------------------- */
 /* 1. Switch channel related */
 struct SwChnlCmd {
-	enum SwChnlCmdID	CmdID;
+	enum switch_chan_cmd_id	CmdID;
 	u32		        Para1;
 	u32		        Para2;
 	u32		        msDelay;
-- 
2.18.0

