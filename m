Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333E6C64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA44C20851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjxfy4Zx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA44C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeLBUYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:24:42 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46698 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbeLBUYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:24:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so10048010wrt.13;
        Sun, 02 Dec 2018 12:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0dF58WahZEvNWNI14RwNxBlOsuvWUlXAKVfNdqdb48I=;
        b=bjxfy4Zx1SjlZDb5rL/xrvQHQET/ZFAd+Donf4xWLce8TAsWEv4j9eLj1rli6nKwHW
         Y2uWkSWVCCAn62qPiTFZw+SZlhn5PLRyNIXcmq5lUHhQgwUPVKbB9dhZNPC75l6/z9j4
         y+B8JNAl09+IxsGVg1dILhEYPYBbDjfjM2w0+aWxrTkqmGXzCWWKA1FNn29RDpTJChDp
         2f8xJeLyT0HTxenEeYKGTyzzlOmOqsnJcGWGC6pKiQrxyFSYbMb/8oR45xM47gljmYHN
         Qgl3X+s27T7lpz+LgQT6HGHON5bkZHnDj2+H3FlffBUL2xfnnf1pxDftSz7RyiCXJ/77
         /o1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0dF58WahZEvNWNI14RwNxBlOsuvWUlXAKVfNdqdb48I=;
        b=CiZBiBZmE8T9pchsAQEKKqmVGG5LVxfNTHqFINQirgDnXZFNvpnsOoPsmU1Y7PJPd6
         kyfKh0nxaOCQt2F/E4zKLGc8idQjacwPkd/wYyDW8vNGa5YxnhlfhnEmd9ETrsARNPIN
         eioMSneBk/CqVXqc9F73lfHyKEK0yged8HrVQNzbhvY/rz8FshVd6j0jgsrgZ+cbDe1l
         oaRHWjJaOn9aLK4Wg4yicONebDEcLwAgvp1Evy7efuhmKAAeYL5UI+VaKmMkhGbp0Rsj
         0bkVchUdb2w28KVEPwgAuFvUf1uOXxdrCXQxSH8dyIYx2Yvb1k9czgFJfFs8rUp5k+nR
         a8Tg==
X-Gm-Message-State: AA+aEWZl6pEQ5o1sjsTZ68atHvdMFCpfZxiLt+q9nE47EC0iN6J8YiCJ
        pMaNpxq7jVMpx99XFFsf1c20Py5lQQI=
X-Google-Smtp-Source: AFSGD/UIBMpoEYOixHcQIADhaHNr5OeWHuua7IJ0G0x5OlPs1bOGAvxLi6k5dK31vLPTSh1JVyZd6g==
X-Received: by 2002:adf:891a:: with SMTP id s26mr11571809wrs.44.1543782275282;
        Sun, 02 Dec 2018 12:24:35 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 12:24:34 -0800 (PST)
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
Subject: [PATCH v6 14/17] dt-bindings: sram: Add Allwinner suniv F1C100s
Date:   Sun,  2 Dec 2018 23:23:48 +0300
Message-Id: <0b60c924d30ce3e04325214789de2c5b0403a056.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suniv ARMv5 F1C100s chip has similar sram controller to sun4i A10.
Add compatible string for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

