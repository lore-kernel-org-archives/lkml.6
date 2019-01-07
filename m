Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADD0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BEA92147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbJQS5dH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbfAGSzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:55:02 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45122 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbfAGSyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:54:12 -0500
Received: by mail-lf1-f67.google.com with SMTP id b20so1051152lfa.12;
        Mon, 07 Jan 2019 10:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/c+ISyiSRiDIt4sidmbC1nUvxvjzDpzrqa5uzk8AQg=;
        b=vbJQS5dHja6YT2ONoe/Mhb6vzDvAyxh9NS28mxwDuNmn1cB3OJYGD7d9t1LOpTVAts
         UViZKsHR0nM6HXwdbWS6W66ecCgt+AZjZ4looIOnVzqzMJHykOOFJGMEbIsqtyxIh3g8
         X5RQssjaLq62I5KWHbxcHoUX1hGudzShybVf1yFOoMKUcfnQQfJjSazif/ABw88CPz2g
         LwhrfUq3MiNSyWSOvz/E6BVxar2N+4ocP5/AU1ccrK7ozzyIpywiyKMXD4OS3JekXL1j
         KAZjC5Ix0ZokYwFd8xC6LQNNhe41lWw/zju2dUtB3vAJuQbh5ijGqBxmOqbD13zJpyCQ
         DSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/c+ISyiSRiDIt4sidmbC1nUvxvjzDpzrqa5uzk8AQg=;
        b=thi5+RU7EQOY8DauI5wVhXxW6QDfIEVn/+1Exk1+rrj13+CdYDrLzbK+EriB4Fquz/
         bdus30BjzvITJDgoF/Qd7zX7EwsA/DvDEqOj4btDy2g1Ls/72ETM/sB0RgOUZ4tqvqkz
         /ZPGM9VtbT0JtQsKFZRX2j/f4fXp9ZRgYb3MelIwgDQlcTqVvZQc3JdsnK2qqIhkivSX
         av6g1tFgApZKwYOjfkzc1WoURFr5LC8BhOqzjNgXY6k1765/uoz62GKAYxBJ++LF82VL
         g3H8wkDKx01eSa9Z5txbOhGi82CS3j+PZ5yrCtAthPLwSvsLdut1/RROpoxQY0F5bdta
         ZpYA==
X-Gm-Message-State: AA+aEWZVJo8sTIHBRAJytcSz++6QX0a7WQ3KMUIJZ5sR5FYlcj57kSQk
        Cc+3Dpk5IzS+kqwOtpmydLQ=
X-Google-Smtp-Source: AFSGD/WSJ2p1LaR7WA9g/hsMkElJipef5Ine2e8s08YHiWNT6TN+Kp+KXCGOfzXUM9yDnJ9g0Unjng==
X-Received: by 2002:a19:1a14:: with SMTP id a20mr29588891lfa.1.1546887250145;
        Mon, 07 Jan 2019 10:54:10 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:c050:d453:6c2:1d01])
        by smtp.googlemail.com with ESMTPSA id h203sm12825007lfe.44.2019.01.07.10.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:54:09 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, pawel.mikolaj.chmiel@gmail.com,
        xc-racer2@live.ca, simon@lineageos.org
Subject: [PATCH v3 3/7] Input: tm2-touchkey: Correct initial brightness
Date:   Mon,  7 Jan 2019 19:53:42 +0100
Message-Id: <20190107185346.30184-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190107185346.30184-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190107185346.30184-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Tm2-touchkey don't have brightness levels, but only on/off states,
so replace LED_FULL with LED_ON.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/keyboard/tm2-touchkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/tm2-touchkey.c b/drivers/input/keyboard/tm2-touchkey.c
index 5a1fe08bdd76..0336789ab1bb 100644
--- a/drivers/input/keyboard/tm2-touchkey.c
+++ b/drivers/input/keyboard/tm2-touchkey.c
@@ -230,7 +230,7 @@ static int tm2_touchkey_probe(struct i2c_client *client,
 
 	/* led device */
 	touchkey->led_dev.name = TM2_TOUCHKEY_DEV_NAME;
-	touchkey->led_dev.brightness = LED_FULL;
+	touchkey->led_dev.brightness = LED_ON;
 	touchkey->led_dev.max_brightness = LED_ON;
 	touchkey->led_dev.brightness_set = tm2_touchkey_led_brightness_set;
 
-- 
2.17.1

