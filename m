Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58801C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C5D220841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 08:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5D220841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeIAMYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 08:24:19 -0400
Received: from mout.perfora.net ([74.208.4.197]:60885 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbeIAMYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 08:24:19 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus003 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LkQWL-1fKTHU2zAx-00cPYh; Sat, 01 Sep 2018 10:13:00 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel@ziswiler.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 00/34] ARM: dts: tegra: colibri_t30: major revamp
Date:   Sat,  1 Sep 2018 10:12:14 +0200
Message-Id: <20180901081248.22639-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:fzEn69+t9fedfWPsGi5MSpDyG0cdh4GMbjMZitln+ZWO9H2ocH1
 OPDJiRd85LXvooPkLmZ5+iF6xTKJMQ9to9+3bF74SKBewBelWEOtl4qna53oa/EhjKA0b+S
 OSRmMTXaHk05T3fVj8SMj8Wa2JqYQqVFdjdLpN1co/bMZXTswelWR4gqFAI1CUfgSw3Y9VV
 DugCZxQ1M9i+G9n4IjBMQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L0Qak8TKHTg=:Dbw6ll+2/9zglgVazNpbLP
 she6v+xXikPQ4IPUY+76Z9ENIPyZVeMJYxlpSmqlZnnuQgVJoykuV/vKVKTt7aDLV+/Q/Q3Ut
 snkUm3wwTL7i9GEPll9OQQbJF3mhf0xD7yM4hI22ZKS23WJzZYcN6QQQEIZqSLy6S62+m7SIE
 s8YyHsnvPGuuXr2JIxzPMq6P758nnGXYyS2+Fx4T1ePiHYpggz+o0OLZvUe342rEYpP9Y0Gsu
 +RsIINUvG7hnKrTXixMsxKB51ObhTiBAOg79XS22Z9uRzoW4u8jF5n0hPvBPU7MEutWno2qCg
 TNizDorZD7Z+1b8TLjiG5i34Gt0I75Dy+e3krgnhemNG+bd2mC/XSy342PA5y941jCBDJg7TZ
 TQ1Mq0tP/hGhVTF6GZdIrmE3jhOPTlEQcRLQgZejCHVTwYZwIjcr0fum3Jl/rGHNZP0iH7XSM
 dkBTZbC9UuOi52gbq6IvroBMFmYPG4kuguyTK6gQbARp2vADalgAPLCeD02BOmvQ/vXwyQAcb
 b/KFd5xXxCyuD9IS+p38aDMn3b5I0e/Tlx1Q4q50GMKRgqOK4SzGuWPon8v0pUgI9Hw3N9pCN
 UuRZca2K0Jlao4Nr2H8yFeJZwRvoxYBaDTLH8AyIqyFmMRtUT1yhUmgYYurHQ0KzixoAglNTu
 +3++ZLx2kp9Kafqax7WMx6k/MGjJ673dlEjgdEvo2OfB93AyGsGpbiDLDmussFcy/72Y=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a major overhaul for the Toradex Colibri T30 system on
module.

Changes in v2:
- Also move serial UART "nvidia,tegra30-hsuart" compatible to module
  level device trees.
- Also replace underscores in node names with dashes.
- Also replace underscores in UART annotations with dashes.
- When running some more tests I realized that the reg-addr should
  really be 0x3f. Fix this.
- Get rid of fake clocks simple bus as suggested by Rob.
- Drop "[PATCH 01/26] ARM: tegra: colibri_t30: enable broken-hpi on
  emmc" which should already be handled by the broken-hpi quirk as
  pointed out by Dmitry. If I would find more eMMC parts which exhibit
  the issue I will add them to the quirk as a separate patch.
- New patch as suggested by Rob.
- New patch.

Marcel Ziswiler (34):
  ARM: tegra: colibri_t30: add local-mac-address property
  ARM: tegra: colibri_t30: reorder host1x/hdmi properties
  ARM: tegra: colibri_t30: regulator clean-up
  ARM: tegra: colibri_t30: add missing regulators
  ARM: tegra: colibri_t30: annotate uarts and move compatible to board
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
  ARM: tegra: colibri_t30: get rid of fake clocks simple bus
  ARM: tegra: colibri_t30: line break long compatible property line
  ARM: tegra: colibri_t30: move input include to carrier board
  ARM: tegra: colibri_t30: remove unused nvidia,is-wired property
  ARM: tegra: colibri_t30: add gpio hog to unreset usb ethernet chip
  ARM: tegra: colibri_t30: enable hda over hdmi
  ARM: tegra: colibri_t30: annotate sd card detect
  ARM: tegra: colibri_t30: annotate ehci instance 1
  ARM: tegra: colibri_t30: update compatibility comment
  ARM: tegra: colibri_t30: drop module level model and compatible
  ARM: tegra: colibri_t30: drop obsolete spidev node
  ARM: tegra: colibri_t30: rename hdmiddc to hdmi_ddc
  ARM: tegra: colibri_t30: rename tps65911@2d, stmpe811@41 and
    tps62362@60
  ARM: tegra: colibri_t30: fix mcp2515 can controller interrupt polarity
  ARM: tegra: colibri_t30: remove unused mcp2515 can0 label
  ARM: tegra: colibri_t30: add mcp2515 vdd and xceiver supplies
  ARM: tegra: colibri_t30: annotate unused i2c busses
  ARM: tegra: colibri_t30: annotate power I2C being on-module

 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 130 ++---
 arch/arm/boot/dts/tegra30-colibri.dtsi        | 780 +++++++++++++++++++++-----
 2 files changed, 706 insertions(+), 204 deletions(-)

-- 
2.14.4

