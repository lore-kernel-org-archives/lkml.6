Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEA9C67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F357920851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 20:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rOy0lhNj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F357920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeLLUwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 15:52:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37507 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbeLLUwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 15:52:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id 80so8891285pge.4;
        Wed, 12 Dec 2018 12:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v69aHLFvfy/7W5kF/1wqVBEZr3a+tgiAo+VuWb8wLUA=;
        b=rOy0lhNj6rwoN1virV5gfDokfzJeAs9cCawWNTXoJwpyHcsKGR1RmZAtJRkEV8ceU8
         zeZWVevjvg8dQz7VLwt6wW2XJ6ab9QlLFDWxXS1L4E/YpAm7VXajBTP5nVbarmMN9fMO
         Mfc6+BoXnJgUHIofA9koTAnse5owp5k2wLPumNBMYOvKZMJIx9E1SarOW5HUJ8jt0w1A
         K8+UAqhUtVjwkOWQVTn5N5/5NKCFMAFT1JNk0rTGDgVFhz64dm0Ca/nxVzu8iTO3DjtP
         M8CCstr0EQvGTpp4CBAY3JNJRzbsM32hqlhIXsXTfDBCIrQmIkWnX7FR6Vd7dDDVwnKd
         mU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v69aHLFvfy/7W5kF/1wqVBEZr3a+tgiAo+VuWb8wLUA=;
        b=eWnnHom6TvTZsyCJOgOv1wBDD/gvolb/dwpBIZzhEmk4WAhJzOMlXk3wj8Yl/CI+4L
         qzeGkQyY+YbBV4QyMy1Jsx8ffh9tokM/SCPr02WryaLAwT8mkW7X1uH/qUumw8817aos
         UWzoDSDxnJc04XY7BbMWNDjyBb3A63WGUSr9qJgaQMpa7Rc+A5jebguyj0qiFnK1R07Z
         /c9AaHcZP1zdDaJ4sDIVXeTu+qasUxAq1R9EIRBzE9CjguDylQXt/rygagUzjy8EaEgq
         +xu7z6jNzpEKj7K9n0X76i6Hz9kwwUiJs9xluuwlc/hmT4bi/mKh1Vv0mNPLOqSvyXls
         KZnA==
X-Gm-Message-State: AA+aEWbU4U7E2LzPfU2hqXpmRroTkuxqkt2akcnl+cY3L8bIBXL341yc
        KFCPOZww5KcjiRnCQZDdiz4hqa8p
X-Google-Smtp-Source: AFSGD/VqpfBJCw/lEZF+t09E8CwDFGM5rxK6B6oYmWwUuK2ls4gcfzIIfBm+JPEG80lwG5+GFJfing==
X-Received: by 2002:a62:46d0:: with SMTP id o77mr21794456pfi.172.1544647962541;
        Wed, 12 Dec 2018 12:52:42 -0800 (PST)
Received: from localhost.localdomain ([94.29.36.169])
        by smtp.gmail.com with ESMTPSA id p2sm34753860pgc.94.2018.12.12.12.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 12:52:42 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 07/24] ARM: dts: tegra20: Update Memory Controller node to the new binding
Date:   Wed, 12 Dec 2018 23:38:50 +0300
Message-Id: <20181212203907.23461-8-digetx@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181212203907.23461-1-digetx@gmail.com>
References: <20181212203907.23461-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device tree binding of Memory Controller has been changed: GART has been
squashed into the MC, there are a new mandatory clock and #iommu-cells
properties, the compatible has been changed to 'tegra20-mc-gart'.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra20.dtsi | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index dcad6d6128cf..8c942e60703e 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -616,17 +616,14 @@
 	};
 
 	mc: memory-controller@7000f000 {
-		compatible = "nvidia,tegra20-mc";
-		reg = <0x7000f000 0x024
-		       0x7000f03c 0x3c4>;
+		compatible = "nvidia,tegra20-mc-gart";
+		reg = <0x7000f000 0x400		/* controller registers */
+		       0x58000000 0x02000000>;	/* GART aperture */
+		clocks = <&tegra_car TEGRA20_CLK_MC>;
+		clock-names = "mc";
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 		#reset-cells = <1>;
-	};
-
-	iommu@7000f024 {
-		compatible = "nvidia,tegra20-gart";
-		reg = <0x7000f024 0x00000018	/* controller registers */
-		       0x58000000 0x02000000>;	/* GART aperture */
+		#iommu-cells = <0>;
 	};
 
 	memory-controller@7000f400 {
-- 
2.20.0

