Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97426C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7702082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Mg+p9GQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B7702082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbeJ3AC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:02:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43771 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeJ3ACz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:02:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id t10-v6so9090049wrn.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IVKNCElcTw4O7+BsXJj7w6a+UoV8WRTsqsukzgsta1A=;
        b=Mg+p9GQ5lAvK9A4y6No9a/ymvvVUBXtA3cpfZVbKj82N5hzU0OQcTMeSs0GhMm3xeE
         mWOHClwKFhq8wNox68iXnxAEJYsJxMFoIfWLY4uwOEnOCejNILnD7gWYxN3kgW5htqCA
         MrOtMDLiO7CJgvgQyOSHSfCbSirCWTbB7N4FVlNS7f8QX05aBunaHsd1efMB8uMkCpyh
         DmmHRaixUP/Dxm4feejY8Amte7gMaO1d6CBZDkb3D5ysQxcfR0zw95cW3ASX4vr3B+2U
         acT099QeBUY+XSF2tQlu6wpz1twyP30XhW+GtcB9xgGJa6MEBHWH/WAjqIFCbmezawJ9
         4NCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IVKNCElcTw4O7+BsXJj7w6a+UoV8WRTsqsukzgsta1A=;
        b=jt7RhiHaR76kliCHuW72CyzF1RuQaSA2x3WQSuOi94lSfNSlTYkA2jt4vdTWt8bMDA
         /2pVOI+0UScwrbVmJ0zhy2R5Vb/naMgG4UeXdAAeeXwPO20ZXtD4IsOZsr18vizM1fYL
         8NR4lH18wTXqBPtMbCGtcd6Bvq7PS3rIZ4K/cwg1VYuh5QHTJzKQ/gyCA0VG4Xe64itZ
         VuYDJncMUpmckUkZj3RhRybEEdLxJ3/ygr8lD+WiQbucsqZLxqNfOcrChjYrJUh55rNW
         tNagO1SmDOYJV2DQqckD49YxyoTAJ9QcpoukyKncKjP7BkVoaL99lZVFKiqFhg+VNcvo
         FQJA==
X-Gm-Message-State: AGRZ1gLf5xi59lz5VYwwaOwxYJJ7o6nRZXe6hUDRjtLu7gaAiqrVchoe
        KL82cHA8w43jGjVPmW9mWNKlpg==
X-Google-Smtp-Source: AJdET5fLzHpcK+2A+4mFLgf+Wm+tfRHGE/RLD6/RtL2yhacmXoHF5pt+cAnexoLfunULXtTSpGKRCA==
X-Received: by 2002:a5d:51cb:: with SMTP id n11-v6mr3931700wrv.121.1540826031334;
        Mon, 29 Oct 2018 08:13:51 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i7-v6sm23045236wmd.41.2018.10.29.08.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 08:13:50 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] pinctrl: meson: fix meson8 ao pull register bits
Date:   Mon, 29 Oct 2018 16:13:39 +0100
Message-Id: <20181029151340.9087-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181029151340.9087-1-jbrunet@baylibre.com>
References: <20181029151340.9087-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AO pull register definition is inverted between pull (up/down) and
pull enable. Fixing this allows to properly apply bias setting
through pinconf

Fixes: 6ac730951104 ("pinctrl: add driver for Amlogic Meson SoCs")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index c6d79315218f..86466173114d 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -1053,7 +1053,7 @@ static struct meson_bank meson8_cbus_banks[] = {
 
 static struct meson_bank meson8_aobus_banks[] = {
 	/*   name    first     last         irq    pullen  pull    dir     out     in  */
-	BANK("AO",   GPIOAO_0, GPIO_TEST_N, 0, 13, 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	BANK("AO",   GPIOAO_0, GPIO_TEST_N, 0, 13, 0, 16,  0,  0,  0,  0,  0, 16,  1,  0),
 };
 
 static struct meson_pinctrl_data meson8_cbus_pinctrl_data = {
-- 
2.17.2

