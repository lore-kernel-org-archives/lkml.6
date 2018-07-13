Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7974ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6107C20873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NV0chlkK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6107C20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbeGMLiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:38:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43311 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbeGMLiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:38:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id u11-v6so24317514eds.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gRf/Dya0P+Cq8Fo2V7ypInc/HkMOE9k1mKzFHTcquhk=;
        b=NV0chlkKHNgZcZsKa6WgYsMXk5vGCBYqz1xnCTO28xDU6Zenj1UU+Ymbwk0odeqLaZ
         cDEMGqaRGtgsSAaa6/jTzhK4KAP6E74QBSjl2badX5BH8DGLPa4p8O3j0Kas4GnsGTkS
         buNPpVRjyR7C934lM8GszNPF3xOf1pepUmNyqrSpmT93KfLYDsACedKVQGoX9kP9ZLyx
         MrssqbTBiKs5VJIkbjm+ESyOReZJjZSchYF92NO4DlJAqLaqVffTAbqhTpYTRs7XHbMy
         jKbCSjVyF4KJKPYxYTS09yYVkPnNCw+cml7nAJKuxdzaZW2ymJSdmHJdYQgqsmMXvJZt
         zJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gRf/Dya0P+Cq8Fo2V7ypInc/HkMOE9k1mKzFHTcquhk=;
        b=NVo5F1Wdr/etm5SHnvnqG/Z5Da2+5PrmcFfJ0qOb5mtufypGdr6xWzGLYE8MoFZWKA
         Q4WePpP1YHcp4sQbP6stT5HjCL6jzbncUPUIM0OQVgtf3bAZqBs/m3T8VM4/MMBOBupm
         MhA5e0mI51ra23kTQOyu1EAJPE6pu0/Iw6Qag6XM+asc8nQkPytYIUhaRY9HB54hMIDR
         kq2BDfEuoEesXYCKNXeIhjWckcfz+UvGFewTfKjCM/7x+dW79WuhsD1KiLQbWJLYgtHW
         j0CVra7EMkx+MWsA2J2V5OzEdDWQU9jdXsyEfb0sMlEDvoxXyh1x3nKtl90IWtndZvqa
         WLmw==
X-Gm-Message-State: AOUpUlGLwbXCquejFIy0dbiyTNrSBY/o0384Z5SNCWH7pi2thDJ4TBjq
        FWIHokrWrlT8h1IJAvicrRP86yEe
X-Google-Smtp-Source: AAOMgpfnonC1x5/PJg13dsBxyirzUeqLl5YTVIWQO22tWPAR34anEJBj1mDV73yaEHCB6d5iaCixNA==
X-Received: by 2002:a50:ca02:: with SMTP id d2-v6mr6379281edi.53.1531481032640;
        Fri, 13 Jul 2018 04:23:52 -0700 (PDT)
Received: from localhost.localdomain ([109.78.208.2])
        by smtp.gmail.com with ESMTPSA id r25-v6sm9392868edb.45.2018.07.13.04.23.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 04:23:51 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 07/13] staging:rtl8192u: rename CmdID_SetTxPowerLevel > CMD_ID_SET_TX_PWR_LEVEL
Date:   Fri, 13 Jul 2018 12:23:05 +0100
Message-Id: <20180713112311.544-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713112311.544-1-johnfwhitmore@gmail.com>
References: <20180713112311.544-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename enumeration label CmdID_SetTxPowerLevel to
CMD_ID_SET_TX_PWR_LEVEL. This change clears a checkpatch warning on
CamelCase. The change should not impact runtime execution, style change only.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 4 ++--
 drivers/staging/rtl8192u/r819xU_phy.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index c67159f2d9ab..0b850abe3533 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1292,7 +1292,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 	/* <1> Fill up pre common command. */
 	PreCommonCmdCnt = 0;
 	rtl8192_phy_SetSwChnlCmdArray(PreCommonCmd, PreCommonCmdCnt++,
-				      MAX_PRECMD_CNT, CmdID_SetTxPowerLevel,
+				      MAX_PRECMD_CNT, CMD_ID_SET_TX_PWR_LEVEL,
 				      0, 0, 0);
 	rtl8192_phy_SetSwChnlCmdArray(PreCommonCmd, PreCommonCmdCnt++,
 				      MAX_PRECMD_CNT, CMD_ID_END, 0, 0, 0);
@@ -1374,7 +1374,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 		}
 
 		switch (CurrentCmd->CmdID) {
-		case CmdID_SetTxPowerLevel:
+		case CMD_ID_SET_TX_PWR_LEVEL:
 			if (priv->card_8192_version == (u8)VERSION_819xU_A)
 				/* consider it later! */
 				rtl8192_SetTxPowerLevel(dev, channel);
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index efbca1f458f5..91b2e9e39368 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -9,7 +9,7 @@
 
 enum switch_chan_cmd_id {
 	CMD_ID_END,
-	CmdID_SetTxPowerLevel,
+	CMD_ID_SET_TX_PWR_LEVEL,
 	CmdID_BBRegWrite10,
 	CmdID_WritePortUlong,
 	CmdID_WritePortUshort,
-- 
2.18.0

