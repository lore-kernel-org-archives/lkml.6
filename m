Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1395AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BE7217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 07:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Y2oYjNTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfBZH22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 02:28:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41552 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfBZH21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 02:28:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id y5so5797898plk.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 23:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CR7bGhJ8X3S3X+Ftt56vfvyr81HKGdBtyFJexoNFZWs=;
        b=Y2oYjNTvtPqBJYeI5TS0Tvs9RXv1SfueahV/wazvcMSCO5umwCTVQyMi/kpaHs/Wm8
         n8j/Z0TF15MVAez+y8xKFhM0Uliq2tJVgBIpRbE3qN3tnCWZUilYqxdHXKsVy2Ytc36h
         TjUOqVAhf2kFnlyPaJ+rO82SWmt+21MZMX4Gg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CR7bGhJ8X3S3X+Ftt56vfvyr81HKGdBtyFJexoNFZWs=;
        b=MhiweE/m+9Ncr2r7nxONLdwfvdW3yiYDwsDbCE4t5Sb2+ts73tc8ywjf7CS65w2eZ3
         P3FzT5+clgSCNEifoKNlKk88lLIBFIjV/2UmKbX+Ni7noCXe3TECDEXwcUsdArQlLpqh
         S05/tHyjfvfDFh5Bvdws0Mlbtfna243SdcYsH680vkKWgxFur5JmSfAdkm6LictZWEUX
         dSTXkTFLlGYrZB25H/InYFK9GkFTTd42aRFIZMQCSiA4xQ+XxI9eL6b3dw+GnKXYX/yz
         SlphUB8aIUP4opkhC9h18JHEjpnP0xRwgd1aQPAINE7/eDjibYRB0p4llX9QoBOc3srB
         zx5A==
X-Gm-Message-State: AHQUAuYvmEf/jEYW8IqzolZ5/f6AROjW+lYii4C8cturVJI3qXP4vR6f
        RJmV4lZ/f7FlZ6KyftPG7ZH4kA==
X-Google-Smtp-Source: AHgI3IZtoP2cvWNml23Ak+skdR9rONyx90EOkMKmkBYneORB1vnk0btELoZbLNPDvLV11rePyY/KFw==
X-Received: by 2002:a17:902:9b90:: with SMTP id y16mr25031117plp.0.1551166106884;
        Mon, 25 Feb 2019 23:28:26 -0800 (PST)
Received: from localhost.localdomain ([115.97.184.151])
        by smtp.gmail.com with ESMTPSA id p11sm29401365pfi.10.2019.02.25.23.28.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 23:28:26 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH] arm64: defconfig: Enable SPI_SUN6I
Date:   Tue, 26 Feb 2019 12:58:12 +0530
Message-Id: <20190226072812.10628-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable SUN6I SPI controller for Allwinner ARM64 SoC's.

This would helpful to setup spi flash, for another booting source.
mark it as static since it require during boot.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2d9c39033c1a..d45e032c4d98 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -372,6 +372,7 @@ CONFIG_SPI_ROCKCHIP=y
 CONFIG_SPI_QUP=y
 CONFIG_SPI_S3C64XX=y
 CONFIG_SPI_SPIDEV=m
+CONFIG_SPI_SUN6I=y
 CONFIG_SPI_NXP_FLEXSPI=y
 CONFIG_SPMI=y
 CONFIG_PINCTRL_SINGLE=y
-- 
2.18.0.321.gffc6fa0e3

