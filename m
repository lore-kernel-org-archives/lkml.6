Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4D1ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AA3F20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 12:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA3F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388600AbeGWNiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 09:38:12 -0400
Received: from mout.perfora.net ([74.208.4.194]:33213 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388263AbeGWNiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 09:38:11 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Lop25-1gEimL3bo3-00gmAQ; Mon, 23 Jul 2018 14:37:03 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel@ziswiler.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 00/26] ARM: dts: tegra: colibri_t30: major revamp
Date:   Mon, 23 Jul 2018 14:36:31 +0200
Message-Id: <20180723123658.980-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:N14EbHF35GrrM7vor+1Wt30Ey8yzU0E2NS6zkLAA9AOap/7GuP9
 R/t0iqgqCA7jDInEQkkHbYKlRGj3x02Xyb4Dx13DiKRSOoISAR2ArLUizfFlcQtaKDCil6g
 4BWAlwDXpaAgEF1RsWByqwH9urVj/4R5Ru6A5YVKsPPKfkE3Sdy2pzdySu5E5fb6mfZMPBQ
 cU0MGk4NDCJLhZ2Q2OANw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9Wx00TWJJ+4=:+DUzAV4SdRuBVuhtCr9p+I
 MGWVVQYsiAtgWv+EiicP+xnCBiVZ2e34Qlwm/jq6ptQ4LffnWay4Os7aMUkRO//OyzwaOFy1W
 cRTz0oewvJYQ53V2tpd7qZgF1Sfp82UNF/gBC5ieLLjCByfrYEqNipB/Oq7Mz1S/fZblSEGNO
 H9xnbHKAjbj4ftD5Lcz/99IEMW5C2MufDLsXAa29rGl8lUeucwAPTeKHgPDO3DUGTNteASQdO
 CgBzhncspoBYM5MI5qRgNWm5+j8xJ7XYhWv4saH2AHIj17XwQT0mf5eeqI2LsLiGlhSVZPFWN
 SA8rDM4POEVnQ9IvFdPEEpcGN4/KZQmXJ3bmC11KT9YpstvoOvOjTfUHFp6U7B0nl21DvJcyv
 +/Z/rdTINEVRh7Z4hRzmDS3oDQ4TNkgKPqKgANUA59WzLs5AogYVipW1xYAamInBWqtiXDRv1
 /drnA87MgGo0YycX1WmUYdZldghSmqQm3o8VshVvkf6fel2xA5Mfesl7SdXqPKYWfKw4Xh84n
 S2IGSaNEHuaEGtiFysPqzGAxSDyvLO+B3weL7azWf+cpEKP5DozEcoyy8Vv42SG38RZfsoa5r
 p7pDPnMRVcBaKwjGxOsWb/x76vFIuFfiJp7d0cTXEH6LlS7KcXRoAQlJ+LM+NQrq7U2jR7086
 yRZLWVLVSDpJ6D3kXJueVHt+CmKJyybYkj8J5Xr7pA2W1KIgsLvOhYllGVlSYcrRaOtw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a major overhaul for the Toradex Colibri T30 system on
module.

Marcel Ziswiler (26):
  ARM: tegra: colibri_t30: enable broken-hpi on emmc
  ARM: tegra: colibri_t30: add local-mac-address property
  ARM: tegra: colibri_t30: reorder host1x/hdmi properties
  ARM: tegra: colibri_t30: regulator clean-up
  ARM: tegra: colibri_t30: add missing regulators
  ARM: tegra: colibri_t30: annotate uarts
  ARM: tegra: colibri_t30: white-space clean-up
  ARM: tegra: colibri_t30: move dr_mode property from phy to controller
  ARM: tegra: colibri_t30: reorder backlight properties
  ARM: tegra: colibri_t30: drop pwmleds
  ARM: tegra: colibri_t30: pinmux clean-up
  ARM: tegra: colibri_t30: add missing pinmux
  ARM: tegra: colibri_t30: use proper irq-gpio for stmpe811
  ARM: tegra: colibri_t30: further lm95245 temperature sensor annotation
  ARM: tegra: colibri_t30: add i2c-thermtrip
  ARM: tegra: colibri_t30: add proper emmc vmmc and vqmmc supplies
  ARM: tegra: colibri_t30: enable emmc ddr52 mode
  ARM: tegra: colibri_t30: rename clk to clock
  ARM: tegra: colibri_t30: line break long compatible property line
  ARM: tegra: colibri_t30: move input include to carrier board
  ARM: tegra: colibri_t30: remove unused nvidia,is-wired property
  ARM: tegra: colibri_t30: add gpio hog to unreset usb ethernet chip
  ARM: tegra: colibri_t30: enable hda over hdmi
  ARM: tegra: colibri_t30: annotate sd card detect
  ARM: tegra: colibri_t30: annotate ehci instance 1
  ARM: tegra: colibri_t30: update compatibility comment

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts |  99 ++--
 arch/arm/boot/dts/tegra30-colibri.dtsi        | 716 ++++++++++++++++++++++----
 2 files changed, 666 insertions(+), 149 deletions(-)

-- 
2.14.4

