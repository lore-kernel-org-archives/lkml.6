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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951EBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1132133F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jP/aqbBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1132133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeK2Jh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:37:28 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45248 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeK2Jh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:37:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id v6so27918619wrr.12;
        Wed, 28 Nov 2018 14:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+V2WbDnTTYDb5DheTPlD4ID/xDgu/F+Pl9HjYjs8x9s=;
        b=jP/aqbBYGtQuDlSXuQ99IiQ7ZzBc8MUcbgYFWN6KLXWnLhgTdnOACgvO9n4rvw2PUx
         Sgt9LcO1JGbN4ZdDQm7mONxndIfJvcz0Xn5OWwmKNGhdJuXrQI+GHK81t1KB71vePmQu
         uR+xGpYzGjMCoRXqM2LCWwa77GemDVuKe1qvebYd/WSlxWDXR3F38yJL7HKZHvDAw0Fg
         TLfqoAjoLuJOWuRoBwtEbSC7Y9Y7JUuk5W8G23W3ulehHURE7+MR3oiHSmC/SAF9NdKm
         DlWgn1GR2vOdgHGkoc6+ekNmrKCa8oLTN2fc807O1mb+WPlGJNeEZnJun46fRPv0GMD9
         7UAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+V2WbDnTTYDb5DheTPlD4ID/xDgu/F+Pl9HjYjs8x9s=;
        b=Qo9s16tT/+BKGtDiOpDcQqcrAtk4bvbcsZ2OWwE2Db9FpEMltRzyngHGphilTaM6Ls
         F6GWShJgt2BPI1r/RPPVKdgs8Hl6AgVrLgNIHlGGMvH43WLTJ3oc+LkvcnDPPzA2oT6f
         TuVIPEkwIBV9SwMsLt9f3/c1kfHAVNGhx+KqRT/3l86uaqprSU2paPwGS5SAkrGsEmE4
         HZsH6XKfSYiVSqAQDY8gUcSY4uwKYDDIK6z/fxgzs/7/fAV/HdHkBqheOVYqIiJ1S+Id
         ipjqf8bxhUWicHTdIIc5ZFrV+j6NIk4XTMkS1i4uG44is6XWLxRAWFNGWZv53yZAnyfU
         KAnw==
X-Gm-Message-State: AA+aEWYSyBb3xOhh+B4UnMzuEEysscOV2zEdO7IzP7gRmK0S3b5uTYkD
        F7VjzBCUIB4gOHDcYqGSBTDs4Rf5sQQ=
X-Google-Smtp-Source: AFSGD/V3AgAn8O7kulBRyCbcguf9ZSWk26XHC8p4i5u9GZPvr8Q3yXevu5wIrwnzxAZn8/7qMiESfw==
X-Received: by 2002:a5d:4b01:: with SMTP id v1mr31438334wrq.5.1543444454685;
        Wed, 28 Nov 2018 14:34:14 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.239])
        by smtp.gmail.com with ESMTPSA id g198sm180244wmd.23.2018.11.28.14.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 14:34:14 -0800 (PST)
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
Subject: [PATCH v5 02/17] dt-bindings: arm: Add new Allwinner ARMv5 F1C100s SoC
Date:   Thu, 29 Nov 2018 01:33:12 +0300
Message-Id: <8daadf3f8467f7b56154e19ae60b921d14aa7098.1543443475.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543443475.git.mesihkilinc@gmail.com>
References: <cover.1543443475.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new Allwinner ARMv5 F1C100s SoC's compatible string

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sunxi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.txt b/Documentation/devicetree/bindings/arm/sunxi.txt
index e4beec3..f9ddc05 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.txt
+++ b/Documentation/devicetree/bindings/arm/sunxi.txt
@@ -18,4 +18,5 @@ using one of the following compatible strings:
   allwinner,sun8i-v3s
   allwinner,sun9i-a80
   allwinner,sun50i-a64
+  allwinner,suniv-f1c100s
   nextthing,gr8
-- 
2.7.4

