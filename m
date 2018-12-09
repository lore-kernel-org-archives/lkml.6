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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AD9C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C5720672
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="qigJXV7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C5720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbeLITvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:51:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44257 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbeLITvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:51:08 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so8392216wrt.11;
        Sun, 09 Dec 2018 11:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uWw97g7ElUgJ2je8JI19vSCNfFEnazDluRAzx8g6jHM=;
        b=qigJXV7eykLEw2HNvRSnSafNDXB74tVhzTxsoMna/5OFyTN4EHbbjF69nWhsKLz5H7
         Bl6SLcqokgsLdjP6pm3tlArBxEM0Mh5+XMW8U2R8Jjz86zF7K5f9gr0+mM0mIkSacKZD
         xaeNDnVtGwmKLhRkHnG3SnEX0AU8SrbtxumT16OGjySJxdAafY1+CkMv0k0XARHKRjox
         4sYaesWY2NgENwweK5m//iXkcvYAIsFWEwZ9qAzlqvjTbyPE2WbhRy97/YBA3dkKO2Dn
         vLmX5cequ3KYMDn6l5bjId7bnrrggCwKy46DqP2fU7HHhfMowjYFjnYXKvW+cQ2oGV9x
         4saw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWw97g7ElUgJ2je8JI19vSCNfFEnazDluRAzx8g6jHM=;
        b=RAMyEDGDFtvMKAgW+/ddpiVqPtAMiGAfd3kJuYme9KgifAXH67uZQ7DcdskqhwhN3M
         JShEo9eNRbnX2z6SNntsiKIaK3mJKCkGFB51XB2j0zLOY06Y+k/Bn5jrR/IqDxljStEV
         rRIAzcVrecSVIbHnKRWtfexggOhf9zCgSCyOxpS+3lspgIH1nmtKvI3iNLLP/xE4sNBR
         lpAkUvbxQl6TgrZTkHjRBrWV+eweTBVNsceYddhkpq/JkwuRmCZGA3pGQ5v3fV5KzZZb
         yNWlm9owtOIrq5Sqqtfsoz61qR7+RCrZTJv2Py5qVAiaF3Qtg0UMNrkLEuPhMQ7OuZe9
         2eig==
X-Gm-Message-State: AA+aEWYSQ4vpOg2yluTleSeIx6+TBEHFnTZVtl1duuPXZCzA6x3lfSJi
        7pFfWqozdgP/zzRe7lpf5j8=
X-Google-Smtp-Source: AFSGD/WuNWoIvyybaMiPYlUdNs8S2clBrxB604ziXFmNaZ4F3Fc5rQZqWqB7gs3uAhxj38Z0YZd5OQ==
X-Received: by 2002:a05:6000:10d1:: with SMTP id b17mr7593184wrx.306.1544385066607;
        Sun, 09 Dec 2018 11:51:06 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id x20sm20270941wme.6.2018.12.09.11.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 11:51:06 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jbrunet@baylibre.com, carlo@caione.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 4/6] pinctrl: meson: meson8: rename the "gpio" function to "gpio_periphs"
Date:   Sun,  9 Dec 2018 20:50:53 +0100
Message-Id: <20181209195055.26813-5-martin.blumenstingl@googlemail.com>
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
 drivers/pinctrl/meson/pinctrl-meson8b.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index 91cffc051055..b455e0c7a282 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -622,7 +622,7 @@ static struct meson_pmx_group meson8b_aobus_groups[] = {
 	GROUP(i2s_lr_clk_in,	0,	14),
 };
 
-static const char * const gpio_groups[] = {
+static const char * const gpio_periphs_groups[] = {
 	"GPIOX_0", "GPIOX_1", "GPIOX_2", "GPIOX_3", "GPIOX_4",
 	"GPIOX_5", "GPIOX_6", "GPIOX_7", "GPIOX_8", "GPIOX_9",
 	"GPIOX_10", "GPIOX_11", "GPIOX_16", "GPIOX_17", "GPIOX_18",
@@ -839,7 +839,7 @@ static const char * const tsin_b_groups[] = {
 };
 
 static struct meson_pmx_func meson8b_cbus_functions[] = {
-	FUNCTION(gpio),
+	FUNCTION(gpio_periphs),
 	FUNCTION(sd_a),
 	FUNCTION(sdxc_a),
 	FUNCTION(pcm_a),
-- 
2.19.2

