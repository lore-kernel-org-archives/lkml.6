Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4B1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24694206A2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFo9zzpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbeLNPM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:12:56 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34606 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730324AbeLNPMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:12:43 -0500
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so5219542ljd.1;
        Fri, 14 Dec 2018 07:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qRMbrgz6GRxf6yeDCa+/ThuxnntpY3MOarYovcWFQ6M=;
        b=pFo9zzpzSc9AuhqD6m4diBv0MXXAqoaMxuil29dqVQwAj++oSDyUmNFyzDoFMjZ5hQ
         OBI0rcJKuz+jbyRYj4YhYRWWq55tPxud0M3BDLDM4+VuQ+/iyezGEE7qfjtDkLKjygjr
         9wiVJMKnziGIUYhded+0llC7JTSXRc/kC3uLkXgmlOaYDu3EIxAou/NAKhE5NvnGRwN4
         PH7UFeLYm8f2I8EmzyxuJiFtvCCDlNU92KxbgMNAa/AOiRV2U7HyKS76CUT/wdiDymzn
         Es+dIDlXTYtzxrO8y7X5cX/fQhSE2Zt70jBdcvndi7vSVftZc4HJNFWhhR8ONKMXXyhc
         9NMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qRMbrgz6GRxf6yeDCa+/ThuxnntpY3MOarYovcWFQ6M=;
        b=ZGYEJbhiDmgKbWH9KtiO2m4bzMQSlugt70BWjAAJX1b6OWlteNe1dLV80HBiQKQ5Or
         PvwFprOmZYju4Ooe6UupUfqQrUe+lG6OvQ77IIwPbAVDsZrbBiv4sQNUBKlV4csmKaI9
         0zH23sDTzLjKrhbIauQoA2sL/bbhTXxB5Z4tbzCxOdq0kQmIRGiXvHewlNs+OZP2Y/Yx
         Zp8oEp7YxTVUxbZXVLfjolxgo0Vh7FdAfY4KV4J6KtbdJSRh6aHcPPyYxX2kK0cfPjzf
         76NzpkD74pZ139cCE0G/KtB+5zaLr29T03kj7lfmizW8+gylg6IJYz4/k+u86jEFxsZ3
         5iJQ==
X-Gm-Message-State: AA+aEWYQLiwuZaR/JNud5zgDYPWloYqx6Ors0An4tk6JepTzEHok7743
        iw32hyyUsUv21h1kRk+OWEo=
X-Google-Smtp-Source: AFSGD/VOnrKfX1vyv8a22wLq9u3naOibHehdLcak71xwAg9pclRRKGzlRDURaL0/8ScC700m9cy/Uw==
X-Received: by 2002:a2e:5054:: with SMTP id v20-v6mr2102682ljd.45.1544800361634;
        Fri, 14 Dec 2018 07:12:41 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:976:99fb:a7e3:627c])
        by smtp.googlemail.com with ESMTPSA id o17sm951975lff.77.2018.12.14.07.12.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 07:12:41 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     nick@shmanahar.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v5 2/3] Input: atmel_mxt_ts: Wait for device be ready for communication
Date:   Fri, 14 Dec 2018 16:12:13 +0100
Message-Id: <20181214151214.5391-3-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
References: <20181214151214.5391-1-pawel.mikolaj.chmiel@gmail.com>
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
Changes from v1:
  - Fix checkpatch issues
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 55a107fc1b73..e8949c6ceafa 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -202,6 +202,7 @@ enum t100_type {
 #define MXT_CRC_TIMEOUT		1000	/* msec */
 #define MXT_FW_RESET_TIME	3000	/* msec */
 #define MXT_FW_CHG_TIMEOUT	300	/* msec */
+#define MXT_POWERON_DELAY	150	/* msec */
 
 /* Command to unlock bootloader */
 #define MXT_UNLOCK_CMD_MSB	0xaa
@@ -3070,6 +3071,16 @@ static int mxt_regulator_enable(struct mxt_data *data)
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

