Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197FBC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05FD2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05FD2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeH2MKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:05 -0400
Received: from mout.perfora.net ([74.208.4.194]:53287 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeH2MKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:04 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MK2aJ-1fu68R2pPx-001RTP; Wed, 29 Aug 2018 10:14:15 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 01/31] ARM: tegra: colibri_t20: move aliases from module to carrier board
Date:   Wed, 29 Aug 2018 10:13:37 +0200
Message-Id: <20180829081407.11304-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:BXT0/FIisKzSJOfcLiGZy4mFL5XmzQSw/nR7gMH12t3hK/Ce79b
 tO1nC30C182T2rhTcDtbxgm+veZ0/TjBGRExqCqZd0/LRQw+WkNq12JWOMLO7zrt2y9mVBF
 /nbhmVfMQBXk2q9BMYz8Sbbj5OlzleH5Xebs98GXm1t19KIVHlGpPAV+Z/tksglJpe0aj6n
 M0VznVhzSQzNQg9nCEmWg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:XgneXXvZbQg=:4GCVEu+/GnldryJ7sffjZm
 C2+mXVTAoI27h5weO1TO7oLrJrrm50xPej/GoSdl7TRNOyw9y+uDH1I4UyBmhXFrpFVetZW8Z
 TLea72C4N362ikiteO02iXZh6MA0iVw7vFy37E3FIDa9Vw/9Ct49cfEpEqz6k5G7Rqf1/mcfl
 nlzIMU0lFBGOeuUz/KK9l0l16Y8bgcdn4L6FECELUo8N3SBuve7DbHvnj3t5YhhS+pdOL+1Is
 PMA7kkyGicUWNXymqkefWJQg7vKulL7DnJ036T4qam29mNa4PNdjZEQ4TDOcKYueXOFx7lilr
 wf8R4Xe/Kt1PSr8Wrio6R9/AdqNhDFwpcOmymqvfW/wnd/faFkZpzAK+P4XhyGUBdLfBnKuXv
 CVFd6CrQMLQvqgbqMcE9oRwqnFwGLgCUAdfyPlznU1wg6d77GFYRkw5LWWOA3ugGG2LpNuV3X
 Jm61QRAJE6GxplguRErK4iBuuruwkhbrv4RN13xpLonAD+uXGzPY9W3GhzFhgPUbQ+Dsb3GNT
 gngp7AbYy/jxjlPR1PhTaoE2x/OQIKxWbGe18k9kgmZ9VsvuX0AgWLqS0iwJvQNy8e+az6jU+
 Y2++aMWajWR7gsWfE8VFNlmS3KmOnRIPuyfKmeJBxfEckAacwNV5i70u+52FOpyulEvBPlXhr
 f2knuX/e8dd2F4DC46nFUIZ3zSRnMtujP6uRbvaiW32aGIB7+JVPmxjeneNkr5pI31FQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Move RTC aliases from module to carrier board to be more in-line with
all our other device trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 2 ++
 arch/arm/boot/dts/tegra20-colibri.dtsi     | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 57f16c0e9917..496b96e229d2 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -8,6 +8,8 @@
 	compatible = "toradex,iris", "toradex,colibri_t20-512", "nvidia,tegra20";
 
 	aliases {
+		rtc0 = "/i2c@7000d000/tps6586x@34";
+		rtc1 = "/rtc@7000e000";
 		serial0 = &uarta;
 		serial1 = &uartd;
 	};
diff --git a/arch/arm/boot/dts/tegra20-colibri.dtsi b/arch/arm/boot/dts/tegra20-colibri.dtsi
index fa1af2dc276c..e34ab4a76158 100644
--- a/arch/arm/boot/dts/tegra20-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri.dtsi
@@ -5,11 +5,6 @@
 	model = "Toradex Colibri T20 256/512 MB";
 	compatible = "toradex,colibri_t20-512", "nvidia,tegra20";
 
-	aliases {
-		rtc0 = "/i2c@7000d000/tps6586x@34";
-		rtc1 = "/rtc@7000e000";
-	};
-
 	memory@0 {
 		/*
 		 * Set memory to 256 MB to be safe as this could be used on
-- 
2.14.4

