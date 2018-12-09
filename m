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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453A5C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0527120672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="nKb6wfX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0527120672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbeLITvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:51:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35311 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbeLITvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:51:10 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so8448656wrb.2;
        Sun, 09 Dec 2018 11:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=urCU7YQjDTJrG7L2Euwj/N64dJUSTa6MEsTdrSmy+1E=;
        b=nKb6wfX/rw5GoEOT0rpZUQ/Lbm5/f+gtcYsGQ8oKTEAAdvv+KRMIy6wLViagKYuiiJ
         6aGvbYWt8b3UaDw6TZnsrpCg6o4aRQZNCXi7vlFInG72DPaXaoLlG9nmvLopf6FT10Xo
         PJGK4/3xFUJzDDZcI7IRGwns+29o8HFNdojMh1ckJ+rQ5Hg0Oy5SRdRm3clsWJ7+hqdo
         uuAOEs31cKHP+0wLksEHZqwbQYumM4VF2/VU2T6gZ5YWlQr6uAqFosNi6LSIrYTgpvZ6
         oZpoXYX0F+BI72w2c5lJoYl9QGscssE4Mf2vR39eicvQy1vYXZ6lBJo4XcxAUWPUUe8R
         rNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=urCU7YQjDTJrG7L2Euwj/N64dJUSTa6MEsTdrSmy+1E=;
        b=M+Z7T1nW2i00e0nDq3+lseagkN/Rn6U1WoAOgwG3vc5gGryAo/30cf0eln5yubfkPH
         Avvztt/BEK+nrzDoORXjNsF8Yq/1/j18M59WFkobVcoKlMBWuJyzqVwSlaYJYRkQ34Uv
         E/VDX3YXP87yJCnEF+XWaUThEPENQIWXPIqneNZJy6d1ZDXBv/vqJbNofNs89gFTUmAJ
         SqUFDMZHwJ92cq+KaH3Knu+0QyjC2I6imnuGQjmkECmF/IPGdNk6d3sqfNSJGT9xZM9J
         Pkg3kHUHBJSNL9hJBzJv0Mj0RJWW7+1QoYngDewjtCuQkDMn2+JBLIyuhai6s9JNNz5U
         HF8A==
X-Gm-Message-State: AA+aEWZ5MY8vpN2XPDuHFu/J/Oz9jDJwhilwusmR1F5N5xD7ik/D0r6C
        y3AzSd2Se8SHZMoxKyWsgWE=
X-Google-Smtp-Source: AFSGD/Ucthwo9Mxtp42S1MnvflXgUPHtWaXWEFRfExBiGs+jzi2+kbxRlXUhB7s3Bki3zzDlkCj5mQ==
X-Received: by 2002:adf:f350:: with SMTP id e16mr7334928wrp.125.1544385068479;
        Sun, 09 Dec 2018 11:51:08 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id x20sm20270941wme.6.2018.12.09.11.51.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 11:51:07 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jbrunet@baylibre.com, carlo@caione.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 6/6] pinctrl: meson: meson8b: add the missing GPIO_GROUPs for BOOT and CARD
Date:   Sun,  9 Dec 2018 20:50:55 +0100
Message-Id: <20181209195055.26813-7-martin.blumenstingl@googlemail.com>
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

Fixes: 0fefcb6876d0d6 ("pinctrl: Add support for Meson8b")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pinctrl/meson/pinctrl-meson8b.c | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index b455e0c7a282..c69ca95b1ad5 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -403,6 +403,34 @@ static struct meson_pmx_group meson8b_cbus_groups[] = {
 	GPIO_GROUP(GPIOH_8),
 	GPIO_GROUP(GPIOH_9),
 
+	GPIO_GROUP(CARD_0),
+	GPIO_GROUP(CARD_1),
+	GPIO_GROUP(CARD_2),
+	GPIO_GROUP(CARD_3),
+	GPIO_GROUP(CARD_4),
+	GPIO_GROUP(CARD_5),
+	GPIO_GROUP(CARD_6),
+
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
+
 	GPIO_GROUP(DIF_0_P),
 	GPIO_GROUP(DIF_0_N),
 	GPIO_GROUP(DIF_1_P),
-- 
2.19.2

