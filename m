Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880ADC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4042D20893
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs9Wcblu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4042D20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbeGYXaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:30:52 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43807 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731617AbeGYXav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:30:51 -0400
Received: by mail-ed1-f67.google.com with SMTP id b20-v6so15031edt.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 15:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GKEMaGFvO1tTV8N/M1wYzH1h/DJmppqgSA1l8dTapvc=;
        b=fs9Wcblue57f54iZXudibv+c00tYIhnHaMB/xQXHcu+0gXiRVYbFTvvf5khuv/bfiS
         75AztCIzu9rZ76oeUssINCCWEV7qMxxB3p/EEQpap5OCINbY7F4IbAVGoqOJl1lR17/P
         ALLwbDJCQEuFzL+6APYqjTb8tXRQ5YAZ10+1vKSJ3SN5osk769i8QL583OVJ8LttxfGH
         5hcozkQ35uIqys1NV7tJPWKiQWZnJO0EhmsSHExRAh/Qe5VrtHDOUZNbI0GKq4BLSsGT
         Ua30wvwz9fP2By200VGGDhIe+TkoMjI14gLiDVemxLXpFwySE5dP4/U/Pgua+sQPv83M
         q3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GKEMaGFvO1tTV8N/M1wYzH1h/DJmppqgSA1l8dTapvc=;
        b=VlEzyZ7wIbY33xxwwu0RRzvLO6b8CtNoWwzyNLCczl0SuQXLkl3E2HY64Hv1Iai5d8
         SlnSc+6IjRBLkrGGI6vY/8XrChW9fqPIj+tn0kRIp+iKD2wp8qpz0k9Sf1EVyy356r1Q
         g89NGFzohu3U7aGVPfmdWt6wlVaSTBUhD5pvR44Jkv80GU13HdPB9xQwkO25KjYpAXVQ
         kqAwakhjhpnQEI6Z3uo5b3IUSaHG2KlaBZsrW/ImUczjAYW//xgIY+92uEgFrriWVwgP
         0p5v1TDs3OA9sjdcqgaewjF8nz7QipfApsFzKNf+Fd66UUBNxCQP6Xv/XkCbfayj8Qtw
         7iqA==
X-Gm-Message-State: AOUpUlFKRjOSZD+nsWr5yAmjktbYs1ecvZcatIL9WNCq1w7h99KXLM3o
        mIZ6QYdJUskK1QYwMKfNm9+aS54S
X-Google-Smtp-Source: AAOMgpfCPSFDuProRLbqhlAKCvg8FLzd+lKJJUqxB7cNMaBF9io8AM2cPsAR7w/xO1hW6xrNTYok8w==
X-Received: by 2002:a50:8345:: with SMTP id 63-v6mr5252308edh.5.1532557027137;
        Wed, 25 Jul 2018 15:17:07 -0700 (PDT)
Received: from localhost.localdomain ([109.77.251.113])
        by smtp.gmail.com with ESMTPSA id i63-v6sm6808814edi.16.2018.07.25.15.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Jul 2018 15:17:06 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/10] staging:rtl8192u: Correct spelling in comments - style
Date:   Wed, 25 Jul 2018 23:16:28 +0100
Message-Id: <20180725221630.28595-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725221630.28595-1-johnfwhitmore@gmail.com>
References: <20180725221630.28595-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the spelling of a number of comments, which caused a checkpatch
issue. This is purely a coding style change which should have no impact
on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_cmdpkt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_cmdpkt.h b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
index 672c8db804e1..40edf96451e3 100644
--- a/drivers/staging/rtl8192u/r819xU_cmdpkt.h
+++ b/drivers/staging/rtl8192u/r819xU_cmdpkt.h
@@ -53,7 +53,7 @@ struct cmpk_txfb_t {
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

