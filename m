Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11893C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79622133F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkTIDWlz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79622133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeK2Jhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:37:51 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44947 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbeK2Jhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:37:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so23620463wrt.11;
        Wed, 28 Nov 2018 14:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iD1UyqjCCFF08dz9kmj5kIY680LVUEWD9EKoGw4tLF8=;
        b=YkTIDWlzx24v+AgPh/a3On6EpHc9K1wUWo6aoPuBFiNT0XuywM5zMfJJUSugVsCjmh
         MwEWaIwkKC6oigyYldkjfoxtvlRpDDaUYiU8ZJv8BVooGJP88JOfOg56imf6lOK5ljq5
         Pbpl1S0M0Qx2zyjwbXyu16qrY1Iyhc02lLTrLPmWGIDB2TOE13L98z+E4mksPe/HwMl5
         WvH2h4z3vVIpj1y26ppmH5koyzO6AksFuwZhEfEZYsKU0Bs3ydg3HCbUkryxaeB0oGEr
         EgL6uBkJ+SnaAgrO1ntSNrB1auVR7AscVy5Y1idrpARbpff0unwSVwUoqavjX2DUqX6z
         P/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iD1UyqjCCFF08dz9kmj5kIY680LVUEWD9EKoGw4tLF8=;
        b=QTNQfmJCNcv3B9Zl+pht+I1xke6gxkD/vl2fuakxGakQzWWJ5/IRYEbfPefJMrKiPL
         PJ/0Fc9WpTgTYeBOzMIyG2eqNWM1KB/tHvgvIThXGocAIrxaWwasvt19xQTPT9p3mw0/
         K+LfFPjZMUxhXeYPnEO954c+y+8j0dIH9lBRblqia/2XZhtdkVyVjqy0T9gYwuyUtDOk
         dSkrPhIH7MmNU6lK4NncvaIA1C20zwI9DNARqbKLWJu90Ud/K+2gO2cQj2bshHfGu+Dw
         sg0Cnknfbd3dKKUl8PUIdh3ueOn1kt6FTzqd7FHLgBf7wDzk5Tt4E1BsWb49yz0NtTbw
         A7DQ==
X-Gm-Message-State: AA+aEWYu9wfKPVj0e+18AqERcQiRmRVtSnv6RbzukgYiO7n/5e/Mn3Io
        5sW4Y64uUk50edSPEBkCvhJYb+KkpFQ=
X-Google-Smtp-Source: AFSGD/UTwavepNCd8VE3zbmOd99XZJPcRLzaSr6sCe+S9Oe9Rh8WG1yTypZMcQKHqIQOPB6qWhnPEA==
X-Received: by 2002:a5d:454f:: with SMTP id p15mr35080066wrr.39.1543444477405;
        Wed, 28 Nov 2018 14:34:37 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.239])
        by smtp.gmail.com with ESMTPSA id g198sm180244wmd.23.2018.11.28.14.34.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:34:36 -0800 (PST)
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
Subject: [PATCH v5 15/17] dt-bindings: watchdog: Add Allwinner ARMv5 F1C100s wdt
Date:   Thu, 29 Nov 2018 01:33:25 +0300
Message-Id: <cbe3ad4ce1d0fb565a525c98165b0c0b8f50a4d7.1543443475.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543443475.git.mesihkilinc@gmail.com>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner ARMv5 F1C100s has similar watchdog timer to sun6i A31.
Add definition for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
index ed11ce0..4605525 100644
--- a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
@@ -6,6 +6,7 @@ Required properties:
 	"allwinner,sun4i-a10-wdt"
 	"allwinner,sun6i-a31-wdt"
 	"allwinner,sun50i-a64-wdt","allwinner,sun6i-a31-wdt"
+	"allwinner,suniv-f1c100s-wdt", "allwinner,sun4i-a10-wdt"
 - reg : Specifies base physical address and size of the registers.
 
 Optional properties:
-- 
2.7.4

