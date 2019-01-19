Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C74C6369F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 21:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BECE82087E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 21:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFLdKf8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfASVSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 16:18:32 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38655 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbfASVSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 16:18:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so19086266wrw.5;
        Sat, 19 Jan 2019 13:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kzKu7Jt1TFcQEeir/0gTQijTxqpN5Q5WlzTbs2XKl40=;
        b=eFLdKf8TOu+KeffqOrW+53a48hHnn5nN9vOXmi86HUg4BxhpjVof5SYY7D7NQlc+ey
         KGJWExX9qNrZhQH6tywUOZNgcCI/HFjdMMzNNSKpBNHOY3ZITjUDjgMlAfH6c0Hq9ma5
         pubuYYhTvOPTZvNs0dHR9VJI68mj8UAeSdciPWQr+4ivccRDcvHwY6QKTIeq7+RqwsLd
         2RtwNGWbpGT+4zaIX9wCNXHkWbZdsPCk3++En4fg87S7fIvBlVNuVrNmDaspFLjtWQrQ
         4m1EOrTBmM4pzV1igiK/XCS3rIj8/eqWAhuuNgKK39Ef+0CaOPvoZUi58IzJMP70jJNu
         jL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kzKu7Jt1TFcQEeir/0gTQijTxqpN5Q5WlzTbs2XKl40=;
        b=K8oEMm1fUxhCOLSSAQwtIAeOYv+VFpUd+WM8XYkHoF4HQ2GvZwN38m9TGxWhtj+AKr
         MUPKywBv0kGR6ydZKoK9gju6NLiaVU6sXQjDAKEZmN71nLSLaVkkrIMDJsu9ZhqvMFDz
         zi+N40Rl+qw9Pg854Lf6JmKHx3TzO0Jem1+BUY2Jmhh6iPdI6NgErvIwBmEWcAwrtSk/
         hHjZ57sK4Nzo4VOVFK8C/ZkYQlBG3tB9lDVk4Z/ECdbZTtE6V3LFknrlhSQUtp/hSLpm
         0GKykOY2caxiWhLbgAy/h2vVa+Ppe8M9k6Bd+sKfj3PJiqyNWKXbPT9KORzxsUpcfb7z
         SRAQ==
X-Gm-Message-State: AJcUukd2bobfxqM2dkuV/y8Eqd3Y/46zVk+c3vMMnCvCf5MbEj7LjtDI
        a3t9fVb7CkkLF6P5p8/kgKLk179F
X-Google-Smtp-Source: ALg8bN6OvbXLv3U3GBXlnrvPTl84iGuAuMi5p6T+A/s4qTw1lOOLiYdbcSpmaNyx/WIRo1FppYLQbg==
X-Received: by 2002:adf:80a9:: with SMTP id 38mr20402991wrl.137.1547932709686;
        Sat, 19 Jan 2019 13:18:29 -0800 (PST)
Received: from mappy.world.mentorg.com (sjewanfw1-nat.mentorg.com. [139.181.7.34])
        by smtp.gmail.com with ESMTPSA id v6sm55737019wrd.88.2019.01.19.13.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 13:18:29 -0800 (PST)
From:   Steve Longerbeam <slongerbeam@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] ARM: dts: imx53: Add capture-subsystem device
Date:   Sat, 19 Jan 2019 13:18:14 -0800
Message-Id: <20190119211815.25101-2-slongerbeam@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119211815.25101-1-slongerbeam@gmail.com>
References: <20190119211815.25101-1-slongerbeam@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add video capture_subsystem device node, and include both CSI ports.
Prepare for adding sensors by adding the parallel sensor anchor endpoints
to the CSI ports.

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
---
 arch/arm/boot/dts/imx53.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index b3300300aabe..a78a447c4b4d 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -31,6 +31,7 @@
 		i2c0 = &i2c1;
 		i2c1 = &i2c2;
 		i2c2 = &i2c3;
+		ipu0 = &ipu;
 		mmc0 = &esdhc1;
 		mmc1 = &esdhc2;
 		mmc2 = &esdhc3;
@@ -71,6 +72,11 @@
 		ports = <&ipu_di0>, <&ipu_di1>;
 	};
 
+	capture_subsystem {
+		compatible = "fsl,imx-capture-subsystem";
+		ports = <&ipu_csi0>, <&ipu_csi1>;
+	};
+
 	tzic: tz-interrupt-controller@fffc000 {
 		compatible = "fsl,imx53-tzic", "fsl,tzic";
 		interrupt-controller;
@@ -158,10 +164,16 @@
 
 			ipu_csi0: port@0 {
 				reg = <0>;
+
+				ipu_csi0_from_parallel_sensor: endpoint {
+				};
 			};
 
 			ipu_csi1: port@1 {
 				reg = <1>;
+
+				ipu_csi1_from_parallel_sensor: endpoint {
+				};
 			};
 
 			ipu_di0: port@2 {
-- 
2.17.1

