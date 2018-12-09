Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB74C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A28D20672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="pNN+iuMN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A28D20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbeLITvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:51:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38455 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbeLITvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:51:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so8436608wrw.5;
        Sun, 09 Dec 2018 11:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wFi788sDnujp6rjIMSWVzX7d/CUd1EfTK7PJQ6DlBVE=;
        b=pNN+iuMNOu2GOB1n61HDXSZY5o30wgR336KctlRR7IBEm9KIk7RgQQy+N1JA1tp3Je
         n491Fpsf0gDHoK2emBNBiXaQxJC7Es5ZaO2UdQJRb1uxYgiVEKyWb3NUEeQEpxu2BRnQ
         lkj0vifwHHvMsM+ubXthfp0A+V/bwnIeB6WMns9hsEoeMdUk/WvcNrrf5Vz6RQa6xDyZ
         Aq1vqQPaXtzN0Ol6UByovuadN/6FJsBkwfQxvD6FfXYRzKYziTnWpdmianVqqyeXGb55
         4NWNwhAjNqHVj8Vkf8vcPc5S11wdHeSgUTQFtWizCb1SQccoxGBPKxz3S7wUpRQhGgDz
         u/CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wFi788sDnujp6rjIMSWVzX7d/CUd1EfTK7PJQ6DlBVE=;
        b=SlIWSc2B0ny7aiO9pfUMYcjypslrHKb4LDorfgvqL2ZsFaE8rpyKuDogJEX5VKK/B0
         /qhcHqLdhd4nwf2wnidC+pHDhzTysFnSU5crFL0arMOzOm9/7GM3D9/57WqOSZp8cIrY
         raPdt23iP6PVC66HLiHu8HrxfmvlUaq26IV+/L0201TAaJq0u9V3u2N1aXJbxvZF4EsI
         GeCpHxeqaM7xyAeFKT6ZfWfF0nZ1x1RWqNO6nX6gUKuEx1QeTSFdzijZgxcIqUTETFZr
         17qBJEGqSodLdM9Ojhyf9856FXgEzUxHA6QLea/I0Y5qNW4LmOhM90LU5jzEsJzS9Ov6
         XPTw==
X-Gm-Message-State: AA+aEWbGVrsndISxiNHmgXUibdJG1Tk90JyjfjF7ps2Y5PH3j6AfQu0n
        fSEYtCvX0o6U0cDWrcgLVPc=
X-Google-Smtp-Source: AFSGD/WJfnDLpniSUCUz9i+RGP7fLMRstRLLHp+SXM5J6z7ndJQjIwps9yqA54zpmhuaDo0SVTpy+g==
X-Received: by 2002:adf:f189:: with SMTP id h9mr7650610wro.35.1544385065674;
        Sun, 09 Dec 2018 11:51:05 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id x20sm20270941wme.6.2018.12.09.11.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 11:51:05 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jbrunet@baylibre.com, carlo@caione.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/6] pinctrl: meson: meson8: rename the "gpio" function to "gpio_periphs"
Date:   Sun,  9 Dec 2018 20:50:52 +0100
Message-Id: <20181209195055.26813-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
References: <20181209195055.26813-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the existing "gpio" function to "gpio_periphs". This makes it
consistent with the "gpio_aobus" function. Also GXBB and GXL are also
using the "gpio_periphs" naming, so this makes the code here consistent
with other Amlogic pinctrl drivers.

No functional changes since thee "gpio" function is currently not used.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pinctrl/meson/pinctrl-meson8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index e482672e833a..5f4935a81295 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -774,7 +774,7 @@ static struct meson_pmx_group meson8_aobus_groups[] = {
 	GROUP(hdmi_cec_ao,		0,	17),
 };
 
-static const char * const gpio_groups[] = {
+static const char * const gpio_periphs_groups[] = {
 	"GPIOX_0", "GPIOX_1", "GPIOX_2", "GPIOX_3", "GPIOX_4",
 	"GPIOX_5", "GPIOX_6", "GPIOX_7", "GPIOX_8", "GPIOX_9",
 	"GPIOX_10", "GPIOX_11", "GPIOX_12", "GPIOX_13", "GPIOX_14",
@@ -996,7 +996,7 @@ static const char * const hdmi_cec_ao_groups[] = {
 };
 
 static struct meson_pmx_func meson8_cbus_functions[] = {
-	FUNCTION(gpio),
+	FUNCTION(gpio_periphs),
 	FUNCTION(sd_a),
 	FUNCTION(sdxc_a),
 	FUNCTION(pcm_a),
-- 
2.19.2

