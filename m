Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F288C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3872147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="zjHDbhlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfA1SXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:23:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35301 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1SXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:23:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id t200so15110669wmt.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KF36F6q9GQzGHJ20m9zEs0OSKLwz9Wn20oRSDsKSvn8=;
        b=zjHDbhlkRCr07+TN1SMYNQ5eDsCYWPn44MbDZJoK3N4hCs0Ou/GHl8txK4GZCV/UeU
         ONr2lwM40JdODhiJzwQquNRpyDcZ72xiI83sDVIZXMR6wOMuZMn/ikiUdeRN+eVg+kzZ
         qaXTyLwoqZIPX5ubXieyc5QpU9CptnqN2y3RjedjkRTKD1HmroGseXq4y8G9b73VU2zF
         +WVpb2uUJCKXn0PnQFetdRhLWU2NXrJOzcem/6s5KRrHsvzd4nEA7QADgS6rHGeb4y6S
         6fQ7QVrnGa/TaKJmzFmdD60blf26Zwo4TlMZfHGquaTLstW96ReTPiHzAOnf7ewAYxVh
         x8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KF36F6q9GQzGHJ20m9zEs0OSKLwz9Wn20oRSDsKSvn8=;
        b=eN2sOgGDB3aaCtO7uRPJ8qqBF5etT9yyQwqwlzFEgUn1J4nh0yr+CjZCuCZoYRKF57
         xRdW6/dAXHvJ5k+mBH+K8Q6CNyLT1xE2Th6J+0p1XPCnCf0bWcqRNEx/BizXvIKjp7uW
         2k11BSrZO4OAmoH+rgQHM2bwmf7kcThTIfr+HK5ejRR2hm/2oguPUE0G9kMxUa5g0szy
         7BKgU0wfuiRnNApTT0wozfw40irIpYccjOY3d9k/elkvdy/FFYgAcC+ZSeIRdJK92Y3h
         J0nY6tJ3HEeE8QWCwD/c1akPwh08uZRtnEtdK0LdEAvXVqUFmFt/RHEfDovEX9cneptG
         2w6Q==
X-Gm-Message-State: AJcUukdWIZ+NEyk4uWPyelcNFAHkTno+8GOIFT0HkT1T0tTQ3jX6PiQ6
        3f4kTYMfUZU3bZ/wmC08GFBgPw==
X-Google-Smtp-Source: ALg8bN49XeLSs+dhj5l9IQ/0Ag8h3yAaNs1LWB9trd1NPYyBk8ti9OKURggjsFGXYvd6jAbnXkQOhA==
X-Received: by 2002:a1c:d00d:: with SMTP id h13mr17657339wmg.13.1548699781116;
        Mon, 28 Jan 2019 10:23:01 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id s1sm169223758wro.9.2019.01.28.10.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:23:00 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: meson: remove COMMON_CLK_AMLOGIC selection
Date:   Mon, 28 Jan 2019 19:22:52 +0100
Message-Id: <20190128182252.32589-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128182252.32589-1-jbrunet@baylibre.com>
References: <20190128182252.32589-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selecting COMMON_CLK_AMLOGIC is not required as it is already selected
by the SoC clock controller driver

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm/mach-meson/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index b16831697183..15e9cb75738e 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -9,7 +9,6 @@ menuconfig ARCH_MESON
 	select PINCTRL
 	select PINCTRL_MESON
 	select COMMON_CLK
-	select COMMON_CLK_AMLOGIC
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 
-- 
2.20.1

