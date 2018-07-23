Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D897ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4043920880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4043920880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388781AbeGWNiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:14 -0400
Received: from mout.perfora.net ([74.208.4.194]:35617 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388263AbeGWNiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:13 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M8jzW-1frVhl0Mqy-00C9th; Mon, 23 Jul 2018 14:37:05 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 01/26] ARM: tegra: colibri_t30: enable broken-hpi on emmc
Date:   Mon, 23 Jul 2018 14:36:32 +0200
Message-Id: <20180723123658.980-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180723123658.980-1-marcel@ziswiler.com>
References: <20180723123658.980-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:a9gcGD81sUDW2Q/6UDgqLt79eCo86iyWodd2Pw58PiR/fNDbD+m
 8JMgEp916rSlASv8Ihvhuxb+9pj8TmsEbaPsEfwBuYygQ9Kdm+A3MKWaw/colc/BrYzo98H
 BoB0zn9mhzVgLchSl98FZdxbJ9MEvfqV2bYbBy+FCxLpvoH16xXG5aWsmuwWill/O7Xd4dy
 q+MWcGVVL0UDpwaqeE1Qg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aCjMwxkFgcY=:G717dV3fFy+miNJSmcX3aw
 98wrc4bXD4GyMKJ2C8N4BVNDBQS2B00/Qe2uw9nVPu6AamyJuXA+nE5WYOKsCBjJYyO83alSB
 RCBVeicqvS0Mckf8YI7G/VH7gFeqGpaUUxR88xgoWCHFAfH4CEX/NZ5ZauMfRUpw8Y/gw/GeV
 OWcfa2LhALe3mB4/+M2BRqk2YHZlz4zdyFg9U72jQot2F3K9A3v4pXPb/GX4FAtGqJAWiAqMK
 G4EDdAB9tTaCscKFcC0TNT+fbzzw3iGg7KDgMFS/8riA9ojDRKkJXULxwS4laiBGRnua6aeC/
 fpk2SyerEYG2mEjVxw2wjRIcxPDJzchnQM1Tfn8EQZqDwHJ2rQ5atdLxDwoW/zBIvsewGmY9i
 krMgWbbwr07pGgWBiKTQSRS04D5ZO5LafpO7+gC0x5YN+ZvJPUF4c3QnG5q8XU8T/Ls9WYver
 uaN11Ldiyl/blBX50ch+/YpaOa/+zsc6LHCM8nr7vE007BHLjSOsP4/fqM4KSo6e/hiQeQfi7
 doCoit8Rz9P6gSMGndZ9erhweY7ubesl7h47sbA3aLY4hW7wg7+MXmKJ33Y2dhv7c4mGeidRE
 7YbvUX5GDNw8x5O52TtUhv74+0JO+iVuCo4FWoUtfS/rapR/5wuWF54N1m03iqiaIW2TaYwB7
 F97yDlTO3GaXGj/A+vhPVk8S5BBB9MrUnNtqd1D96rrKYL7w2fJe2SrR/z9qHTaqHcWQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Avoid eMMC issues by specifying broken-hpi.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra30-colibri.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 526ed71cf7a3..6293422c977a 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -430,8 +430,16 @@
 	/* eMMC */
 	sdhci@78000600 {
 		status = "okay";
+		#address-cells = <1>;
+		#size-cells = <0>;
 		bus-width = <8>;
 		non-removable;
+
+		emmc: emmc@0 {
+			reg = <0>;
+			compatible = "mmc-card";
+			broken-hpi;
+		};
 	};
 
 	/* EHCI instance 1: USB2_DP/N -> AX88772B */
-- 
2.14.4

