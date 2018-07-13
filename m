Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5907ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A096F208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pshc7X9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A096F208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbeGMLiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:38:13 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39257 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbeGMLiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:38:12 -0400
Received: by mail-ed1-f65.google.com with SMTP id w14-v6so24327642eds.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PNjbW/5HAK5q8+YpXp+u5hQreHxkIwiUg19gWhl4Y6o=;
        b=pshc7X9MHcbH3apA27qkVmYAfQdkHY/gYlvjVgX3bbF0VdRFVAF81uySKd1PM7Gztr
         Dby1mac9Jw+FLftE83HztC/zRyHsiOtGnIwfO3ofYd9710sLlOPdLmL7NFHAeSREOvKW
         K/MX5d2xanOok+fnazc2HaIIDVOz+VymWCNfk0aa3ymtqOm1+uvLeibQ8YFvcBMkwLzx
         x+CqDNjJINa8tbzN4vYC9LoVUttxgzNZ2MGN9jGk3gUwBlARKJKlu6IEmGwQEn4U/zyL
         FS4eelzuEiOdIBFEVMgcrZmpY99GIi+1ZrQIoiUKVjRn7I3ydaxiDgO80VwiRaD3wB/1
         toMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PNjbW/5HAK5q8+YpXp+u5hQreHxkIwiUg19gWhl4Y6o=;
        b=KzzI3SSC2aeL2TvM8Lg1JxMImJoQcy+CDJFyQxM30YtNXQ1GwAhSRR2ke1lShcshyp
         DOv9B4OVmkWCOGNGkeU+s2qPJb9HM4fC994R1pXiJ8A0DnUxTzgas88yU0dgBgRsHOZ7
         qMB0pGNMysC6aIQsYZcHKOtXp+llYfDcb3kUAyf6BSmaRvlLxyLrEEquViMFcSiMaASQ
         0N9w2EC2k4DmU97mdswURyanPxilUOCXvVLIbfMWxJjgkUDuuOtoC5lhlRUAtpYYrOQE
         z5CARalsRHSri6geIClyloW16r+69vUItWEd+YA6SoyhLC3423uBjeQ3vENbl8eEf1QT
         25EA==
X-Gm-Message-State: AOUpUlGqeUfMCztABXhJquubPS3ayQEKR6iCdppx8UgYKNow4AZdo/Ao
        t0YpDAuTGiJZd0DQAvuVMVRT3QmC
X-Google-Smtp-Source: AAOMgpetyy+lYg129RsEU8u5oaeBXNZ5U7A3pCoT/0RhhXIFB7D+2pGwMQmKvG9onNzL8GSBUATmuA==
X-Received: by 2002:a50:b045:: with SMTP id i63-v6mr6811616edd.18.1531481036250;
        Fri, 13 Jul 2018 04:23:56 -0700 (PDT)
Received: from localhost.localdomain ([109.78.208.2])
        by smtp.gmail.com with ESMTPSA id r25-v6sm9392868edb.45.2018.07.13.04.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 04:23:55 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 09/13] staging:rtl8192u: Rename CmdID_WritePortUlong > CMD_ID_WRITE_PORT_ULONG
Date:   Fri, 13 Jul 2018 12:23:07 +0100
Message-Id: <20180713112311.544-10-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713112311.544-1-johnfwhitmore@gmail.com>
References: <20180713112311.544-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename enum label CmdID_WritePortUlong to CMD_ID_WRITE_PORT_ULONG to clear the
checkpatch CamelCase issue. Simple syle change which should not impact code
execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 2 +-
 drivers/staging/rtl8192u/r819xU_phy.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index 0b850abe3533..a10d3455b1f8 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1379,7 +1379,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 				/* consider it later! */
 				rtl8192_SetTxPowerLevel(dev, channel);
 			break;
-		case CmdID_WritePortUlong:
+		case CMD_ID_WRITE_PORT_ULONG:
 			write_nic_dword(dev, CurrentCmd->Para1,
 					CurrentCmd->Para2);
 			break;
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index d69b03ce7bd9..95250ac4764e 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -10,7 +10,7 @@
 enum switch_chan_cmd_id {
 	CMD_ID_END,
 	CMD_ID_SET_TX_PWR_LEVEL,
-	CmdID_WritePortUlong,
+	CMD_ID_WRITE_PORT_ULONG,
 	CmdID_WritePortUshort,
 	CmdID_WritePortUchar,
 	CmdID_RF_WriteReg,
-- 
2.18.0

