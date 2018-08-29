Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F021AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52D52082B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B52D52082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeH2MLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:11:06 -0400
Received: from mout.perfora.net ([74.208.4.194]:56303 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727712AbeH2MLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:11:04 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0M2eDz-1fcZSz1Ncz-00sRdL; Wed, 29 Aug 2018 10:15:16 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 29/31] ARM: tegra: colibri_t20: iris: simplify model and compatible properties
Date:   Wed, 29 Aug 2018 10:14:05 +0200
Message-Id: <20180829081407.11304-30-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180829081407.11304-1-marcel@ziswiler.com>
References: <20180829081407.11304-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:8f4XRPjEnkbmzS/QIH0ThkyGg86qXr3hFTwUH1oyasPmo3dEOTW
 uBrrX4W3xjky9VBw7/THvSnxhfEyQSajHYshAheS7us3RYiSpfkkWTXAcaRjWi12IvbUham
 zaeDLmQmvSs0fJWmD30GCV68jOjBxKxy0nLeXDySxWMYG73yRomrEJ9PeHsB08lX+wmuGwb
 iDDo0JEhqEFT/lSZFyJ+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:W0btK+Sd8aE=:n5cYejUj4wQ69pWaFsJKOI
 4kNMQzNgubskdVSV3M4Cakr8MH+2IxuER4eDFOIa1OWKmh6zzsLZnzITk6Mj0qMOezV7P6khQ
 r5442VWqmHM0AJIpuxDSr0Ne0N0kMB2E+fG6AKSSy1kkheGhkXjWQgKpByGdRfHnh+hD4cqHj
 Fm6CjRoI7K7vqrwK8etqB2WIyixiNSLlEIvS9hAQsJe/Jn0Oc7bkYWoGsGbbmg8GO9CX9D+2N
 7UxkYYaAZn3UAGQTT9auJCpHSK49l0/tTVy/zWPHAcJdomiPNZMr1ffVNPVULoNKAL0fNSlMo
 wuWQIB+vi+Yxi7IehLXGoIf8v0O4lrsrgStGNJPKN0Ew7m20XBxF75UY9Z+6LGl8iYa35bwFF
 0rR4O0e90cNm8AlvY5C1O4L8cJONcP0qmGXOhmmZ1eOIYFkhPiXTUBynaLvLnp4HFFM6B8jWQ
 aFdGJXNvdRMhxxv3z4W4gVRQwYn1rVxghUxpcnYOCkMVY/jWA9bNNTooZVu4G5eNqNP/jf9rL
 i3ffcKvqV6jrulKuRchg/S1boujo23/G3d3Xd0iDJcxfYuVt/hVaZIBXUd7YkYcfQ1ce3w/a3
 SbWcDNN3e4N6VMuMlqH8SVSkmBCQLxXs1PLAsKfGwGawDpRRh+8je9mr1tqMwQqxXWKnSmdwv
 wrIxKAEjua3DRQyKAGMmE6p5MmxnbXTW/7JhrORZMmON+xR8p0fIVXFJe9ps7G6hg27Q=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Simplify model and compatible by dropping the 256/512 MB from the model,
-512 from the compatible and rename that property from toradex,iris to
toradex,colibri_t20-iris to be more in-line with all our other device
trees.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra20-colibri-iris.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-colibri-iris.dts b/arch/arm/boot/dts/tegra20-colibri-iris.dts
index 955d1e1ad8e0..3bcbb74edf2a 100644
--- a/arch/arm/boot/dts/tegra20-colibri-iris.dts
+++ b/arch/arm/boot/dts/tegra20-colibri-iris.dts
@@ -5,8 +5,9 @@
 #include "tegra20-colibri.dtsi"
 
 / {
-	model = "Toradex Colibri T20 256/512 MB on Iris";
-	compatible = "toradex,iris", "toradex,colibri_t20-512", "nvidia,tegra20";
+	model = "Toradex Colibri T20 on Iris";
+	compatible = "toradex,colibri_t20-iris", "toradex,colibri_t20",
+		     "nvidia,tegra20";
 
 	aliases {
 		rtc0 = "/i2c@7000c000/rtc@68";
-- 
2.14.4

