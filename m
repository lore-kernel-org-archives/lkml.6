Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6239C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2B2224E0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 16:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="GhPRvIWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2B2224E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbeKMCl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:41:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39479 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeKMCl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 21:41:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id b13so10104999wrx.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 08:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xx6q8O+0zXWvkOGamkkFroUdkt/kbjAzRkRaQXN2Q5Q=;
        b=GhPRvIWhBW5onZO0UKJ8Ys84yToh03eE1GHZkrBV7adCM2VHDNg0MXKy9jm8aU4s4a
         azA7b+zeo99P1cAJYZXEKtoC2sCnwIDwAJUv/q5V6ecY2pccwl6gA5IJaoocD9F56e+m
         rqwTGhpZ94RT7z+zTwXz/nyO0mIN4zsKEIjJ88YMOspHSxy2Hw81ubqeBa5e2h0no5rX
         e9h6GTBb9mueuBbkS/JjcA7M7UkRTDz5hUSoYywsJzdMTjZoZ+otgiSgI2U3LN36zXcl
         DK97Fkt4F4lRnJLovwWaAntz/z1S48Ktwx2rUanMHerrYOs7bOrOFk7aX9B3IOb0qqEx
         AFwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xx6q8O+0zXWvkOGamkkFroUdkt/kbjAzRkRaQXN2Q5Q=;
        b=JhPpSZ5QKyeGckkXkd1DmTY/v/gVjBCmIFbvw90lfAGY3sp3aR53RwJ/W8IMTjhusb
         M5OFq9tmG4t5pxziNacCInzJFkBpQQ5FPevQrss4ngzntkBzmXKuJLxh8fFVVBqEeDE8
         nVt9FZk1CNiQMO0Vje+9DpYp6iNCivsxtPw0NQrGLhwQffXcmaivSvZS6+/sDc7g2vZY
         XjSmktv6kkJevm+Jh2M6IjrNxSGxgzo6vY2dKzzR87a3kyY6LRWTec0yo40GpIVDrL70
         C4tulJ1tmhfV7ZedrvG3NyKrK5mZ+MFjZdNSVbf2jf9uhjUWtdfPih2wOB7KkKQkXS0Y
         0Suw==
X-Gm-Message-State: AGRZ1gLHwlFyEyBSGgi1tttyX47DHvZT2XjdUVqGz4nmBnww1qcS4oeq
        WrcELMiWTQpsSRA4vxTWgJL0Qg==
X-Google-Smtp-Source: AJdET5dRX0YFsHuLTbzh3HIBKpp1cuTavdAVJbnN0/xtWCowhCzv+bnsmVM7+IzmhwLrJp901mmAyQ==
X-Received: by 2002:adf:fbc6:: with SMTP id d6-v6mr1796277wrs.241.1542041243899;
        Mon, 12 Nov 2018 08:47:23 -0800 (PST)
Received: from localhost.localdomain (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id t187-v6sm7878770wmt.45.2018.11.12.08.47.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 08:47:23 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH] drivers: soc: Allow building the amlogic drivers without ARCH_MESON
Date:   Mon, 12 Nov 2018 17:46:54 +0100
Message-Id: <20181112164654.28594-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current condition makes it difficult to compile the amlogic/
drivers with COMPILE_TEST, or without ARCH_MESON in general.

Fixes kbuild errors with patch series that depend on drivers in that
directory, for instance the meson video decoder.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---
 drivers/soc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 446166ba0bec..90b686e586c6 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -13,7 +13,7 @@ obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
 obj-$(CONFIG_ARCH_MXC)		+= imx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
 obj-y				+= mediatek/
-obj-$(CONFIG_ARCH_MESON)	+= amlogic/
+obj-y				+= amlogic/
 obj-y				+= qcom/
 obj-y				+= renesas/
 obj-$(CONFIG_ARCH_ROCKCHIP)	+= rockchip/
-- 
2.19.1

