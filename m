Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB681C43612
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 19:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DD0621871
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 19:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KTtQ33rq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfAAToa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 14:44:30 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37260 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfAAToa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 14:44:30 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so28703740wrt.4;
        Tue, 01 Jan 2019 11:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EgFPtA56/pi/munJDAyiQosAJuwozyE4DN+t4JD48nY=;
        b=KTtQ33rq1nkZfx1bdDLywWiyhsq+wNwCOVnJefVmcdIFkS7Gep6aM57xgF3pD7kt+6
         BnnOrz+ift5j5NUL5CQ/pkqFqYxGzYyAl01PrIydBXYGqtKHROvY9x8zZlL6LddWSxWg
         d4QFrj1aOV1tzXxM1/ctCUIsNGghaU92nZJdTRKuno+LmYkaXOFLEbdKMVjZT53N8wei
         u3qHz4l3SvwpBXzdgMmnDTePkUAj0PraW4AFtaJvXLK9NnAVJdCzkbH+PeNAiZ1Wu9gT
         y2Nn1RJHrQ0Xolu9h2E7FuGTiYaZYwuPF/D0G2LQiri4D5Cdo+l820rKSPpMFoyY3HEo
         DBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EgFPtA56/pi/munJDAyiQosAJuwozyE4DN+t4JD48nY=;
        b=dNp+v5rfCAscRjr/eTRV8nl/SkE5Sq4dKPxdNCUIt4XnNV5C8exG7Tsmv+UlBbu/aE
         6zBmf/yvRVfi9TDANHLksTkSbzNgXLa/kfBoEiAzXHY+APVJXShfp/aNzarExjRvXLkq
         Z8BlaE0OHMoSe8DD3OIhIrjOP+GJECbfEjQLy/4+CBNUN6cvox0uJmnoFlz7s35BEvPl
         z6YcCg0kpth/ohKhZ6MKBmMZCxzXM1uXXDUP3nGWFSxnbHplNzCnIDRBgK7epn9hSojs
         2jv2+MeS7IJzD/caORYMnQBR/I1A7hSPYhwKQyIlmeB+17IlTVtnaU8RQ4BpK4iig0bN
         FH9g==
X-Gm-Message-State: AJcUukfyy8MomiPs2A953Iiv6ckDHWbbV1N5yrvqTJ5EeGKsD0u8XVrZ
        8L3eh4xVxuJXnvrgh+cEkoI=
X-Google-Smtp-Source: ALg8bN7siEF/o+Fia3jVqdBHmMwwt9X55TVA12QJYTgHiS2e1GnuxWa8MvbLt4fCiXGYqlPoIZJIcQ==
X-Received: by 2002:a05:6000:120a:: with SMTP id e10mr36672882wrx.85.1546371868049;
        Tue, 01 Jan 2019 11:44:28 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD719940081266F57D36520DF.dip0.t-ipconnect.de. [2003:dc:d719:9400:8126:6f57:d365:20df])
        by smtp.googlemail.com with ESMTPSA id l8sm41505654wrr.60.2019.01.01.11.44.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 11:44:27 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     linux@roeck-us.net, bgolaszewski@baylibre.com,
        ulf.hansson@linaro.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/1] mmc: core: don't override the CD GPIO level when "cd-inverted" is set
Date:   Tue,  1 Jan 2019 20:44:14 +0100
Message-Id: <20190101194414.24766-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190101194414.24766-1-martin.blumenstingl@googlemail.com>
References: <20190101194414.24766-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device
tree") gpiolib-of parses the "cd-gpios" property and flips the polarity
if "cd-inverted" is also set. This results in the "cd-inverted" property
being evaluated twice, which effectively makes it a no-op:
- first in drivers/gpio/gpiolib-of.c (of_xlate_and_get_gpiod_flags) when
  setting up the CD GPIO
- then again in drivers/mmc/core/slot-gpio.c (mmc_gpio_get_cd) when
  reading the CD GPIO value at runtime

On boards which are using device-tree with the "cd-inverted" property
being set any inserted card are not detected anymore. This is due to the
MMC core treating the CD GPIO with the wrong polarity.

Disable "override_cd_active_level" for the card detection GPIO which is
parsed using mmc_of_parse. This fixes SD card detection on the boards
which are currently using the "cd-inverted" device-tree property (tested
on Meson8b Odroid-C1 and Meson8b EC-100).

This does not remove the CD GPIO inversion logic from the MMC core
because there's at least one driver (sdhci-pci-core for Intel BayTrail
based boards) which still passes "override_cd_active_level = true" to
mmc_gpiod_request_cd(). Due to lack of hardware for testing this is left
untouched.
In the future the GPIO inversion logic for both, card and read-only
detection can be removed once no driver is using it anymore.

Fixes: 89a5e15bcba87d ("gpio/mmc/of: Respect polarity in the device tree")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/core/host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index f57f5de54206..cf58ccaf22d5 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -234,7 +234,7 @@ int mmc_of_parse(struct mmc_host *host)
 		if (device_property_read_bool(dev, "broken-cd"))
 			host->caps |= MMC_CAP_NEEDS_POLL;
 
-		ret = mmc_gpiod_request_cd(host, "cd", 0, true,
+		ret = mmc_gpiod_request_cd(host, "cd", 0, false,
 					   cd_debounce_delay_ms * 1000,
 					   &cd_gpio_invert);
 		if (!ret)
-- 
2.20.1

