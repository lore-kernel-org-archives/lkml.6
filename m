Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E966FC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0402208A1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tCclTBcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0402208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbeG2Who (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:37:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37269 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731854AbeG2Whn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:37:43 -0400
Received: by mail-wr1-f65.google.com with SMTP id q10-v6so10594120wrd.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QAujNV4yi1xw7jw37/eLGQx9/QRasJpEiLkqU/Cs00g=;
        b=tCclTBcmrPeLOZL+p9smNZdThrO9bbIqELQFbV0TfwPWgP6vpCWaayK8XNxOAEaeGj
         I9YlWmN4LUF8PFk/nmo1q+xPnQTNnEWnpvU632k7R/6FafwG1GLB9WKBjvzyO12H3L+Q
         5szFITuydz8I930IjVnjT2PQC2mh+NTwEq/TXXJBjLljExLhbLJbTUlFsx81wgDhqL+3
         nsET/05rKhOAq7UtmWSYBgRzi2+UP2jYOQFaqd2CWDIqTXLb305zJVYs6TMi6Vz7J7pf
         ZB+EZwaQLxR+50yMJWkfVgdP1PCWY3cmr7qRp2HNnCK7Xkp/m85ciRTGKwdEh1vpGW+v
         WZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QAujNV4yi1xw7jw37/eLGQx9/QRasJpEiLkqU/Cs00g=;
        b=jSeMcn+2udr/hslT1k/DhiTD0Qq6gz+InVGoic2SKQxBA83xIm6FqhY2h+dKk45KEH
         PD6OJS+uwoaAN4wIjLeznbfFvlZX+gTdxzld57Zg6ffu5AXYkDPhEUE/o8g8C4z5Oc22
         zAXQmS0eUBxSuSOA+uh/yxZY2Z3AIxLfoY+lM8icYxtQ2Z8KEf06UEcXb13tXejqPbie
         bVCwSgnmKsejqF2/GKbo2vxnnwcylsJYr4mvoG7IhaPYrprbE4xRHS0kSuMxqy8Ux1Wl
         ARDWSu9v4Q1jSVwuZe5GZ/D9/RFlOAOol95jWXvOzYlgkuX0fZ2qjDH+YvAwa7+SPFdG
         jD0A==
X-Gm-Message-State: AOUpUlF9WUNMDduwL1yq12W0SikRcBSEvI0Pa86EEgauHgVEf4fTq/Em
        qK6U1hJjCvH7DxNHFXEuTp2XbMh9bJQ=
X-Google-Smtp-Source: AAOMgpc2VeLxwdDUGBJU1U68hOkd4C8CAQZ/p3J9yxANvvHEfH9N+MWYi/4Gs7jLU00zmEcR8YeBQA==
X-Received: by 2002:adf:81a3:: with SMTP id 32-v6mr15626301wra.9.1532898352343;
        Sun, 29 Jul 2018 14:05:52 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id l19-v6sm10476876wmc.3.2018.07.29.14.05.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:05:51 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 04/15] staging:rtl8192u: Correct spelling in comments - style
Date:   Sun, 29 Jul 2018 22:05:18 +0100
Message-Id: <20180729210534.10617-8-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210534.10617-1-johnfwhitmore@gmail.com>
References: <20180729210534.10617-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the spelling of a number of comments, which cause a checkpatch
issue. This is purely a coding style change which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_cmdpkt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.h b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
index 50218d9a406b..d2e07b0ff30b 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.h
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
@@ -53,7 +53,7 @@ struct cmd_pkt_tx_feedback {
 };
 
 /* 2. RX side: Interrupt status packet. It includes Beacon State,
- * Beacon Timer Interrupt and other useful informations in MAC ISR Reg.
+ * Beacon Timer Interrupt and other useful information in MAC ISR Reg.
  */
 typedef struct tag_cmd_pkt_interrupt_status {
 	u8	element_id;			/* Command packet type. */
@@ -80,7 +80,7 @@ typedef struct tag_cmd_pkt_set_configuration {
 	u32	mask;
 } cmpk_set_cfg_t;
 
-/* 4. Both side : TX/RX query configuraton packet. The query structure is the
+/* 4. Both side : TX/RX query configuration packet. The query structure is the
  *    same as set configuration.
  */
 #define		cmpk_query_cfg_t	cmpk_set_cfg_t
-- 
2.18.0

