Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BABECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DA1214C5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqNoDaTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DA1214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbeIRGRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:17:51 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45706 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729407AbeIRGRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:17:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id j8-v6so91694pll.12;
        Mon, 17 Sep 2018 17:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wHav3Nwh/EegPSO4dRJ04MDT2MQcX0l4gtMFSLuNA+A=;
        b=iqNoDaTmBQNWLkypPz5EZn50/CE5L4RY7rI+DPyF45MWAdQp7/ugILrHK5vuwXc9m6
         j0xvPp5W+tufhdtGHk5HQd2GLisycyO2FzbXWvfe+yu15sX480q+fpAo8G99t9Ob0dVl
         WegIZSs78SIDEfXGIxEY8So5lwlgFyCm3/cq54gQ3+8VPIW0tB2A/mtOS1AOEyFwRThW
         GJwwi6BFRAUHzpTKjb9/0g4qzBfjUOByR5wqxvARJvagZ9yH9hZ0JRcTFSLeymZXq6qr
         htgwq+vdsJ/v26JnHd0HDM4uwcnD21wQq6dwCtoZGXKOOKaBuyAD9mHKabdS3D0yntdO
         eOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wHav3Nwh/EegPSO4dRJ04MDT2MQcX0l4gtMFSLuNA+A=;
        b=Ta/M7wu7awUwxI1jkmRANCthHBH6Bsj4tPNWFwdvv99wOHmXG7KayhHHcyAUhChMU5
         tGtPnisA1pdudw1N3wmNb/ne7AwYQNURXTP0Ef8Bd4JAsLnplAM29xuRSZ22IVaYhiYy
         KPKPlBEeIH3Cb4VQBoOIj0RDXlkE/qGQ90UmYafB6uLDnfsVkdTBdIrhnT1HnMudFO1F
         QL9/zM+8D8eMwoFd+L0J8BRTUZcf3XpxqXbr9xNg9p6CavTQgVZaYkDNwggKV3ieRFxn
         t42ePZcPG31mNaEw4PQIde5r8KuwYkeuVtKB5oA3US2q+HRfh/YAa9sVjWRT/V3KFsCF
         AZTQ==
X-Gm-Message-State: APzg51DIJSOKGAXoiGFSkiokxgLx5cdUIukpnmXkxOWj3Pa2gUQLq22p
        NASSf0bxRRIe83mxpiMW68OEG1s/
X-Google-Smtp-Source: ANB0VdZEhWjytE0ILerWk8a3NCxKXt2Geah3EaaKPzossZakJRTbxLy8AwPYdCjumGnBsgHrWneVKA==
X-Received: by 2002:a17:902:1ab:: with SMTP id b40-v6mr27663473plb.55.1537231675978;
        Mon, 17 Sep 2018 17:47:55 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:47:54 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 14/20] Input: iforce - only call iforce_process_packet() if initialized
Date:   Mon, 17 Sep 2018 17:47:26 -0700
Message-Id: <20180918004732.9875-14-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is excessive to check if device is fully initialized in
iforce_process_packet(), as for USB-conected devices we do not start
collecting reports until the device is fully initialized.

Let's change serio transport code to not call iforce_process_packet()
until device initialization is done.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-packets.c | 3 ---
 drivers/input/joystick/iforce/iforce-serio.c   | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index c0a665961c23..976ec1c7cf15 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -172,9 +172,6 @@ void iforce_process_packet(struct iforce *iforce,
 	struct input_dev *dev = iforce->dev;
 	int i, j;
 
-	if (!iforce->type)
-		return;
-
 	switch (packet_id) {
 
 	case 0x01:	/* joystick position data */
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index 0dd95d145e85..8d7eba9c9f0e 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -172,7 +172,7 @@ static irqreturn_t iforce_serio_irq(struct serio *serio,
 
 			/* Signal that command is done */
 			wake_up(&iforce->wait);
-		} else {
+		} else if (likely(iforce->type)) {
 			iforce_process_packet(iforce, iforce_serio->id,
 					      iforce->data, iforce_serio->len);
 		}
-- 
2.19.0.397.gdd90340f6a-goog

