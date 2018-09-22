Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C68ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1A62154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uBUufexw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B1A62154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbeIVNpp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 09:45:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46786 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeIVNpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 09:45:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id b129-v6so7028307pga.13;
        Sat, 22 Sep 2018 00:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C4Mdmn+WkEtGLorwYz0JZmLfHLWBJ/DuiHb977olMvg=;
        b=uBUufexwvZiirrI7IV3JLCe13iBO4pgnDdDmSJJUaF5gaCB+1FCUvG0Yr0zkAUqJvd
         9NxRo52K0nQ28M4xHyhI8ZgB+Bp98oEpYL8G1MC2axTwBuc0FmYmJgO+FUb2bisIvZcD
         w1p4FMXa4EWkmxiD5DWLUlDdfTlxRvAYpqH4ONtaxKarDcDwOcuGXj+gS/984X5iFT/6
         SjbkLR0iZHpvN0RLl+Xl0f/YiqqoyXYLwZ/4nRrKVUybwxQV3jf2ol1xQIaCj/e9/Abx
         sI5Ey+shpDw25u48HC0oyT7lNeE5yWTqoYFsivS7nEtewvSqNiedbqsPu/2l/F5VW9EX
         hquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C4Mdmn+WkEtGLorwYz0JZmLfHLWBJ/DuiHb977olMvg=;
        b=f21rm0DoC6UV3AqM5GtEFImq3gVHZ+5SifiuybF9/zf6AXou/fj7JQmmBJx6u+fmJd
         Xs17MDFUZDlbQ1oEK31AszzxDKDKpz+vikM35DiSvS8FVdAceEvXO0dDGLtI5RGri0hg
         tC6hN5mfXeZSHj0zgynRTXRTN5Rwn4Ha/i4XDyLJPybX0hLE9qKQ15F271hmyfxvqpsK
         HI64C7Z1O47n7CgSLJPT2k0he2TLwBDzsVSUfBNPj8B2Rdk0DavdunlGHL9agtn03pXf
         RnpdehQILdeE6ffj5Sh2orrODcae7DoPxh3mWjGv/n4vLakBC/8srJ7CnTeGkkcVrO+Y
         GNPg==
X-Gm-Message-State: ABuFfoh1rDGjaE7FEYZTIdD+bkfI95Tx4qjYC6txRth+t9LQ0/ZFki3V
        0nYJwZZk7/oQBKpOy4SjhWY=
X-Google-Smtp-Source: ACcGV63n1GoRb2iZ0BIakBIHhnkNTtFk1eqdAvKvEn+1yTyX2wkeFnG3Lb7Zl2/g0SHkUCy+zthd+A==
X-Received: by 2002:a63:4f14:: with SMTP id d20-v6mr1286301pgb.121.1537602787101;
        Sat, 22 Sep 2018 00:53:07 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.116])
        by smtp.gmail.com with ESMTPSA id f67-v6sm53219253pff.29.2018.09.22.00.53.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 00:53:06 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCHv4 2/6] ARM: dts: exynos: fix regulator min values of LDO13 for Odroid XU3/XU4
Date:   Sat, 22 Sep 2018 07:52:34 +0000
Message-Id: <20180922075238.884-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180922075238.884-1-linux.amoon@gmail.com>
References: <20180922075238.884-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the schematic sd_2 min/max range from 1.8V/2.8V so fix the
regulator min value to 1.8V. Without these changes sdcard will failed
to detect on booting when UHS-I tuning is enabled.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376262.html
Fixed the commit message.
drop the ramp-delay changes.
drop the vmmc-supply/vqmmc-supply changes.
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 0508e6891f41..15ab380e5fcf 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -231,7 +231,7 @@
 
 			ldo13_reg: LDO13 {
 				regulator-name = "vddq_mmc2";
-				regulator-min-microvolt = <2800000>;
+				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <2800000>;
 			};
 
-- 
2.17.1

