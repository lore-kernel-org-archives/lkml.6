Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB341C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5D8D214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJzLjZhT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5D8D214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387406AbeKVFHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:07:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37996 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733244AbeKVFHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:07:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id k198so6787445wmd.3;
        Wed, 21 Nov 2018 10:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qZvHXmvgGNHtSbf7khGdqjsE979WJwqjjtYuLbWwukM=;
        b=aJzLjZhTvceIkUFlbnCoOIpdBNKLPlxYjfPgkX4Th+aOvY1d5OtRVdUSsZxzZIp+Ab
         0zSKrnlB4xWD9uXDl54v8CRzYXZpkAqnKY9dWZa/5puaVfVqtNF8CRp9REVxVqZz9+kh
         tx7LZ0SvnFs3GMV7cP17odWYdWC75og8arq0h0s+Mbt6ta87Iog9fi+iegSoKW1bJ9mH
         VTTaaoiiYTNaTkCFpK92OIdjLt+fNVKwj3u45iyU/FLCQU+aJlLVJWxznX+qL59WLRIF
         bqTNis0XkIui3T3LZHeXa1VIt3x6v3O1YK7jlVx4+ZCVtiT9+gtKRhQBM4HLXqQpqlb9
         ymZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qZvHXmvgGNHtSbf7khGdqjsE979WJwqjjtYuLbWwukM=;
        b=jffoLQbKasIAJUG1X2f1eCy0VosQnQ7NDBdoCdeHTEblSJwD+dXqS0nVQmlkwULRTc
         ETuzukjBX0vdaAeWpVsjQ6YVjUC4AyLKwf9vdVdkLKqwarQmeTMD5dElZM99f6DDEUum
         NuII2ZT87dYfefCzfkIZk4210jUcbcS81f+/AibbqOXa7K4J1HwqPH4KFD0/FhvrSCDD
         QFAWiQOhBe8ImDCcR8A/JouWj4ZLGDic55jdhmhVyyt+1z1vc1Gdktlfcjcr1mQHB6Lw
         mhv5RkUd8pUzEEek/qoOXk1SEx6g8CpUquZtJWiD7lmGRQLYKToKbs+LzJYBogpiyZvB
         OjJA==
X-Gm-Message-State: AGRZ1gI/SFy0uWe4rmbugLzglXmrBjKiYwkEgZ+WH+NdM1jv1vQNpsF8
        VGgSY7aitdMrp7bLIWtCPHULKw1s9Qo=
X-Google-Smtp-Source: AFSGD/V1NdGHuJTISYpfva3sX37QCD2FCAH3WzTg1X5MY1erE5Uf0OMHH71NhngIsGTIM+DShJlx8Q==
X-Received: by 2002:a1c:5448:: with SMTP id p8mr6983089wmi.124.1542825125212;
        Wed, 21 Nov 2018 10:32:05 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id e66-v6sm2568779wmf.40.2018.11.21.10.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 10:32:04 -0800 (PST)
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
Subject: [RFC PATCH v3 12/17] dt-bindings: sram: Add Allwinner suniv F1C100s
Date:   Wed, 21 Nov 2018 21:30:45 +0300
Message-Id: <37d6119252ea024bdfd19f9c8061bcd16fec8b58.1542824904.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
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
index 62dd074..acee82d 100644
--- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
+++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
@@ -19,6 +19,7 @@ Required properties:
     - "allwinner,sun50i-a64-sram-controller" (deprecated)
     - "allwinner,sun50i-a64-system-control"
     - "allwinner,sun50i-h6-system-control", "allwinner,sun50i-a64-system-control"
+    - "allwinner,suniv-f1c100s-system-control"
 - reg : sram controller register offset + length
 
 SRAM nodes
@@ -58,6 +59,9 @@ The valid sections compatible for A64 are:
 The valid sections compatible for H6 are:
     - allwinner,sun50i-h6-sram-c, allwinner,sun50i-a64-sram-c
 
+The valid sections compatible for F1C100s are:
+    - allwinner,suniv-f1c100s-sram-d
+
 Devices using SRAM sections
 ---------------------------
 
-- 
2.7.4

