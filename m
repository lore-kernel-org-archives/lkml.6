Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A989ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E847920873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="um+yf5AY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E847920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbeGMLiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:38:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42470 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731634AbeGMLiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:38:15 -0400
Received: by mail-ed1-f65.google.com with SMTP id g12-v6so24311877edi.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nbQxOqr1YwJ/ACx97Cksp7Kfjjy0JBDByusGidTGrrY=;
        b=um+yf5AYXFObTYPnXkz+Sh1+FUQIJ9GHWusP0JU2DkPRQC2kcAHiT6N+A4HBPrRzGo
         DGKm53WC4iBHnqjQxHQMPGH3VUX6nGPxlM17A7KgkDeXA63pq7hA0FKh69PGcpR5d/uG
         BbHLZppIhO4rd4OfvDQxQ5HyEV9jvt8/wP1WrrpPsWy+ZlCe/TofSGQXQUml0FtlTMVt
         U+vxYFeAgUXwGsPnXDw5MZCpur9woAkERmqHjsRTooKeSrwRxMN7afhnXXvwp2IWRpMC
         doA0L+muvmhJ6viwHp1KHleGbmTLesPAZ/OGLhNEI0QFX/gNSfL7oRA7tQPyDXewma/q
         d6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nbQxOqr1YwJ/ACx97Cksp7Kfjjy0JBDByusGidTGrrY=;
        b=TW/hdD45WDa/va0XTLjJzQgBmSOiefSBHnJkmxJyFzFkWaZEryDyzsTxUUj4ABwI8e
         SAuaaSRGfn2cA9QGwZUdT0hl6XrK13l7KT7PIsyii+vYF8Z8I0iDaC8QLwyULvvDyusy
         ajWqTauhMuppy6yHZjwCHEc1eN+KQvP2DLDg7hxLAXPt4LzB38K++K++4CZuoedcO9DI
         VBHFyPMUoCIdg95aHVevdAIK/vxpTJ3t/7dv1SOCCiZasm9TEwE3XeC+7whzctreZmFR
         RD38T0qhaOSLf1lS6fuTH18nCWsvjo6xDGkgLTIDInx0g1iVI8gvpkptWgGd9Caa6FIZ
         WgCg==
X-Gm-Message-State: AOUpUlGbTGe2lRoPkORRH8QeHGwiTLu8iIxtr97ogYXss6mvKO/6pbOU
        sj0PZKsCVQwBGGOOe6qG0FLAJo5o
X-Google-Smtp-Source: AAOMgpf6nSd70inJ0WWl4x9OJnkhhv3b9jlfxkFH7+KaNpnoe1SBvoPJ7SNZ1BTFuaFn3Wmn6SGd3w==
X-Received: by 2002:a50:da01:: with SMTP id z1-v6mr6745881edj.62.1531481039485;
        Fri, 13 Jul 2018 04:23:59 -0700 (PDT)
Received: from localhost.localdomain ([109.78.208.2])
        by smtp.gmail.com with ESMTPSA id r25-v6sm9392868edb.45.2018.07.13.04.23.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 04:23:58 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 11/13] staging:rtl8192u: Rename CmdID_WritePortUchar > CMD_ID_WRITE_PORT_UCHAR
Date:   Fri, 13 Jul 2018 12:23:09 +0100
Message-Id: <20180713112311.544-12-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713112311.544-1-johnfwhitmore@gmail.com>
References: <20180713112311.544-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the enum label CmdID_WritePortUchar to CMD_ID_WRITE_PORT_UCHAR, to
clear the checkpatch issue with CamelCase. The change is a coding style change
only and should not impact code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 2 +-
 drivers/staging/rtl8192u/r819xU_phy.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index a681e7eab219..6c57c38dc9fe 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1387,7 +1387,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 			write_nic_word(dev, CurrentCmd->Para1,
 				       (u16)CurrentCmd->Para2);
 			break;
-		case CmdID_WritePortUchar:
+		case CMD_ID_WRITE_PORT_UCHAR:
 			write_nic_byte(dev, CurrentCmd->Para1,
 				       (u8)CurrentCmd->Para2);
 			break;
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 45372a2ff7c5..1496f74768c9 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -12,7 +12,7 @@ enum switch_chan_cmd_id {
 	CMD_ID_SET_TX_PWR_LEVEL,
 	CMD_ID_WRITE_PORT_ULONG,
 	CMD_ID_WRITE_PORT_USHORT,
-	CmdID_WritePortUchar,
+	CMD_ID_WRITE_PORT_UCHAR,
 	CmdID_RF_WriteReg,
 };
 
-- 
2.18.0

