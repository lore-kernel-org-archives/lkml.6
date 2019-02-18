Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE2DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4DA217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550511225;
	bh=p4SdIGkvVgtQhEIp2ZxCGiKPuadNN6Gytyjdd1O37WA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=aNtOvI0Bio0b0gcZD2+88wfc/j5o/jP7YA6RwVevIkE2xJyh4plPQ7Br7FfArisP6
	 D+i11k156zDX6GCEmI1EBt6AfWgfrLDfIgze2ra1WNcZ5AHIP6a/+/hhq0Ac6luR/w
	 zCefE8LZRBtIvV4DVcNMSQZZ4KACppDSd28/6/FM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388175AbfBRRdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:33:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:37284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729822AbfBRRdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:33:44 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 939972177E;
        Mon, 18 Feb 2019 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550511223;
        bh=p4SdIGkvVgtQhEIp2ZxCGiKPuadNN6Gytyjdd1O37WA=;
        h=From:To:Cc:Subject:Date:From;
        b=UHlh3SBtznH3NUfKYTZQUVDYzvshrQQyOO+r2GJxd8R/91Vcjdh4HFPyX9DkG0AMs
         jqSc2s02e3laqHR13BM6rbpf4bZeoK1dI6dq5VjRogrY0UpseM374GsTvf6ugk1cox
         v8ySh0U/rosrJh3ihlTcSC0eXkQ/xFMTTfWWGE7c=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Markus Reichl <reichl@t-online.de>
Subject: [PATCH 1/3] ARM: dts: exynos: Use stdout path property on Arndale Octa board
Date:   Mon, 18 Feb 2019 18:32:56 +0100
Message-Id: <20190218173258.7071-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing bootargs with stdout-path property in chosen node allows using
early console by adding just 'earlycon' parameter to kernel command
line.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index 3447160e1fbf..832757999e4f 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -24,7 +24,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttySAC3,115200";
+		stdout-path = "serial3:115200n8";
 	};
 
 	firmware@2073000 {
-- 
2.17.1

