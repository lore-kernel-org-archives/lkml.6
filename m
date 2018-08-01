Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660AFC46462
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0188920894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvkCE0l9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0188920894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389037AbeHALdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:33:00 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32915 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388952AbeHALdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:33:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id g6-v6so19467426wrp.0;
        Wed, 01 Aug 2018 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mwDJ6+OsJiYOZTKOFhDaYtsRx47tV8oqoIlTAjeZSac=;
        b=YvkCE0l9h3o/4M6CfavOtbQn8fiCNprGLvCkAtnEwro2galhDIIeXfV0EHjTX3D0Gn
         aRNKEo1pqDeCVvtaYM7CDB0jJSFQgrwxDPfNlGofeRQLkIK6Mp30FxI9srGH4VfB7Yzi
         tnfu0K4GgOGIqPGBK1s4jlUuW73mtMR1kUXxTAauSxlmYuBRVpqIvS7WrPWERSPu8cYO
         xDhpZmxw1Bibjb43x5nsrycCSP5AYTCSK5i9/4DXbGH0oPy9oojdJpAjLY8lNmJh3bCx
         0Y4eoW7I6wB87XOfF3LmXTNCcNZWC80FT08n7GQS7gg1vIXzlOZ6ub4DjfJh0qazK8Si
         6T8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mwDJ6+OsJiYOZTKOFhDaYtsRx47tV8oqoIlTAjeZSac=;
        b=QpX97WcLoBxE2EkjnbuGWUAvoUFj2Vio2+AdZP+s/UbwG4/TYY8SHXSXDnimYc2RBP
         3no40lEqzqL31HBn1dgAEqQtvLVV1Jk8k/5+UGeUHPopEMmuEuupv0FEw2WofiHTb6nw
         RGeaexekvSEHQCxd2mOhIRVT4EAd46Poz5M7Itj8OoPaJhboyrtTu1wkgVgLynpIQMiV
         T32wpk/fvZu8/DgxEaOUmhXkG2ej7G/Rc/tTyAWFpFzwBrjM+P7d1AuJY9qJnZ3cVaSy
         Y5+NCx3nPeWK6PvfCHg2IaKJjBZ3EibItWas0QdmBkd+rBF2j5h9lqGvfvtaT7I0TVEX
         M/nQ==
X-Gm-Message-State: AOUpUlGdGUm+LB0C6z9UqYzIlKY9e/LkITHGuRX1O6jeRl3w+GQ8YeAq
        43gQbIbJyDOPL9c37NWMBC0=
X-Google-Smtp-Source: AAOMgpeOEkgCEDmqTbVGUPXv4yWpOuAQq+TT9Ck9KNnlsZtHvinjojHag7eENh4ox2p5W/zRXmNkbg==
X-Received: by 2002:adf:b243:: with SMTP id y3-v6mr24574857wra.90.1533116884095;
        Wed, 01 Aug 2018 02:48:04 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id r12-v6sm13580217wmh.0.2018.08.01.02.48.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 02:48:03 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org,
        linux@armlinux.org.uk, sean@mess.org, p.zabel@pengutronix.de
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v7 1/4] ARM: dts: sun8i: a83t: Add the cir pin for the A83T
Date:   Wed,  1 Aug 2018 11:47:58 +0200
Message-Id: <20180801094801.26627-2-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180801094801.26627-1-embed3d@gmail.com>
References: <20180801094801.26627-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CIR Pin of the A83T is located at PL12.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 2be23d600957..afed6c0dea6f 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -1004,6 +1004,11 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
+			r_cir_pin: r-cir-pin {
+				pins = "PL12";
+				function = "s_cir_rx";
+			};
+
 			r_rsb_pins: r-rsb-pins {
 				pins = "PL0", "PL1";
 				function = "s_rsb";
-- 
2.11.0

