Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7F5ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27BFB20873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjab+At6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BFB20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbeGMLib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:38:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42468 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730110AbeGMLiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:38:13 -0400
Received: by mail-ed1-f67.google.com with SMTP id g12-v6so24311827edi.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9GCe/aLzfgwot85bLQfuxGcCvL8MRm3VhgAFP9x5c2c=;
        b=pjab+At6JR+jSx6FvLMVzIMqgvvqBSQ07RfIFY4oSDUub/sQ3fpLFG1XsBs7CwbPDP
         FUdMtMIH/qzNZV6ZJAmeebvstY8GbNrLgrZvCNgohk/a1dOuwombk5PSk93GgT/LcPAf
         VaaCZ+bq5RnIc8r9AFpNrpzo2jRWS1a+6Ce4iOpPpeKVRVzz+fB777RydZKthJ8bDxpZ
         ql8RLeL+SnYjvZDn8mzsUQGQPe2ZsyiDyJUTGkjGrpKDFq5xgXilvI/zLA3f4ysxRLWl
         p/HvRUtd2vO+awDpX5zzWmqbr2Hc+DEUGeaFFaXj3tnUIPi+m6vAIjjtsne8grenegga
         hn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9GCe/aLzfgwot85bLQfuxGcCvL8MRm3VhgAFP9x5c2c=;
        b=e5XM1dLsDEeVxfKeZHG1Tr93Ql+YQKzNUnk5sGOP4gvQx5xKLNE8QTG5+6STnZRPZM
         H93edZT7HfJYmT4GJkLLqNnQYBgNJyRkp0VRhtXiTmCj/o96koNsNNmkkG+s4zIlBGAq
         r1rDcCv36aroFxJ+6Tom2fsxz1c51RkCCvPxpXEHPqCMybBRtfum7qoaYUM0NVk15daX
         TGeEBl10+213JJ/Zt676Bw2uFUcz00xUPs01ZTO8JMRcHG4v9/IOOF+uEsvBBpKFOziC
         /a20aLCygyGuoh+hYyPfdFoS7ZEGCES8eW/xUzCizPNrx8NP+5Py3ECTreaJqiUgWxg6
         ICNA==
X-Gm-Message-State: AOUpUlGUwjNQmJbe1Q14LzRsjghlgXV9U3RkGJ1ri58aOM24Ti2p9P1y
        X6jGH3Qds7Ci37CPYMSFpqmvYmqP
X-Google-Smtp-Source: AAOMgpeqRZM9uEQ9+GaYektxKz3+x1D62OQbdBTBbQCF5APnqf8mUERbDvRqQhNsSguEGqn3c0z6jA==
X-Received: by 2002:a50:9dcb:: with SMTP id l11-v6mr6786737edk.234.1531481037870;
        Fri, 13 Jul 2018 04:23:57 -0700 (PDT)
Received: from localhost.localdomain ([109.78.208.2])
        by smtp.gmail.com with ESMTPSA id r25-v6sm9392868edb.45.2018.07.13.04.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 04:23:57 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/13] staging:rtl8192u: Rename CmdID_WritePortUshort > CMD_ID_WRITE_PORT_USHORT
Date:   Fri, 13 Jul 2018 12:23:08 +0100
Message-Id: <20180713112311.544-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180713112311.544-1-johnfwhitmore@gmail.com>
References: <20180713112311.544-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the enum label CmdID_WritePortUshort to CMD_ID_WRITE_PORT_USHORT to
clear the checkpatch warning on CamelCase naming. This is a coding style
change only and should not impact code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_phy.c | 2 +-
 drivers/staging/rtl8192u/r819xU_phy.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_phy.c b/drivers/staging/rtl8192u/r819xU_phy.c
index a10d3455b1f8..a681e7eab219 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.c
+++ b/drivers/staging/rtl8192u/r819xU_phy.c
@@ -1383,7 +1383,7 @@ static u8 rtl8192_phy_SwChnlStepByStep(struct net_device *dev, u8 channel,
 			write_nic_dword(dev, CurrentCmd->Para1,
 					CurrentCmd->Para2);
 			break;
-		case CmdID_WritePortUshort:
+		case CMD_ID_WRITE_PORT_USHORT:
 			write_nic_word(dev, CurrentCmd->Para1,
 				       (u16)CurrentCmd->Para2);
 			break;
diff --git a/drivers/staging/rtl8192u/r819xU_phy.h b/drivers/staging/rtl8192u/r819xU_phy.h
index 95250ac4764e..45372a2ff7c5 100644
--- a/drivers/staging/rtl8192u/r819xU_phy.h
+++ b/drivers/staging/rtl8192u/r819xU_phy.h
@@ -11,7 +11,7 @@ enum switch_chan_cmd_id {
 	CMD_ID_END,
 	CMD_ID_SET_TX_PWR_LEVEL,
 	CMD_ID_WRITE_PORT_ULONG,
-	CmdID_WritePortUshort,
+	CMD_ID_WRITE_PORT_USHORT,
 	CmdID_WritePortUchar,
 	CmdID_RF_WriteReg,
 };
-- 
2.18.0

