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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA35C65BAE
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C3420851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj+80Ode"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C3420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbeLBUYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:24:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46694 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeLBUYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:24:33 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so10047831wrt.13;
        Sun, 02 Dec 2018 12:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tGbSsIW2SbVXCg2177J/dhUcc17dCh4iHBqaTiJQmZQ=;
        b=gj+80OdebSSVq5nefzz3NW171uHq85/iL3ZzgkH8altvMKjQqGTaQMu4z+nbvSKCPP
         4A5kkAhOzJOf8PYGQmDfVs1PRDVJEne2d965qhxeMJtv3qY7+ItYIkzom6S2qvokP3tR
         wpDr0FIo1k7F7fK7Nm7svwptMgykTa5TeBzpuv2wRsIvzC0xjWZU1LEWp/31yVot3/+T
         t1+rCWJeIQHxYm1izibJAkZpq7l1m74z3v+GoqUVUfwRZsttzeOz5cnbL23PthnFu8HY
         HAKTaV9IKPYgi/OUuzIoyJOGC2CHPq9o+bHh0eNrHWcCl+vvO6uGB2APN1Ig+p7DOLPK
         ZTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tGbSsIW2SbVXCg2177J/dhUcc17dCh4iHBqaTiJQmZQ=;
        b=nDrJn1zdUo5L98W4hdMXvHs8aSyJJZPJXccJ/9YT2GyevJMHahDay0U2ZtU5JY+XMJ
         yR5b3Bh4ex6hJGGO1KVpKG0JhUhLfpQb1NScNUqLkQ1v82yf7Y+C0wKtQJ6LFiqZmi6J
         UKNOqx9w02rsu2vL26tS6wt21HmSulLrgGcS69vtifNcmTSQQaepc2WBWvtWKcAd8qRl
         HxLrPBUJ1XK6mnQaBEvNun2Kjo31CzxEzgzc4BuLHEyaToB3RBlkxhqWXx3omkmBOZiW
         BhEjGlrzyV+kHoyURvoUMImODLbDx1ixhFygyuI8ov1ZNQT/g6rBSjpO/pdgQp6V3SiX
         7EPQ==
X-Gm-Message-State: AA+aEWaTNioH1qCJ+F7wagqdNnqzm1gDG8npzJz4dWTjK0murWFKqDq0
        V5of7F+9amR6QHZsEmTcwZxm69N6hKs=
X-Google-Smtp-Source: AFSGD/UDZGcVXa7xLpVupO30EWsZ/e6ViKVGcMCI0S3Z7YAkyXlUSnC2Lcb246MQfkxU4uJgO+N8cg==
X-Received: by 2002:adf:8421:: with SMTP id 30mr12119622wrf.153.1543782267898;
        Sun, 02 Dec 2018 12:24:27 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 12:24:27 -0800 (PST)
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
Subject: [PATCH v6 10/17] dt-bindings: pinctrl: Add Allwinner suniv F1C100s pinctrl
Date:   Sun,  2 Dec 2018 23:23:44 +0300
Message-Id: <9e222e14e31fd28fd5400d50259f77fc89273f5d.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Allwinner suniv F1C100s SoC's pinctrl.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Patch applied to the pin control tree for v4.21.
---
 Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index 258a464..a7f7133 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -29,6 +29,7 @@ Required properties:
   "allwinner,sun50i-h5-pinctrl"
   "allwinner,sun50i-h6-pinctrl"
   "allwinner,sun50i-h6-r-pinctrl"
+  "allwinner,suniv-f1c100s-pinctrl"
   "nextthing,gr8-pinctrl"
 
 - reg: Should contain the register physical address and length for the
-- 
2.7.4

