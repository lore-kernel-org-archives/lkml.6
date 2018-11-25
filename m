Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8131C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F38820664
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PdjUSzOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F38820664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbeKYSeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 13:34:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34354 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeKYSeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 13:34:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id y185so10244173wmd.1;
        Sat, 24 Nov 2018 23:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mE3unBNTSEEQKHcawpgmfKIgZOmCbz3waMPMJ3LpvUA=;
        b=PdjUSzOzIE8ODToWv4rTVXmqDTRtWJJh6XCNf8jfeOn8KzUII4S9NWOdgJ2EESTE05
         XvR7CIs2hwFhkfqda+J+q6S6BYmoz94IXikbyLHlqgSx/bfu/Ra3D8hP1iGx359woAoX
         NpUBVemBycTSfNDdXjOp9K0slXTETsxmsTHEEFJtFRsg41eWe+0LSuWIgtKziWwedV7G
         CY2+IeZvqbChjE5fWUrTdsSVG7wOmxmG8GERF/mEmHTVl/Ew4Rk1bmSxGD+eg+UNebQT
         0M+01klOrKJGSuWP2aYtJKYr+adv81nlJHYY3na4xA426Rni3GslnYaPOcAcZLTLMzGI
         PlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mE3unBNTSEEQKHcawpgmfKIgZOmCbz3waMPMJ3LpvUA=;
        b=nvpnkYjWYbIp8KR++diXly7CGi15U6btLE6QkpziPJ27kBKSMxlmu8iUbPZhTR+XBA
         0/yiWFjwmIC5PxrPPT0CqkbpIxWXBausRkXCzJ+Ff17RaTY0k134Cu6kgSNiOCBz1gND
         sfZVb9nvxWpLHBJMk7scZ44SQHVHJmx9N/PiC+bLeTrpfxgRW9m6uQMSKft+kur0mvse
         BKq0j+IKuYDPYx4U+7B6heETo0E9vfG4N29nxE4TgH7c+WtPYcE/zWHJuuP9i59UmPlw
         TiyVRLbKDU23PJlFQtMvYcDZl2zzuhKSeT4ESmUp4p5N9MCX2QLz3Tk2QhvySSCFMc6E
         by4A==
X-Gm-Message-State: AGRZ1gIyxprp5NZ3uE0SsIHVfuE2lZHc2EQVd1tz3yD7mWqOD/OaK6Vb
        ZjqiRULJUrd6WxO6RemqfsmCNPGwP04=
X-Google-Smtp-Source: AFSGD/UGeJlcIx//K9dAhlk6MBGaP4sEiwGSB4ZvpHNHsyDRdkmgs3EZ6eiDHiDYipvjDvqr/WJtkA==
X-Received: by 2002:a1c:8d86:: with SMTP id p128-v6mr20711371wmd.48.1543131832314;
        Sat, 24 Nov 2018 23:43:52 -0800 (PST)
Received: from localhost.localdomain ([185.219.177.224])
        by smtp.gmail.com with ESMTPSA id 6-v6sm12296780wmg.19.2018.11.24.23.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Nov 2018 23:43:51 -0800 (PST)
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
Subject: [RFC PATCH v4 04/17] dt-bindings: interrupt-controller: Add suniv interrupt-controller
Date:   Sun, 25 Nov 2018 10:43:07 +0300
Message-Id: <ea00e2cc4dadb4a661e694dd022d8ca06470d3e8.1543131714.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Alwinner suniv F1C100s SoC interrupt
controller which is stripped version of sun4i

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
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

