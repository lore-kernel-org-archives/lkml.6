Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A260ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5188D2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2Kl2Bn9N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5188D2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJ3ACz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:02:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32970 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbeJ3ACy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:02:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id u1-v6so9138584wrn.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HfflCg4Qw2FH+NwxmZyMZZXnm57vofYP5WlUFbknjj8=;
        b=2Kl2Bn9NujwQpKNbw7DfIxMlvbMG9fBRtqSZnbdrT7BoE5yn7yTzJeUZKQsuTJ4/2s
         QUPluiVND7IxBWEw4NP7PGTvzx+WoKjSJg44tN4sKuXi92v/5H/89j1S3I+vbyF/EGwO
         LwGVXpbij2HCrkuxJNviNjJdWRaBLDAzwfV28XHyh35qDXErbR14NQmGBcZEqLYT0/BH
         cVmidWDQScn6wKoIGqWJ+LEoOHF8Ir/AsTXld8H+EHOIKbsd7mAQnDxAJCWN81roTKCT
         PegaAvfPceoTQuRrEUAB7s0Si/koM4igUln6zx9XdLtJ1UuFpBUdOsu82rTscGnyJHGe
         x0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HfflCg4Qw2FH+NwxmZyMZZXnm57vofYP5WlUFbknjj8=;
        b=P0Lvody1bEK9Vvd3FT52s0rVquDVxkoBgW08j6d8nMIFN607yZEDdJXqKg7Ma76z5A
         DUcfV1WFbLUNgS7I/Qox9apV4fvg71BHDKiY7muAYgjEZ4JMmxFeVujaA2Q8fIeJZjmM
         3Lw2B6OJfJ5x5BJ+j/75MpxgcXJwUp4HUsJYJatVYQLK+v3oDOSG8v6w04PJlWgzTlWt
         FAEE7E1dkLTZnzcJci6zjhdFZL/bjQN6Fd332CYukp8OrgtRPrYzaJQhxZ3YqJYsncwl
         tZonSUAdwZ7AJgWrN+FW/M/iDTWslMJU3ipqmHwx5WG8BTCowUCkG39CXOqm/2pYvxRp
         GR6Q==
X-Gm-Message-State: AGRZ1gJZG/ISdtimE2wMx+jUn2zTznZuBQCaZFf+DMA2SlYPTWVKQTIo
        d0Q0pvE966MQ9yJHfTzF/g2cEA==
X-Google-Smtp-Source: AJdET5dRVW71Oicyk68QJm76/Y+3LIrPu5i2N5R6LgMN/PsGcUMPWi0ZP0hhQsMKHPu/rqboItgEGg==
X-Received: by 2002:adf:92e6:: with SMTP id 93-v6mr15731892wrn.124.1540826030373;
        Mon, 29 Oct 2018 08:13:50 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i7-v6sm23045236wmd.41.2018.10.29.08.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 08:13:49 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] pinctrl: meson: fix gxl ao pull register bits
Date:   Mon, 29 Oct 2018 16:13:38 +0100
Message-Id: <20181029151340.9087-3-jbrunet@baylibre.com>
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

Fixes: 0f15f500ff2c ("pinctrl: meson: Add GXL pinctrl definitions")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxl.c b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
index 7dae1d7bf6b0..158f618f1695 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxl.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxl.c
@@ -807,7 +807,7 @@ static struct meson_bank meson_gxl_periphs_banks[] = {
 
 static struct meson_bank meson_gxl_aobus_banks[] = {
 	/*   name    first      last      irq	pullen  pull    dir     out     in  */
-	BANK("AO",   GPIOAO_0,  GPIOAO_9, 0, 9, 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	BANK("AO",   GPIOAO_0,  GPIOAO_9, 0, 9, 0,  16, 0, 0,   0,  0,  0, 16,  1,  0),
 };
 
 static struct meson_pinctrl_data meson_gxl_periphs_pinctrl_data = {
-- 
2.17.2

