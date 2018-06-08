Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id th9VOf0nGlsPEQAAmS7hNA
	; Fri, 08 Jun 2018 06:54:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D3B20607DC; Fri,  8 Jun 2018 06:54:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T1VorLAU"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 49C666074D;
	Fri,  8 Jun 2018 06:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 49C666074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbeFHGyp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:54:45 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41305 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751054AbeFHGyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:54:44 -0400
Received: by mail-pl0-f67.google.com with SMTP id az12-v6so7715485plb.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 23:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=HS95F6AmXx6dReOUr/RBhtRv3IaYyjkllBloByxiaTY=;
        b=T1VorLAU19R2I2IF77k1nR4ImZrzkQiMqjiklGBu0bdGw1OTh1Jv5VIT2lUPPs9ijp
         neCo/akjl8EnblEGKC2xr5iGtS/ZrlRAjdhdBYdQ5Z/cdG5SbL48Bg/gUQ9PO+x8T2fR
         2wDJcVHC+ibRXgaFMrtMBylM++D8VfdEDsaNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HS95F6AmXx6dReOUr/RBhtRv3IaYyjkllBloByxiaTY=;
        b=q7FE/A2poBWKQ0IorEqXH9RzTd3IuIlzBtvNvknXya3RrcpRbWDsDdZFAMxvxk2CXA
         dqgR6+Gvdx3onDZomkvoVGx2iUIlChecs7BXQoaFNtOLHwvhg+j3juM+gSz8QY9RMNxo
         i3ePh7yBGU2b4oWeYQOmEZmefH0xRaX1fIq/j/CDvOzKeSV+6TKx7U2C1tIXxRGDTlIG
         lzv0szk+61+73iqQPeQQTgK4b4ee11gDfbAHEJOUN/gZpa6Qi9AgdTbdFcXGCiuKWkTV
         zzF1Un+7xC3pApbzol6uIN5ev8Y4ZS0JcPJKq+ANpOT3hSR7IcNTigjxQsPPkMHVj7Ej
         g0Rg==
X-Gm-Message-State: APt69E0tN0ZBpsdUdlUVlDhpTbFUwxmqAojlgtayJZvn0aYrjhjp7dyQ
        NTnZKDgv6Hyd983inSDAuDU/QQ==
X-Google-Smtp-Source: ADUXVKKXSnhZo2nGSyGcnIMHhGxI2XNzZEo8dgL6qBG0lU4RB66BSEznuwgYJcTeScTl9Vo9DvreEQ==
X-Received: by 2002:a17:902:aa48:: with SMTP id c8-v6mr5301951plr.132.1528440883598;
        Thu, 07 Jun 2018 23:54:43 -0700 (PDT)
Received: from excession.tpe.corp.google.com ([2401:fa00:1:10:3987:9bf6:3352:7574])
        by smtp.gmail.com with ESMTPSA id c27-v6sm63287516pfl.63.2018.06.07.23.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Jun 2018 23:54:43 -0700 (PDT)
From: Louis Collard <louiscollard@chromium.org>
To: linux-integrity@vger.kernel.org
Cc: Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, apronin@chromium.org
Subject: [PATCH] tpm: Add module parameter for hwrng quality.
Date: Fri,  8 Jun 2018 14:54:38 +0800
Message-Id: <20180608065438.110109-1-louiscollard@chromium.org>
X-Mailer: git-send-email 2.13.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is now possible for drivers to easily specify a hwrng quality, however
most do not currently do this, and in cases where they do, it may be
desirable to override the driver-specified value with a user-specified
one. This patch adds a parameter to set or override the hwrng quality.

Signed-off-by: Louis Collard <louiscollard@chromium.org>
---
 drivers/char/tpm/tpm-chip.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 0a62c19937b6..4def49cfc634 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -33,6 +33,11 @@
 DEFINE_IDR(dev_nums_idr);
 static DEFINE_MUTEX(idr_lock);
 
+static short override_rng_quality = -1;
+module_param(override_rng_quality, short, 0644);
+MODULE_PARM_DESC(override_rng_quality,
+		 "tpm-rng quality (overrides values provided by drivers)");
+
 struct class *tpm_class;
 struct class *tpmrm_class;
 dev_t tpm_devt;
@@ -409,6 +414,13 @@ static int tpm_add_hwrng(struct tpm_chip *chip)
 		 "tpm-rng-%d", chip->dev_num);
 	chip->hwrng.name = chip->hwrng_name;
 	chip->hwrng.read = tpm_hwrng_read;
+	if (override_rng_quality > -1) {
+		dev_info(&chip->dev,
+			 "Overriding hwrng quality for %s: driver default=%d, override=%d",
+			 chip->hwrng.name, chip->hwrng.quality,
+			 override_rng_quality);
+		chip->hwrng.quality = override_rng_quality;
+	}
 	return hwrng_register(&chip->hwrng);
 }
 
-- 
2.13.5
