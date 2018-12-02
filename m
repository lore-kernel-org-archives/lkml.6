Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41964C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025CE20851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 20:24:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLGP7GIa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025CE20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbeLBUYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 15:24:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:32825 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbeLBUYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 15:24:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so5502554wmh.0;
        Sun, 02 Dec 2018 12:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JOM18/2JI/XRqmtoCiSEfwWrBMkMvuRt2TRd7mJVRjI=;
        b=gLGP7GIaVXawVef7RXWc0UwDAdtOX2LMpmP0FaeI+zFg1FlFTMrX3BSsca8bF9a1CP
         htQqoMaoPCjg0ow8siWQ8AlVeUhYf2usojFv1/xQzM3HyX+NjzHZsRfzFLglgq8I6WhV
         Lu2aRcwTs9KJhFKZRXFLZPzOjpMmd3WRDRlfCKkfoJlQZEFbsHB0o1rwDzBBM5L/5lRI
         nwl0tOlgsAp6ghGbmgMpDdmxXDvNwqbpiTPT6hJbOl4Xw/v3TYEbJOQ2L/PswYpJaThS
         t6oRqUfzj03DphaveXQWD9ZJ/jIMeq3r9vF0xUQdlPd9Pln5O2oMXVipr+VHmXwG9bBf
         DJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JOM18/2JI/XRqmtoCiSEfwWrBMkMvuRt2TRd7mJVRjI=;
        b=gvnCWxuq+9YuVs5mtwfo4tWJ35/YdNYbKb7+HOyYvNqCNBZ5c+pivydpN5YXqRxXd1
         S35ToM+zgun8UbHwTOMsGfglRTpxZCkZoZj5Kr4xtvQzzE/yKjyCw3EfYaKC+SPnGfpm
         tCFpBaKR9FkCUaG/Aj3UiO1VYAlY/VCtPBF71CAJhLo7M9EBqEcgw8NR7Usr8yILckEp
         Tp8Kc8XtPV1RvvGCc5wHKnVSAajUCvp1kx0iRgMxk4qE6UxY854EgwEFvmZfuM+Gt/oY
         7XNDi+ctUkYwGvhFDOAFf1hDyTDy2TFUWa3vuFXjBgzZ5IWFkpt93igsKd5B6eBsgEtT
         K+LQ==
X-Gm-Message-State: AA+aEWa1IAOgyBTqEXpt250kB37iKq/FpfrneUZ3FpH5N/txVntshYV8
        V3NgqGn0+mMYhVkAkU6BlCmvCE57CfI=
X-Google-Smtp-Source: AFSGD/W7QX4J2lsvaA8NvQCdiuL27IRzzpKO6FhpOjj25mfcInqV8rBl40DwmYhmRdkims1AAu47BQ==
X-Received: by 2002:a1c:3e84:: with SMTP id l126-v6mr5546933wma.91.1543782264458;
        Sun, 02 Dec 2018 12:24:24 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id l3sm14451510wma.44.2018.12.02.12.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 12:24:23 -0800 (PST)
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
Subject: [PATCH v6 08/17] dt-bindings: timer: Add Allwinner suniv timer
Date:   Sun,  2 Dec 2018 23:23:42 +0300
Message-Id: <50f5d37e67d9aaf88c911aa614a7a520a9179996.1543781680.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543781680.git.mesihkilinc@gmail.com>
References: <cover.1543781680.git.mesihkilinc@gmail.com>
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

