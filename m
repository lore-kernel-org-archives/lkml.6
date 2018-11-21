Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BF8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4E0214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPs/g+iL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4E0214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733169AbeKVFHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:07:14 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32986 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeKVFHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:07:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id 79so7891275wmo.0;
        Wed, 21 Nov 2018 10:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Az1ZeQVeS0lqIWYILqfSwJKxQrZ+cicFXortIIHWQog=;
        b=qPs/g+iLNMhEeDCXDb87m1nkE/GNWWprkFXpMmmDsWJdy3zNwzLe1VUTeaAB0nu1tI
         oV9eUAlcnPy38J5bUNV4RruZ4FueUYe9irp+MPHUAyz9Vp7kNQbqAwctMVta3SLWAtb9
         p/aQqMFPME8Y/JhoxWQ/6FQfm4MFx3/tkB/e5X5usBlj7E5eMvPipBBHrsh9uza1nKTB
         ofDbwJkuCtPfUXcJOc5gu4brC7NAQEL5KloRJP4It7/jp4IFyyRVHlGvHIm3RgTkMb28
         m9N74nU9U1Jv8lxn5eLrnfEW3K4VszxM+MbR7VVaNkU+PKMbN0XNwRMs0e66NRcOTpGy
         5CkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Az1ZeQVeS0lqIWYILqfSwJKxQrZ+cicFXortIIHWQog=;
        b=nIyKcz0sqKwazYnOh5b5uVDFuM51sY4KOnNbqCuIXJSfS0C7EQfDp4+54hRXjgU5dd
         CLPWWy9qpqFeGU8x8SfBTihzW6dLeVklOhG6SplDY0Af+i5hOft7jdORSFr4uoV3ZpIe
         3lxt6cEy7dcQylc4UNYPrXJkAH9D8M/98E5u4CM+vs0DtNi40DdSH0ewQx/uIgOjj5hT
         D3XK4C6TjwERycEb4rMX92pV1XJ1YUUt0S94Pu3BoEPvyXiEEug5hwVWkjMgNWYtD/ow
         jdTTJq8tnMcyPIHfQewEPmRGH2TYu7n0itRb8D4493a/4qLggOGgkeMSVlwT7Mhi4lJX
         UwoA==
X-Gm-Message-State: AA+aEWY1i0yIwNrvFdmMYQIQXX9vZbjHmKfzZ/SKN9zskAQeineycbQt
        jCaFbQD2HvtMBU26kEa/yAFo216968c=
X-Google-Smtp-Source: AJdET5cyB/94v+OoiLdvfpWp1wUqu7FGXIiH3IkKi26ty1DLDa00nRUjHUpGXRtc2Y7wRd/5MtumNA==
X-Received: by 2002:a1c:9855:: with SMTP id a82mr6557682wme.20.1542825104143;
        Wed, 21 Nov 2018 10:31:44 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id e66-v6sm2568779wmf.40.2018.11.21.10.31.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 10:31:42 -0800 (PST)
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
Subject: [RFC PATCH v3 02/17] dt-bindings: arm: Add new Allwinner ARMv5 F1C100s SoC
Date:   Wed, 21 Nov 2018 21:30:35 +0300
Message-Id: <4c5ee3bf877ba0de233ec400ca27f3a91014a737.1542824904.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new Allwinner ARMv5 F1C100s SoC's compatible string

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
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

