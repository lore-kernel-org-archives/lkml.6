Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B87ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17AD521547
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XADdqMpP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17AD521547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeI0U0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:26:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39807 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeI0U0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:26:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85-v6so2055005pge.6;
        Thu, 27 Sep 2018 07:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C4Mdmn+WkEtGLorwYz0JZmLfHLWBJ/DuiHb977olMvg=;
        b=XADdqMpPZcfcLfd4cFabL86Y55bDfaHCSKO1EzpbwpdLI8vIMWc6tMJ+KJ/wRzHp0g
         n57DS25FsCd5FfotNfG7U3CGFxzmBQWNEtLOX1xCehJ0FJL+sZl9fovxJzjPR2Ufs280
         vRIzm73ni0D+1rXDihXZYIL6bUD4l6icWPhYqdYg9Rt6fjyafSxFOWeTmUtGDh19zVMv
         ZDAG42Z758BBLZbFQAeH+2k6QEoGRZubIHANCh1fA6opwE0FWev76byLe2gGDkdzSdHk
         YaXe0EP/BEX5zeQehFx1/VfNGaiTIZUxJ++DbUmFbU97OXzIpY68c2t1s2VYKXmsV69j
         zkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C4Mdmn+WkEtGLorwYz0JZmLfHLWBJ/DuiHb977olMvg=;
        b=odSFLfW/OyLBceuTKttmL8WUMgRtQ6qD0cYWS5MfHPkA0nKF1pC3QGgtWAnd8nrDVm
         HbqWOp3IT5Z4HGxCCWM8Uv5Bntetj5bN/TuSvgi8Z/m44f/D377RIx+aTN+bew7chcx+
         zlPtzma4BrJSsD35SeflO1oMoomWoZZPMlTDp+vSfNBAjcyEQrWq6g73PDED3MUpltnx
         tUgO10KZYawfHGcVKEZcR8sM7W3ycNnZPVvc9yPFBqCZdd5Be2Bjcw8bqG8yXXg3bZoX
         yN9tz3UrZM/Ojor2BZhR5olpldoZezXSru3CPcNpDQmfYcgmYLKrgufklrYgEKh5i1iR
         S8cA==
X-Gm-Message-State: ABuFfojtB5KRLyssKOlnzSGjqyCWWBO8LH05qJBn3C/67qG/Xbiz8Kpw
        +ZOxbUpstsMF2pQadlNz1VA=
X-Google-Smtp-Source: ACcGV63Lt042KJqMl+f+8g7iVpR2jNwBHBX7xNyf3OpeTQoEZH3lUKUdgi93ribUoHcHmM7tcGci5g==
X-Received: by 2002:a17:902:744c:: with SMTP id e12-v6mr11323902plt.186.1538057283998;
        Thu, 27 Sep 2018 07:08:03 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.185])
        by smtp.gmail.com with ESMTPSA id r205-v6sm4259763pgr.11.2018.09.27.07.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 07:08:03 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: [PATCHv5 2/6] ARM: dts: exynos: fix regulator min values of LDO13 for Odroid XU3/XU4
Date:   Thu, 27 Sep 2018 14:07:34 +0000
Message-Id: <20180927140738.1006-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180927140738.1006-1-linux.amoon@gmail.com>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
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

