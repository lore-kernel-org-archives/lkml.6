Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDECCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B48920832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJq7otV9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B48920832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeK2Jid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:38:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35413 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbeK2Jhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:37:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so27969712wrb.2;
        Wed, 28 Nov 2018 14:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0dF58WahZEvNWNI14RwNxBlOsuvWUlXAKVfNdqdb48I=;
        b=CJq7otV9K90+KrRxKCT29jV3nW+XKyxkRy0ZVYxmtG6eBKLlbKf7V1Zx2oKGvncrkT
         99wOE0k0L0dKnZ4Cv23Bzo4LGPn3wTvAqmVL8xA0pivPFDfKKcUQr+g6YsxpAddQbAOC
         qi1CaUkVL4IOWqmheQG5rNVGwwOdFNq5KCH9f7NIrJYd5ijx7QWoVi6tiNkPjkotOhRB
         WcX0N0FClh01yVvU+kNeFY9HBSpZ951owMAfl6h11qa240lX0lkJoO56ozCW8hGHgdYv
         xaOZMEt6DphAdcz0OfEkEjZM4HxXkSnhP0rOQLzbI5fyZUkSOI84sgDQr2KCsj2Tlmbg
         t+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0dF58WahZEvNWNI14RwNxBlOsuvWUlXAKVfNdqdb48I=;
        b=eJYzaedJrbvRmPsZhRonqMlnXNaBl7YDJSsEQIZPD+oPOJTa0aAIAz8tzQv2cUMMiL
         nE9nIvcXYIcQ4Fk2G+pc8LxQxw/PbTR1BwgKpAOCRpcthL4rWKePJZeVqWLX6/UIepvx
         0yHLxhouHKMwArpbkgAnWqaO81DUcr/YWmFw+tfJ8VqVS0AJ7TuMzEJ6boWsT9lOysrL
         SL/fZV89X+BpabG/Mum19bVKeoNgDkX1MylC5miR+FuAzDzwcD2yCgH52gkWbaM3PcWv
         aKJ8BklZxRK6NRop5OiAxe2a1DMjxrl1Z53Qxn9WuYL5vs2t9Dmx7i0FPi2zmg5mUgoM
         mQYw==
X-Gm-Message-State: AA+aEWaZudloN/Q4KwxMpp8pzoAKj/C7o3ckOBHGgn1RzdE8m5Ti8Tj1
        zkwSDXX+6kz1pxq48Nql3xNDWyHVr7s=
X-Google-Smtp-Source: AFSGD/U83R+6xykhtbwypL/iQjFNMZoqJ6botQSLXy/hI4KmVmqVKIes2DEGh/1F9Qwki7y3S1uiRw==
X-Received: by 2002:adf:9542:: with SMTP id 60mr31728742wrs.60.1543444475691;
        Wed, 28 Nov 2018 14:34:35 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.239])
        by smtp.gmail.com with ESMTPSA id g198sm180244wmd.23.2018.11.28.14.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:34:35 -0800 (PST)
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
Subject: [PATCH v5 14/17] dt-bindings: sram: Add Allwinner suniv F1C100s
Date:   Thu, 29 Nov 2018 01:33:24 +0300
Message-Id: <8b4e03c64633ea17a7fa7d117b35d23551de831c.1543443475.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543443475.git.mesihkilinc@gmail.com>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
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

