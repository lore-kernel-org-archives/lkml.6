Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0C2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFC0206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFC0206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbeKMUEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:04:55 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:32957 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731448AbeKMUEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:04:55 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42vNbR3gkWz1r2st;
        Tue, 13 Nov 2018 11:07:29 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42vNbP5JCdz1qr2g;
        Tue, 13 Nov 2018 11:07:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id UImaU_HXcTF6; Tue, 13 Nov 2018 11:07:28 +0100 (CET)
X-Auth-Info: 87vb/9JBGSEZBQTotGrMvBq67Ho9Mqo5rNHwEbWX25M=
Received: from xpert.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 13 Nov 2018 11:07:27 +0100 (CET)
From:   Parthiban Nallathambi <pn@denx.de>
To:     linus.walleij@linaro.org, manivannan.sadhasivam@linaro.org,
        afaerber@suse.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        mp-cs@actions-semi.com, thomas.liau@actions-semi.com,
        linux@cubietech.com, pn@denx.de, sravanhome@gmail.com
Subject: [PATCH v6 0/5] Add Actions Semi S700 pinctrl support
Date:   Tue, 13 Nov 2018 11:07:04 +0100
Message-Id: <20181113100709.5615-1-pn@denx.de>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds pinctrl support for Actions Semi S700 SoC.
Pinmux functions are only accessible for pin groups while pinconf
parameters are available for both pin groups and individual pins.

pinctrl driver is verified using the Cubieboard7.

common functionalities from s900 is moved for all Actions Semi
SoC's usage.
Common pad control configurations are moved to SoC specific

dts entry for pinctrl depends on clock driver which is still under review:
https://patchwork.kernel.org/patch/10533959/

Thanks,
Saravanan
Parthiban

Changelog in v2
- GPIO Interrupt support is added
- Device tree entry for GPIO and Interrupt configured
- GPIO and pinctrl define reorder, commit message findings fixed

depends on owl GPIO Interrupt support
https://patchwork.kernel.org/patch/10483477/

Chnagelog in v3
- Fixed 0-DAY bisectibility error

Chnagelog in v4
- Fixed 0-DAY sparse warnings on static declaration

Chnagelog in v5
- Rebase to mainline

Chnagelog in v6
- Rebase to 4.20-rc2 mainline
- Fixed nitpick findings in v5

Saravanan Sekar (5):
  pinctrl: actions: define constructor generic to Actions Semi SoC's
  pinctrl: actions: define pad control configurtion to SoC specific
  dt-bindings: pinctrl: Add bindings for Actions Semi S700 SoC
  pinctrl: actions: Add Actions Semi S700 pinctrl driver
  arm64: dts: actions: Add pinctrl node for Actions Semi S700

 .../bindings/pinctrl/actions,s700-pinctrl.txt |  170 ++
 arch/arm64/boot/dts/actions/s700.dtsi         |   16 +
 drivers/pinctrl/actions/Kconfig               |    6 +
 drivers/pinctrl/actions/Makefile              |    1 +
 drivers/pinctrl/actions/pinctrl-owl.c         |   71 +-
 drivers/pinctrl/actions/pinctrl-owl.h         |  142 +-
 drivers/pinctrl/actions/pinctrl-s700.c        | 1912 +++++++++++++++++
 drivers/pinctrl/actions/pinctrl-s900.c        |  205 +-
 8 files changed, 2324 insertions(+), 199 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/actions,s700-pinctrl.txt
 create mode 100644 drivers/pinctrl/actions/pinctrl-s700.c

-- 
2.17.2

