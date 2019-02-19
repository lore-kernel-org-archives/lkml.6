Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4FAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1952021736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 13:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mathembedded-com.20150623.gappssmtp.com header.i=@mathembedded-com.20150623.gappssmtp.com header.b="EFQUjzCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfBSNDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 08:03:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34804 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfBSNDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 08:03:42 -0500
Received: by mail-wr1-f66.google.com with SMTP id f14so21959119wrg.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 05:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mathembedded-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=+gQlFZa1wdF25zlNKhW2637JpdXuTp6UB6jqREyKiOE=;
        b=EFQUjzCzBaBnTbOTiQ3kB5vpOPa0wz23b3f1dRZs3GghvdENheV6nccoLJlACL25ot
         mtqlH2y1e7JwhrCFYlvqWM7b9NHBTSGRq9Se7XfVKI4cr8drR1ofcOFX9JM/7bCVU39A
         9egW65Y0qtgqVSaPK5dAHZv8nfVJz0nnelTrE6TI66mscmhn9bmohS8rxHkS6RZpLTcg
         RPQczq/KKngZp/K9rncicCiob+4wi8skSjyi5gbwIg/t9uRI+SAwbQ46mVvpnoeeeytM
         ObeHUA7ZHt2jPgBBnD7VJ+zP1hLl4ml4CLdM83cwXjf80SG868WBO6+tEUE46Alc7u+/
         8nNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=+gQlFZa1wdF25zlNKhW2637JpdXuTp6UB6jqREyKiOE=;
        b=hKHv1UBwa9GpNb6uNrD2D9E7e0pL/0lHJ+QJiDdYOxjvUTPAJFuZ3c1NFak4bLzt/6
         ztUxvBGQuLPC+zCjGQFWoKUDC8CKjtZqjSnRc8GDgmKZh1rwQbvF3TgQw9TqhGz3/mFr
         t+edihbW/zTuQGkYh6cK049C7bSTJYtT9rJ1b/zRcXIbhtZEm3ABmJMqbUDWhPoHs8gp
         H0djhyLA6gjtF8zhTe+mZ1DMhIGkslzzwO6mj0C/2R4BqcfDf7NhcHCNeKDD41RJ3vmF
         mO3m5qVZTo5rP4XVS49uEbcgIti8xRN3Ek8ee7IpVgxL6FRfrpKAUcTDUdGCa2V/fZua
         yqiQ==
X-Gm-Message-State: AHQUAuYxHzlNVr0ZuFwmNHw/G6uVXmYwMlDDSvjvI58Z7kWlI5579N4b
        +yNC7xUPGBpdqzroszoY7mGgWQ==
X-Google-Smtp-Source: AHgI3IbS2Q5qLE/JWW7pqezyvz51nUcoMMmlGLa1pZ6hh0XdR81xHuRLW5leWVQ+QtjI+ftSrYD3qQ==
X-Received: by 2002:a5d:6107:: with SMTP id v7mr21664141wrt.78.1550581420366;
        Tue, 19 Feb 2019 05:03:40 -0800 (PST)
Received: from diamond.mathembedded.com (host86-137-106-133.range86-137.btcentralplus.com. [86.137.106.133])
        by smtp.gmail.com with ESMTPSA id y22sm61899811wrd.45.2019.02.19.05.03.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 05:03:39 -0800 (PST)
From:   Stuart Menefy <stuart.menefy@mathembedded.com>
X-Google-Original-From: Stuart Menefy <stuart@menefy.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Devicetree updates for Exynos 5260
Date:   Tue, 19 Feb 2019 13:03:33 +0000
Message-Id: <20190219130337.21353-1-stuart@menefy.org>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These four patches are stand alone updates for the Exynos 5260 device
tree, which do not depend on any other code changes. They either
fix issues or add functionality which is already available
on other Exynos devices. They were previously posted as version 1
of the larger patch series "Resuscitate Exynos 5260 support"
https://www.spinics.net/lists/linux-samsung-soc/#65035
which was only posted to the samsung-soc mailing list.

Changes since v1:
- Removed from larger patch set for easier review
- Applied reviewer comments to patch 2/4 "Add high speed I2C ports
  for exynos5260"
- Expanded patch comments

Stuart Menefy (4):
  ARM: dts: exynos: Use bustop PLL as the source for MMC clocks on
    Exynos5260
  ARM: dts: exynos: Add high speed I2C ports for exynos5260
  ARM: dts: exynos: Add interrupts for dedicated EINTs on Exynos5260
  ARM: dts: exynos: Fix interrupt for shared EINTs on Exynos5260

 arch/arm/boot/dts/exynos5260-pinctrl.dtsi | 16 ++++++
 arch/arm/boot/dts/exynos5260.dtsi         | 82 ++++++++++++++++++++++++++++++-
 2 files changed, 97 insertions(+), 1 deletion(-)

-- 
2.13.6

