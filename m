Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D3CBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8FD1214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVHRI0tt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FD1214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733237AbeKVFHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:07:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54278 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733171AbeKVFHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:07:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so6552783wma.4;
        Wed, 21 Nov 2018 10:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZkceRaoAsyVLn4ygcIwzBYgJqRFMUtrkHiTDx/pcxF0=;
        b=QVHRI0ttS6h6Di10gx9GXh3dxdU8X359KgnoIVeMzDFjIknCn8aVuBEzEfSaGmeMl3
         t0KJrWREOZ32ay7GaYdOe1nlg0MTT02RnTWxRv3pUfCgP/5qQpl2V6sniArwBt4wmogn
         XuQxFri49txIuX1+bukfgBYBMdS4LD2XPovNXEx30yAvjsHOsY49/usPXlwL2BMMfwxi
         S9JtrpeiCQYaxCfmsxX4rl6s8xr8jhdPVaaHwiV/9aHnAhQuK1PheesYykOlTELGeuqF
         ODBaWFdmfSXni1GCoSdb1VH5Uw+nkYf4Q2hnGj5xtAEyzFwnCjZp+mn7IaamUDCK29LF
         kLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZkceRaoAsyVLn4ygcIwzBYgJqRFMUtrkHiTDx/pcxF0=;
        b=rkIfabEmhztmz4BgwURhXzUWQXyzIQRn1RpZFfdXeWLQoyYT9FHHJ4BYzeV85CBUyx
         m3C6nzwLDWFXHXyHOeg5+k1fqXXgqty3A1hylHls6EOx7LSWcXXy/em1wHJej0eOzCFf
         u6fi0HcUp8K8amlPbVkv73G94xNHaJqN1odZoGY1GJ0qxm8Wlg1M+DLXO+CEeUEDzg8m
         xzauuupxrc5K4eG80d2jPCyV150W483Z+BLrfWTiDnIbYUVKU2cd14fSQe49HQqPNHKg
         9tOOj31I0JefMEL4+kC59kD6RUgJuUIq0kTpR5hbI/p7147toxGBgSd8qt77Sxoca9sF
         rWHw==
X-Gm-Message-State: AGRZ1gK+I89wEZb7gUeEVQH4HZwVQZPZ0GcQPTEaI9vh3CeGnPvnxlcU
        tuJK4sxtVw9wnj8FAMbPLyeOwKTqHT8=
X-Google-Smtp-Source: AJdET5f494gSUJCR8DidssS5lkI3ZJIFgF9mzyvcpI+1sd5tvdDJJdiWwWRg42sMGoAIGlUdOMMKjg==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr6975341wma.151.1542825113062;
        Wed, 21 Nov 2018 10:31:53 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id e66-v6sm2568779wmf.40.2018.11.21.10.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 10:31:52 -0800 (PST)
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
Subject: [RFC PATCH v3 06/17] dt-bindings: timer: Add Allwinner suniv timer
Date:   Wed, 21 Nov 2018 21:30:39 +0300
Message-Id: <9927bde09ef20cadccdf81541fd1f91165508357.1542824904.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Allwinner suniv timer which is similar to
sun4i timer.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
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

