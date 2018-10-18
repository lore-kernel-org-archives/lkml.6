Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258EDECDE3D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9F38204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 00:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa1PdMqB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9F38204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbeJRIqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 04:46:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40285 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeJRIqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 04:46:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id z204-v6so3982322wmc.5;
        Wed, 17 Oct 2018 17:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xcnfFYizHMxnUPllgOX1D8hJjkZn9o3CAUyNT0aq2B0=;
        b=Xa1PdMqBs0vvD+nZiXyZ0pJHnr8Z5PMsTIWSTKSGXIL/VgHUl2KSGe/GCWATYyC8iA
         POUUNxjOHSVhV6ftsZn/Uqmjc0tVkR02uDBC2J1fgjooc4cOSuK4lxd2mNe2WWgGmbDf
         bE5GLAphT6U0U4C5/jZDm6eQ0ogLi9T45uxdBDWV1pdPpKgw1wrwiow7NVfzfTe2kXaX
         +9J5+FasBRXL8lv2dHvGjgLHy2rIxxpGqjfzU37E2MolVLE9Hz+p4q703EQnU7ZaudS2
         qFmqJsm/FVt9CV8mrK3q+lSmprKwYOzh5JeAky5lWfI3+OTMYyx95XQ/v+bKX+/VUQpU
         VYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xcnfFYizHMxnUPllgOX1D8hJjkZn9o3CAUyNT0aq2B0=;
        b=B/nEs855BHGUNr3lzR6btTWpJz3vPqzrVrZCvqY5wtALiMo5r1PRQVh0Qq9nkuUbIO
         gRQcRSbaHDQ7VkaEIsl9mZgjAO6ysbjNsE5Oz9gJ5LTSYoyT23rGnMKd+/0BzC2CSMou
         1MIgcssEWXv08+ipyvYGhqJCBaRVaj6O4W4QqzpUpQVONeUtHtxZ/vagzR29X9N9EsNf
         4L+LOt/joDvBFepRoKRX5WJgL/tM9wnJrqIA7Y7oGZ/41IROKgGxrpEyTJDuRY2YT4aN
         Pc+8JL39lEG53H1T+D8Bc9I3wSTezR0zS9EZX3/VS8wVZJlAXA7LN6kluUEjUyz4O13Y
         qgXg==
X-Gm-Message-State: ABuFfohaSuGgETkOKh8Rk4tiCU+r/bYiCfoD69U/EvZPMWd+lV/fQaPV
        RhKhYVM2JIK13jG+3LfNeYw=
X-Google-Smtp-Source: ACcGV62tsjVwyNt+Mul70WMtBRfu+uWCYoTJTeiqCP4pKfr5ynpEFnPU5MN4HdTJye7JVytp5JFlpA==
X-Received: by 2002:a7b:c151:: with SMTP id z17-v6mr5233762wmi.39.1539823714304;
        Wed, 17 Oct 2018 17:48:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j9-v6sm13622937wrt.32.2018.10.17.17.48.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 17:48:33 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ARM: dts: omap3-gta04: Fix comment block
Date:   Wed, 17 Oct 2018 17:48:16 -0700
Message-Id: <20181018004816.6627-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling the kernel with Clang, the following warning appears:

arch/arm/boot/dts/omap3-gta04.dtsi:385:56: warning: '/*' within block comment [-Wcomment]
                        /* OMAP3_CORE1_IOPAD(0x2194, PIN_INPUT | MUX_MODE0)     /* mcbsp_clks.mcbsp_clks */
                                                                                ^
1 warning generated.

Fixes: 3c10507a39e8 ("ARM: dts: omap3-gta04: add mcbsp (audio subsystem) pinmux")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index d5fe55392230..e53d32691308 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -382,7 +382,7 @@
 			OMAP3_CORE1_IOPAD(0x2190, PIN_OUTPUT | MUX_MODE0)	/* mcbsp1_dx.mcbsp1_dx */
 			OMAP3_CORE1_IOPAD(0x2192, PIN_INPUT | MUX_MODE0)	/* mcbsp1_dx.mcbsp1_dr */
 			/* mcbsp_clks is used as PENIRQ */
-			/* OMAP3_CORE1_IOPAD(0x2194, PIN_INPUT | MUX_MODE0)	/* mcbsp_clks.mcbsp_clks */
+			/* OMAP3_CORE1_IOPAD(0x2194, PIN_INPUT | MUX_MODE0)	   mcbsp_clks.mcbsp_clks */
 			OMAP3_CORE1_IOPAD(0x2196, PIN_INPUT | MUX_MODE0)	/* mcbsp_clks.mcbsp1_fsx */
 			OMAP3_CORE1_IOPAD(0x2198, PIN_INPUT | MUX_MODE0)	/* mcbsp1_clkx.mcbsp1_clkx */
 		>;
-- 
2.19.1

