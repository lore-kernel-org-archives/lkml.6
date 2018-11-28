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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C74AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1131E213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5OrcmYq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1131E213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbeK2Jhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:37:38 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38882 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeK2Jhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:37:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so24462307wrw.5;
        Wed, 28 Nov 2018 14:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JOM18/2JI/XRqmtoCiSEfwWrBMkMvuRt2TRd7mJVRjI=;
        b=j5OrcmYqWmyjJ86PcxGLu3lejXxy49Cn73sTvFHOB1J7hT5NIRvTjpkOvDg5zR33n8
         4XjMAF52B+5YNdx9/6T13of8K2CiY2KBbcXAGQ4h6b5/4A2cACXAh8OYWOhDkbZljInn
         4zYnQQvGEKix0YF5gWSmT2gzzXLJisGnXXkBYVj+Qz9h3BqmJQljYRdXC5R5yvv7cIV9
         7UX6q7CqjEmH/zyMGdMumN/hYEy8uwAjHjHqS06cYkR+bDJMWFR2jD/1E1WSQCaxy+mi
         yh0JMnPBw2LUu6Ij9sZrEuUbAfF6NHWchkQ7TMGbKWkdlaLmxJ0KIMIFEylApuvO+/BY
         Mjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JOM18/2JI/XRqmtoCiSEfwWrBMkMvuRt2TRd7mJVRjI=;
        b=foGnuCzFAYX5tAfrI5WCl5GCcCpYWq0feMLjFyJR/66EF3RoU4ZeZV4BRdOLDOyTyt
         k/dpYwCzAvxFPhXkaxBNwbZoDonW3rauJjAT3edVuySczaDByZA7jtt4jHXbK2Iyil8Q
         sH5k0jEdTuewZvWZTIp5I8iQ/ZBxfEx6BvZT584LkPNuXDduL3ksbBHvZOiC2E9m+Cq8
         ldG9tr6NRtSDGE3ZvelDMZZeKjMwvtDB3JH1DLGRzgkdVcqTt7gNCQKwoi59s+nz1ugS
         5qLIMEIClTIk7rtwBCKNZxTv86z3vtzkpyqWgRzKISaZQ137V3Qw+114uooWWOjse477
         X3zw==
X-Gm-Message-State: AA+aEWYYeVsMWNVRhijO9iMTn+hY0YpNbQqGYT4Bi9AFQID7QYHt4RPw
        fgOeuZcMSpHw7d0+KR06wjNpWZ8b83k=
X-Google-Smtp-Source: AFSGD/X2croyY81SEeF9xCWoXZtILnyeuesXJfO0l/UUg/AaGFqqeX7GoG4flYvN4lfRlH6k8M+UMg==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr31350860wrr.74.1543444465029;
        Wed, 28 Nov 2018 14:34:25 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.239])
        by smtp.gmail.com with ESMTPSA id g198sm180244wmd.23.2018.11.28.14.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:34:24 -0800 (PST)
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
Subject: [PATCH v5 08/17] dt-bindings: timer: Add Allwinner suniv timer
Date:   Thu, 29 Nov 2018 01:33:18 +0300
Message-Id: <ebcaf22f77ae631bb626a74baaaf1187c1878b99.1543443475.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543443475.git.mesihkilinc@gmail.com>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
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

