Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486B7C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE83208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BIREaNpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE83208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbeGaLC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:02:27 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40604 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729768AbeGaLC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:02:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id y9-v6so2327074wma.5;
        Tue, 31 Jul 2018 02:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jBCF5OYdsOEdWKAdYLBMBsHgn2F2SAZ3lPTXjstKWRY=;
        b=BIREaNpKxg9qcCsLAYlY7+/rMRUvt3rfUMw8EjFUdfvsqwPGNNL2GuA/uhr2ta8Z4y
         Vkd0odOS7nZ7Bp7gqKZfRgJAO/1CGIoslKH7Eq0NcA8Xz2H5rYeIlDRkUKmBpspwtY2a
         SRWBMmjca3LDXH/4OG3UjZ1c7WpQPjBEBeu7t1pOJygsR0OSZRJ0KhdqEVCBbJ1vNIye
         jrDaN9v1sgOf/J+XRoCZzSek4fDJpcsu2VUSp6Qcfb144dTb03oEUfYqCIHwbDy9rgPI
         og1CAC+DMBAw9K74v3JTOoyPsBf/wLxjO+x8Jk6iV4wJMmAJwJlKS4arSp5KMvi0OEBn
         5TYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jBCF5OYdsOEdWKAdYLBMBsHgn2F2SAZ3lPTXjstKWRY=;
        b=ujEy/o7/fIv90/2IWLNAkcmOQ+fYY9qZnfYUepaooo4tUNUuBkO6WbBKyYs62kAa0v
         M0Ij+VhHA5v1/ya6e/wxJVivmNzqjOXptJc0bXLuwiX08XYkqKGjSQqp9sIL3onBgWCO
         QybY3hwLSg3Dhw632pX7Z7tLVirRixojF7lnN0spQ5x5WdhGdhbGeKuHnL0y514lBv21
         ZQMWGU6a6VoANGcHf3tNb3wQ+6GKUZ7hrVUquuR17Th96vKLbWjCyzOfu09vzve7k0H0
         fZALLaOhEXQ0hHbiJt6kV85ttMkB6ijPE8d+t/lAE7BhfmEFaywsq8otQtiZiFFC0rUQ
         5aJw==
X-Gm-Message-State: AOUpUlGs1fLlNvyynXOUXHW9mjRVHUHbc0gGwIXX47OPFpS3w+NzBpGX
        aRSGlky4XMTY1lVa/RJlp58=
X-Google-Smtp-Source: AAOMgpfqZX+yquBvV8/cYFtcGxVIgccDrn+Q6ju71Ix4zcuf2G4xBjqbmGO9uOnp+k1xLpWpuOdFGA==
X-Received: by 2002:a1c:1004:: with SMTP id 4-v6mr1710796wmq.68.1533028980919;
        Tue, 31 Jul 2018 02:23:00 -0700 (PDT)
Received: from debian-hp.wlan.uni-ulm.de (eduroam170-020.wlan.uni-ulm.de. [134.60.170.20])
        by smtp.gmail.com with ESMTPSA id y191-v6sm1670873wmy.4.2018.07.31.02.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 02:23:00 -0700 (PDT)
From:   Philipp Rossak <embed3d@gmail.com>
To:     mchehab@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@free-electrons.com, wens@csie.org,
        linux@armlinux.org.uk, sean@mess.org, p.zabel@pengutronix.de,
        andi.shyti@samsung.com
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: [PATCH v6 1/4] ARM: dts: sun8i: a83t: Add the cir pin for the A83T
Date:   Tue, 31 Jul 2018 11:22:55 +0200
Message-Id: <20180731092258.2279-2-embed3d@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180731092258.2279-1-embed3d@gmail.com>
References: <20180731092258.2279-1-embed3d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CIR Pin of the A83T is located at PL12.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
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

