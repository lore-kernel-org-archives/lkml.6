Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D688C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D11BD2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 10:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="tDMMMXak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbfARKeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 05:34:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43559 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfARKem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 05:34:42 -0500
Received: by mail-wr1-f65.google.com with SMTP id r10so14370503wrs.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 02:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P9AjnAWzF1joho7fIkFSGa6Vz8VBjxoU9IlCRi8abS4=;
        b=tDMMMXakZ2OKycxV63R0kDoca3W+5RsF4yYMPAY5/VGS3twWcTA3vTJYyzqe+6L5OW
         vKmPWUZqYNKtIkoQIyPtvypB4SbGzZDrP037Y16eDj/i0SIlX+5+X75d2bDoPnvuj25F
         igllX71zAQkQFmfbAizRoWOUTVut8TwGbQDtiSX7K3/mVzjmKngqrBklbeduDTHdXETb
         agXdfHF24nAzTqQ9/wem+vRrgSScvmXbPw2DC3S6Qa/uXb4jjGFHGsVe3PIupCyMw+As
         JnNkYftWgnbfqsDoTTkfYPZfft4rtq0styc1YRvVRWVUMm4YlkALzXGa1Cmlk3wYlqj+
         GROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P9AjnAWzF1joho7fIkFSGa6Vz8VBjxoU9IlCRi8abS4=;
        b=CIw7JWhfRkAvzI8HF5sYpsV4pSFgHCYqQ9zSmOaKa4QM0cBArUuGEZ1z08KlEztmUt
         yaOz41/OEdh5UfspCDA5ycf7zASmoO0JQ+pA1KwbvI47Xv1eViopR6QIxWHKYKsXolEl
         V74l67Z4gYbnQwfyb6s1oLlorb7EOQJszJXNktIwx3/NBPP+oaMZmkzP0z2kNS0DDbij
         +uBszW4Vb/9GDNO55L7KjOUsNu7nBt+x3ek2+kO/C5ruUGySQHjARgvULNxMUMuzyDl3
         oe+4cCjmOfadeM2HqhhXZEjpqp3ovnxHycreW9bbiQl1f4xLvTaZSm8NucLr2U5k+lDZ
         ZnxA==
X-Gm-Message-State: AJcUukeiB1gAfmle+9INigrytI+MevjbGdMuMEQ5LCiHdbiP6eHfBBL3
        GAf33BtgZtbEorN4tQslZEUC9dNiltM=
X-Google-Smtp-Source: ALg8bN5FfHDfot/9R7M6iyDxWcxTidV/KLl/0YgGRrJ24gZo46Tyte8I3t6T7G36YOBo2J3jgMoILw==
X-Received: by 2002:a5d:4382:: with SMTP id i2mr15808334wrq.172.1547807680464;
        Fri, 18 Jan 2019 02:34:40 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id s16sm67066247wrt.77.2019.01.18.02.34.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 02:34:39 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-bot+notify@kernel.org
Subject: [PATCH v2 3/4] arm64: dts: meson: axg: add clk measure support
Date:   Fri, 18 Jan 2019 11:34:22 +0100
Message-Id: <20190118103423.15075-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190118103423.15075-1-jbrunet@baylibre.com>
References: <20190118103423.15075-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock measure device to the axg SoC family

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index f044473dc7d0..398b7ac1b107 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1610,6 +1610,11 @@
 				status = "disabled";
 			};
 
+			clk_msr: clock-measure@18000 {
+				compatible = "amlogic,meson-axg-clk-measure";
+				reg = <0x0 0x18000 0x0 0x10>;
+			};
+
 			i2c3: i2c@1c000 {
 				compatible = "amlogic,meson-axg-i2c";
 				reg = <0x0 0x1c000 0x0 0x20>;
-- 
2.20.1

