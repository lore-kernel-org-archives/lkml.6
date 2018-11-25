Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7439C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB7420664
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ogR4rcYx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB7420664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbeKYSen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 13:34:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32808 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbeKYSem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 13:34:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id 79so14282047wmo.0;
        Sat, 24 Nov 2018 23:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Wi0WGhkeV1RzlVqOJY4HaXI1Zlham8MFTpuZ/KUi9PA=;
        b=ogR4rcYxcp/b+hqI5fCswutLuCS4br+AT4cfsWIShZ+ps3HQTbfis/4/Q3et/X+aLA
         tJUKBNbV81Bbr8fz7q9gfIEE8Aai9OSGpnGrRTfkIASHSUna0MKFNI/3jjnVn30vEDS/
         YWdH5XDsMK8GyhZUzlWGLtbIA7CpEZhcc8Qe7Ap4KnTaH2xn2AlXKokWasotZCr7eYb4
         MdvVFQI7BCCBdKp442ofxu0aXt2aYcZboez8Uu6IAXt7/RJ97STNL+bugvPFTjNfBJsg
         r+lfSSadV+D09hKXHcTTdS1OfLWvYfxVUli5Sosp3MjQSkjRGgmIOcN47JYlSHo2ytqh
         NLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Wi0WGhkeV1RzlVqOJY4HaXI1Zlham8MFTpuZ/KUi9PA=;
        b=NyHX0TOCDOoYxS3w2U8Xsf617+dfCAeco7UVyi6+Jik1CFa4f7d6yiPGIT+JFmxjK4
         uw9pDngi2TV7BD4ImQJLkv00z7ZULDDb5auTfRbV8bbYs1VWDqYLFXvkMf+TDJCo0w73
         qr0/DBQWS0W5Fc0WNZnn9kjZrp0/qNd1qU6BwI/0MxQ82Y8Uw1MkH8oCXdfU9n+0skj0
         61QE8XIDtE/vNZ6ZKNzdZ9lwhBgxP7TKkpj9p5VvStPdmF5PimfryaqK90UPQmP8vIAk
         JEyi+sxTd/U52aro1qYk7SkQ2bL9uy/pzWNL1CCRQPoinrPpo3tXWUN5pUJEGrHu66dt
         IKsA==
X-Gm-Message-State: AGRZ1gIeMeTRFcZu29Uv+uAihiiKyOy3yTSDXoT4bBwEEZqNnP3LdrA8
        SdiY1ZKpxc8M18oajeMM3VyU+4QTIfs=
X-Google-Smtp-Source: AJdET5e0DVbiKoIunvuj/eYPNez3GFEYebViPktkHFizirnUO5BsrbG0T9v8MrIMgLZCu0qaYiyAvg==
X-Received: by 2002:a1c:e046:: with SMTP id x67mr19006106wmg.122.1543131852005;
        Sat, 24 Nov 2018 23:44:12 -0800 (PST)
Received: from localhost.localdomain ([185.219.177.224])
        by smtp.gmail.com with ESMTPSA id 6-v6sm12296780wmg.19.2018.11.24.23.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Nov 2018 23:44:11 -0800 (PST)
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
Subject: [RFC PATCH v4 14/17] dt-bindings: sram: Add Allwinner suniv F1C100s
Date:   Sun, 25 Nov 2018 10:43:17 +0300
Message-Id: <f80ca2de497c44c9415b02ac9aba93721d723730.1543131714.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suniv ARMv5 F1C100s chip has similar sram controller to sun4i A10.
Add compatible string for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 Documentation/devicetree/bindings/sram/sunxi-sram.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
index 62dd074..5c84850 100644
--- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
+++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
@@ -19,6 +19,7 @@ Required properties:
     - "allwinner,sun50i-a64-sram-controller" (deprecated)
     - "allwinner,sun50i-a64-system-control"
     - "allwinner,sun50i-h6-system-control", "allwinner,sun50i-a64-system-control"
+    - "allwinner,suniv-f1c100s-system-control", "allwinner,sun4i-a10-system-control"
 - reg : sram controller register offset + length
 
 SRAM nodes
@@ -58,6 +59,9 @@ The valid sections compatible for A64 are:
 The valid sections compatible for H6 are:
     - allwinner,sun50i-h6-sram-c, allwinner,sun50i-a64-sram-c
 
+The valid sections compatible for F1C100s are:
+    - allwinner,suniv-f1c100s-sram-d, allwinner,sun4i-a10-sram-d
+
 Devices using SRAM sections
 ---------------------------
 
-- 
2.7.4

