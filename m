Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E763C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9C620815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 14:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKRrsbji"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D9C620815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbeKSAiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 19:38:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44263 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbeKSAiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 19:38:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id j17-v6so29282114wrq.11;
        Sun, 18 Nov 2018 06:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cbhrZWurc5ave0lcWWOhuqmpYWnwRFoHI2oMYYLYp3k=;
        b=TKRrsbjiORHWY2JF1OV8lbRLxCD2hANmpvmB9OLcqXdUkUTXFP143FCE4rVtau1Q4l
         iQexKUXWS+yFYS11NEsfxmSM/kjAGf/4cxca3picDQ/YfhEO3eNz5cSevOMxPniDrYyM
         m99x1G36d4tclSXfOLRM/oHc5BgF25AWCoGKv/11tJW5JmHvHTkNkOMr51HgzePvrUZ9
         QNad14x0fkJ/yqmtWwcyBqzMnhnFG0Vmzmh2gA3sjyPOXlXdvLJAepxoExo9fy+NF6oZ
         xQc3KnrQ1Ei1IVHDLiTJcNNJVhuxoFOZIv6H3TDQdpWqr0rO+uoqTbODQ44wPwTj9lsP
         PN2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cbhrZWurc5ave0lcWWOhuqmpYWnwRFoHI2oMYYLYp3k=;
        b=KfpHO3/mgo/fbs7gHbo5DXTmvVLrefg1g/9wVHG/uz1dCxkIVdNFKCe5uVIdZjAw4x
         ofzAx/qiDlqTmqqk/iGJjYG7tOVShrGQm09rYEV6iwQIKEX85CLgpYBA1AUF09y/sogZ
         oWZnFne40RhVeRS13qQUQpLePF/YGjeXEH1LQZg90bY/aH/I1t9WgqGstUMCdq9W7OTV
         Etbayfuz4nOTvfkGG+iCN7xusFkNN8tmwQMJF1QeXawIRw5AyHJny7KO+6aPO8+XzIJI
         CgrSodOKdF0JhhZD4m6JCLF41kywhXYU5FpwS9zSmroxiRTqU6+dobd9ClLlbewHw6Xp
         nL2A==
X-Gm-Message-State: AA+aEWYhH2d6q4GlIrvK47ZudcVr8Bz690cJlM/xpYulVAEQKx3tkS2g
        Q4zjMP+m8+slA5JrAGY6hYEmJ1eYHVk=
X-Google-Smtp-Source: AFSGD/WHZ1qrLVdS7jZxQW3+kHtjjT22cCeBU3vLQUQmKLh5lgA60wOKTtLAwxoNMakYIanvq9QcLg==
X-Received: by 2002:adf:edc1:: with SMTP id v1mr1485389wro.105.1542550704353;
        Sun, 18 Nov 2018 06:18:24 -0800 (PST)
Received: from ThinkPad.home ([185.219.176.209])
        by smtp.gmail.com with ESMTPSA id d4sm29814412wrp.89.2018.11.18.06.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Nov 2018 06:18:23 -0800 (PST)
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
Subject: [RFC PATCH v2 04/14] dt-bindings: interrupt-controller: Add suniv interrupt-controller
Date:   Sun, 18 Nov 2018 17:17:03 +0300
Message-Id: <e51824832fac0b981cf886f25efc25056d573da4.1542546735.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Alwinner suniv F1C100s SoC interrupt
controller which is stripped version of sun4i

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 .../devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt  | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
index b290ca1..e04ddb4 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
@@ -2,7 +2,10 @@ Allwinner Sunxi Interrupt Controller
 
 Required properties:
 
-- compatible : should be "allwinner,sun4i-a10-ic"
+- compatible: should be "allwinner,<soc-familiy>-<soc-name>-ic" to identify
+	      Allwinner IRQ chip such as:
+              "allwinner,sun4i-a10-ic"
+              "allwinner,suniv-f1c100s-ic"
 - reg : Specifies base physical address and size of the registers.
 - interrupt-controller : Identifies the node as an interrupt controller
 - #interrupt-cells : Specifies the number of cells needed to encode an
-- 
2.7.4

