Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC83CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF65C20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF65C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389227AbeGWNis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:48 -0400
Received: from mout.perfora.net ([74.208.4.196]:49005 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388302AbeGWNir (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:47 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LgFn8-1gJzNv2A6e-00nfVx; Mon, 23 Jul 2018 14:37:40 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 17/26] ARM: tegra: colibri_t30: enable emmc ddr52 mode
Date:   Mon, 23 Jul 2018 14:36:48 +0200
Message-Id: <20180723123658.980-18-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:Ni6eUn9biBYZr72Fv5+58HqIAOxUDW+aTKlLUkFgXX8Lw/AWqyV
 0VjAz9ONA+uRWlyiAg+97jR1EYtWDb9BkzkoidZPxIBlYQOB0ceDrXU2TGmwkZ5zQ/TLupm
 Xg4qBZiNk0YyA34mDAitNk+1swEqRCqAK9GPsl/FldQ96GEvfU9EfDjsvQodkBZbI5qkM++
 04tlfsEOqZc6FNxqHoyoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d/U4Mt1H/LE=:G0aKN+XvPajIGZZ25ljZ3I
 92nMDM0J1Ml1jbjhazXrPyTD2g+nDC7AP31qBwq10lBU0QtyGWpEFt1Kp8k2+XN8x8ZcSXym4
 V/76dkvZ2wIgjrSEW9CHt8v9b5F7mHkPHX43w96w0GiEB8AjbMGRmO4sem5fP1HRE4oZoVZ5S
 1aQrs3xPX4oH+losM19zz33DfQgtFXNHleNvx4eEO6D1F2LKvQOU+Yvb6eu02fL1GRNVdPrN5
 4JOYOiRoAAyPesWfzwVQJC50ZOMlok/k9MkZz66mNpuFrndnNajLNVDr0ds1dDoHtG9uzphi3
 VGaXeV8tHmXXsz3kesyQ1fg20mF2WBc1U5ydr9WlZYPhHEgsUh6ocPZqfPfWWEND9gFMSxXvX
 r9taZi8gpV4fZ3wT8ogKym93Z6lDamw0cGQkdpjWU075RKaJyHn97lbh2K1EKPrSaZRYKNbaq
 Agn5E5Z9EZYLKpINcpbi3Ifi5JMnXt6PffqbCHaRQzp0f/k3umbYKvgC09Dpz4rSEuLAMcK+2
 PQfEKHFH64Xp86rMAJlX7k8yXi4AE1qFyzQKzwOTkNc0cYK1B4Ke/QrIATXTywEoAy1UnqHOd
 eaKg9tf6tGxlk7Ikg1RdTgDpYbuUndwlgLL64hjr9AzPKAmXC/e30BShh7li8KL1H5sDLXHog
 KBI4D7XPqqfwPSGjIjFmYuo0Y+h/LoFKAKmvJIn+puEyPjMdyQS8rB3s3+K89414EVWA=
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

 arch/arm/boot/dts/tegra30-colibri.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 0a2115f59e41..14ce77ebf4a5 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -927,6 +927,7 @@
 		non-removable;
 		vmmc-supply = <&reg_module_3v3>; /* VCC */
 		vqmmc-supply = <&reg_1v8_vio>; /* VCCQ */
+		mmc-ddr-1_8v;
 
 		emmc: emmc@0 {
 			reg = <0>;
-- 
2.14.4

