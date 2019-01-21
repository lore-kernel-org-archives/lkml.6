Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E95C7113B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A3E20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QNn6woVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfAULMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:12:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40841 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfAULMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:12:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so9350827pgp.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 03:12:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mnGAbei/QrtULUg0QvoNQpL5YKEkHiuSC510n/3AaPU=;
        b=QNn6woViz7BHLyK6FQs7k8AmeuYAJlP1WIqegDi5CWolZqCuPU1mDsKbOQIeg/7z/o
         Ctws+5gMeP0Nu9yCx76dIrfzyRRPCxTUtvwZYtPht4eDivjWe4QgtKpt6WovMnPc+zxv
         N51Y562g04QmkNMH1YqNMipFzK73WZNo3C8e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mnGAbei/QrtULUg0QvoNQpL5YKEkHiuSC510n/3AaPU=;
        b=b6EFrmbNfYW+vFdclzbc29vfR+Xz0X1onxG6BS1xF1R1yrPz4QIuJUKbaTbv/PiaHH
         bMfMNUrn1a4F5XnZL+n98F1Pal3fqtT4i9QOwEE1pjWMde1cRa3Q5S6KJ4/vuYXR/avI
         0pMvQ/8/lDzhpYnrOBvjjRlPGpCuxsotTLQUz1H224Zr1qXNf3gaDUFCxeLEZDiSfjXG
         469GvoQ66KyRLBIBruotltNYdYRsVVtSvWpoR/Q3ZOcRzXhdbkfdZLHOMKiyq0eU46UQ
         FSl76W5gdy8MjgO749sacbLXBarp5MRNezoGoRz33v8veHOeRez/6Gp0PS3MmM2MsXy6
         7hYg==
X-Gm-Message-State: AJcUukcbUAEsc65KfsYCYZ5juuZJZM/8t8EPpNPiftuMJyfYIhRoyhit
        s6ftaLSVlFJ1A/v2QvlYYNqjhw==
X-Google-Smtp-Source: ALg8bN6cg4/uKCarseArTuNyXxaoh2sgw6MxKtglvupRqGd+AN8UGnhEi+imN9jdhf3hYov5Uz2l6Q==
X-Received: by 2002:a62:c185:: with SMTP id i127mr29598788pfg.43.1548069152920;
        Mon, 21 Jan 2019 03:12:32 -0800 (PST)
Received: from jagan-XPS-13-9350.domain.name ([103.81.77.13])
        by smtp.gmail.com with ESMTPSA id a90sm21821288pfj.109.2019.01.21.03.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 03:12:32 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/2] arm64: defconfig: Enable I2C_GPIO
Date:   Mon, 21 Jan 2019 16:42:22 +0530
Message-Id: <20190121111223.18384-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO-based bitbanging I2C driver is required to configure
CSI data, clock pins on CSI block in Allwinner A64 SoC.

Let build it as module.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Note:
- These change depends on A64 CSI support patches

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 1f1f4eab89df..eefc1ff0c1e0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -318,6 +318,7 @@ CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_BCM2835=m
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_I2C_GPIO=m
 CONFIG_I2C_IMX=y
 CONFIG_I2C_MESON=y
 CONFIG_I2C_MV64XXX=y
-- 
2.18.0.321.gffc6fa0e3

