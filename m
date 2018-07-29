Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7D8C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F81820857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 21:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTOuHYUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F81820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731606AbeG2WlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 18:41:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43878 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbeG2WkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 18:40:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id b15-v6so10589660wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jul 2018 14:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QAujNV4yi1xw7jw37/eLGQx9/QRasJpEiLkqU/Cs00g=;
        b=QTOuHYUyqhIexh/TKW9dl4MZaOxbz0yoaz/6QmuUmshkBXIrNDP2ViT7jH7bx6lm4/
         FoAV+PmIGBjXA9Vbg+fApHfyiuZGsUogR3hFYxZzF83LEMrgZ9Q3eI9tU2xrVQt5vGz0
         SwsG1ZmA87JMH3fC/3HdTIa5FYqkBoD4oPNmqNYhubGiNqZm+aBlQ7YDcNS1PzozvfIp
         SXCDjCxup435W8g93CsvKjg5mXbd5YsRpUqYkGs53UwaycbX/GuGAt67H6cKAEthehAr
         oOcx9CyfBUwVu30OK+If1NdrVKp2pYrGuE5aD+7inT5X1GFqx7qCM33DGtazo9q3MLAj
         uRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QAujNV4yi1xw7jw37/eLGQx9/QRasJpEiLkqU/Cs00g=;
        b=kt4RotGP3aYYr8+rdZrL6MQMRqH4L3Oek5Tz+3lzv13wULkdZKWD53jBfApsoODiaQ
         qUhH6u4yQlW/85K7so4fOMhNqNcX+eLYgniX4QKxW/+LJRo2d1oqDlvfq6MboS+ytUqV
         1XG7z7/rHzjmTeJszDFUWoxK+0gwVio7wRb8d5d3ua7y5AagWaP5Q29wbSq9brbBXFnD
         H2Nxvi1yRRKZQVRDI53gc+0T1cdOgnmtcx2SFSDIDPEf1argwjQTFMACVeP/IMojV2S8
         rgEAPpg6Uz4+o3eiHmDuzdMoiDPqpF4tOPL9EKSQz3M2QP0Fa0xhEFwOwCr8unCDjM1L
         ky4Q==
X-Gm-Message-State: AOUpUlHa8Tzf+t/K7c3TdfoC47Rnp165P4VdApnTyD7PVVrzurlsi1rv
        u/toUJZN8wcf3owE+wvRXgEqLZM8q0k=
X-Google-Smtp-Source: AAOMgpd8jVfKrAqCAItGY33S9cw3UPk1AOMzCw/dvggNth0uoDqXtF7KDgMoZrC1tHuoQM3fm4CJFQ==
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr14826415wra.120.1532898507359;
        Sun, 29 Jul 2018 14:08:27 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id d26-v6sm9264532wmb.15.2018.07.29.14.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Jul 2018 14:08:26 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH v2 04/15] staging:rtl8192u: Correct spelling in comments - style
Date:   Sun, 29 Jul 2018 22:07:36 +0100
Message-Id: <20180729210747.10803-5-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180729210747.10803-1-johnfwhitmore@gmail.com>
References: <20180729210747.10803-1-johnfwhitmore@gmail.com>
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

