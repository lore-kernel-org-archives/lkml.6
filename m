Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A49C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 812812083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:15:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 812812083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbeIAMYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:24:49 -0400
Received: from mout.perfora.net ([74.208.4.197]:55105 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbeIAMYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:47 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M1001-1fd6dX0bwl-00vBQl; Sat, 01 Sep 2018 10:13:32 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 16/34] ARM: tegra: colibri_t30: enable emmc ddr52 mode
Date:   Sat,  1 Sep 2018 10:12:30 +0200
Message-Id: <20180901081248.22639-17-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180901081248.22639-1-marcel@ziswiler.com>
References: <20180901081248.22639-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:DrNwvbshWVsZdX/KN8D+WXszYBA7f+QV1fuKDoFjoZzP0PP9a2Y
 BXll8VL0stY7OEwknIj4qs6t7CLv5rm5LsNjQaSsqBS8mrbjtmBTFe2SEtPfNjDea+YpNo+
 erizFEezesjUHuzbZ10ND07KxFPffecSCuIOsxIwSI7Wk+kggOay2onJ5PyjqqNTzLD663l
 1ogiahIBp4QEFXZ0M8rrw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/FLwyDRY0+k=:F8SqEkhItLdi9um0MWEQM9
 VjrpduC5rQdFTilwGs/bgzIz87izaeaAr5gftKpmG71SMCrQOLw5sx9PZqWMKZ+1TKI4jD4kb
 rmN1OgKwf80sFKFyt+gij69fVXI5KV0v/n3UoBPiM4UABC5fNwFmUUZX93inu7iUo+67W84C1
 DWdGaE/IiHTwJ+/eSmX9vAHXaaO+4D6ZidQBQW7Q92opBvgGFmw+fhT09fhsC9RIILrz+Re5P
 RC5t+uDioemZeVFhxUhxyBSqw64GGk1MPg83LE+uj3WbK+i0dkD1QbfnTEbRDWEAuESxq9e0P
 AyDgkF/Z6s/V5Xydcs8j1XMDx7PJSPc0BdV4u+gl7y4vuxIGp+dQSd7D9E+edm3R7JknPODKX
 GmEnYvqSj9AErANCuJy96qzvXXBqr+gH4gPsRqICxVj5YCzEy3aGwd5pCJ9lHe0Z0fiqKnwaF
 ZjxBsNzEqKqU3MZBTq1tHQefxjO4GVF4XRIqN+ITe/N0+V2IhbdlfCv2l/iK4Cvuw83fpl2v2
 F5Xb4RefNBcOjGvDEG7BLuWnLfk80d9AB4zn6kJEFT2kxHfsq00eLfz1sw9ou48105IP8iopS
 2XDJtiHEt9dBZtgjaqaOCkoZGvnqdphwICsLPW6GnaJc8V2+8Sbn9tD8iQ6oZy+MPy2DaRI/E
 TEZS5obnl4Kpu9cpEU3HUC1xseAB7StYUGBeN+BoneeopJmI2ILTJgbMAApJy4/9l/3A=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add mmc-ddr-1_8v property enabling eMMC DDR52 mode.

root@colibri-t30:~# cat /sys/kernel/debug/mmc1/ios
clock:          52000000 Hz
actual clock:   52000000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    0 (don't care)
power mode:     2 (on)
bus width:      3 (8 bits)
timing spec:    8 (mmc DDR52)
signal voltage: 1 (1.80 V)
driver type:    0 (driver type B)
root@colibri-t30:~# hdparm -t /dev/mmcblk1

/dev/mmcblk1:
 Timing buffered disk reads: 222 MB in  3.00 seconds =  73.92 MB/sec

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v2: None

 arch/arm/boot/dts/tegra30-colibri.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index c5cb05f78604..95b6444a6f05 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -933,6 +933,7 @@
 		non-removable;
 		vmmc-supply = <&reg_module_3v3>; /* VCC */
 		vqmmc-supply = <&reg_1v8_vio>; /* VCCQ */
+		mmc-ddr-1_8v;
 	};
 
 	/* EHCI instance 1: USB2_DP/N -> AX88772B */
-- 
2.14.4

