Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73854C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D872098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="jp2wgwZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D872098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbeJCOLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:11:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40740 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeJCOLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:11:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id d2-v6so437728wro.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 00:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HWUmP9WIqIx98V4afoeN4S5i7X/mWASZwbDWOFagoHw=;
        b=jp2wgwZ1W4Wb7hADTcwOzfz+mqQ13pcFlis/JhaY440LfLAhIy1VZG0PgiWzw0Ynq6
         MRnQOI5JcKgVkCR1ETuUfk9sZnKFyTEomi2lWaBzHNm8tx0udVsIaM8SbfR2WRdpwgps
         UpMhh3NipTV7LsKNbGh3vOMkDRKyxfyz+x/3gouLtLmXfxLvAy7GLPPJDfa2eTCFJlh8
         AWyMldzzhPaIY8Hq3Z660CY4QtdJFbu8dpBxWNlp0Ssq+tJDTtBIZ/rzUPS3oFR1XjA7
         HeMQ5qJAcYwxJffQqGIMF5q0p5kB7eG5yZ/cwbDgBpHSjEkZv0/tUIxpAshfGl3eAeIi
         tI0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HWUmP9WIqIx98V4afoeN4S5i7X/mWASZwbDWOFagoHw=;
        b=U75DlqButaK0QZLNVK2nYOI+rhrYnGPDgFBq8KcFGSobIyKmwYIup1H9cEbTFbsdDK
         mYErfkfiXUPU7e/DzIUNNzWOJrYwsDEQbawCkBT4Mvo5WOlOV0BOj0Lf4AH15eZ/pZt1
         XBtRnwulodfVzyKoFyF9DM0nWXQvp51eH4om+pFY2YJObeJpZ5dhsf+WfHNiqr9PO1Gw
         754c3KW27mQbjxHSHiLR1yorj5+xvLeJBmU9mo/n2ZJj80fMu818GmMWeqfkDvH8V8cu
         WCODXquiRHQR7ZitaYnGxVoUX5V9X0+M5LJl6fQUCt+jK3ZxSamEYVJxPuirCEA2OGfN
         mSjQ==
X-Gm-Message-State: ABuFfohV//3WZgO3B/ylRm0zEyDNF8MNm7eGRRtG8KIsvkRyvoEUFKMX
        /kIXvugfeRatvnb9Ctx+yX7F5A==
X-Google-Smtp-Source: ACcGV63i5+q9CynCeLabKJKcvTEYXrIvtIf3k3KaLGTBe69X71YNQpJEZdtMs8ZVuk6U/sLRNKn+xQ==
X-Received: by 2002:adf:f88d:: with SMTP id u13-v6mr151622wrp.311.1538551473610;
        Wed, 03 Oct 2018 00:24:33 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:217b:7d7b:52aa:bc53])
        by smtp.gmail.com with ESMTPSA id j9-v6sm412028wrt.32.2018.10.03.00.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 00:24:33 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Greg KH <greg@kroah.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2] nvmem: lpc18xx_eeprom: remove unused variable
Date:   Wed,  3 Oct 2018 09:24:30 +0200
Message-Id: <20181003072430.20966-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Remove a variable that's no longer used from lpc18xx_eeprom_remove().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
v1 -> v2:
- added the Reported-by tag

 drivers/nvmem/lpc18xx_eeprom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
index b42dbaddb419..66cff1e2147a 100644
--- a/drivers/nvmem/lpc18xx_eeprom.c
+++ b/drivers/nvmem/lpc18xx_eeprom.c
@@ -255,7 +255,6 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
 static int lpc18xx_eeprom_remove(struct platform_device *pdev)
 {
 	struct lpc18xx_eeprom_dev *eeprom = platform_get_drvdata(pdev);
-	int ret;
 
 	clk_disable_unprepare(eeprom->clk);
 
-- 
2.19.0

