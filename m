Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C15C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277542082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:13:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NeyZUXmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277542082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeJ3ACy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:02:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37073 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeJ3ACx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:02:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id p2-v6so8304199wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 08:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0VhoeL3UY49i/r3Uv5WwXcxN1BcTVCznhsZ8wfU4g58=;
        b=NeyZUXmZYPFiamyJy6Mextlt3eCUJIYenp2CHMQKIgEXft/niJoHz9VXJJdo45FonJ
         aQriVAdzwbwyq9mC017f8lD1+7DB3rjeiqvzefsxWjhGXz2sMde4SjxciB5S0vOwdA7l
         Oq90rjuVlHSWrkxOC7sXyRJMZvsBBGMxxuVrvn2/S/QLPlu0Ud89PeBQy6oex4pYLbwI
         P9IqSsZw2Wd1CZUnPj4HRwoh9ZJiWpED39k/PnTbH/a90NsMovjtFm0xmE7LoPiM1+Al
         W4jDyOrVlQhyM2rTx3PHV9CaukjE7pTlqBdnAwPwIH5rt96T+1c/39cOKODfQyIxUZ+b
         cVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0VhoeL3UY49i/r3Uv5WwXcxN1BcTVCznhsZ8wfU4g58=;
        b=H2lyKbquuGTSDHGJJvBqOpawhWCU+MAV41gUnBZEjGtYI0BZsz4fVhLASm3i/NNC0N
         DO0mrlvC54tzSjbDsdAqQ2lEAIVhg8W09+gR1bLhqhkoCQxT7D0qgx3Kdy7UGGQgOH6I
         lvQFV7GYzRyJTL2noc+qq3Ib98QU/g6MB5mbHUuusTc8iQD2/+IL3GHX73tXMAK6wsjc
         ggAPUTXWvq6g4HZcIqOIklY06gNAIZa9VO9HF3Xo0iLxKgSwqaX0uU4qSRGYq7ASfCJf
         fgORDScvF12XY5HGwcsBLIBq11TKdAGwENkuxT3v/1yhnnxKHPBamxDhXrwDG86GSczR
         jqag==
X-Gm-Message-State: AGRZ1gIW02/177EIzvgsfXjgrJDIv+1B7ent5zjsiF5X+eMs6u1k9C/q
        j4ae/XhR3HUs82x0To6HGo4T2Q==
X-Google-Smtp-Source: AJdET5cwELqT9reYQwEgf0ThUPiFZrEp5casMhPyLDohV6RBhutmn5tcLMdUSQ4+jU8EZRKvJl2KZw==
X-Received: by 2002:a1c:f514:: with SMTP id t20-v6mr14245688wmh.129.1540826029381;
        Mon, 29 Oct 2018 08:13:49 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i7-v6sm23045236wmd.41.2018.10.29.08.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 08:13:48 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] pinctrl: meson: fix gxbb ao pull register bits
Date:   Mon, 29 Oct 2018 16:13:37 +0100
Message-Id: <20181029151340.9087-2-jbrunet@baylibre.com>
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

Fixes: 468c234f9ed7 ("pinctrl: amlogic: Add support for Amlogic Meson GXBB SoC")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson-gxbb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
index 4ceb06f8a33c..4edeb4cae72a 100644
--- a/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
+++ b/drivers/pinctrl/meson/pinctrl-meson-gxbb.c
@@ -830,7 +830,7 @@ static struct meson_bank meson_gxbb_periphs_banks[] = {
 
 static struct meson_bank meson_gxbb_aobus_banks[] = {
 	/*   name    first      last       irq    pullen  pull    dir     out     in  */
-	BANK("AO",   GPIOAO_0,  GPIOAO_13, 0, 13, 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	BANK("AO",   GPIOAO_0,  GPIOAO_13, 0, 13, 0,  16, 0, 0,   0,  0,  0, 16,  1,  0),
 };
 
 static struct meson_pinctrl_data meson_gxbb_periphs_pinctrl_data = {
-- 
2.17.2

