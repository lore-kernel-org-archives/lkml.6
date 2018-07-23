Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8779ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9351D20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 13:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJM8H7I8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9351D20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388355AbeGWOVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 10:21:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35295 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388053AbeGWOVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 10:21:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so1213576wmc.0;
        Mon, 23 Jul 2018 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6COwS89nu26Msom+rscHlSZ4QQPeZOVMv7pa6eA3eB0=;
        b=uJM8H7I8utIsCco9sgd5yB2PbMe3XrL1nIcTQLwnAWhXEVu6zKg16tQeLFFh2kj9Y/
         YXBmykPP14UewtxlzO9FtaJHbY6CUmntNz8lYfJmnE8SNdL2vP8rIVv0dB1s52LylzBF
         sG0c4wIFM5RlWVjQ6Dc0Y+UBlH7kp6Qlx42705WmRi6d1+hRUtsxGbFZ89Zt83yiTXnf
         q9Zz4n2DNIvEztdXMyUq968OrX5N28rMXq25gm9Q1I+HC4O9xg+P7RnvbEoh7zcSa9pX
         PHvbCWSvm/o62Sz8Mh0PcCyKTrZnRXP9u2rQTgy4gbDO3jNl9UFibpUhZ+IqeMDK9pXz
         +QaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6COwS89nu26Msom+rscHlSZ4QQPeZOVMv7pa6eA3eB0=;
        b=JHLTZt2Aghxt1CurH+WHlcF/emMlly6JnjONT3qNk+qFM/heahH2xk4wGm8YxMYVan
         H5uLe2Y64DYUJv6wdN85ale2NfzCLaIfBKT8vCR2aPpedP6iOTUWPaGTpCszr/U+way5
         FZuuDfJix8/xo0eKT8MlWUmH20fZHxRiuSOm1pbEjcqgRp/u0nRlHvifzltY7iT4tESw
         323TVodjXBvlSjuXibcfS3m87pZfrzidcyaH2kIDVEK33xSFzWaYR2ykc8DBXUfTZc6f
         djb6En9jbEg5dcjASmHUOj+3qZEB9//VB927O/layZepL4sUJecyvCnTUPNDnx8p6IRa
         nPJw==
X-Gm-Message-State: AOUpUlF5HA/487zyhx77/v2zSId8aiS1kh8UOaiqKH5ASaJByLl1H5N8
        ezMSmZdrv8rbdCP5t+zE4kc=
X-Google-Smtp-Source: AAOMgpdWxJkq+8eBjI6Oh8GR5Zz8qmY2hZnDkLBM+kVkg53a8LXOg/U+T32aBiZ1YbinX8yuW+/3vQ==
X-Received: by 2002:a1c:e189:: with SMTP id y131-v6mr7324868wmg.44.1532352002585;
        Mon, 23 Jul 2018 06:20:02 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:201:1487::2])
        by smtp.gmail.com with ESMTPSA id t184-v6sm8368459wmf.18.2018.07.23.06.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 06:20:02 -0700 (PDT)
From:   dev-harsh1998 <harshitjain6751@gmail.com>
To:     trivial@kernel.org
Cc:     Harshit Jain <harshitjain6751@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Simon Budig <simon.budig@kernelconcepts.de>,
        Andi Shyti <andi@etezian.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] touchscreen: ad7846: Use octal permissions
Date:   Mon, 23 Jul 2018 18:49:18 +0530
Message-Id: <20180723131954.30739-2-harshitjain6751@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723131954.30739-1-harshitjain6751@gmail.com>
References: <20180723131954.30739-1-harshitjain6751@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);

WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
+static DEVICE_ATTR(pen_down, S_IRUGO, ads7846_pen_down_show, NULL);

Signed-off-by: Harshit Jain <harshitjain6751@gmail.com>
---
 drivers/input/touchscreen/ads7846.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index a2f45aefce08..7c07de0802de 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -431,7 +431,7 @@ name ## _show(struct device *dev, struct device_attribute *attr, char *buf) \
 		return v; \
 	return sprintf(buf, "%u\n", adjust(ts, v)); \
 } \
-static DEVICE_ATTR(name, S_IRUGO, name ## _show, NULL);
+static DEVICE_ATTR(name, 0444, name ## _show, NULL);
 
 
 /* Sysfs conventions report temperatures in millidegrees Celsius.
@@ -561,7 +561,7 @@ static ssize_t ads7846_pen_down_show(struct device *dev,
 	return sprintf(buf, "%u\n", ts->pendown);
 }
 
-static DEVICE_ATTR(pen_down, S_IRUGO, ads7846_pen_down_show, NULL);
+static DEVICE_ATTR(pen_down, 0444, ads7846_pen_down_show, NULL);
 
 static ssize_t ads7846_disable_show(struct device *dev,
 				     struct device_attribute *attr, char *buf)
-- 
2.17.1

