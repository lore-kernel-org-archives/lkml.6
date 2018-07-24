Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDB2C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 216CF20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 10:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216CF20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388458AbeGXLtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 07:49:13 -0400
Received: from mout.perfora.net ([74.208.4.196]:41935 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388416AbeGXLtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 07:49:13 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MI7NQ-1fiTYC33PC-003ttQ; Tue, 24 Jul 2018 12:43:15 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel@ziswiler.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 00/15] ARM: dts: tegra: apalis-tk1: major revamp
Date:   Tue, 24 Jul 2018 12:42:54 +0200
Message-Id: <20180724104309.21741-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:ivgU6tEUOmCE07p05kScw6apkApnBW9yizkrMDcVHoB0AYAoj0w
 3nAHQeTSXFEjmEPnQoF+7/Cpwn1kvUb2AHx9a2Dk2lHSzMDQitaDPo2GljYc+lCBp38rcVK
 oGBcVjxoh2FC6RiY5tLOBJ3yAxWjnhiAfD5u4XHq+42l2rasOv1rVlkg73Vf3GrvPxMqzkg
 iIJutRv1pt9bjyTxJJNJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Vw9RoVBkc6U=:9U/j2q75z0VXomJrmwu6I0
 sOOgb5gUwHKDhECXSXb8p2lwp6IHe4hM8ES6N6fGiRmNng3MaRortNHuuVWoRUkpOuduXcx4V
 fyl6HMgWGjGlxxSGkuSy4iisKVyfXxO0t1Pekznaci+Vh4ZfhSEIPr60YA5oBJDVO1HzQcXTk
 ZtGPUJhlucpLTOz2B4kGLL7Xj2xXd6ihXgMxo8ezSOmT5U9FOTFE+l8RnDNsyAHPSy9ozfwYP
 sdBqo6N0IrupLrTyBSEbsBQF0igWSt4vul3gYxcI4+F4355ST35ellEop+4BHlLIgK7/kn3Xw
 tB2SGBjqlNx0GMs56LqSIIEP61fJuHqI+Rdgihn8HbVq9+wxaD3FGMC03idV9H1mEEHZQgsNi
 EYxkb+bT7xv8VmLqNcAGBIsO+SVJORh1BzmhGqb/iNIrgANGTZlDVFn6BArnCBLT+JjiVWY4H
 N3/htRHYiO4pbwYVFM+0hJYWhHKZKG7+hx0rFjIl5Y+f4XF0rYCjpSr7cBlaNlxofuqstJ9Gf
 Arwj0akEOOTerxaDuz0j71Ul2Jv8TWJQMKtZ+A82O86rTJx2bUgUMu7Qs1qrrd3atk9rb9Kwn
 vyZXYpy9nV2jVa49UdweCdanwqTJ5smYKOAd2agY1GeXqFAdSJAOB198+8GV6TMAnN1ilJjKn
 VQjmAVfpSSTAtQPSuE8QhPwhUP+az1ZV2QtV31eO3NRQTB3o8u4taoTL+vC6lgOi8n9g=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a minor overhaul for the Toradex Apalis TK1 system on
module.

Marcel Ziswiler (15):
  ARM: tegra: apalis-tk1: add local-mac-address property
  ARM: tegra: apalis-tk1: reorder pcie properties
  ARM: tegra: apalis-tk1: reorder host1x/hdmi properties
  ARM: tegra: apalis-tk1: reorder padctl properties
  ARM: tegra: apalis-tk1: regulator clean-up
  ARM: tegra: apalis-tk1: add missing regulators
  ARM: tegra: apalis-tk1: drop unused pinmux label
  ARM: tegra: apalis-tk1: white-space clean-up
  ARM: tegra: apalis-tk1: reorder backlight properties
  ARM: tegra: apalis-tk1: add proper emmc vmmc and vqmmc supplies
  ARM: tegra: apalis-tk1: enable emmc ddr52 mode
  ARM: tegra: apalis-tk1: add toradex,apalis-tk1-v1.2 compatible
  ARM: tegra: apalis-tk1: fix pcie switch vendor compatible
  ARM: tegra: apalis-tk1: reorder cpu dfll clock properties
  ARM: tegra: apalis-tk1: reorder SD card properties

 Documentation/devicetree/bindings/arm/tegra.txt |   2 +
 arch/arm/boot/dts/tegra124-apalis-eval.dts      |  26 ++++-
 arch/arm/boot/dts/tegra124-apalis-v1.2-eval.dts |  29 ++++-
 arch/arm/boot/dts/tegra124-apalis-v1.2.dtsi     | 143 +++++++++++++-----------
 arch/arm/boot/dts/tegra124-apalis.dtsi          | 143 +++++++++++++-----------
 5 files changed, 208 insertions(+), 135 deletions(-)

-- 
2.14.4

