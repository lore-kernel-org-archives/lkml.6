Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2297C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEFB720660
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BAHt31rl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfANJ6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:58:00 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41793 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbfANJ57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:57:59 -0500
Received: by mail-lf1-f67.google.com with SMTP id c16so15101609lfj.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 01:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=TZeGN3rlRP+BY2QvEk3qQEzkoTkwqoKfmJP5E6E9R+U=;
        b=BAHt31rlG9ugX7GNkSQ9IQMxQXOCNsAl+g2MFZgDG1d35EKxagIDsIaPKF3jB2BQ9F
         BQIh1bzTmWWLRSQZXu7H6fBgtTuNOERB7JS2MqG5JxBUAl+ga/gL72fwDFy7/lm+Trk0
         RtMlLl/ZdNGx7FtNfiKbRQRaT4LQrOh4QRIqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TZeGN3rlRP+BY2QvEk3qQEzkoTkwqoKfmJP5E6E9R+U=;
        b=G7pOv+ccTuQ9o0hvMJQ27UZvnCYgRpmMsn+ToDH3DoW7bWfL4YSrzyJ2nvtsX74gDf
         pKAE9ROixxbZcZuJ8UXVfmntzn6VybeKn3ESDnowmnKV7Jy1TXTSTNEjjAHoCaC4el4b
         MHYfn43Tiw9xtQwE4L8KwAL18ctcDBtW/vxRbIxSpyc1Hkuf9U0HDW0/LjlV+T8ksfsX
         ieC2YzDsVQqTXNZl1mcfTVSlbn+ZMZ07GxyWusUrbrr4iZ0Mko4DLFGIUijeTQ/IqF5u
         GBrWcKgSWgHtDNa4m2XsSxE2U/0gHgVYCsf5xPviggmCrXxpKxrvh8ILF4KRl76vs7tG
         JYOw==
X-Gm-Message-State: AJcUukfR6Vo4xbFBo0psnEmi/hL41SqRj/lgF8ssfqhRfmCIsIv6+jsN
        nfXUIyX5ZzpyDQyiK9ZsGXpsWg==
X-Google-Smtp-Source: ALg8bN4CuKicsbu2IVtGrvUr+ISks7OeB2qmc+DMq6H9Dt1jTVYyN84SqAB7x0/EVF5NVmKsvca7CQ==
X-Received: by 2002:a19:ee08:: with SMTP id g8mr13283753lfb.72.1547459877456;
        Mon, 14 Jan 2019 01:57:57 -0800 (PST)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id u12-v6sm17389497ljk.79.2019.01.14.01.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 01:57:56 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH 3/3] input: touchscreen: fix link error
Date:   Mon, 14 Jan 2019 10:57:54 +0100
Message-Id: <20190114095754.23175-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix link error when TOUCHSCREEN_RASPBERRYPI_FW is enabled as a module
and the dependent module is built-in.
The 'depends on RASPBERRYPI_FIRMWARE' by itself prevents the touchscreen
driver from being built-in when the firmware is configured as a module.
However, the '|| COMPILE_TEST' still allows it unless we explicitly
prevent that configuration with '|| (RASPBERRYPI_FIRMWARE=n &&
COMPILE_TEST)'

ld: drivers/input/touchscreen/raspberrypi-ts.o: in function `rpi_ts_probe':
raspberrypi-ts.c:(.text+0x3a8): undefined reference to `rpi_firmware_get'
ld: raspberrypi-ts.c:(.text+0x3a8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `rpi_firmware_get'
ld: raspberrypi-ts.c:(.text+0x4c8): undefined reference to `rpi_firmware_property'
ld: raspberrypi-ts.c:(.text+0x4c8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `rpi_firmware_property'

Rework so that TOUCHSCREEN_RASPBERRYPI_FW depends on
RASPBERRYPI_FIRMWARE=n if COMPILE_TEST is enabled.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 drivers/input/touchscreen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index af6027cc7bbf..068dbbc610fc 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -698,7 +698,7 @@ config TOUCHSCREEN_EDT_FT5X06
 
 config TOUCHSCREEN_RASPBERRYPI_FW
 	tristate "Raspberry Pi's firmware base touch screen support"
-	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST
+	depends on RASPBERRYPI_FIRMWARE || (RASPBERRYPI_FIRMWARE=n && COMPILE_TEST)
 	help
 	  Say Y here if you have the official Raspberry Pi 7 inch screen on
 	  your system.
-- 
2.19.2

