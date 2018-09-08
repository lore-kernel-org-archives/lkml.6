Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB59C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB4020844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 09:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THZIeH99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB4020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbeIHO3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 10:29:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38227 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbeIHO33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 10:29:29 -0400
Received: by mail-wr1-f67.google.com with SMTP id w11-v6so17148377wrc.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 02:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bV18M6tQz4SD0cOnqE6q7CdYxWrRUJwwwIIEfru2n0M=;
        b=THZIeH99pk03o/gRrSobSC9HHp0S4vnxo+zrmrjXvVVmWdMSq9SnfsNg1/YmRcm9lU
         5LXfdAMspIvBh0CAuVccMz84ykAsK0iDFQ8tR17Kyn2bRjdlm2ag51gsrJwegzr0ryEp
         clcGj0KA1awn5ICiRuoCyvBpjLUWlMZKDd20ip9Bm1HrHmnsVm8bo6gcOcKS4iQQEkik
         CtB+5xsNKNSBb30IkqFPgzwcUS8ICXWiOJ/xml9tXNowP0VYg9Zvz5LC45PNJ9SUGYbZ
         kCZLbe+i7yIwzXvRmf+5GKIXdfkb21Y1Tv4OZsDqsdCKH8JiaFbNqH6aEadoVcqWUz1F
         MAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bV18M6tQz4SD0cOnqE6q7CdYxWrRUJwwwIIEfru2n0M=;
        b=Uae6K4nW3tAheKzMMxMTLkXQqa6hKJRJsG5kKubPc4e74Xr5ox0YmRDqps5Bpv+ZbO
         Q1d+DvY51fX3ZoB9pz+pFq5Tiaz/rpBrPWWXuoO+iuWm4NbW+OSqFLxzDUMs/yrSDNJq
         PmQWtBaXeHKNsh9WEun7aOq4RPDC6goKzCwtl48ZGdW1i35nNtH6FjKcs3jDwApOysxH
         OVAxInqMblHwT77HZFGLf954dcHdAr3CqCAW/rcqIQtlAqMhdTpkbivOamBreFkJX9KP
         e8sz5hYb1MHhC66aPpDd+JhjB2ld4buV82mzXomf/JL8sDy/6pCZvtrgCWfG1D9etiir
         B9Pw==
X-Gm-Message-State: APzg51DOGSifBkcK1HSFUiCWrfXO6LD/kMr8Juys42zkDztmv31nP1Bq
        GQ4ZrRJ4AW5j91dxvsNb+HKm/qM+
X-Google-Smtp-Source: ANB0VdZbsYzL+U80L/hfyUVdv4i8pmIG03K6apT3WT31naC8iUetBsY3OqHXbL7gktvBHnAi6v+Irg==
X-Received: by 2002:adf:8367:: with SMTP id 94-v6mr8872438wrd.258.1536399859056;
        Sat, 08 Sep 2018 02:44:19 -0700 (PDT)
Received: from localhost.localdomain (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id t132-v6sm13975018wmf.24.2018.09.08.02.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 02:44:18 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 3/4] staging:rtl8192u: Remove typedef from firmware_init_step_e - Style
Date:   Sat,  8 Sep 2018 10:44:08 +0100
Message-Id: <20180908094409.4043-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180908094409.4043-1-johnfwhitmore@gmail.com>
References: <20180908094409.4043-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the typedef directive from enumerated type firmware_init_step_e
this clears the checkpatch issue with adding new types to the code.

This is a coding style change which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/r819xU_firmware.c | 2 +-
 drivers/staging/rtl8192u/r819xU_firmware.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192u/r819xU_firmware.c b/drivers/staging/rtl8192u/r819xU_firmware.c
index 9c7e19aedff1..15fd026638fe 100644
--- a/drivers/staging/rtl8192u/r819xU_firmware.c
+++ b/drivers/staging/rtl8192u/r819xU_firmware.c
@@ -209,7 +209,7 @@ bool init_firmware(struct net_device *dev)
 	u8			*mapped_file = NULL;
 	u32			init_step = 0;
 	opt_rst_type_e	rst_opt = OPT_SYSTEM_RESET;
-	firmware_init_step_e	starting_state = FW_INIT_STEP0_BOOT;
+	enum firmware_init_step_e  starting_state = FW_INIT_STEP0_BOOT;
 
 	rt_firmware		*pfirmware = priv->pFirmware;
 	const struct firmware	*fw_entry;
diff --git a/drivers/staging/rtl8192u/r819xU_firmware.h b/drivers/staging/rtl8192u/r819xU_firmware.h
index e78e547044b4..870301853480 100644
--- a/drivers/staging/rtl8192u/r819xU_firmware.h
+++ b/drivers/staging/rtl8192u/r819xU_firmware.h
@@ -5,11 +5,11 @@
 #define GET_COMMAND_PACKET_FRAG_THRESHOLD(v) \
 	(4 * ((v) / 4) - 8 - USB_HWDESC_HEADER_LEN)
 
-typedef enum _firmware_init_step {
+enum firmware_init_step_e {
 	FW_INIT_STEP0_BOOT = 0,
 	FW_INIT_STEP1_MAIN = 1,
 	FW_INIT_STEP2_DATA = 2,
-} firmware_init_step_e;
+};
 
 typedef enum _opt_rst_type {
 	OPT_SYSTEM_RESET = 0,
-- 
2.18.0

