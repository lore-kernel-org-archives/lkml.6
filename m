Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C25C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D3320863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:22:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/QhhZrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfBKJVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:21:50 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54168 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfBKJVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:21:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id d15so16212430wmb.3;
        Mon, 11 Feb 2019 01:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JOM18/2JI/XRqmtoCiSEfwWrBMkMvuRt2TRd7mJVRjI=;
        b=d/QhhZrYnhRw+rD/kN8Q0NSqsLHYO8JFZqmcqCz+MvyTEk5ClAjLS2Bjm9gU999leo
         TEky8slQIZbooNvaAti2WY+VvjNmcPmyqkNYwMkaqrkCn82uzjbawATJBWBarIX42bk4
         OIbnjGzy6tf6A3KacgEAlv3ZvJb0tsEc65exBXUHBzRf/bAO/aAGw1awltrOGX+ENudR
         5aIh3OFMeTRDugdblEwdpMF7xwryeKlT2wP50q5O1AlINQAco1aEFzVDV0Xv1DmME8Pv
         tT04sXUeIwkR0UqYhbCuZxpeuW0RN1syyg9/dvZcdN1l6b+qaE+P8HJoryqTFTGSIQ1H
         l5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JOM18/2JI/XRqmtoCiSEfwWrBMkMvuRt2TRd7mJVRjI=;
        b=B1t+/lUUHZq/bcY9mweQm/ECHwRQZNjtduNOnFRtpRqd2czTPcv0sYA42b/4zqHUTJ
         Jh4e95jnVw1rkhtjsjM5oqYUK+PLoaRPo1JrYCJ83bDzHabH69Fg83IiqGf45yVLN2R2
         /C50Sz/zhPsoyc9t678Pop8owpVUhN7GnEMnbykS35E0IiJ/2sJItpK0BeXsQmXPrEQv
         pMvzTtECER496qEP8t3SdLC7XFMXTVivZbJJoXzOL4WLY23E8kFgSUH9iMQW3UbASX/L
         mmwzpSFI5CcBFGuIstYNv/nr16qsxBkdFmDbD6lv2XQxUPa4/8GAJ7OAv032oRnZZ7j8
         9GnQ==
X-Gm-Message-State: AHQUAubgzCf/DR1AqA1VJfhlEnnb75Y4hbLRV3Yi0Viy1FTtGc3naYo5
        Dg/IlvgAIkVTIgYcvcRvRX4iYb+hSkE=
X-Google-Smtp-Source: AHgI3IYw/k+kQXFFJH0VPzoQMV+1Wj7RkmesoDxp//a3KMm1MSI9pUhSfkOM+eFFGG0+ZK3p4tlkUA==
X-Received: by 2002:adf:efc2:: with SMTP id i2mr8358239wrp.44.1549876906593;
        Mon, 11 Feb 2019 01:21:46 -0800 (PST)
Received: from ThinkPad.gtu.edu.tr ([193.140.134.118])
        by smtp.gmail.com with ESMTPSA id o7sm11388979wmc.44.2019.02.11.01.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Feb 2019 01:21:46 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/7] dt-bindings: timer: Add Allwinner suniv timer
Date:   Mon, 11 Feb 2019 12:21:07 +0300
Message-Id: <df301a8a7c97f59eb7c87cfc9c5be2355fc6bc71.1549875778.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1549875778.git.mesihkilinc@gmail.com>
References: <cover.1549875778.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Allwinner suniv timer which is similar to
sun4i timer.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt b/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
index 5c2e235..3da9d51 100644
--- a/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
+++ b/Documentation/devicetree/bindings/timer/allwinner,sun4i-timer.txt
@@ -2,7 +2,9 @@ Allwinner A1X SoCs Timer Controller
 
 Required properties:
 
-- compatible : should be "allwinner,sun4i-a10-timer"
+- compatible : should be one of the following:
+              "allwinner,sun4i-a10-timer"
+              "allwinner,suniv-f1c100s-timer"
 - reg : Specifies base physical address and size of the registers.
 - interrupts : The interrupt of the first timer
 - clocks: phandle to the source clock (usually a 24 MHz fixed clock)
-- 
2.7.4

