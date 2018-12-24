Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45482C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 21:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 047792184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 21:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="iPanVUxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbeLXVj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 16:39:27 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:58468 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbeLXVj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 16:39:26 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id ED0AEBCF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 21:39:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MTsGV1kzEkmd for <linux-kernel@vger.kernel.org>;
        Mon, 24 Dec 2018 15:39:24 -0600 (CST)
Received: from mail-it1-f200.google.com (mail-it1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id A4D879D9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 15:39:24 -0600 (CST)
Received: by mail-it1-f200.google.com with SMTP id g7so15094330itg.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 13:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7RYsDfMgiAguPYV89izW8+HWY2mw1oC7VV4dg6eWvpE=;
        b=iPanVUxxGsqPMzEtMWD/Ifva8WcPRVTo/oHlSFzBOtTTwiCHoTxZe8N8pbYOQYprSc
         tnV1rzvMa3mP1iGiJuQ2+nKA24KxaCRw54WZWdAPLZNtvVnia19beVVzkW2xRceKNgBG
         DSMLC9Sfn+d+O83jUE2IXwCpyG3U66KSBWGgtUokyAlXQIZ5Mpu7glt2JxydfEihXzK1
         VjjZUgyKtZnErWV+eXBOw1G72kfsC4M9GlMQU4xu0znNUyOOkwnk7nhu5/SGD/A/E9jx
         d74XPKpm/iWQawt0Y5L6xVCs4FVOGWVKDv75/2JuNlFqjdmLTOjLUZ/erFTiHxxsmgCx
         CqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7RYsDfMgiAguPYV89izW8+HWY2mw1oC7VV4dg6eWvpE=;
        b=A8Adu6qFuGhXuLMl7qgIl+yiiWWjujdMjOn09DLrYMUOOagJ0/2vqPUabFw/4WYK7J
         vs+N0D3QI2zZrXaLJ83KDxsUd912wVvy0fnCAgfRjMYC2xX6DIknyUwr2igbjPiM2R42
         /rzJ/tcBiO/9puENLeWvjIX7Id7unAEAGVm9PR4mljeY4nYga9h8Lp3xk/Xy2ervQ1ae
         +HkG+Dyr64PhcAzlpzjys/vZ+GFqDtMpnmCA1ibOdEkFhEOqC7AZgiVGRMp0/gPGiYFI
         KCSGXBDDIWTdgvp6syujKjPaEDxsitZJ8ZCsREGQfYbsJz29YAwsC5Lur/AuhPGfZcJi
         gA2A==
X-Gm-Message-State: AJcUukcVEnJrrFRECx2q7cqZxc7yNg3Xdv6WL10+zl4LEU+Eyuc3s869
        1o15sOUt5oT7UveLQ4jJGrBN7MtslgQx1Y9WOsNjCfHy7bSI/ygGq/UnEkBI/AzLpZXY4Qisjp3
        19K+V27J2lhvMaoU3sVD5nlvwGsXA
X-Received: by 2002:a24:2e94:: with SMTP id i142mr10540086ita.157.1545687564246;
        Mon, 24 Dec 2018 13:39:24 -0800 (PST)
X-Google-Smtp-Source: AFSGD/X5nMH/x4zxNC40JrRJIKs7zITcDYOBrERJErHHnQuCw8Bnpa0uTncgRTWxvBoTSJ/NNfPVng==
X-Received: by 2002:a24:2e94:: with SMTP id i142mr10540082ita.157.1545687563997;
        Mon, 24 Dec 2018 13:39:23 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id m18sm3519105ion.78.2018.12.24.13.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 13:39:23 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hid: Add checks to fix of_led_classdev_register
Date:   Mon, 24 Dec 2018 15:39:14 -0600
Message-Id: <20181224213914.26453-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In lenovo_probe_tpkbd(), the function of_led_classdev_register() could
return an error value that is unchecked. The fix adds these checks.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/hid/hid-lenovo.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
index 643b6eb54442..eacc76d2ab96 100644
--- a/drivers/hid/hid-lenovo.c
+++ b/drivers/hid/hid-lenovo.c
@@ -743,7 +743,9 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 	data_pointer->led_mute.brightness_get = lenovo_led_brightness_get_tpkbd;
 	data_pointer->led_mute.brightness_set = lenovo_led_brightness_set_tpkbd;
 	data_pointer->led_mute.dev = dev;
-	led_classdev_register(dev, &data_pointer->led_mute);
+	ret = led_classdev_register(dev, &data_pointer->led_mute);
+	if (ret < 0)
+		goto err;
 
 	data_pointer->led_micmute.name = name_micmute;
 	data_pointer->led_micmute.brightness_get =
@@ -751,7 +753,11 @@ static int lenovo_probe_tpkbd(struct hid_device *hdev)
 	data_pointer->led_micmute.brightness_set =
 		lenovo_led_brightness_set_tpkbd;
 	data_pointer->led_micmute.dev = dev;
-	led_classdev_register(dev, &data_pointer->led_micmute);
+	ret = led_classdev_register(dev, &data_pointer->led_micmute);
+	if (ret < 0) {
+		led_classdev_unregister(&data_pointer->led_mute);
+		goto err;
+	}
 
 	lenovo_features_set_tpkbd(hdev);
 
-- 
2.17.1

