Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABEFC04EBA
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5545A20664
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJzU+x/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5545A20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeKYSeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 13:34:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34835 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727733AbeKYSen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 13:34:43 -0500
Received: by mail-wm1-f67.google.com with SMTP id c126so15225269wmh.0;
        Sat, 24 Nov 2018 23:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TJuBhd+OHQHd+WHL80OinaN4yVj5tzpFhMXqi9psrjg=;
        b=WJzU+x/crKOcafFeVizgWIX1KDe8Ovl0Iag31vJJTw0H8tcPcFUyqeZVG74clLj24B
         PK1noV8esW5PUabAxd1X6aabkv5LvW1k7lSJWOrMk/znDzQssQlvFdiMjAPEIuYAPV6a
         nfBj3vChaK0N6XVCLAURx+WqPQV5FaqBZHWjNzqRIO5rkXFr2NP+RMCJ2hCkiZiHaHxu
         1T9MZzpfrF+NXuhSs2UICjhf+2uWgx7f5qbA1ezDA5qrXkfNEBmM6YBTvOInEV9zydtQ
         a22CFPQYHMkLOMC7ASfC8sE5lZmKhc9XLkT7ibiIWsMXswouDVEbKSXbBX/BRCm041+3
         C/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TJuBhd+OHQHd+WHL80OinaN4yVj5tzpFhMXqi9psrjg=;
        b=NqfztMDShjo2yk6TRvBZHtPXhp2znC/OGhLwyMDfeXvONcE4kehsPJKPmzgM/J5g1E
         Ci5tWHQL9FhEw+O+nzzr6Uk3K6HuJaposoMhP8B4W8MEv3kJ76YDu6rcSim/xthGD7YP
         cQfOvZ03h/uLwJkqtkxDB82YIX3uv1Bdt0fl62oW9n0Dxd0CWh9yRJQM1nUa1rQksyVZ
         jWeUbGr7KSQWn5+28kJw5IVwv3PQQxYiFVy+4En+ADRIiAU3lM+Th148vdcYUAG04yKo
         jEmW+xxwHYgwmRDOrYHTnqKx0NPij5M7hauARCgjkwi1X25aHCErLEThTaOCDw0SuUSU
         khag==
X-Gm-Message-State: AGRZ1gJ46/i/415x4QbPIDt5RF8M5eT93mlfkfCSAh/6rJX1vl5YWho5
        iFUmxeTDHvVIgT3s42y76FdrUfPDGeE=
X-Google-Smtp-Source: AFSGD/Whg+/NgmrsSFieLcwF//7U51fn8nA7MffpCU9ysXnNhppU4r7mgKtIk8s849LqDZ1lX1XQdQ==
X-Received: by 2002:a1c:8d86:: with SMTP id p128-v6mr20712224wmd.48.1543131853781;
        Sat, 24 Nov 2018 23:44:13 -0800 (PST)
Received: from localhost.localdomain ([185.219.177.224])
        by smtp.gmail.com with ESMTPSA id 6-v6sm12296780wmg.19.2018.11.24.23.44.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Nov 2018 23:44:13 -0800 (PST)
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
Subject: [RFC PATCH v4 15/17] dt-bindings: watchdog: Add Allwinner ARMv5 F1C100s wdt
Date:   Sun, 25 Nov 2018 10:43:18 +0300
Message-Id: <29723ab4d09399185b8807a3f20bb2551b940f2f.1543131714.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner ARMv5 F1C100s has similar watchdog timer to sun6i A31.
Add definition for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
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

