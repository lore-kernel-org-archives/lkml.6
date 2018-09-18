Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0890ECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79102214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ietSreGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79102214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbeIRGRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:17:35 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36754 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729070AbeIRGRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:17:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so116515pgo.3;
        Mon, 17 Sep 2018 17:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ASxqEhgQ7B67xw9F76ph/2Ld0TEHcTytkExevqFD/b0=;
        b=ietSreGJ/b43bF1W5FBUn72l9loRar2LmBFb/uHdPFfhlGzBrYVbV9jUCj+AVPMaiw
         Jr3IKH9mi/4nzfxyEHTJnVqQh10umxFLX4bRCjhfyHjEiO2dm95PHwOQvb+GdbwukM5z
         q2gKA7sA6MEZH/04VQ6568B1oHBGf0JptEvMbBGTJJoiC/hXbLGXYxem52wXl4+BxghJ
         5fFqZg1iJcgQLscP3fuz/ueCu6LG4vAeTJlfkVSyjbxBtFliVN6VTNMTUlLgqlYzbX3U
         OrZGMvHJikpdGRLuI7pu+NiYulf/SWNUQ9HFTBnKhGRxNKBRcAXXz4vIC7WC2mgC3517
         5+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ASxqEhgQ7B67xw9F76ph/2Ld0TEHcTytkExevqFD/b0=;
        b=DjzVL25lBnRHlPdavR6RxdrIwElhKgmrUDjYx8gcXlLL32Wq6t46jw33E/kT9QPqkL
         K0ETJ7DV0cq/F3s4toQIQ8xFT8Gti6mdX2VL1XpxP/8pJggXo4Jq3qSI/F91R2AJ/nti
         9mTQDYTFPFFT1eU4BEA/opWvxZhbDwChmpTvm7wl1lLCTv+gPuvNtFK7xdi5Ai+Dd+Q1
         Dj6ucztTocvsqLFcmeR7i0hOPivddZpn90RyzR2OJwLfxYUCAifNq6AzmG5wjJIDgVQm
         rOJnlWMhGXQsvZYzNAfRsHLVjxpW6id+M3AvawI+COWP8+wgrTbFwo1HUYUfw+Q3rhb1
         ssLw==
X-Gm-Message-State: APzg51AbNLZ+u8SZoUSGvhuDO5MuwfMJwvtVFnc+iwq6fRwYT7dHHs8T
        Rdbl/BJIy0CmTzr5/Ez4VyxnKGVn
X-Google-Smtp-Source: ANB0VdbkS3wZLeox1kaP55zyFGfTFtxAtCc7DqT3lxfdpbcbU1z/UUZRh+iFBvLaFpH09ANnSyAKzg==
X-Received: by 2002:a63:e949:: with SMTP id q9-v6mr25361765pgj.4.1537231660488;
        Mon, 17 Sep 2018 17:47:40 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.47.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:47:39 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 04/20] Input: iforce - move command completion handling to serio code
Date:   Mon, 17 Sep 2018 17:47:16 -0700
Message-Id: <20180918004732.9875-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Continue teasing apart protocol-specific bits from core into transport
modules. This time move RS232-specific command completion handling
from core to iforce-serio module.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-packets.c |  7 -------
 drivers/input/joystick/iforce/iforce-serio.c   | 12 +++++++++++-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index e677562efc9a..8a9a152bb595 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -134,13 +134,6 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 	struct input_dev *dev = iforce->dev;
 	int i;
 
-#ifdef CONFIG_JOYSTICK_IFORCE_232
-	if (HI(iforce->expect_packet) == HI(cmd)) {
-		iforce->expect_packet = 0;
-		iforce->ecmd = cmd;
-		memcpy(iforce->edata, data, IFORCE_MAX_LENGTH);
-	}
-#endif
 	wake_up(&iforce->wait);
 
 	if (!iforce->type)
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index fa45ce425d47..eca2f6eca7f0 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -130,7 +130,17 @@ static irqreturn_t iforce_serio_irq(struct serio *serio,
 	}
 
 	if (iforce->idx == iforce->len) {
-		iforce_process_packet(iforce, (iforce->id << 8) | iforce->idx, iforce->data);
+		u16 cmd = (iforce->id << 8) | iforce->idx;
+
+		/* Handle command completion */
+		if (HI(iforce->expect_packet) == HI(cmd)) {
+			iforce->expect_packet = 0;
+			iforce->ecmd = cmd;
+			memcpy(iforce->edata, iforce->data, IFORCE_MAX_LENGTH);
+		}
+
+		iforce_process_packet(iforce, cmd, iforce->data);
+
 		iforce->pkt = 0;
 		iforce->id  = 0;
 		iforce->len = 0;
-- 
2.19.0.397.gdd90340f6a-goog

