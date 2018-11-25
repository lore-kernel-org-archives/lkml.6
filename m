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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DA6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A9A20867
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 07:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqWdDeAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A9A20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeKYSec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 13:34:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34514 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbeKYSea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 13:34:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so15810359wrw.1;
        Sat, 24 Nov 2018 23:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=82/AP5Pddj062yEUAtC+25muwMZ2kQsBU0LkRIZNK0E=;
        b=MqWdDeAjwEtwIg2MSJu9qC4yQlIBBHuZa7rDE1XTEd8DmKwb3V96TaTt4w4YrfYnNT
         PBfqctZIYc7FL3cFFmLm6yfxzQsSx0wkD+Q6oU5/+vhMHxu1716l6x5/EbtzwyM5AE3E
         TYWe5UJn1Hgc6nQy8wEeVrg9lNgUCQTUUckOJ2k2fDlfmhOSWABnwybxKIEGJB4EHFL7
         cp8Btr/y1KU8IfGIKN0jmiP9599tGbp21rwDIX7shgB1gM+7xx7ar7Nqr8EXy1OHE7ba
         dYBLItmkl50ir4dqUus5Jj9i9xMkq7u+MaJL6e+guBKvx9Pf1r8f9u2TPmZKRyt9FaCP
         8XkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=82/AP5Pddj062yEUAtC+25muwMZ2kQsBU0LkRIZNK0E=;
        b=eof+EuenB5r47kAi4oz1LB1gYZslzswfeyXuQzwY16sQne0bpqphRUVSEa78HxtsGm
         yu2YOyj89oEpLecouiWzMVNseXusoSOv5VPqHYTjmD5Su4x6aovbzoa71lIghGdHHlLc
         Kv2J0qoKjpAZvEaxArO/W0/EdDISOqCtgc458u7TM2BRqfbLMsfBJNQAtGunRkwV7t6b
         pK9TKBs1IBHrcZBdjnos5D+9fhAfm0L9VFinwVOzMergrDic4Pv1NzJQULJF6sx1zO0T
         R5IOpkaC/HZxA4EDUTT4ZYbi+DmFPboCy0Zd98H0X7QP/qczMOhSWAlQweiwVFyxtZZ4
         urnw==
X-Gm-Message-State: AA+aEWbkSZjWWo6mOoS8C1q84p80AiCYOR4NfpwvwqSgR5eUC5LmsZqa
        bws0ZrwqBwsLJKxqXvj+fOSTVRq1ZKo=
X-Google-Smtp-Source: AFSGD/V7Isb3gk5aCV6DxN2z59GuBQeuAFUVuCiU4PiO97FjE5B7L5xybmXHXRHpOOebDtsIhPM7Ww==
X-Received: by 2002:adf:f550:: with SMTP id j16mr19184199wrp.258.1543131840034;
        Sat, 24 Nov 2018 23:44:00 -0800 (PST)
Received: from localhost.localdomain ([185.219.177.224])
        by smtp.gmail.com with ESMTPSA id 6-v6sm12296780wmg.19.2018.11.24.23.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Nov 2018 23:43:59 -0800 (PST)
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
Subject: [RFC PATCH v4 08/17] dt-bindings: timer: Add Allwinner suniv timer
Date:   Sun, 25 Nov 2018 10:43:11 +0300
Message-Id: <48e7ce4d5e4c87a857cacbd01c427540c6bec002.1543131714.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Allwinner suniv timer which is similar to
sun4i timer.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
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

