Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A3BC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8582920839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8582920839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbeHaUri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 16:47:38 -0400
Received: from mout.perfora.net ([74.208.4.196]:43337 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbeHaUrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 16:47:37 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MAebN-1g2bnZ08Kp-00BqfO; Fri, 31 Aug 2018 18:39:10 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 23/34] ARM: tegra: apalis_t30: enable emmc ddr52 mode
Date:   Fri, 31 Aug 2018 18:38:05 +0200
Message-Id: <20180831163817.23970-24-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180831163817.23970-1-marcel@ziswiler.com>
References: <20180831163817.23970-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:KJsawIJBR0v3pBmj4prTTuVZJE3VV85CJaTm9bYd4nAQl3gy8mZ
 Cw83dajejxqpIL1NG2N8Hx+5N/Gn+M6EafHKSOKWWjXxiG/31rVTizCU3rn66SJiISwRkOI
 zCD61RabZMCsT4hn1AcBAhM5Sb2lY2HJeJ1MdfoEN1UDeyeN3u1xVmlXA7bRZQMQOygiTci
 k+9au7y03X4IQqpwxc/9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:FZ+cz9+ia04=:mMkjXo4L9XOe7sJKh90AtO
 l0LFLAvjpAcksrj5SQpWbbjzJNQ0IAj4oAbPtXLBniN8oUkSaZNZJYoHbu2Xupydk4TK8HC3g
 bL2kAKSQ1/8fcT1JOu6Ew3a9AUlNVM3uAJ/vJV0G46SsR8lhsIeF6h5VRvYE4XI7suF/PYBql
 ROLNoKN94Mrq07ITSZ7Zkuxj84a8CvsI0rGNroz+7ccxYCMDU/N0tdOrW2Ly0TtXz23qNeWJy
 j2OaLQiKJix/sD6dsRsZfO01Ulg+syPDmD6RWKrrmmFxOeXHl26eqlNEtDKPaO5FqZWaLCLHt
 ZxltQ0k1vwYh5UcSfCaXfwb2aIum9qWHGneX1ABniGw3i991shuHJct9u5sapoJ+NGrbVhMkc
 P9dtJVfbJVIMAWx7obTZDqZsgfAB+QNjt8HGjOip7woBxtRayrd+5qFN2dqBwJgPaEAQY63pn
 PChEYOttQTOdXeLFpSkRlwbLZmz1SQs05GUo+QvPKvM0810fHpUNDrEeTjdFQRzECtiF35/I/
 YrgVgsmTEkTo1yKuiAZ8jB77LVXF2PZ9qgW/Q8dyRBEY7MrPUGOumYzp7Vw3GpwETO9QDfKMn
 n7GFZyj0L+VIQf/ScBR6FdloZJkSg3EfIA/Yk9fxvuIIVP6xg1NpDtE/2lWrg7fPBqFrHJYh2
 rOL5ts3J2Bi6J+uGlTkz3D8O/WmK0mz2n5Uu7XlzodpJgkxroKgYyg9SvpWKccv1hKMI=
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

Changes in v2: None

 arch/arm/boot/dts/tegra30-apalis.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 2e2cdd454fe3..6d6f17422478 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -1094,6 +1094,7 @@
 		non-removable;
 		vmmc-supply = <&reg_module_3v3>; /* VCC */
 		vqmmc-supply = <&reg_1v8_vio>; /* VCCQ */
+		mmc-ddr-1_8v;
 	};
 
 	clocks {
-- 
2.14.4

