Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A123C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C416D2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:06:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="e6HaISH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C416D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeKOJL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:11:27 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40850 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeKOJL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:11:26 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so9951788wrt.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 15:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HHoyYW18XrBqprc0/3V4HAST/9tgyhVfZ5Ann5Gqo0g=;
        b=e6HaISH07czkpDpYe4E0bRrWI84lgpAAZJj50LDvKfp5M/RIhZSvH3YHAthGVtLWHG
         SiCnOXaF5RQ6n7KPqmuG+fs4SNH7FQssEet6MNR76M20adEelfAu6F06+yx/PldgPcLL
         ZrjqejiKRrFDb90RB+A/MLU61LSJcrZKy5CMeqlycnavND1KH3bbuKsK3sVJp9WLn7LG
         IzGFQIe7rQbKsrjUVxFroHmYB/dBEGh1xqzXQp71Orycsj0TxZtqvOaClgHfFjDuhqFc
         1C090q2wKxBMXTi6v1LV2u8pGyu6vK+09lRtQALTy8QFCV9HZi2oD5cYT/AqxpFe9JXt
         TM+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HHoyYW18XrBqprc0/3V4HAST/9tgyhVfZ5Ann5Gqo0g=;
        b=KJ7KHmJwwKY0rmOcFplw8rJ2i3L0PDTA6VCTmajvq/jrg/kAtYGzegPMLiKF+tgWpF
         YCVbAG2/w9bY5rb/2wR4PRDeVxHZMJwF6ahUKSVrtyTQeUj8p0R6qDPwFL2oPwmNEYG8
         8rj2RH1fCGcS0GMhYfZq5DoVh7pBkkwwkqJnPctH4Py3PeN6jkrfk9MfbfatsbYjJbO/
         rHh8VorIX7Zu7/9IvdTwwsxhRcWn4E9btry/cBXbWa9GdQOL1xxmF1wEoeHpmVzjp1lk
         ijrPZSUojJFVyH24R0PPaeUaRGrzUwnAU0cipP0IZ0DAb8iJtq3ee3jJ61fchcy9NNvg
         Uv2Q==
X-Gm-Message-State: AGRZ1gLj+yRRa7rjk1g4Ssf9S9yR3uFp/dl8AfqUu2e5H7PQ4iBYpy+D
        jUtV+ORYt7QiZYIsVZDx14Y=
X-Google-Smtp-Source: AJdET5dQfJva1TWXDiVFWgJw2Na7b71bZNn7dauq4vszaScf+4zl0ht/zZWm1MyNpOFdgcXXHjS1Qg==
X-Received: by 2002:a5d:61c4:: with SMTP id q4mr3552962wrv.308.1542236768114;
        Wed, 14 Nov 2018 15:06:08 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100301AB549B11D5ACB.dip0.t-ipconnect.de. [2003:dc:d717:a100:301a:b549:b11d:5acb])
        by smtp.googlemail.com with ESMTPSA id b129sm4575357wmd.24.2018.11.14.15.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 15:06:07 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] ARM: multi_v7_defconfig: switch CONFIG_PWM_MESON to built-in
Date:   Thu, 15 Nov 2018 00:05:54 +0100
Message-Id: <20181114230554.4968-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Meson8b boards (Odroid-C1, EC-100) use a PWM regulator which is the
voltage supply of the CPU cores (this regulator is typically called
"VCCK").
Now that we are preparing support for CPU frequency scaling on Meson8,
Meson8b and Meson8m2 we should build the pwm-meson driver into the
kernel so we can configure the CPU voltage early in the boot process.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 63af6234c1b6..525316285570 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -928,7 +928,7 @@ CONFIG_PWM_ATMEL_TCB=m
 CONFIG_PWM_BCM2835=y
 CONFIG_PWM_BRCMSTB=m
 CONFIG_PWM_FSL_FTM=m
-CONFIG_PWM_MESON=m
+CONFIG_PWM_MESON=y
 CONFIG_PWM_RCAR=m
 CONFIG_PWM_RENESAS_TPU=y
 CONFIG_PWM_ROCKCHIP=m
-- 
2.19.1

