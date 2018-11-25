Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB3FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6672086B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2M7PJc4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6672086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbeKYSee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 13:34:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40196 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbeKYSed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 13:34:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so15217830wmf.5;
        Sat, 24 Nov 2018 23:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wFnlC7wXTWrqm8vWa+YQRXI7dnBYYtKJEY72/FfFZuA=;
        b=f2M7PJc4ycTbSA/XvpwKS8rPIpNGIkM5JesM0vt9Vs2UKWhs8gh9MAewrz4Z0erTST
         m+RQoya+pL0aFmByqAnRViSII7JAy2KRXdrm4XSt2CuM6Kz5Jcri8ukjauyKDNYT7DZy
         gHl9JW4i/nDuXBSdkdqn9qj1aKFDKEkhqmTwnfvwIGIPixgvW2Gtw39GyTjHIOmVS5OD
         JpTn2abslxWTGBGltCPVlYUksibJ9a9jm9aQkdADc5T9soxWNHShrGrgD+pH/RXuXOvI
         4RwPRbdrj94bSxRzx/AdjgUB01wDF0iu5PL6ULJa+rR5XfFFoxe6GeXMiP75a2C1/sGI
         KpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wFnlC7wXTWrqm8vWa+YQRXI7dnBYYtKJEY72/FfFZuA=;
        b=tQRLZIYNUW0MH/R4OtMybpmugDJpCzLsLZnJEry3THSfb3F3DDIsA34G3lY5tbI2jP
         Lt6rsnn1+kLYav7flMH/5i+MKfoBiW6+AXKDlL7zencMMbP5TcTUaxS62SaARfjyOKSz
         0a16oBVlG39xTnZ/ozkAU4TXJxwK8g5RG5mRODAWIORUNFsyxoIH97T0Yr9C/bNopWxe
         ho1QWuznHlSI2h4lG97LA2RxAKKQBgLEuwCy70k/4t99Or2qxqWR2YrIUBTl3mdAlxPG
         lqAbgkHDxvuIXwUUuevKfHtgnzhkR0z00YQsD1SvZsuWK4MMJHCus3V6Uia4wm/WF7d5
         amJg==
X-Gm-Message-State: AA+aEWZ2ezMxEbC9KfdiLKd4oHE4P1Ag+XaPshP2Cr/s+CiUg39CsXsA
        J2u2jsqJmbqdvIVG3MzrdgRZB+sXDOc=
X-Google-Smtp-Source: AJdET5ept4Ht5Y3BlH3cA9TaH+BzzA/QHLUggIJ0JtSqn03dsbMm16EkyrhtxncupMuLPltOFRQFJA==
X-Received: by 2002:a1c:9855:: with SMTP id a82mr18493908wme.20.1543131843818;
        Sat, 24 Nov 2018 23:44:03 -0800 (PST)
Received: from localhost.localdomain ([185.219.177.224])
        by smtp.gmail.com with ESMTPSA id 6-v6sm12296780wmg.19.2018.11.24.23.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Nov 2018 23:44:03 -0800 (PST)
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
Subject: [RFC PATCH v4 10/17] dt-bindings: pinctrl: Add Allwinner suniv F1C100s pinctrl
Date:   Sun, 25 Nov 2018 10:43:13 +0300
Message-Id: <ac8d900789e967650e0ab16eeadc04ec456fcf34.1543131714.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Allwinner suniv F1C100s SoC's pinctrl.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
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

