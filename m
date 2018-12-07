Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8B3C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365C720989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 14:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e11A58l1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365C720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeLGO3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 09:29:11 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40575 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbeLGO3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 09:29:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so3721001lji.7;
        Fri, 07 Dec 2018 06:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWNAi8KA5a8AOePm/F4rK7ibKNtgPheT1xDfWNYRieY=;
        b=e11A58l1OICddwBkd3QPB4OcLgtsliFd4zjJy+N9bQGigToT/1BMutBRd+QtlEq0pO
         5LILs7A2Lq1IguK022EApnKfxclTwl6Lk0siOrwEnjOvMPWwhwnJMb7K4znBRl9PMqjY
         7iFelOBgQN4qdgQ/Ccn71jD9m5ARPDAyzAvvTuwyZJdkdOqe4qqG2KbuO7F0zu4UqMCq
         Lbkf79c1fmzl0DIr3/R25r1Z4JJQvquvrsGcs29lV26z6fLl7+MasKIYjRGOeXXScP7k
         N2bKdnFvRiRdLSBowMW92NXuKlUeaLSqP30c9FPFmpiBbJ9DI5T9b7crQLPV/KH7geN0
         ZxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWNAi8KA5a8AOePm/F4rK7ibKNtgPheT1xDfWNYRieY=;
        b=ZR+toqXAX8n6ejWxUUuHPIu6rk+w2sWu99lkqrgh04q3NCEgVFkFKp7bZ+eg/p1U1i
         sYsRcqq5fbMk+GDEoh8vAReVkj41GmroqzsPj0OcyOu331kYHr7eBp/PWmXMOju5Oec4
         e2GcCy4XV9xPyylp6PN/X0isMbPsiKsrqCr1uVX1dBJhqFYXRVJd5vrYG9BiWfK5JM6U
         5gk7bcjQC0sBjaBFq8Ggka/uMdxfDszoj6hSN0cVFO/4CC7fapp/PeG4qXh5iVo7QigZ
         7UItvr79Lag/piuvhPg5jYWSgZylaRfhkmRACbf8YOaEAnQDgzP8yircTnOk9eprHY0o
         Js8w==
X-Gm-Message-State: AA+aEWaZOOsRKKzaeWIHhuL2KsJt1r32mpFzG3fdAyji+jwCLJQvHQi8
        9WEK6LI4/ne1RCncYC+An3n+3thzhEg=
X-Google-Smtp-Source: AFSGD/Up/wbof3FtQRCE3rUT1ZzDsRe88dk6wQP8OjxkQVHawaLT5xP91x8lz8V2gRHiotkgE7dz3g==
X-Received: by 2002:a2e:994:: with SMTP id 142-v6mr1316978ljj.120.1544192944605;
        Fri, 07 Dec 2018 06:29:04 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:74d5:51ba:2673:f3f4])
        by smtp.googlemail.com with ESMTPSA id v64sm630504lfa.48.2018.12.07.06.29.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 06:29:04 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v4 2/3] Input: atmel_mxt_ts: Wait for device be ready for communication
Date:   Fri,  7 Dec 2018 15:28:56 +0100
Message-Id: <20181207142857.15818-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181207142857.15818-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to documentation, device isn't ready for communication,
until firmware asserts the CHG line. Add missing wait for this.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v3:
  - Fix checkpatch issues
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 1dc8ad0da5af..3f956d07d09e 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -202,6 +202,7 @@ enum t100_type {
 #define MXT_CRC_TIMEOUT		1000	/* msec */
 #define MXT_FW_RESET_TIME	3000	/* msec */
 #define MXT_FW_CHG_TIMEOUT	300	/* msec */
+#define MXT_POWERON_DELAY	150	/* msec */
 
 /* Command to unlock bootloader */
 #define MXT_UNLOCK_CMD_MSB	0xaa
@@ -3068,6 +3069,16 @@ static int mxt_regulator_enable(struct mxt_data *data)
 		msleep(MXT_REGULATOR_DELAY);
 		gpiod_set_value(data->reset_gpio, 1);
 		msleep(MXT_RESET_INVALID_CHG);
+
+retry_wait:
+		reinit_completion(&data->bl_completion);
+		data->in_bootloader = true;
+		error = mxt_wait_for_completion(data, &data->bl_completion,
+						MXT_POWERON_DELAY);
+		if (error == -EINTR)
+			goto retry_wait;
+
+		data->in_bootloader = false;
 	}
 
 	return 0;
-- 
2.17.1

