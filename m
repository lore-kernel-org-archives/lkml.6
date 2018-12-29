Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D2FC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6933F20828
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 13:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1sUBtnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbeL2Ndh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 08:33:37 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36241 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbeL2Ndf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 08:33:35 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so19485959edb.3;
        Sat, 29 Dec 2018 05:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A9CGCUXo0DL9xsxniBKUOUCc5uB50j5v6oJSc35/j3E=;
        b=d1sUBtnvZbhwSsMdxCL4lC6uoFj6Y4yvmcOoT6TGqGT70UZa28DLMX0FNrnBH6ZTNY
         Qx25Ba0DCE6Hyz6OcyNBnQgc2XypBNqiMSaHCT8WktOs+WV81KFeYUPrYWe9EX9awzMs
         uQrluLqSAJPrZ80IaEMu27clTfAj9WkJ/BWSxLdOkV5jN16K7vlot5HtR13DHNU1TbpL
         xNlNzMLLhCgAsDBQu6tpqAluJ4nFjsfFYbEX5Nb37cj6O1rxLmaa+Vdo+E9vBoOBTCcp
         jXGFUn0YTyLomDUI0J2U0bcjLVBNt5NpPThFC1BmhKuW9vk+vNF2vJhZ/Ofo8JLIPrkS
         gy/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A9CGCUXo0DL9xsxniBKUOUCc5uB50j5v6oJSc35/j3E=;
        b=XbwRESm/sCPNLWKHlaEvbYNeX3ieDMDQRhsyoqFcj2CvDnQBVuDxbQdzS72RSRfcwz
         aJ76q+Q7ryVhl9QszHhXV+knNrnDfD8nWAw6MXHEXqZPhv9tWn+pbRaMkXK+tuWUzwJX
         2gGFA4DOi1nnUdb7J/+TCLm4lhD/UIe/ZoDJwB03oIx10y2eaUwJjODclk2xflQkz2g4
         Qe9Zr3rE3DSps/evSQxz8s5tf9ztCzTuzqNDIfyUU/dwFcJOoY9ExWO1SimumKE44/on
         YO1AqPVv+pvVZIQPVbGmS9UQSXxBW//gfJGRVPJc3kJWyGPa1ksfxvETbwHpicv84gzv
         /gjw==
X-Gm-Message-State: AA+aEWb0tJatZNHVlML2rqZwhsusZhgMCwIQCO3rjAk5/enKh8KzNALu
        MXx1/YfhEXDtdS+y1mZHJW8=
X-Google-Smtp-Source: AFSGD/Uwcm3TMhLtnB59jHhd8zvYH64jpys9HBxCmf/3/kLuH/vCaqOysmjHPT31yrel0zX9Dic6CQ==
X-Received: by 2002:a50:b964:: with SMTP id m91mr25927173ede.184.1546090413886;
        Sat, 29 Dec 2018 05:33:33 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d7-v6sm8023063ejx.68.2018.12.29.05.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 05:33:33 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v2 1/7] ARM: dts: rockchip: rk3066: add HCLK_HDMI to pmu node
Date:   Sat, 29 Dec 2018 14:33:12 +0100
Message-Id: <20181229133318.18128-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181229133318.18128-1-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A MK808 TV stick with rk3066 processor
boots normal with logo and console,
but after booting the monitor remains black.
This patch fixes a vblank wait time out
by adding HCLK_HDMI to the pmu node.
The HCLK_HDMI clock is now part of the logic
that enables the RK3066_PD_VIO power domain.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 30dc8af0b..b6b3a77da 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -669,6 +669,7 @@
 				 <&cru SCLK_CIF0>,
 				 <&cru ACLK_CIF0>,
 				 <&cru HCLK_CIF0>,
+				 <&cru HCLK_HDMI>,
 				 <&cru ACLK_IPP>,
 				 <&cru HCLK_IPP>,
 				 <&cru ACLK_RGA>,
-- 
2.11.0

