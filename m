Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCEBECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A08B214D5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PiotIvNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A08B214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbeIRGSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:18:36 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46148 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729344AbeIRGRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:17:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id t19-v6so89953ply.13;
        Mon, 17 Sep 2018 17:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xA83sai601+9Drcvsji0za+nEGwEcKki265UlqOSVfo=;
        b=PiotIvNkWk6A7nqH4gZh7k3MELgk/IiFfbahoYFmWPDxTiPTNoXgTjyr89lSFuS8Hk
         wDjDd2G3InTa8hd1g3/h9m7cLRfIeFhdtX2p7qGiq/rr61QQhTXvE/OSOS1Ij2BOAddB
         BcZvABU+L+TndqCjDqVXj2brTVh7td0fzIPUWCxb9lppNZb+mt+qKnJYOau9Dl3H45ps
         sWbAs8H8gwXdm1fpqDNxcKD2cRhoCwHQHrkQ9r3luzHFmQ390I/tVzCPM0GMPqQvl4v2
         ilRthD8Qqm9sZpj18WS2LvZvssC0/VVj49kKZdJF7TXeQTjDaONenAP+iiSu7xSi2JLk
         24og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xA83sai601+9Drcvsji0za+nEGwEcKki265UlqOSVfo=;
        b=AvruGECsNe8kBUcmII2m/RPW5raAQb2nA6WKDQLqftNUshEjIbHpzzM91Cn6fLbHqZ
         qI28zZSyptpEfevtMo7OAFWrCWosv41GDH5o32jsBPXIyNuQXA3RsM3yH7T6vavEk9Q1
         ZKbHuYvTOTd+3RIWGseFEWWSy9JuAX23aPAz8EI/k9NTTUKm6IaTPGETsJ0zfaLwMi5l
         CRAoHczIiiFI5JnqZQ8kAoT8o9CHu3NyX4YuIuu8r+fAgXB81LKyoJan+MA1Pb7i1iC9
         ci9ETEOYQfBEo5DMmtx4SLr1vFij8m3n+FsfwbMVUmnoBKtfq/xgddMxN05C4S8+wSSr
         QIeQ==
X-Gm-Message-State: APzg51Cl8oNvadjr4npmP5kuGYOH4pYK4TV9hBH0J70+ZNd0Ogc61tCz
        5qetPJ0FoNvg47pWXzbEZ3qzaDe1
X-Google-Smtp-Source: ANB0Vdb9ByfNGZDjSXM1u7yQ/MdJQvCTny+Z5Te0jWm0JyRDY7quaq4vCdIaBdAX33KsjHUT0JdljQ==
X-Received: by 2002:a17:902:163:: with SMTP id 90-v6mr26776449plb.322.1537231674351;
        Mon, 17 Sep 2018 17:47:54 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w69-v6sm26053316pgd.37.2018.09.17.17.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:47:53 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 13/20] Input: iforce - signal command completion from transport code
Date:   Mon, 17 Sep 2018 17:47:25 -0700
Message-Id: <20180918004732.9875-13-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signalling command completion from iforce_process_packet() does
not make sense, as not all transport use the same data path for
both commands and motion data form the device, that is why USB
code already has to signal command completion iforce_usb_out().

Let's move signalling completion into individual transport
modules.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-packets.c | 2 --
 drivers/input/joystick/iforce/iforce-serio.c   | 9 ++++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index 35b7a5206977..c0a665961c23 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -172,8 +172,6 @@ void iforce_process_packet(struct iforce *iforce,
 	struct input_dev *dev = iforce->dev;
 	int i, j;
 
-	wake_up(&iforce->wait);
-
 	if (!iforce->type)
 		return;
 
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index f8bf7d2aa59f..0dd95d145e85 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -169,10 +169,13 @@ static irqreturn_t iforce_serio_irq(struct serio *serio,
 			iforce->ecmd = (iforce_serio->id << 8) |
 					iforce_serio->idx;
 			memcpy(iforce->edata, iforce->data, IFORCE_MAX_LENGTH);
-		}
 
-		iforce_process_packet(iforce, iforce_serio->id,
-				      iforce->data, iforce_serio->len);
+			/* Signal that command is done */
+			wake_up(&iforce->wait);
+		} else {
+			iforce_process_packet(iforce, iforce_serio->id,
+					      iforce->data, iforce_serio->len);
+		}
 
 		iforce_serio->pkt = 0;
 		iforce_serio->id  = 0;
-- 
2.19.0.397.gdd90340f6a-goog

