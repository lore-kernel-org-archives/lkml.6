Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03635C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAD9208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9XHWvhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFAD9208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbeGaQ7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:59:14 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37309 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbeGaQ7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:59:13 -0400
Received: by mail-lj1-f196.google.com with SMTP id v9-v6so14070003ljk.4;
        Tue, 31 Jul 2018 08:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oDFpD0XD10AgLdPz8ese+ZwKGg/jgVOPdmYGBME+5IY=;
        b=E9XHWvhN5FI7YmYY0EdAm/mUUcuzhDrJRJDgxFXh89blslJEGE54hCxGHen4KODisp
         iJXv1cppINm0Bb/ZBpO83Nx2ecfBAsb+vsXc8ip7kjBSNVNlGRY2D7BoJUJFchaH4/AY
         JpAjqUmG7x3qr5WqO7+lINTFCxWdat6WAAqQ02SLnxYRN9jrHu2V8nTbKcffeyhBKj8o
         6L0ryIitoq0SXNpG/1/CjuOF8JQKGK5Dkc83nqjwjJ+X8A9uUfXpH/ZeGWPltm9Dwe8X
         VCt0lsk116YSZYOIxYT7QAOmFiXGhSj+xq+lA/nIxjssZPA5lO4rze7kcPG4EB9QzsVm
         ShqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oDFpD0XD10AgLdPz8ese+ZwKGg/jgVOPdmYGBME+5IY=;
        b=Fb+ysNLipk5+VzXmW7oxF+c8EE3SjJ1uIirifVk0ogfeoMbzEes6BhuegJ7hsvO1FG
         LqrhXLCJ6KgMrWp0BK9xhGRyGtJ/V50q6rlrPDjpD7r5V1edE/QOuwlTbK8lG0Zdo6lC
         0mEmuNoqdGRi5y5tj99QWsiqBWtumr2JWWld4ySpmMVU2z/6J3u2WOswero6l9gq1Nmn
         ntHUiH8xIWReO0IlUkH4p/KQqqGwiL1IF/78CpKXnPBNXq7yMbk2pqvCoaJHKf0yckmC
         dF/uop2BLvuER1HaXBCouOLqSKYD4ndWboRdhMzQBgp2w7ab37C8YOBY3NzcCp81dJUV
         HbPw==
X-Gm-Message-State: AOUpUlGk0ZPjCyM8OEvg2QDw48LQupymGFmLPMJ5T2qMfwb5VyUonT3F
        Lb6khMiRTi+GRXCT8pD+O6kh7SOTFck=
X-Google-Smtp-Source: AAOMgpd5vAZQ4cR3dc+7QPzWJsQzsqW1Uibyl9sL/eIa76qFyGInDJUztPW27RS/EW+naM+neDXscQ==
X-Received: by 2002:a2e:6d0a:: with SMTP id i10-v6mr17416037ljc.145.1533050303364;
        Tue, 31 Jul 2018 08:18:23 -0700 (PDT)
Received: from localhost.localdomain (user-94-254-173-71.play-internet.pl. [94.254.173.71])
        by smtp.googlemail.com with ESMTPSA id p88-v6sm2606209ljp.90.2018.07.31.08.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Jul 2018 08:18:22 -0700 (PDT)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v3 2/3] Input: atmel_mxt_ts: Wait for device be ready for communication
Date:   Tue, 31 Jul 2018 17:18:10 +0200
Message-Id: <1533050291-11502-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533050291-11502-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1533050291-11502-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
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
 drivers/input/touchscreen/atmel_mxt_ts.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 2cd7f6db6ba9..79e08916359f 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -202,6 +202,7 @@ enum t100_type {
 #define MXT_CRC_TIMEOUT		1000	/* msec */
 #define MXT_FW_RESET_TIME	3000	/* msec */
 #define MXT_FW_CHG_TIMEOUT	300	/* msec */
+#define MXT_POWERON_DELAY	150	/* msec */
 
 /* Command to unlock bootloader */
 #define MXT_UNLOCK_CMD_MSB	0xaa
@@ -3046,6 +3047,16 @@ static int mxt_regulator_enable(struct mxt_data *data)
 		msleep(MXT_REGULATOR_DELAY);
 		gpiod_set_value(data->reset_gpio, 1);
 		msleep(MXT_RESET_INVALID_CHG);
+
+retry_wait:
+		reinit_completion(&data->bl_completion);
+		data->in_bootloader = true;
+		error = mxt_wait_for_completion(data, &data->bl_completion,
+										MXT_POWERON_DELAY);
+		if (error == -EINTR)
+			goto retry_wait;
+
+		data->in_bootloader = false;
 	}
 
 	return 0;
-- 
2.7.4

