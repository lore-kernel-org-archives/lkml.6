Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AABC64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8960B20881
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+Qj1ubQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8960B20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbeLBUYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:24:33 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40631 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbeLBUYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:24:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so3646477wmf.5;
        Sun, 02 Dec 2018 12:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X2MJDswe0qbs6RG81mMPQ4p4MRYjzcSOeYYQ8FhXgr8=;
        b=M+Qj1ubQFvaREfl4/OBN9UUta+ly3CdzpG/BcCRSAwkE/jYCGhNwzHaRZFQ/gBQQ46
         j8EGEIa1ktgegY2zOf2IHSNEK85pIFk3tuCM7zGLAlGQEoZzHZDwwpc87Aa7zgCFkzWB
         WmmFhL66zj91hyJsP4/4CTDej1Kwwz6c/i4P4ig9rn8NqDzQXD2DYW0WS53p74hoF9UQ
         oHaMoMZ+sxYXFYrDDJM8uO0MpGbVB+nvHYQY2U6rUGlSB5QwjWLF8TmFjGBCXHNuRF7D
         ahepO74vR3pMwAlcv7tIfUKK79K7pl2ByV08w35uZUCephJz1ltlDgGazoB3a6wCA2yc
         V0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X2MJDswe0qbs6RG81mMPQ4p4MRYjzcSOeYYQ8FhXgr8=;
        b=edOqluz/BUFgqAgJ3byWAw0PT+4Z4nkIqR+AgbOO7xlESuitrTmUIz9a41cCDo/4z8
         cSAi1P0441SDC9XMxi0cOQjwmDZASsEXQK7Nh33bQg9Rp9uzOoHCj6nxF3Gdg64WGEjr
         H4CF+/0mWUbANaUut4ElrrdiBdJJxAQNlehE/f1GvkROrPX5r7lG/UCWZfa54/BLNEJz
         orz9BzZfC/wfgQyzssPrZvmWvEF/DeoO38YH6vmrd12uu5P1gRlrrgc1pDa7g4q8lR1s
         i6/uwZEL3YU74LRsxfZzgxl8xrjXqzsWFoQJmHJunrzlMsAE7Xp9NTd+VkvWdWuNWkxH
         E75w==
X-Gm-Message-State: AA+aEWZZVSguD7LgLrjRK9fpvLbMIx33O83BksCxS7XRg8b2iVm0MyXu
        DyIRCP3a0PKmYNljVQnsgCsPQMRQnLg=
X-Google-Smtp-Source: AFSGD/UqjgLR3cwcry2yhqBeBLwEwmExmps8Kw8/WEGYd9+uBz+JNpuEQuiKyO1AaNIZaWgRWqvvVw==
X-Received: by 2002:a1c:c181:: with SMTP id r123-v6mr6011173wmf.82.1543782266161;
        Sun, 02 Dec 2018 12:24:26 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 12:24:25 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Subject: [PATCH v6 09/17] clocksource: sun4i: add a compatible for suniv
Date:   Sun,  2 Dec 2018 23:23:43 +0300
Message-Id: <2b0e0a33b1e99f0f33d2eebd44de38bae9140bca.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suniv (new F-series) chip has a timer with less functionality than
the A10 timer, e.g. it has only 3 channels.

Add a new compatible for it. As we didn't use the extra channels on A10
either now, the code needn't to be changed.

The suniv chip is based on ARM926EJ-S CPU, thus it has no architecture timer.

Register sun4i_timer as sched_clock on it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/sun4i_timer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index 6e0180a..65f38f6 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -186,7 +186,8 @@ static int __init sun4i_timer_init(struct device_node *node)
 	 */
 	if (of_machine_is_compatible("allwinner,sun4i-a10") ||
 	    of_machine_is_compatible("allwinner,sun5i-a13") ||
-	    of_machine_is_compatible("allwinner,sun5i-a10s"))
+	    of_machine_is_compatible("allwinner,sun5i-a10s") ||
+	    of_machine_is_compatible("allwinner,suniv-f1c100s"))
 		sched_clock_register(sun4i_timer_sched_read, 32,
 				     timer_of_rate(&to));
 
@@ -218,3 +219,5 @@ static int __init sun4i_timer_init(struct device_node *node)
 }
 TIMER_OF_DECLARE(sun4i, "allwinner,sun4i-a10-timer",
 		       sun4i_timer_init);
+TIMER_OF_DECLARE(suniv, "allwinner,suniv-f1c100s-timer",
+		       sun4i_timer_init);
-- 
2.7.4

