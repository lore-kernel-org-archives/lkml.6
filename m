Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B40C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0935F2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0935F2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeH2MKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:10:02 -0400
Received: from mout.perfora.net ([74.208.4.197]:48353 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeH2MKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:10:02 -0400
Received: from localhost.localdomain.toradex.int ([46.140.72.82]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0LfRRn-1fbZAj1gPB-00p0mt; Wed, 29 Aug 2018 10:14:12 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marcel Ziswiler <marcel@ziswiler.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 00/31] ARM: dts: tegra: colibri_t20: major revamp incl. eval board support
Date:   Wed, 29 Aug 2018 10:13:36 +0200
Message-Id: <20180829081407.11304-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:mJ27eHAbNsdrV+iMD44jOqU7uKz7V+05w3Sh0U4tjsCk1PhwJ0Y
 Jfq54eFUAG8MwzpHW4BzCE9xeLYu++/tgYGhg50vzQsETF0FZ6LK2GOrv+oGZw1AA3NZwfr
 TXCXU+wohfKPEOJS6ZdDRcog5vFreCUd8G509n3ihxleNLweckKZ90sTERp3DMz4wpEfG+l
 JkTISbSG+fooXoLBlMeRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:huS/LiKDTqA=:hlIErvM33upCF5m7D36QRy
 8K01tS0TgYB2pfusTV4X0IgvPlmLX2WSGFzl1Os6yIQivr7AuDY+oCi2z2buXE65tmuxZZxLF
 cJQAPDs5cAcyW6ACX/r/j7vXdPcOaHZVzFPGD3CgxS0PPbloPRtnVWP99+ey2DacIf57reuOa
 NU9te4R9Ez4FVS0lsGn9Xac5/J8Bq7lt0/hu521e71DHT0RUsXRaehfh63uzDFri36d7rTReg
 jDTNutulY0Savh/a585lHBGjRPHhZYB+feqcQ0zAr6ZRMm51O8rNWAS+YVmJrUQrAYC+O9MfG
 Fn4UcP/Cm1LP3hvVxxNm82ZK6V0mFP7CqNKWsU4DnR2yVDXkUVk401vxJdpXDFpHdPAvVzvt/
 6vAVn0LPn0LJ/sMQSKw8Af6XdP6d5qosA0n0U2oPMTQvqXdRlEpVHMrOjkfNSzuvkrLXGscos
 SXBN/8LqG2eBY84z2+ngLhLA3d1ou9f7YFbaDlAkX/lXTmsgtjw6fC0yKZt1zuBdyYeF8a91y
 u2oO/BrnBHzT1xbbLJSqu1UM3t+a6Mzq6z/yjZRcIShOBiMNLns1+nwWmYSW+C3zf/yqJUzfk
 OfuQNgnLPkMoWDBOFQyHbjc/yn8VnKxKE902gCUX+LzdX0VzgB6aE+ZE7iAwQsziZycSxQPze
 bqFjcnYayFtWOMnfRv8o+2M1oV2ZOvjvMnwT73pU+sr6CT7OyX5VbUUNCIfkFpPHR2QM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series is a major overhaul and adds support for the Colibri
Evaluation Board device tree.


Marcel Ziswiler (31):
  ARM: tegra: colibri_t20: move aliases from module to carrier board
  ARM: tegra: colibri_t20: iris: integrate i2c real time clock support
  ARM: tegra: colibri_t20: iris: annotate i2c busses
  ARM: tegra: colibri_t20: iris: add missing aliases
  ARM: tegra: colibri_t20: add local-mac-address property
  ARM: tegra: colibri_t20: reorder host1x/hdmi properties
  ARM: tegra: colibri_t20: iris: use no-1-8-v
  ARM: tegra: colibri_t20: regulator clean-up
  ARM: tegra: colibri_t20: add missing regulators
  ARM: tegra: colibri_t20: annotate usb ehci instances
  ARM: tegra: colibri_t20: remove phy-reset-gpio from controller node
  ARM: tegra: colibri_t20: indentation/line-feed/white-space clean-up
  ARM: tegra: colibri_t20: update sound nvidia,model
  ARM: tegra: colibri_t20: pinmux clean-up
  ARM: tegra: colibri_t20: add missing pinmux
  ARM: tegra: colibri_t20: iris: display controller rgb panel support
  ARM: tegra: colibri_t20: iris: annotate uarts
  ARM: tegra: colibri_t20: iris: add uart-c
  ARM: tegra: colibri_t20: use high speed uart driver
  ARM: tegra: colibri_t20: iris: add gpio wakeup key
  ARM: tegra: colibri_t20: iris: add dr_mode property
  ARM: tegra: colibri_t20: annotate/rename lm95245 temperature sensor
  ARM: tegra: colibri_t20: add i2c-thermtrip
  ARM: tegra: colibri_t20: add gpio hog to unreset usb ethernet chip
  ARM: tegra: colibri_t20: add gpio hogs for gmi_wr_n buffers
  ARM: tegra: colibri_t20: annotate/move sd card detect
  ARM: tegra: colibri_t20: add compatibility comment
  ARM: tegra: colibri_t20: simplify model and compatible properties
  ARM: tegra: colibri_t20: iris: simplify model and compatible
    properties
  ARM: tegra: colibri_t20: iris: add colibri ssp support
  ARM: tegra: colibri_t20: add evaluation board device tree

 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/tegra20-colibri-eval-v3.dts | 266 +++++++++++
 arch/arm/boot/dts/tegra20-colibri-iris.dts    | 198 ++++++--
 arch/arm/boot/dts/tegra20-colibri.dtsi        | 629 +++++++++++++++++---------
 4 files changed, 858 insertions(+), 236 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra20-colibri-eval-v3.dts

-- 
2.14.4

