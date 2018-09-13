Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F6CC63684
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E1720880
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0rzI8v8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E1720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeIMXQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:16:35 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40407 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbeIMXQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:16:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id s13-v6so3023840pfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 11:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=59lQH9Q/QmZtcJtpBlnVqOngV0HBlFi1sO1Cx4uHtJ8=;
        b=V0rzI8v8frt3DBR1Pfb4qLiFxuc1VyRv6tO4pOPCjbPZquX/VTIcFljPC2wxVBXWpt
         fgtoMaZ2m12TEJbMfnVSpGpklJFdxYNWFPXxnPLI8DsQp4XntOfeSgiaBzQ1A/c9QQiC
         sv65XV0YhCXRa/z/uFCsve/P3nmHE7V5eunNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=59lQH9Q/QmZtcJtpBlnVqOngV0HBlFi1sO1Cx4uHtJ8=;
        b=W72RrqnHgACrjq7Frymx+98nhGiYh/AQScYECr96Qi/Pz+9IrEEAQncxdcRfVuIJIy
         PH0wjeTei28L23ONsT7Tbjsy9hxoSwChYthX1rs3iZviOTrG/wCiVTz2Yg8lYB8sJuIQ
         BeSM/B5p1mw5prjMnR7hs1ykEn2E49q+BlSz5tV0BVsL8yELBj6H6D80Y5ZNGkNxl2VD
         swBeYVlVIsa3Sn+tWaE1G/3f+1qNRuseNWrH6YSM04WaI2uDOYefvmGVYKtkh/fut/Tk
         2Yb7KGxlgkLnzomiXKNlRmc1bJ6POP4Rjz3toF41rooHjatN2XgENErpZq68Ur7FzYmv
         Ugmw==
X-Gm-Message-State: APzg51C5RsZipi0NqLJZrEKT2vZlQVXah/J0A1B8C4krO7Pid3qgbc95
        PiwG/GyvVLmEGgjOrERR6zRk
X-Google-Smtp-Source: ANB0VdZtfdwO7ISvl3OEXqGKoZsXEIH8prm6wmWdtPUih43nrp02TGRUG3uaw+e0w3AoRD2nrZZuyw==
X-Received: by 2002:a63:4204:: with SMTP id p4-v6mr8038590pga.200.1536861958922;
        Thu, 13 Sep 2018 11:05:58 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6115:a36e:955b:f94d:4607:e9b9])
        by smtp.gmail.com with ESMTPSA id u184-v6sm8856802pgd.46.2018.09.13.11.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:05:58 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     heiko@sntech.de, robh+dt@kernel.org
Cc:     vicencb@gmail.com, shawn.lin@rock-chips.com,
        ezequiel@collabora.com, enric.balletbo@collabora.com,
        pbrobinson@gmail.com, tom@vamrs.com, dev@vamrs.com,
        stephen@vamrs.com, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/4] Add 96Boards Rock960 CE board support
Date:   Thu, 13 Sep 2018 23:35:41 +0530
Message-Id: <20180913180545.29756-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds 96Boards Rock960 CE board support. Rock960 CE
(Consumer Edition) board is one of the member of 96Boards Consumer
Edition and AI platform and is manufactured by Vamrs Limited. Most of
the board configuration is shared with the Ficus board manufactured by
vamrs, which is an Enterprise 96Board.

For the sake of avoiding code duplication, a common rock960.dtsi file
with common DT nodes for both boards and separate board specific DTS
files has been added.

To be specific, below are some of the key differences between both
boards:

1. Different host enable GPIO for USB
2. Different power and reset GPIO for PCI-E
3. No Ethernet port on Rock960

While adding the board support, SD card Chip detection support is also
added to the common dtsi file, shared by both boards.

This series has been tested on Rock960 CE v1.2 board.

Thanks,
Mani

Changes in v3:

* Moved usb and pcie nodes to common dtsi and kept only the properties
  which differ in board specific dts.
* Updated the common dtsi commit description.

Changes in v2:

* Changed the board compatible to "vamrs,rock960"

Manivannan Sadhasivam (4):
  arm64: dts: rockchip: Split out common nodes for Rock960 based boards
  dt-bindings: arm: rockchip: Add binding for Rock960 board
  arm64: boot: dts: rockchip: Add support for Rock960 board
  arm64: dts: rockchip: Enable SD card detection for Rock960 boards

 .../devicetree/bindings/arm/rockchip.txt      |   4 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 524 +----------------
 .../boot/dts/rockchip/rk3399-rock960.dts      |  52 ++
 .../boot/dts/rockchip/rk3399-rock960.dtsi     | 542 ++++++++++++++++++
 5 files changed, 604 insertions(+), 519 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rock960.dtsi

-- 
2.17.1

