Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84396ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C5F20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mt3+iZ/7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36C5F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbeGWOVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:21:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44745 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388156AbeGWOVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:21:46 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so673385wrt.11;
        Mon, 23 Jul 2018 06:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yrEK7wylPi26wjkh1to8Jnf10ztAXnVDAd4Pj6MetCY=;
        b=mt3+iZ/7XNrg5rxmGw2Z8fFhu6SqEJf7zFxYzZb5UjD48+IZGuLU0XPcPMmZ0fK0EA
         ffO66TUtMGE7Hnac5/xwUWWidcLMmLBZwNGaOIDkL/x3ALphY5eJmTyXkq4E7R5Hq9aO
         CQjeAU4gqmx5cCPnqyNfkzJlkmo5WdlVGDYsyR3mil6lY8Wm3xWao8eBULBuVl6DHMM9
         pQQBn0VdTZWsX4cb9f4Bbd8k2yw+dR8MzZQ3sgnG/c4HICSBI1AcdYNJmNJT9XFUKTEU
         FythQsHJ69uFU/yHA6lE6odsTyV4mzcCfDoZRWD2GILlEJPrOx9r65tBtKPc9l68rCqx
         dByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yrEK7wylPi26wjkh1to8Jnf10ztAXnVDAd4Pj6MetCY=;
        b=PY88lPub1XkUagMAVmotUjhOfzsi4sL3YE+0KUtIBOnbDoG3PVHS6kBkDQK3+PX9sx
         Y6uSb1UrwEsfAhsm92AN6IoXMQGdEIKQHSaHS16Kfzh1QB1RnJFNOeWpgbiJvW1nfOPd
         IIhrzSAZbXSLhytKmmh4G5A4eXdiAadmniCji7NlEYXdbuWrTc0HSTdg5CKAD9bGBoOp
         69wYbzPUkjx7NcOMGIui6BCo2YYj+Q32GE4miHss6yqK99YYRJzs1WDmSUKp53Ge3X1t
         nxoLcNK39BWUs7B/aduJ/X/Ld7lR/zAVpge0LkpzVUL3R5/Dg16tpExRd7TT/wFqX7tw
         YIcg==
X-Gm-Message-State: AOUpUlEhx8IZvrSGIgQJ20x3a+FpReT7vfzvu1BkBDgYB2Yvje8XVEXD
        BIPQ0/KgD8KolI/gTkHoQ/Y=
X-Google-Smtp-Source: AAOMgpcxVgRTcDoU71YLRIT469AqwngrzENtDTCXv+GV4slnIVQa9MiW6Yx/5UxwpAtziKmcutBqGQ==
X-Received: by 2002:adf:80aa:: with SMTP id 39-v6mr8799968wrl.57.1532352031921;
        Mon, 23 Jul 2018 06:20:31 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id t184-v6sm8368459wmf.18.2018.07.23.06.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:20:31 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Harshit Jain <harshitjain6751@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Jeffrey Lin <jeffrey.lin@rad-ic.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] touchscreen: raydium_ts: Use octal permissions
Date:   Mon, 23 Jul 2018 18:49:24 +0530
Message-Id: <20180723131954.30739-8-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723131954.30739-1-harshitjain6751@gmail.com>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(fw_version, S_IRUGO, raydium_i2c_fw_ver_show, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(hw_version, S_IRUGO, raydium_i2c_hw_ver_show, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(boot_mode, S_IRUGO, raydium_i2c_boot_mode_show, NULL);

WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
+static DEVICE_ATTR(update_fw, S_IWUSR, NULL, raydium_i2c_update_fw_store);

WARNING: Symbolic permissions 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.
+static DEVICE_ATTR(calibrate, S_IWUSR, NULL, raydium_i2c_calibrate_store);

Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/raydium_i2c_ts.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/raydium_i2c_ts.c b/drivers/input/touchscreen/raydium_i2c_ts.c
index d1c09e6a2cb6..eddbb51e55dd 100644
--- a/drivers/input/touchscreen/raydium_i2c_ts.c
+++ b/drivers/input/touchscreen/raydium_i2c_ts.c
@@ -934,9 +934,9 @@ static ssize_t raydium_i2c_calibrate_store(struct device *dev,
 	return error ?: count;
 }
 
-static DEVICE_ATTR(fw_version, S_IRUGO, raydium_i2c_fw_ver_show, NULL);
-static DEVICE_ATTR(hw_version, S_IRUGO, raydium_i2c_hw_ver_show, NULL);
-static DEVICE_ATTR(boot_mode, S_IRUGO, raydium_i2c_boot_mode_show, NULL);
+static DEVICE_ATTR(fw_version, 0444, raydium_i2c_fw_ver_show, NULL);
+static DEVICE_ATTR(hw_version, 0444, raydium_i2c_hw_ver_show, NULL);
+static DEVICE_ATTR(boot_mode, 0444, raydium_i2c_boot_mode_show, NULL);
 static DEVICE_ATTR(update_fw, S_IWUSR, NULL, raydium_i2c_update_fw_store);
 static DEVICE_ATTR(calibrate, S_IWUSR, NULL, raydium_i2c_calibrate_store);
 
-- 
2.17.1

