Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27164C6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD6A20874
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 16:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBD6A20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731347AbeGVRr4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 13:47:56 -0400
Received: from mout.perfora.net ([74.208.4.196]:36397 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731283AbeGVRrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 13:47:55 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LiBGf-1gLW4R3RI3-00nMuy; Sun, 22 Jul 2018 18:50:33 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 24/28] ARM: tegra: apalis_t30: enable emmc ddr52 mode
Date:   Sun, 22 Jul 2018 18:49:32 +0200
Message-Id: <20180722164936.20581-25-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180722164936.20581-1-marcel@ziswiler.com>
References: <20180722164936.20581-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:bXGzbvngPBZoatwfv/hnRAz4ieqjyIjL6/r4a+OSetah5gpvudE
 fV5r8S9Iyf9Pzt2GF+ckW3KNRnRVXXAcxNODgwHFhh91INnVltxsjWFid/e5BHaLFDaJ97Y
 nwnWiuGvJh2xmSt8cmGeSYaWmTa7WeI9wbyP0P/sB/uD5sP9i2SlpGBeq6UVQCYAJxhKNfG
 Z8AqBxL5XZGJ5ok0Ia8Zg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SpP5qBxpBcI=:wqJj/fZ0F8VOWvrmLqJ6sz
 lbA/RBSA3DC8/F8sutq4Fj714Tp3wTcjjQout4em1QDdxvTBrdcW/zLx/zbsnw51wo+bs7+Qr
 nRVxJoj1XQ/BjSJePkr5rZ8n+D7h+W7MsQqAjqMVQlJWyeHV0MP7maRZEE/6LzuO/k/Pkjcom
 kkHVNyviGH55SbsIWrACKB8U60Jk+hxOwcwVPWI38qE01DhBvA8G6Vook1NubEMK6Sw07w2ZD
 uahcjd+F/0O5U16/cbhgPOCVphuGO/EIynan0zbXOXN35B+RmjU//jUvz6SWZHUEPo+ZKAC4c
 4AmXrGsYiCnuu5mgu3P3CZybCcwxSFHgmOTIG0zTrkqAtYbiuo2v8j2XXqvmrKMXNIx5h1iJG
 6CfHyVrJHMH93/onWpm5/RwrqxN8U0t6YpKlc9UqYhYl/C6tSr4BfIU7svDxQLfvJ3f+dh45k
 XDfNlD79HWvIBTh1oPyXSf6vWAdzXHxDu7uS7Ehdw6gpyfcTwt5jzvzFQejh2x9WOxeic3p9J
 NAjrlAx8TIS9j1tr/GMFzBkGocX0s5g80V0lrdEVqBVcntR8Z1zL2/eVKjpcZboRgrPMy0n2V
 Hux8aGCmql2f9vhwagWHURHzXcVtIGWjDRcO8YdzD0hGTOs4O0uNuP4xWZM5TRkVpapIXJC6Y
 yyiKaKMC24SzrFC36FRuZGWIXZ0KL6cI2z4cokERvSxWITunS732/7ykG8K4jIHCbQCA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Add mmc-ddr-1_8v property enabling eMMC DDR52 mode.

root@apalis-t30:~# cat /sys/kernel/debug/mmc1/ios
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
root@apalis-t30:~# hdparm -t /dev/mmcblk1

/dev/mmcblk1:
 Timing buffered disk reads: 232 MB in  3.01 seconds =  77.10 MB/sec

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-apalis.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index d50fcb69dd38..5f5a287eb535 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -1080,6 +1080,7 @@
 		non-removable;
 		vmmc-supply = <&reg_module_3v3>; /* VCC */
 		vqmmc-supply = <&reg_1v8_vio>; /* VCCQ */
+		mmc-ddr-1_8v;
 
 		emmc: emmc@0 {
 			reg = <0>;
-- 
2.14.4

