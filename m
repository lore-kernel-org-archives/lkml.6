Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5267C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9570820873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pMzv83cL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfANQXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:23:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42134 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfANQXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:23:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so23556321wrx.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78t8t5aJAh2lJS/DVWCOAAUfzOZLIRzFq7ne2kpHrMs=;
        b=pMzv83cLJsDs/jPNbYToLkRh+x0/jjeyVjGHqBy16uN3IpV9nNcxWRtUt6dqFCFRuP
         ve0YGVV9lqgvurpjWxDLS27kDzjOUaJIv46OZM1PxTE+SPEG2uniYmKQJa+LA8SHIeNM
         fdU5b5twgmv96VzJp60ZDEl9/lWVXanXbJpT5MAbxFQLBO1Cnr5W+wNBlPJLhUKWwhWA
         +5U1OzCZUZsP5FZI8iIPxIXeGNKvSesmlvejSXRa9jkLIZ1VNANL4lBOU0d1Tj7s1xUD
         SxYeQaAJPWWSMzhLkCL5+sYtDcBwwLjI0Nt1uccbBWgCqw/BZRlCUs5A0hzITJcPReIV
         jqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78t8t5aJAh2lJS/DVWCOAAUfzOZLIRzFq7ne2kpHrMs=;
        b=MyzPMqpj4bF7RqrJC1feOqvhg+BtCnm2RVrVdyDzNxwGpJ4esEJKLe3vHIOV6fISjn
         l8TixziFhs/FxmXalo5KbsjrAoSPHC9bIvRWwbYc8FY3bAuRBTQAOPwsA1IlzYCDbj/+
         AE59eIMUy4cG2fMJtwiRPSdy3X+Cpr4BEx3NbmaqgqM2eMGzWwdNA4g5jFHYs02sWcEZ
         azINmUXQp6q90HrCwwBaRtD7/vda3zK7EQddxznrw7yaxrR/74DkQlG3p4bWN279S3jA
         xRKfp7a48l2GRV5c8G17yNwm2PX4EML3fhFW12F39cf5UvByIvWXFetoLYsGzG0kGE4V
         1aoA==
X-Gm-Message-State: AJcUukea59RhCAckkJHAKwQKshK30mIEd061BbrSsVcB5o+gT5S/dtiQ
        7UQyEgdlgFUY3EkS9TV4J/Bt5A==
X-Google-Smtp-Source: ALg8bN6xPB/GWgv8moGXhtR9EB+HitQgjRHYhA2km3idSCj8U97SQrUCh+Gs3Tem1zI5Q06WOWzPwA==
X-Received: by 2002:adf:9f10:: with SMTP id l16mr25799030wrf.206.1547482981472;
        Mon, 14 Jan 2019 08:23:01 -0800 (PST)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id v133sm25931441wmf.19.2019.01.14.08.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 08:23:00 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-gx: Add canvas provider node to the vpu
Date:   Mon, 14 Jan 2019 17:22:29 +0100
Message-Id: <20190114162229.5412-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows the vpu driver to optionally use a canvas provider node.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 44c5c51ff1fa..9b0ac183ee0c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -510,6 +510,7 @@
 			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+			amlogic,canvas = <&canvas>;
 
 			/* CVBS VDAC output port */
 			cvbs_vdac_port: port@0 {
-- 
2.20.1

