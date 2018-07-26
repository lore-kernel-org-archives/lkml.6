Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D8BC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05B9F2064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ELKUZomU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05B9F2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbeGZPbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:31:06 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38654 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729506AbeGZPbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:31:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14-v6so1885068wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 07:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=q1bbeBlbA5yGzCz3LYX30EBNKRjem+abrzOXES8zWXI=;
        b=ELKUZomUJ2W+Gkf92t2sb8t4JHUOvuFi2hXV1O60cjJvOt6f73EJtjj/+6WQetDynE
         WhPB/bCR4V8Yfxv9fkFOOIROaZx1NjYfuo/wFbDwacuI6/K1Ku7mVaKLW/SG9q1NzIHm
         MufFfhtUAQk8uDrXI0nSRQ3xX+bumZgz+1ly/3/iFhFCtlBjpL5geWKroA/xeYQqLqzm
         hfpf/CVK+Bhbsp5OyaaJuE4wOzlkeYRlunZpPh59jBLL8bweNPNmaSwUgECfYteqFe4e
         8NjG7f7GGOfdMlumUgQjlQueswxQ5EoDAmMiNLCetMv1d1CBZqW6tE5SCreiuZc507yq
         sGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q1bbeBlbA5yGzCz3LYX30EBNKRjem+abrzOXES8zWXI=;
        b=tug0hvX8mRXOnXd7CqSVWz33SC4p1sTwFIjNwyVkj7rOi8qaFjg4a2+3PZH/jxM8Bg
         z6XG1Tb/A+oH+9uwFCyGNJj4C2wUsKO95xK4g9eQWoAvnCddqBhJIKw1COlh7v6w4Dyu
         XzIzbXe6/YSfLvQ4w984BoQEraqsMdVcvB6/LkxsXi1azDGedXTD+Yi82r8x6Lh7iCC6
         wohktz6npyMu2DvIXy6cUce39fx40P3RaZF/50YKfBGmFwUtQQvT2PMrL5IXIMMU8czr
         Tx/5aU5k9PxTNmPH3xHNnsuKUWSNFeu4pqF2D9iUlRjx9W+fcjuud6FJvctTifld6VKx
         ZDrQ==
X-Gm-Message-State: AOUpUlF43VrbgGOl1D9R3WPrYfylLekF9hhwFVWst10frGzWsZr4XSmx
        srRGqqP5HsGKM8tgUrEE6OCmOQ==
X-Google-Smtp-Source: AAOMgpe93TLLgQwrspDx2cZNGsFdcQgZgKHP2X5DwtPFX+IvCEGOM5lASYCFgL6auT9Ok4MFbst98w==
X-Received: by 2002:adf:b2a7:: with SMTP id g36-v6mr1725501wrd.218.1532614441450;
        Thu, 26 Jul 2018 07:14:01 -0700 (PDT)
Received: from bender.baylibre.local ([90.63.244.31])
        by smtp.gmail.com with ESMTPSA id j9-v6sm3558062wrv.5.2018.07.26.07.14.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 07:14:00 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson: Switch simple-mfd and syscon order
Date:   Thu, 26 Jul 2018 16:13:58 +0200
Message-Id: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The order between "syscon" and "simple-mfd" is important because in these
particular cases, the node needs to be first a "simple-mfd" to expose
it's sub-nodes, and later on a "syscon" to permit other nodes to access
this register space through the "syscon" mechanism.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
This also has a consequence for U-Boot since the U-Boot DM is much simpler
and can only associate a single device to a node, thus here we want these
nodes to be an mfd bus to be able to probe the sub-nodes.

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 6adc8d3..3f0de9d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -342,7 +342,7 @@
 			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
 
 			sysctrl: system-controller@0 {
-				compatible = "amlogic,meson-axg-hhi-sysctrl", "syscon", "simple-mfd";
+				compatible = "amlogic,meson-axg-hhi-sysctrl", "simple-mfd", "syscon";
 				reg = <0 0 0 0x400>;
 
 				clkc: clock-controller {
@@ -1180,7 +1180,7 @@
 			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
 
 			sysctrl_AO: sys-ctrl@0 {
-				compatible = "amlogic,meson-axg-ao-sysctrl", "syscon", "simple-mfd";
+				compatible = "amlogic,meson-axg-ao-sysctrl", "simple-mfd", "syscon";
 				reg =  <0x0 0x0 0x0 0x100>;
 
 				clkc_AO: clock-controller {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index b8dc4db..d88699f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -344,7 +344,7 @@
 			ranges = <0x0 0x0 0x0 0xc8100000 0x0 0x100000>;
 
 			sysctrl_AO: sys-ctrl@0 {
-				compatible = "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd";
+				compatible = "amlogic,meson-gx-ao-sysctrl", "simple-mfd", "syscon";
 				reg =  <0x0 0x0 0x0 0x100>;
 
 				pwrc_vpu: power-controller-vpu {
@@ -431,7 +431,7 @@
 			ranges = <0x0 0x0 0x0 0xc883c000 0x0 0x2000>;
 
 			sysctrl: system-controller@0 {
-				compatible = "amlogic,meson-gx-hhi-sysctrl", "syscon", "simple-mfd";
+				compatible = "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon";
 				reg = <0 0 0 0x400>;
 			};
 
-- 
2.7.4

