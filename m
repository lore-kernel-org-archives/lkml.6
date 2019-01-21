Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE48CC7112F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A924220870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 11:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PMn4Uwyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbfAULMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 06:12:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35785 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfAULMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 06:12:36 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so9360257pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 03:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GZZw+Hr+hHbP5sXTJ433pxgAxN3fV6oKqp+6KB31Tb8=;
        b=PMn4Uwyz58/5Um/YnVmGFYmb4HbN+v7xUJ8zjn09cF0rKhN54/UADvAcm3jhYhCQ7E
         gv3Q3p02MDYEu6zQB7VI9/GyUjmeuW6svHBjYlzZPBr4FIli5Xw0pXm9l5ccvB6cBdJP
         +qQRY9vhWBCZQlnh3GFVhH1UTPTYsPeqCcbiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GZZw+Hr+hHbP5sXTJ433pxgAxN3fV6oKqp+6KB31Tb8=;
        b=Ih0Co5HUdmcqONO8aCkT/LhaBPsHtbNfTnGN9fUUIcPT0aZmt4TO4hskYWpMU2rnbQ
         33pEublj1lwqgqNa7uzYgXEzEz/NIgd7DCFQyqhgEeS//YWsBWP1NHWb7aFE5Hav9Cd1
         sourPesf13/uKTMtnBT7upSaV5CalCpLhbQalW5cs1okvh7RGHdNJUCI87Ad9la71w0E
         rEnKikDgOn8Z63zYTubS3ifT51byVUd2GsLy3ENywFkyLOhaCQo63AI3VsthMMEL5V+v
         YqTkL8CVsgOgpfOxt7oV99BoZyrhzbOUph5wFQFwQD8b1mdQ4w3TEwpTMTzglkmi39tB
         /mqQ==
X-Gm-Message-State: AJcUukf+2aMic4jKwQPJ8gUno75jG35GbbI6vgQIIrlBPoOsd6mJtG2X
        fBazaTj8/Y825axa3RLvhOV5zA==
X-Google-Smtp-Source: ALg8bN6ITrR9sOEzrGQUNC2uzOcqUV5K55w0yPjnlsuVGPMs1ebBtgFOGBm+9mxveJAc5RQTfgcNHA==
X-Received: by 2002:a62:5793:: with SMTP id i19mr29519806pfj.49.1548069155754;
        Mon, 21 Jan 2019 03:12:35 -0800 (PST)
Received: from jagan-XPS-13-9350.domain.name ([103.81.77.13])
        by smtp.gmail.com with ESMTPSA id a90sm21821288pfj.109.2019.01.21.03.12.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 03:12:35 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 2/2] arm64: defconfig: Enable SUN6I Camera sensor interface
Date:   Mon, 21 Jan 2019 16:42:23 +0530
Message-Id: <20190121111223.18384-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190121111223.18384-1-jagan@amarulasolutions.com>
References: <20190121111223.18384-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable Camera sensor interface for Allwinner SUN6I SoC's.

This support enable V4L2 platform drivers static and
VIDEO_SUN6I_CSI as module.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Note:
- These change depends on A64 CSI support patches

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index eefc1ff0c1e0..cbcd2a98cd1a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -433,12 +433,14 @@ CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
 CONFIG_MEDIA_CONTROLLER=y
 CONFIG_VIDEO_V4L2_SUBDEV_API=y
 # CONFIG_DVB_NET is not set
+CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
 CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
 CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
+CONFIG_VIDEO_SUN6I_CSI=m
 CONFIG_VIDEO_RENESAS_FCP=m
 CONFIG_VIDEO_RENESAS_VSP1=m
 CONFIG_DRM=m
-- 
2.18.0.321.gffc6fa0e3

