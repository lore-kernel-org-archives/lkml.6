Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DBBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41A32145D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGvis8fD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C41A32145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbeK2Jho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:37:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40473 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeK2Jhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:37:40 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so264559wmf.5;
        Wed, 28 Nov 2018 14:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tGbSsIW2SbVXCg2177J/dhUcc17dCh4iHBqaTiJQmZQ=;
        b=cGvis8fDxAbAt3KFa+a/4Uie3rZpW9hHPNT4zMUvBoo6EZIVv/hqv+4fYXDhM7Uzj2
         IhmpDj3sJAYzfKm3ivnH9jT1GfmEd5KzmTkcLE8GAD9Bp5Fhb7Qos70EhTQqCi6JklJD
         jSjFuVmXrNqSxLPzy6UTts0Uow0Kdq9WK0Pf7NfrfS7gweo3gN2cX6XJgeYWyANiRJ9s
         5RPvXH/GhHAFjIU3mPykp+FToXvTqvuaayP3RzbnO8otZ4Jwt9ZthrqgS1cp/3ZMMjSL
         h13mrJ8etx1vTxfdsIhPUIo/YzgRHaFbSMviLcR7MvSap30Lp3Q6pENxuzBJq3E+1/O2
         Vemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tGbSsIW2SbVXCg2177J/dhUcc17dCh4iHBqaTiJQmZQ=;
        b=Sq0MG36FmnLupk0uonoe67KEKdrJRfxyjX5ZFCpdtfZLFXR+q0eCDxAWy4SdqlMJh/
         isyfNxqMU4A0DvtI8y2C5omNSgaWP3pXShBdmQkF7a3EmH4MJbZZ+6158zbzxHGb68Lt
         DrqXp2MCCa0IMxRO/0KdZ9+t9Fou6nasYRpF/AyQHIWEq8XKqBfvgJJ0DcW5qdJLDV3r
         kFPhedtFDkbBL+ki5dmMk2flxogMmByn5ZfZKuHTBEmhtgdjmWb0QEKY9GN4pH1oTwrB
         9LMntpSxHq99VRSpWRk+PaRz3fCKxvQlgQDMmF33UwMvwoPKUyW03zw/t7L0OBs2HFfw
         SLjA==
X-Gm-Message-State: AA+aEWY+m0RMRzURyT5IlYlVMsVX3td9X/a/TEvvERYoSUPuhMIU4XGo
        TNNVhEFGMxtmiqjhbb4ez1HiugSfUFg=
X-Google-Smtp-Source: AFSGD/XmmlqO4qc1nMTi1xlMTzAbqnXH/5ls0HCU1IKQSJVyQBcFlhqzGfUn5KVf7nKuiVvJl+NLjw==
X-Received: by 2002:a1c:f916:: with SMTP id x22mr4555902wmh.87.1543444468456;
        Wed, 28 Nov 2018 14:34:28 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.239])
        by smtp.gmail.com with ESMTPSA id g198sm180244wmd.23.2018.11.28.14.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:34:27 -0800 (PST)
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
Subject: [PATCH v5 10/17] dt-bindings: pinctrl: Add Allwinner suniv F1C100s pinctrl
Date:   Thu, 29 Nov 2018 01:33:20 +0300
Message-Id: <68a5d5576c5ad16a57c1ab884c5c3044c06f6da0.1543443475.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543443475.git.mesihkilinc@gmail.com>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
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

