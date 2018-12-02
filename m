Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1051C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BBF20892
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9iKNK98"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BBF20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbeLBUYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:24:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36542 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeLBUYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:24:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id u3so10053744wrs.3;
        Sun, 02 Dec 2018 12:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PqiSTLwl5WXrDtWtjcIXDjRJSUqIIl0Us7oauuCOk9k=;
        b=e9iKNK98m11pgSa/BPEv8VvGiLNUd1ZlXI9Y3Yo90vq9Fjau0IsbrlkKLAeu0ePix1
         W445CLoeL3/XFiA6y64V21KVljl/vZaMyuiufxyZ8Oo1P5QEfEE1Lfqavavq+2iHOZVG
         KUSvcEX4jqDc5zfzRZnX1zBJs4PTUlkOmSecW/2iMAaMOh7u4s9TaxkqyhJoQ+7w4DGF
         WPSbBnoF2vVg0lOmhWKIO1x/C/AERgYpPQwuF5WG9zrOwCDitJlJ5xGMnbgi+WZMhJ01
         WxlCaKSEXITINCZXxTGGJfU9ofzk1JK5DnTjkUo0JTZouA1PIUKmiS1pEwhYNCktqwkr
         n7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PqiSTLwl5WXrDtWtjcIXDjRJSUqIIl0Us7oauuCOk9k=;
        b=EJ9pIC7kwe/TtkkA4tn7CashcSkuatbFtbhQhH1FGfawlfzN+6dfGF4KJGm8DowGmP
         e0FKNOTZnDQJjzXhoVdsPA2ceRwCKNsTAov72QHPbT/NfIRP38vwun9Fg1qC/dDyp+uU
         p0ySWZVMnrSbrSe/K0eVaYZ+tznxHOCbxE48O/pVDE3I4mwlGOgX/NB51yIdSTc6KOr6
         /OsSHaVutzz/h0VAQn+1DYq1cof2GC3gyDrnYatg2X+Z4YnpmqH4h/YuN/8p8Y0XPA5L
         eP6SwsGz04WRWNR8vLpkeprcfHXUM8Fo65MeWvg+m0cwJfqS3VPeLTcNxmIBZrZ+yHps
         hpUw==
X-Gm-Message-State: AA+aEWbjWK9AUGQXxnzBlsrDsm1MTRffk4cgyc9UaGoNOKHGj0Kb2MsX
        TFNuQ1iuDVhOzpUYSQcjunN4TCrqu3A=
X-Google-Smtp-Source: AFSGD/UqijtIBCI4InCgJ2A+px76jgUgOs52e/O3u9GKyFEmb6OwmrQkEnOqP4xOnrZx74oUzsLkhg==
X-Received: by 2002:adf:891a:: with SMTP id s26mr11571267wrs.44.1543782257366;
        Sun, 02 Dec 2018 12:24:17 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 12:24:16 -0800 (PST)
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
Subject: [PATCH v6 04/17] dt-bindings: interrupt-controller: Add suniv interrupt-controller
Date:   Sun,  2 Dec 2018 23:23:38 +0300
Message-Id: <0d15ef1e424f0f9627b4e278273c7e77239869af.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Alwinner suniv F1C100s SoC interrupt
controller which is stripped version of sun4i

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt   | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
index b290ca1..4043525 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
@@ -2,7 +2,9 @@ Allwinner Sunxi Interrupt Controller
 
 Required properties:
 
-- compatible : should be "allwinner,sun4i-a10-ic"
+- compatible : should be one of the following:
+              "allwinner,sun4i-a10-ic"
+              "allwinner,suniv-f1c100s-ic"
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
-- 
2.7.4

