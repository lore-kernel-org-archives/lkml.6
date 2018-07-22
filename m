Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B9EC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20DE20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20DE20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbeGVRrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:55 -0400
Received: from mout.perfora.net ([74.208.4.197]:53575 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731282AbeGVRry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:54 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MIxBv-1fjlTL3Cf3-002WqU; Sun, 22 Jul 2018 18:50:31 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 23/28] ARM: tegra: apalis_t30: add proper emmc vmmc and vqmmc supplies
Date:   Sun, 22 Jul 2018 18:49:31 +0200
Message-Id: <20180722164936.20581-24-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:89jPXyGwIhpV/OCJcSuFRCCOmTtOWiMCnVGG3r9ztzju0sT/O0d
 LAaszEVMIMDQI8xKmqqK9CAnO5P0of/idJ9H/5YpD8mP+hZrmTU7SVja2QqKdkld+g/P/LN
 F6Vva72wGCcwAZtvDcyH1h3SPo6dkJit6yb770ZtbCAmBsziPHBReOF/TWyWbfk3k/kkavL
 gJ8wgRV+DgVS+G9tQeiRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:T5WAfkSpZIg=:MT3sPBSOdohWOH0MPMuS4C
 QtqCbMkJ74z+/8LpZzoD5Yx26Hajy4jXe4kXvsFr4bi0+yybDtlH6TCSyMT3qNV15Z9OfClEz
 Duw5/AtlP2uPTbcI15MsVNkBAioqi5N70UNu53JPUUV6sU3jYbt+2BvzRL98Lj1qNrpxKRfis
 /jIZHwdHwr6MXFrx6kHlbr8g5m1o4NMx/XIYdOWf5P6aJ+PCFTK3qQM62sDfDMYvqD0Me1bxM
 M8NPw036txi1/sKOuV5E9pLE3AN7oTiFJjC6LB8IKqiO9oWz6EkIuP67QSHabmSkBQuZ2aHPF
 FtbajCjtjkgQBIc3U+VrKNAX1+A2jPfkGQ+K39HPDxHIvgqSlUextAUw3ue25FcFBleKu80M2
 /X7wv0Fv24h9AfF/uuHWA95E8A//aGNT8gniIInBxwqvnRPkOpbStzbSk6VZFZBPgM8EQuaqz
 WG/uDAH9Eck67rifSAA284FeIDE305jhrztlbONhPK+wEg9T54ofWUVozD2BllKszxGY1hkPr
 /V7rEGctZy/dDDBCmVT0MCnFvVu/fpcpTrGchVoWMRszo5voEXIvN0RXjiHaaHVPfOTbhx3Zv
 E/45tFfUvJXESf7PWZtpY4lPzNAw0/ZkvSyqbAIs9hu4ruPgAUccvKuc2si6N3AnPy4nsEKEz
 qaYf7I76qulrY4hQ7Jr24HEE0kvpdS/fcuw5t/VZfnz3iwFEusK1D1uAq4Qs1QLQ78dw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add proper eMMC vmmc and vqmmc supplies e.g. fixing signalling voltage.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index f8caf3f07fff..d50fcb69dd38 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -1078,6 +1078,8 @@
 		#size-cells = <0>;
 		bus-width = <8>;
 		non-removable;
+		vmmc-supply = <&reg_module_3v3>; /* VCC */
+		vqmmc-supply = <&reg_1v8_vio>; /* VCCQ */
 
 		emmc: emmc@0 {
 			reg = <0>;
-- 
2.14.4

