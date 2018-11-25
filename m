Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C334C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0746220850
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 16:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WoDya4d0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0746220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbeKZDOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 22:14:06 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35443 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbeKZDOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 22:14:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so2396958plo.2;
        Sun, 25 Nov 2018 08:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=oRZLwlngBTRlgTkLLHYb5YuavMVSU0mKsDQHiQNPGqw=;
        b=WoDya4d0Ue/2VK8tsjlG5qxNEH6E1C5gKxxqNiQgkXdU1cCFgdsBntdmt7nKOrJBQp
         TIHmt1VvsDbaqd4B6tKvFEBYLRLpTV38Fv8u6cQgUG7eEll03jp8eWZ9FiKBBbLce9UU
         y38ECjyYYf+CaxBhGuUQGv3SxyXFkvWxu6oX5d1eppWCXy5X5OjpYZDsphvzb+fgW7+d
         ec9PFSsIT6nGJcAF05DgSV2JXfJCctcRnEKnuyxn56QyuahMocAK00pgvp01SNT2laB2
         9mbFFJTLZEY5epvdajUWHlu7AdJ0YJKyGh6b97nLSDMcy4RGvJ4Oj5Nbf/0v9LhtlARi
         3oOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=oRZLwlngBTRlgTkLLHYb5YuavMVSU0mKsDQHiQNPGqw=;
        b=KHAVHK6E1HZ9hKsmpoAOWYST37wQfWVT6F9sMWzIiROCgJg+NB2Jgd1NiLkdnwllp6
         /CyvY79sdZUulxziSK8okco61MevYPaqUAU3ucFgABPRwYBuVW9w074UZQRS6vc6oZ5K
         e4KG8Pt7nmlhXMVsjrzg8bTI+JH1yPHzbVLFpV6fBFRcTNqfbooMxllapeATSf09Ni+K
         1psm4/xl3NQn81hUwISbSe7iM2YAvaCUwBHNwgis4blmm3wfvo1JXcoQwJiAf8REUnOE
         OdSNewDfGKLprj4Ot1QTuYhJ+u+kOBceehGdOzXIfMoVHa0oF7txofuExJFYdL53U7ac
         AVrA==
X-Gm-Message-State: AA+aEWaYMNigRE9TtLaknx0BS0GhRqJ56j44LTtPsUBmi2RXtHzQIjSN
        43Me4yDRa0aRlG5LvSQTlUE=
X-Google-Smtp-Source: AFSGD/XG/ppJrvo3uySEydwXN3OS+lrhza3wBuf9w8NDGdNIdZo1lXT/fNXfaLUAJeFZfDgvtBR8gg==
X-Received: by 2002:a17:902:f20d:: with SMTP id gn13mr23129317plb.11.1543162961002;
        Sun, 25 Nov 2018 08:22:41 -0800 (PST)
Received: from arx-s1 ([116.238.148.251])
        by smtp.gmail.com with ESMTPSA id t13sm123088987pgr.42.2018.11.25.08.22.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 08:22:40 -0800 (PST)
Date:   Mon, 26 Nov 2018 00:22:03 +0800
From:   Hao Zhang <hao5781286@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com,
        sboyd@kernel.org, thierry.reding@gmail.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com,
        hao5781286@gmail.com
Subject: [PATCH v3 5/6] DEV: CLK: sunxi ccu: export clk_apb1 for sun8i-r40
 soc pwm.
Message-ID: <20181125162203.GA5392@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock source for sun8i R40 is from apb1, so export it for
dt parses.

Signed-off-by: Hao Zhang <hao5781286@gmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun8i-r40.h      | 4 +++-
 include/dt-bindings/clock/sun8i-r40-ccu.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.h b/drivers/clk/sunxi-ng/ccu-sun8i-r40.h
index db2a124..181ab26 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r40.h
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.h
@@ -51,7 +51,9 @@
 
 #define CLK_AXI			25
 #define CLK_AHB1		26
-#define CLK_APB1		27
+
+/* The APB1 clock is exported */
+
 #define CLK_APB2		28
 
 /* All the bus gates are exported */
diff --git a/include/dt-bindings/clock/sun8i-r40-ccu.h b/include/dt-bindings/clock/sun8i-r40-ccu.h
index f9e15a2..a2b8f06 100644
--- a/include/dt-bindings/clock/sun8i-r40-ccu.h
+++ b/include/dt-bindings/clock/sun8i-r40-ccu.h
@@ -49,6 +49,8 @@
 
 #define CLK_CPU			24
 
+#define CLK_APB1                27
+
 #define CLK_BUS_MIPI_DSI	29
 #define CLK_BUS_CE		30
 #define CLK_BUS_DMA		31
-- 
2.7.4

