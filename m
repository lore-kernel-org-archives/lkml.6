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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBF8ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79FDE2154F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJGYFNvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79FDE2154F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbeIVNpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 09:45:41 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38850 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeIVNpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 09:45:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id u11-v6so6940682plq.5;
        Sat, 22 Sep 2018 00:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zVV1QVWDSXH8FUaryikZbig4x0P4dBZVMEQFAsQAPYo=;
        b=cJGYFNvyOy028cEmQ8aVEH3G7LdSBVG0jKMjw6ZHzpftNuVqiBCW/fhUbZk5h0Fh3t
         rJftWGw7FO7o1jwQCt7Awup8ac37C9uU2bKd8ykTeLURVgCUzUVpCf+I1yV9j22hvwhL
         CMmqMlUubIFHmFMfGfh0D7P4+sFKLUMDgXFQMO0IiiKMicRNZ2tqIHD6CTW0U/pg48Zu
         Bq7KXgCIWVnkomRFzMpTzJO4Vsb1n39+L+aC0Q8Kl1VeE62XS7wVC+cVOprE4/4AlBUT
         jAYeXhBRYZJ42mtRX9UCMVUQhuaVRgtwJbPJPeAiXJ9Ww3XXFYwlxCEissTFtYBeFXkg
         FS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zVV1QVWDSXH8FUaryikZbig4x0P4dBZVMEQFAsQAPYo=;
        b=jW1j1djuCgVivbXeqRSLyYl6GEhvrNdC7zIHAMHJ2N+qG+iFzD+CVHyBzzBl4adlrF
         6pI3/o/L5/QSlDS7pU694hPnywasCVmbuqMEgf8t7w/ha23oWvQPM4Bj0NzP5ZYGk97H
         3wvBN4KX4I22OnrTchu9iIGSEjZS/Px7X4BD72Fh/WywBDPdPPjImLe3j2ne/P3GK9+r
         ZYXntG0rBx2PZSwkhvWg8ikKVcvTdxXU1IT08OP/m4rRYNZpl/xRcs3fr49IgT2XUg9M
         SsATSK1akSzDL1JzJW0wNOzXqfQAZ3UzFYUWS1jZAiijlxayXy6PzOaO2q8aVv9rk/qG
         OuWQ==
X-Gm-Message-State: ABuFfogbPotYkhzB/GPuHtEfYJH/qBFoxtjrSqqVTD+O2ceF2SwmNdZv
        2OkC/znHEe7Go016SN6Gz3GpPWhg
X-Google-Smtp-Source: ACcGV6103sh4/UH8F22irzFOTWmHMuYmoIu8BHiboNrytPncJzJmItOfCx2hZAxk8Lo4jq0+PewCOA==
X-Received: by 2002:a17:902:290a:: with SMTP id g10-v6mr1478698plb.110.1537602783330;
        Sat, 22 Sep 2018 00:53:03 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.116])
        by smtp.gmail.com with ESMTPSA id f67-v6sm53219253pff.29.2018.09.22.00.52.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 00:53:02 -0700 (PDT)
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
Subject: [PATCHv4 1/6] ARM: dts: exynos: Added UHS-I bus speed support
Date:   Sat, 22 Sep 2018 07:52:33 +0000
Message-Id: <20180922075238.884-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180922075238.884-1-linux.amoon@gmail.com>
References: <20180922075238.884-1-linux.amoon@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for UHS-I bus speed tuning for SDR50, DDR50 SDR104.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/376263.html
Changes from above.
Fix the subject and commit message.
drop sd-uhs-sdr12 and sd-uhs-sdr25 as host driver is not enable as of now.
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index 2fac4baf1eb4..0508e6891f41 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -503,6 +503,9 @@
 	cap-sd-highspeed;
 	vmmc-supply = <&ldo19_reg>;
 	vqmmc-supply = <&ldo13_reg>;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	sd-uhs-ddr50;
 };
 
 &nocp_mem0_0 {
-- 
2.17.1

