Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87C9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ED04206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 18:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yj2C6uDi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ED04206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387491AbeKVFIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:08:02 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40511 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733244AbeKVFHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:07:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id q26so6727109wmf.5;
        Wed, 21 Nov 2018 10:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VkBCO6K4jPS0dHvhbbwgoiFud7vJu2Xh/5JJylFhPPU=;
        b=Yj2C6uDigE6tefumrJ9LeCkOdpgu8m3kUgt2duyMpuxSCMwDfI3KFU/DMUlJptLe3q
         9sqtlxOoIaZobYcVSrROZHsM2fR0bEYGinjIwLeMmLImQS3iptN2NkPZuaEBMsjb6lKs
         leO3Fb98EZxYhvOWT/yUK5dQgEyczFEf60m6HIuFadYa+fiNMOLkQSfwGUqltsAfjuxO
         am77xw4kq3+zZifOTGsyw/jo7TV1pF9NlUXhDrJ3iwyJTf69Y+Hh5+0nhTS/ZojOG836
         oDoBJ6IwVEL8c6CrvSd7jjbFQOQQQO5Ui+XOVloo90IqlWOKpVBte5ZjCU6puXby3Aay
         ICIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VkBCO6K4jPS0dHvhbbwgoiFud7vJu2Xh/5JJylFhPPU=;
        b=b3aCBv0Y5u2lJSUQT+iSs9T6pu8DvMjiAy5HkQBtqkNQBQFJ49dhoqyjYzcS59zqE7
         2h0lt9VK36UY1sPEnr0bbu+Z/Z7Ntw1RPMX9nUhEthGD9Lz6UEzMTZGQHY04F2+pl7in
         k4utl9LdRDVR2McfUbwfexDxsluYQIs0LYvUU3i/bgTcLQDcbfe1H0kn9PudxSvJsHca
         R+r4DXJNM5ZCRVt7FYAbw56fTUiKdeaeWbXyHd/zO4UnmJN/y/IQONEo9iRjUI2NIxEw
         39ymUxtETqmPuQ3vddH14T6M4oAWRboWgUBpouOyfjByKB/8GdSu78Zi+BzmjlYJiNuT
         WSVg==
X-Gm-Message-State: AGRZ1gJf/QLIFgNYWRpQgj3O5iUalD92OUFZjbvEKXWIvj5AdBE8G7j+
        u6vsXC4oN+mIki6P46RV+6BD86wCWrQ=
X-Google-Smtp-Source: AJdET5dwzuRTFDl53YX4LXEVa6hjSNu9rDJqqMEUX+C7d9FWIHOPnESUu5sC4/mFo9XK4CR00tpVFQ==
X-Received: by 2002:a1c:c008:: with SMTP id q8mr6195038wmf.99.1542825129152;
        Wed, 21 Nov 2018 10:32:09 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.229])
        by smtp.gmail.com with ESMTPSA id e66-v6sm2568779wmf.40.2018.11.21.10.32.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 21 Nov 2018 10:32:08 -0800 (PST)
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
Subject: [RFC PATCH v3 14/17] dt-bindings: watchdog: Add Allwinner ARMv5 F1C100s wdt
Date:   Wed, 21 Nov 2018 21:30:47 +0300
Message-Id: <713a56409ba6afb4896d3ac9617f1784c7889f0f.1542824904.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1542824904.git.mesihkilinc@gmail.com>
References: <cover.1542824904.git.mesihkilinc@gmail.com>
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
index ed11ce0..5eefc56 100644
--- a/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
+++ b/Documentation/devicetree/bindings/watchdog/sunxi-wdt.txt
@@ -6,6 +6,7 @@ Required properties:
 	"allwinner,sun4i-a10-wdt"
 	"allwinner,sun6i-a31-wdt"
 	"allwinner,sun50i-a64-wdt","allwinner,sun6i-a31-wdt"
+	"allwinner,suniv-f1c100s-wdt"
 - reg : Specifies base physical address and size of the registers.
 
 Optional properties:
-- 
2.7.4

