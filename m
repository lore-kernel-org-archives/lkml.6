Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45857C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CB620672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rjV46Cuo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CB620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbeLITvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:51:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40878 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeLITvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:51:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so8415739wrt.7;
        Sun, 09 Dec 2018 11:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=73UkkgA13PS5wgqSSg53HYdLX82FskY2VGqT47R/Ls8=;
        b=rjV46CuohTjDWjmOlylN0PPJ4QoyI0TphLd0mYyVgxiOk9CkdZiCuDJ9WkXfmZhcA0
         dgiI0INUsNYU5oxmi25WlwEXpLerXMXzJpqMIbhUK+RhP/1K5vkw7Navj7iUYJgB3Npy
         EkQso7Xf5kogTb0IPOI2m4e8uylsv/UQ1i9LDFCT/haTRJedKi9CBA+A++IqAy5b4B74
         hrXDcqu5GLugag4xXcNfO3fT/voKaCpH/m0OuuFy2fANcMOsGxuVMHeE0lZAb7Xc3Et8
         Lb2FY3DF4+FfRA6lis0ek4RncEVv8tECgzwuUmtfM0wXGhUryeKF9UGByRvp0ZDN1tYv
         QfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=73UkkgA13PS5wgqSSg53HYdLX82FskY2VGqT47R/Ls8=;
        b=aaTBSQJtKu6APCEhaqY/y7l2MV8+4xRgCbl84/NOG3uVtjIV7/yKW1xYnEZmEATmEu
         qP+y5cqMPd663hXeWkLTk7CYS2dEsqPVovHRieAkRpeUB0ez7dJSWMFvLW0VSE8ylBJ/
         /XTOiPx67nADjxiCDS0lJ5QhJJbgx3t4pLGd2bNz4kCDRVxaFEn6iPHlxq4OhJfbtvbp
         aTlmjqRpUglbMrWLxtVkFVh0qoGWeHRl6CUjhp65vdc4yZ15/kG3cqBmpXWnQkqkFKRB
         GJMhPMxu56qpECsa8NeQ17pG68F5FsMHUWgO/71lKqrc2/jmSOEzcXULogbfaQlDfhz3
         PggQ==
X-Gm-Message-State: AA+aEWaDZCZlu4mZ9lIwlnS9rw2s3m2CO9IjeerbOt0sfH+9o5cxmLlN
        RENgeJCHuXiSInjGYEGVp8M=
X-Google-Smtp-Source: AFSGD/WpDg8nYCDo+bcLfGzSW/+YQAqSKzR/ZupWv1uc5LyOCMp9VZZPsHKhN5JdEYkipi3BwpSeug==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr154720wrw.311.1544385067544;
        Sun, 09 Dec 2018 11:51:07 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id x20sm20270941wme.6.2018.12.09.11.51.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 11:51:07 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jbrunet@baylibre.com, carlo@caione.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 5/6] pinctrl: meson: meson8: add the missing GPIO_GROUPs for BOOT and CARD
Date:   Sun,  9 Dec 2018 20:50:54 +0100
Message-Id: <20181209195055.26813-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
References: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the BOOT and CARD pins as GROUP_GROUPs as well so they can be
configured in devicetree using groups = BOOTx or groups = CARDx. This
makes the behavior consistent with other pins inside the same driver as
well as with the BOOT and CARD pins of the GXBB and GXL pinctrl drivers.

Fixes: 6ac730951104a4 ("pinctrl: add driver for Amlogic Meson SoCs")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pinctrl/meson/pinctrl-meson8.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index 5f4935a81295..785e29e74a56 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -506,6 +506,32 @@ static struct meson_pmx_group meson8_cbus_groups[] = {
 	GPIO_GROUP(GPIOZ_12),
 	GPIO_GROUP(GPIOZ_13),
 	GPIO_GROUP(GPIOZ_14),
+	GPIO_GROUP(CARD_0),
+	GPIO_GROUP(CARD_1),
+	GPIO_GROUP(CARD_2),
+	GPIO_GROUP(CARD_3),
+	GPIO_GROUP(CARD_4),
+	GPIO_GROUP(CARD_5),
+	GPIO_GROUP(CARD_6),
+	GPIO_GROUP(BOOT_0),
+	GPIO_GROUP(BOOT_1),
+	GPIO_GROUP(BOOT_2),
+	GPIO_GROUP(BOOT_3),
+	GPIO_GROUP(BOOT_4),
+	GPIO_GROUP(BOOT_5),
+	GPIO_GROUP(BOOT_6),
+	GPIO_GROUP(BOOT_7),
+	GPIO_GROUP(BOOT_8),
+	GPIO_GROUP(BOOT_9),
+	GPIO_GROUP(BOOT_10),
+	GPIO_GROUP(BOOT_11),
+	GPIO_GROUP(BOOT_12),
+	GPIO_GROUP(BOOT_13),
+	GPIO_GROUP(BOOT_14),
+	GPIO_GROUP(BOOT_15),
+	GPIO_GROUP(BOOT_16),
+	GPIO_GROUP(BOOT_17),
+	GPIO_GROUP(BOOT_18),
 
 	/* bank X */
 	GROUP(sd_d0_a,		8,	5),
-- 
2.19.2

