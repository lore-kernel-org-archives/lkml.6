Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA513C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788B32075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ww4lETpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfBLPOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:14:19 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50575 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730006AbfBLPOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:14:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id x7so3348575wmj.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 07:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UckL5F5wh14/YUh0EVruXB5oWRHagYvkkrGnqq3zUiE=;
        b=Ww4lETpwizQsUdnAm2qIdHMhCP85ZOydMyiTTX6qQKV73ZRx6kagGSPv6iuZr3FAFD
         9ALBszVPoHHnbjOfrsfley8xk0ZNvw4a8KeSW4XPaZtW6JUD5Ay4i4dsZK7ZRC7Xa/p5
         RzJ+kDsIxhcvgT93T8ARnToZElGPd5lrlSMQDHyPFO03BKaLlKp77EDi0oMe/Qi7Q13+
         1vtDtuhN1E9skOfkhu3JSGg92yTg0twl2yZD1kCg5Vr72q40gGtKckNCgKt+ouw6JVUA
         Ans54ZtJEliafc4+KKK0+GA8+AQo0kq+gDnWUzWoyZZIyfPv1lt6ZkcsXiq6QhA5tq8Y
         p8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UckL5F5wh14/YUh0EVruXB5oWRHagYvkkrGnqq3zUiE=;
        b=T1WnQolUlg0LN25iczOGj0f1RZofnavoMDaGMVVaYzBuw+RJTwsweW0rxXYlOdPl7o
         p6j9cPEbbRW3cDnpDE/d8lNbkOcin09rRleV2x4TJ1FEKhIm86H94Yv5KtTikLeGWS4s
         Q2yzYXGxZkXsEMEDrGVXqZCnZ1lbudVdbpaie2zvSiFtrPn4aaGnmGm6sXVdH1mkN77u
         WYtTluyyweKR+NdIZlomNYOw8jniY8IFW7SgSV0UUKmTcbw/Ikv5xvuIeVrH6S7YhH3O
         gRPqSZdGmiGZs0K5C6+0FWXjbqZ0Z9AHpisKNzo9oqf8tzE7NAHLZpBMK+rjWnyvz6/p
         alCg==
X-Gm-Message-State: AHQUAuZZ13jDhDiH2Nc1nceXAZHH7KyrVH75E+LynGS/rxlcQe9Anl/3
        gxW18t3MICxnNIBMW4CuCzb10g==
X-Google-Smtp-Source: AHgI3IbE/WnTSfsIWA2e4zZ/8ElQpqHC/9f0glSu8Ltf7WCBwxI7RcaVE8d6ILzTCgdgNRAh69VmAA==
X-Received: by 2002:a1c:b70b:: with SMTP id h11mr3421759wmf.72.1549984455689;
        Tue, 12 Feb 2019 07:14:15 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c1sm1589515wmb.14.2019.02.12.07.14.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 07:14:14 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] arm64: meson: Add support for USB on Amlogic G12A
Date:   Tue, 12 Feb 2019 16:14:05 +0100
Message-Id: <20190212151413.24632-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support for USB on Amlogic G12A SoCs.

This patchset is composed with :
- bindings of the PHYs
- bindings of the USB Control Glue
- PHY Drivers
- USB Control Glue driver

Device Tree nodes will be added in a separate patchset.

The Amlogic G12A USB Complex is composed of :
- 2 USB Controllers :
 * DWC3 for USB2 and USB3 Host functionality
 * DWC2 for USB2 Peripheral functionality
- 2 USB2 OTG PHYs, only a single one will be routed to either DWC2 to DWC3
- 1 USB3 PHY shared with PCIE funcionnality
- A Glue to control PHY routing, setup and OTG detection

The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
routing of the OTG PHY between the DWC3 and DWC2 controllers, and
setups the on-chip OTG mode selection for this PHY.

The PHYs are children of the Glue node since the Glue controls the interface
with the PHY, not the DWC3 controller.

The PHY interconnect is handled into ports subnodes, which eases describing
which PHY is enabled (like the USB3 shared PHY) and futures layouts on
derivatives of the G12A Family.

This drivers supports the on-probe setup of the OTG mode, and manually
via a debugfs interface. The IRQ mode change detect is yet to be added
in a future patchset, mainly due to lack of hardware to validate on.

Neil Armstrong (8):
  dt-bindings: phy: Add Amlogic G12A USB2 PHY Bindings
  dt-bindings: phy: Add Amlogic G12A USB3+PCIE Combo PHY Bindings
  dt-bindings: usb: dwc2: Add Amlogic G12A DWC2 Compatible
  dt-bindings: usb: dwc3: Add Amlogic G12A DWC3 Glue Bindings
  phy: amlogic: add Amlogic G12A USB2 PHY Driver
  phy: amlogic: Add Amlogic G12A USB3 + PCIE Combo PHY Driver
  usb: dwc2: Add Amlogic G12A DWC2 Params
  usb: dwc3: Add Amlogic G12A DWC3 glue

 .../bindings/phy/meson-g12a-usb2-phy.txt      |  22 +
 .../bindings/phy/meson-g12a-usb3-pcie-phy.txt |  25 +
 .../devicetree/bindings/usb/amlogic,dwc3.txt  | 109 +++
 .../devicetree/bindings/usb/dwc2.txt          |   1 +
 drivers/phy/amlogic/Kconfig                   |  24 +
 drivers/phy/amlogic/Makefile                  |   2 +
 drivers/phy/amlogic/phy-meson-g12a-usb2.c     | 191 +++++
 .../phy/amlogic/phy-meson-g12a-usb3-pcie.c    | 414 +++++++++++
 drivers/usb/dwc2/params.c                     |  12 +
 drivers/usb/dwc3/Kconfig                      |   9 +
 drivers/usb/dwc3/Makefile                     |   1 +
 drivers/usb/dwc3/dwc3-meson-g12a.c            | 650 ++++++++++++++++++
 12 files changed, 1460 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb2.c
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
 create mode 100644 drivers/usb/dwc3/dwc3-meson-g12a.c

-- 
2.20.1

