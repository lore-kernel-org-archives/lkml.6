Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F54C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C6721738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="M7+NLFO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbfA1SXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:23:04 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54301 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfA1SXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:23:01 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so15082316wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dSImbPlNDIywIdqcZTWb3Qn/6DZr3el7F0sh0GH4dss=;
        b=M7+NLFO/nlmBfyC59hkNptd7DHeK7vI5LyDgPf12El+xVGcTqxP9I/08aBi5m7B7a1
         kJ72Sc8hlsn3emC4zcH0K3UOx7ZYWG87qE5y1aFCO/rodTlY7gUQ8nPYDGfQiv1SDfjy
         sAa5gIjAQC49nJXDozRMozzVuaXXfPXjBjl3qo1FECRBT+Gyg2UlhzPQ4zaPfc+5aMCk
         poDogurE31LdjdeY+I46MmzQCuB29KKOfaPvYkb7i67r2KDHT789qQ1dDVHwqJynBm8T
         x7PI0LF+qtuMHZ8oKhRko0S98gPzuM2f0kZI50OHuEaO/OVgcht6QT4aKYGRFo/gi+XU
         JoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dSImbPlNDIywIdqcZTWb3Qn/6DZr3el7F0sh0GH4dss=;
        b=qci7C0w2if2HYWTfX4luvCAiE6uF2vcZsdWUfeBd2JoCnGDZUAyrhYFqVPPEjdmTXG
         gXH3o0e1DwgnE2tjCRLx2VdyTP/QNX5JS0VjMMDO+oXS4bSaH711B1VOZXNZ+yYyJzIJ
         8uheq/bAecg/OpUYlf5A2KNVWtEIo/FGLNPDGVWw45ejY8CWONp98pqTbQVLDN0Gx01u
         3xB+HBBCUiC0xi+9T46RacVV9qGMg3kjxkXvoucJMwCeFZW6cK2ZW1MdT2UQuHtgouf/
         QzHyHv/61fiA02v5fITDv346f/TE4e7+V4XToW42okNQhZ3KyGIdVc9eozvDDGkKIKsr
         E67A==
X-Gm-Message-State: AJcUukdmEn5nT6s0Nzz2j9qxk/M/U801SJ0oFjwPp6f0/JnBdN+h4Nk7
        mzCsAoNOVb3UuWtcJ+NnVUAH6w==
X-Google-Smtp-Source: ALg8bN4AEdWhwQn2iOThFA+3Lvqrn6rmwSBfNsb+pcUvuauS0gfrltNNs5Cj5CwUzlA/pgz+Ws4zhw==
X-Received: by 2002:a1c:6489:: with SMTP id y131mr17963873wmb.34.1548699779850;
        Mon, 28 Jan 2019 10:22:59 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id s1sm169223758wro.9.2019.01.28.10.22.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:22:59 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: meson: remove COMMON_CLK_AMLOGIC selection
Date:   Mon, 28 Jan 2019 19:22:51 +0100
Message-Id: <20190128182252.32589-2-jbrunet@baylibre.com>
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
 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 251ecf34cb02..819e74ae9224 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -112,7 +112,6 @@ config ARCH_MESON
 	bool "Amlogic Platforms"
 	select PINCTRL
 	select PINCTRL_MESON
-	select COMMON_CLK_AMLOGIC
 	select COMMON_CLK_GXBB
 	select COMMON_CLK_AXG
 	select MESON_IRQ_GPIO
-- 
2.20.1

