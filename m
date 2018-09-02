Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A00C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E19520841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 10:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E19520841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbeIBOYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 10:24:48 -0400
Received: from mout.perfora.net ([74.208.4.196]:39767 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbeIBOYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 10:24:47 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus001 [74.208.5.2]) with ESMTPA (Nemesis) id
 0MGh4Z-1g9HUy1dyL-00Dfa6; Sun, 02 Sep 2018 12:09:17 +0200
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
Subject: [PATCH v2 00/37] ARM: dts: tegra: colibri_t20: major revamp incl. eval board support
Date:   Sun,  2 Sep 2018 12:08:29 +0200
Message-Id: <20180902100906.25792-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
X-Provags-ID: V03:K1:xzz9YjGokC/Eelakk+r0B449RyLiPv1UOjmnDxMCJPp6blRjr6G
 7w5L5YMqrLvEDduLC/PXCT94XHkdEyQTuvhflmKiFs3cJxNlJyIKiih1EcY3Tt29AM8+fVR
 5yi/NwDjdVpgjM7Nlu73yxZ43x7OtHGkzKzEYE7E9v7+npnzul2cL6jsTH+XQp4CMmxvwAI
 WrBIxX4EZVULsPr7fYdAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:7RGe7J32Hv4=:kShgJ4J8d/Zu/gqhbLtryY
 HRIayB5iAl1dTjcO+teQY/tc/v6vjbsDtHOPImpkp3FufTIBFU9qUoR0sqFHcgwACs7CyZODe
 cDPFIshSjGQeGG/9eT6vQRgewGWSpxVpBIYZJFFV76eIKtUNKLvjOzDy5CP8BheJgnGnALp4V
 KFrhKbExSAcIDCBHH3eoy5vNRN+4MM2N9Wg+IuIt0k8VJrLGuhNj2t2134h/mXuCnqcaKrL47
 9fuH5u3rQ1mDksNvc8WfbEdYVaG1SAc268S+8FIltMOYZd/rIzvYNmcAZzt+SA/pKIhRinusO
 zO/towHX8hFain0LMeklF1cQZuj9iBrnkeUbY4nPtbsg0PUFi6dP41fE71Fx0y+ZVhLRTEZ3u
 RS1VU6HH1MZwGRa7mPt78uywYeaL0xBgO6CVn+sjU5pmoB9fHmvbf5hmws5+JfBLgtHwC86If
 s4Zoe6t3q4iKnGOmBht5ckNdpplhNMvcJ8fgNjSYiECAdSr+Kn8SqhkvZVSX/kIs4TYVAFZ1f
 ZHTjxakXrNbliwGfQM7sMfmyoA/Q1HOKuL/tW64w585FB3wS3Cc/Gts3px0ZravmAUTuxkbGj
 umOx8Z19ab/w8nQVthbJljT7gJl2rb6Nq1E5KWj7Ou/2O6WINL1Qru99OTve3RlcoAjFG4rRI
 7rcbxf60vV19pRgPoc3Ri0dMsfZHvGy3O2GLlqmWQpwRUEZ++W9b119xv/MXG6U9eGLg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a major overhaul and adds support for the Colibri
Evaluation Board device tree.

Changes in v2:
- Fix commit message which was mixed up between "[PATCH 03/31] ARM:
  tegra: colibri_t20: iris: annotate i2c busses" and "[PATCH 04/31] ARM:
  tegra: colibri_t20: iris: add missing aliases".
- Also replace underscores in node names with dashes.
- Also reflect this change in the Iris device tree.
- Also reflect this change in the device tree bindings documentation.
- New patch as suggested by Rob.
- New patch.
- Get rid of fake clocks simple bus as suggested by Rob.
- Updated evaluation board device tree with all applicable previous
  fixes.
- Also reflect this addition in the device tree bindings documentation.

Marcel Ziswiler (37):
  ARM: tegra: colibri_t20: move aliases from module to carrier board
  ARM: tegra: colibri_t20: iris: integrate i2c real time clock support
  ARM: tegra: colibri_t20: iris: add missing aliases
  ARM: tegra: colibri_t20: iris: annotate i2c busses
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
  ARM: tegra: colibri_t20: drop module level model and compatible
  ARM: tegra: colibri_t20: rename i2c_ddc to hdmi_ddc
  ARM: tegra: colibri_t20: iris: drop unused i2c_ddc label
  ARM: tegra: colibri_t20: rename tps6586x@34 and drop unused pmic label
  ARM: tegra: colibri_t20: get rid of fake clocks simple bus
  ARM: tegra: colibri_t20: rename ac97 label to tegra_ac97
  ARM: tegra: colibri_t20: add eval board device tree

 Documentation/devicetree/bindings/arm/tegra.txt |   5 +-
 arch/arm/boot/dts/Makefile                      |   1 +
 arch/arm/boot/dts/tegra20-colibri-eval-v3.dts   | 262 ++++++++++
 arch/arm/boot/dts/tegra20-colibri-iris.dts      | 200 ++++++--
 arch/arm/boot/dts/tegra20-colibri.dtsi          | 655 ++++++++++++++++--------
 5 files changed, 866 insertions(+), 257 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra20-colibri-eval-v3.dts

-- 
2.14.4

