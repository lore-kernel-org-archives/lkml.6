Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84C1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBFC20815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo2E4Lbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABBFC20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbeKSAjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:39:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41209 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbeKSAjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:39:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so645790wrs.8;
        Sun, 18 Nov 2018 06:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Xu7tw3hMoHQOvn1iK3m+Q2vz8pwKTqStprFDM6Xgq1g=;
        b=Yo2E4LbrQyhK97AQI7z5/bqdXWwiPK5qHe6RWcvCWl6Kw9cQEk+7zZSPKHsbjGbUsk
         /pJSj67BUi5AAzWP8I/l4VOdm+0uEBV2SWvvdbn1ImqjERj7GqnZkGCQ4XWirgvJaNlE
         4XDtN9zbpZHJawKM4iMOTzBEroK7vlmVMlOMwUoUL7n1SSXi+gxoXUeiyU1hEsN8mABG
         bfTreFAAx1WcwqNkRUxR5sQqTOekdzy4PHyY8oOBpiYozq9Chhpb2gpu7MKZHImd4HkA
         v7Mteh6eC4GvvwtuHGZsFdRKFoHBCtlA4nXpZH/HkE267Wn3C7WKMZ+wQS+uBS46F4sN
         l2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Xu7tw3hMoHQOvn1iK3m+Q2vz8pwKTqStprFDM6Xgq1g=;
        b=Xf6VuROdAqQF/KVQnEkUX57EHHA23SygRP7xZjlsE5DjJQA15S+7a66obOEwdpvXNc
         y3xdqrzNibQkYgGn0rrCNHq3wGGgzmPLO6dqwY0eXiawgrqu67kygp7CE07VZy6xltAK
         GbvIvma0zv7elmBOGGZRZzfs06K3HGv0chwudX6QN2uDWGVb7CF+WJtL0vdurY5cbSiO
         PfFLOLmF/nmzkp+c0rq9O+vamDj/RO+P+h4h89IXygbIbX05Qz0RFgdFx0NvZebeNtvn
         7bgd+H9q9g2I3J2Z9LriyzpGRwmEnJ1fPmCXZKbwNgYt81VfKsTAON/gfU0xEp2wOEZQ
         2IAw==
X-Gm-Message-State: AGRZ1gLWxP+hPfO7hUejo4nB+E2oByz9mFC1qgq+bFZFkTjXGemchRyW
        ZJBtox+6aWnUB1nT9y0JcqQ2oKtaCxk=
X-Google-Smtp-Source: AJdET5drRZyaoUj+oRtrwP5TlR566/kACuA+hKmYzMciamLXhomsM1i8qzYhAGUwTm6FUUDMixDzSA==
X-Received: by 2002:a5d:4cc6:: with SMTP id c6-v6mr14832444wrt.75.1542550713632;
        Sun, 18 Nov 2018 06:18:33 -0800 (PST)
Received: from ThinkPad.home ([185.219.176.209])
        by smtp.gmail.com with ESMTPSA id d4sm29814412wrp.89.2018.11.18.06.18.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 06:18:33 -0800 (PST)
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
Subject: [RFC PATCH v2 09/14] dt-bindings: pinctrl: Add Allwinner suniv F1C100s pinctrl
Date:   Sun, 18 Nov 2018 17:17:08 +0300
Message-Id: <d54a4f7e2f33742145394bc2d8c3afb4013b860d.1542546735.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Allwinner suniv F1C100s SoC's pinctrl.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index 258a464..5086734 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -7,6 +7,7 @@ the pins includes drive strength and pull-up.
 
 Required properties:
 - compatible: Should be one of the following (depending on your SoC):
+  "allwinner,suniv-f1c100s-pinctrl"
   "allwinner,sun4i-a10-pinctrl"
   "allwinner,sun5i-a10s-pinctrl"
   "allwinner,sun5i-a13-pinctrl"
-- 
2.7.4

