Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F95C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3840D20863
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 15:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="FzYNB9vh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbfAaPUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 10:20:54 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33512 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbfAaPUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 10:20:52 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so1622690pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 07:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SO2+hNh+R2hjZNepqm+Cb6kTtGpzyd/D4ehTmz8FUkc=;
        b=FzYNB9vhS2LCUsuU8GYXrmhSim8C3MhNXkqQlapiN7bonJ4QZdpjlSeC9S4Vg0uBLj
         a6DBGrVtPnLdEd02Vj6ieQMl3ench8M1MroKxaEfJjsrxrJLk38kvXT1iC0lPRvqOdrZ
         qWK5/RpeneSveKoEd3vzG+ILuOxwyw86iFKt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SO2+hNh+R2hjZNepqm+Cb6kTtGpzyd/D4ehTmz8FUkc=;
        b=WUNxYVwDyYqXoJi0bEb3iM1MqBJJK+OVpC3pJM+eWypjDkEYIROy0IygRrzx9J0aW2
         oZiOSvUVZZfNKZ3vjQTz06jU3QTVD9tCdJ6aJRfLrk0B1i5UbYGdVLasY1zMLwJ/m1lz
         /72NXmg/xxE20KOK4J/IjBxhbDqJgXfp6wf7PAt7xtXHf83CR6aTp7FyVt7l1pSo+jYN
         cn5ArOIRWV1o+qpw8mps4kP3RzM9mev/CJgjYPFuEvsp7ixVJhyJAdMsdC8UaycFrmzF
         neYjY6e13bRXb3oHsQNizTeH0JabxxRllL53LeWcZo6Ozn1X0npXnrku6EGSZCiL5E3x
         NbFw==
X-Gm-Message-State: AJcUukc3det53wfKfDAaap/vJiWdgG5DSJ+l6sxbPjLLoY5kE9zXjaNm
        tUlp3XtkAUnj9Kwe3XBsakKhrg==
X-Google-Smtp-Source: ALg8bN51eKzYXlDOqbuxHYxN2tP+wpZh8Qn72GxxDM9wicOyaEGMz3B22L3Li+/I0eHRzI3TR5irNg==
X-Received: by 2002:a63:1321:: with SMTP id i33mr32408980pgl.380.1548948051950;
        Thu, 31 Jan 2019 07:20:51 -0800 (PST)
Received: from localhost.localdomain ([115.97.179.75])
        by smtp.gmail.com with ESMTPSA id u186sm6633664pfu.51.2019.01.31.07.20.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 07:20:51 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 2/2] arm64: defconfig: Enable SUN6I Camera sensor interface
Date:   Thu, 31 Jan 2019 20:50:35 +0530
Message-Id: <20190131152035.7138-2-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20190131152035.7138-1-jagan@amarulasolutions.com>
References: <20190131152035.7138-1-jagan@amarulasolutions.com>
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
Changes for v2:
- rebase on master

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8f36b1e8017a..67132c1f0072 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -467,12 +467,14 @@ CONFIG_MEDIA_DIGITAL_TV_SUPPORT=y
 CONFIG_MEDIA_CONTROLLER=y
 CONFIG_VIDEO_V4L2_SUBDEV_API=y
 # CONFIG_DVB_NET is not set
+CONFIG_V4L_PLATFORM_DRIVERS=y
 CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_SAMSUNG_S5P_JPEG=m
 CONFIG_VIDEO_SAMSUNG_S5P_MFC=m
 CONFIG_VIDEO_SAMSUNG_EXYNOS_GSC=m
+CONFIG_VIDEO_SUN6I_CSI=m
 CONFIG_VIDEO_RENESAS_FCP=m
 CONFIG_VIDEO_RENESAS_VSP1=m
 CONFIG_DRM=m
-- 
2.18.0.321.gffc6fa0e3

