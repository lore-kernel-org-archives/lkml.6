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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A40C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E522145D
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAWbpl7C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E522145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbeK2Jhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:37:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33932 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeK2Jha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:37:30 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so5014515wmd.1;
        Wed, 28 Nov 2018 14:34:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PqiSTLwl5WXrDtWtjcIXDjRJSUqIIl0Us7oauuCOk9k=;
        b=VAWbpl7CqFX2Xio7o0H6NFsqhlIpon5tbSlBtPK+Vdn8nnXtSDJaiElVNwdgdHM9zr
         WNVh2KBZJr/bKNQgXPMgCmdYfgzMN8ccoN/gXmOy89Cm4kXhKTmBuZO9HTloquqFR9uN
         51Cqva4isokVA6qzUl46P6hUpihfbjZsUXqkGX6x6/rAg7ZOLd0sSQR3V3a+roG6fDK+
         QRSFN3xYgKw/i+3dKC9cgIRnp2NgTeLxQRI12IeeXx4MtXihBKKsNY+50uNML/OS9yA4
         QsWr3yP9mxCBkJsBylUQ9n9MNFIWKBYclfrS1AcgqbNd0N6HRR7Ugbwkqy4j/FAH/aDF
         11tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PqiSTLwl5WXrDtWtjcIXDjRJSUqIIl0Us7oauuCOk9k=;
        b=IZ2lc5p4DS3QnLI1Isaa4bFLGUsnK2D7uwu0rT7Srx4MxUf5YuKgqM1JsKW5yieHqi
         oMhYkrjKJ2srnmQZttoNjyDNpog07LC4t8xGkMkwz2EOZuEleh0C6Qx9agAg7BDIqz9B
         81F8ThZX0MRzilPBzjSsQpNGobdXkckuqtUKicucMtk+hZtF1or7PkILalcDvepebxQZ
         Gl85B4PbGcLkPUGRzszsjwWxeQm+yKLmsYjlclGl1PaGIZrkReiU8V4FE3BrSoWrPwJz
         jbWHWREOagvkaZl7mGpZPFmfNO41MVFtc+SWcSdCb4wSPgmrmNQUE2Mw/8kZAPvdh9sf
         02KQ==
X-Gm-Message-State: AA+aEWZRCj+EYaDPbXUEqfJnAXVROrVJiPHTaq7iIwzHERtNJkKkWM3Q
        D3TK9nNNFz6Add7HX8yBxfvh2biDbv8=
X-Google-Smtp-Source: AFSGD/XFbg1ZTrlfRVAuvZPOtHOXE2Pnu6wLKpNsqeq83WEyUHO2jS/XXgXvkylOzxFj0HUACkjyBA==
X-Received: by 2002:a1c:110b:: with SMTP id 11mr4273858wmr.83.1543444458165;
        Wed, 28 Nov 2018 14:34:18 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.239])
        by smtp.gmail.com with ESMTPSA id g198sm180244wmd.23.2018.11.28.14.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:34:17 -0800 (PST)
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
Subject: [PATCH v5 04/17] dt-bindings: interrupt-controller: Add suniv interrupt-controller
Date:   Thu, 29 Nov 2018 01:33:14 +0300
Message-Id: <05d604cf3bf8d9d38a51713f2e67d8ee74149262.1543443475.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543443475.git.mesihkilinc@gmail.com>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
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

