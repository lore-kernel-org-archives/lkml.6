Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9B4ECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F242145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajPXCv9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46F242145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeJRG1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:27:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33027 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeJRG1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:27:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id s4-v6so13371909plp.0;
        Wed, 17 Oct 2018 15:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rsbmwslK1y/a10zryAJqFIGvGdsklgJJzE4KXOfru3Q=;
        b=ajPXCv9lgDbGpOUwApydLdVdS5H3q58WmODKcplMgCbPsheQ5Flpg9i1NqdKxt987M
         P76KHeRpVMVAcBWqBVC/6Wa2dqqALTBT4ol3Pc3IlR6GAN8kOFw/aVvDtKPDQjctW+X+
         ArwNRj9yD/MhKkgmhKyd2QnnIuijFGWGxHuy9C93WLw1WsGnFiTs+ECuvkKuYekPztb3
         82/1ozEN9Rfys6CfCZJ9eJJFYsgAKYoe26am7KD3bYnpzSQUth1YVeNYjW1j9oLUXSLn
         CkFw4TRYUqLaeG0qVTsvOrp38KfRMge6Yu+tFG9rLz8jRWHbj6xKA4bpvpoLtNkElNJk
         29Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rsbmwslK1y/a10zryAJqFIGvGdsklgJJzE4KXOfru3Q=;
        b=Yd9JfdAT2Er++aC8zND6nVDPkz+XD2dRjRxXxxSdCtbiYSOkjK9hFrLBEQuyoUGS/B
         auphtzYRH4cH8nT8KZd36qcTZZKLFFzjUR8qfyPswPvxMa0VgHY7AdBASv+leVjHX1np
         cn+l97cVWg0a6IQaAahucnXORVMH21aiYeHk6p4JyXLvC0STzARJfLC98ATF6Nheh4HE
         ZlSCKeVlqggDhwMSaACHSVGtuX/M8P3lPsR/BowhFfPNpi2CM1tvnBlzsl/t9W2szsRU
         ksOm6wDPKnVOF8MVqReLUAec5YcGo9pcOwwkZPo//bV6WXShmiuONgQUanpyVnXK8ond
         DsRg==
X-Gm-Message-State: ABuFfojWNucPYK2bymGpx2UuVQXoYLgh8MRP7Yo/vx2EhKNz73VDIe5X
        wInlLNIyFoZpcBiDI8z6xgW+uKSX07Q=
X-Google-Smtp-Source: ACcGV62HYwKHBgOpiR3p4LLS5sF6SXiKm9aoiYMKxLNhKj0zYucCynsfqaKKzhftoBf0i9XXwccFrw==
X-Received: by 2002:a17:902:5e3:: with SMTP id f90-v6mr27105341plf.222.1539815393821;
        Wed, 17 Oct 2018 15:29:53 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p3-v6sm352597pgl.2.2018.10.17.15.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 15:29:53 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH V2 0/6] Add XHCI, EHCI and OHCI support for Broadcom STB SoS's
Date:   Wed, 17 Oct 2018 18:29:03 -0400
Message-Id: <1539815349-24126-1-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2 - Based on feedback, the functionality for XHCI and OHCI was
     moved from Broadcom platform drivers into the standard XHCI
     and OHCI platform drivers. The EHCI functionality still uses
     a Broadcom EHCI driver because of the workarounds needed for
     bugs in the EHCI controller.

This adds support for the XHCI, EHCI and OHCI host controllers found
in Broadcom STB SoC's. These drivers depend on getting access to the
new Broadcom STB USB PHY driver through a device-tree phandle and
will fail if the driver is not available.

Al Cooper (6):
  dt-bindings: Add Broadcom STB OHCI, EHCI and XHCI binding document
  usb: core: Add ability to skip phy exit on suspend and init on resume
  usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
  usb: ohci-platform: Add support for Broadcom STB SoC's
  usb: ehci: Add new EHCI driver for Broadcom STB SoC's
  usb: host: Add ability to build new Broadcom STB USB drivers

 .../devicetree/bindings/usb/brcm,bcm7445-ehci.txt  |  22 ++
 .../devicetree/bindings/usb/brcm,bcm7445-ohci.txt  |  22 ++
 .../devicetree/bindings/usb/brcm,bcm7445-xhci.txt  |  23 ++
 MAINTAINERS                                        |   9 +
 drivers/usb/core/hcd.c                             |   8 +-
 drivers/usb/core/phy.c                             |  18 +-
 drivers/usb/core/phy.h                             |   9 +-
 drivers/usb/host/Kconfig                           |  29 ++
 drivers/usb/host/Makefile                          |  18 +-
 drivers/usb/host/ehci-brcm.c                       | 291 +++++++++++++++++++++
 drivers/usb/host/ohci-platform.c                   |  35 ++-
 drivers/usb/host/xhci-brcm.c                       |  17 ++
 drivers/usb/host/xhci-brcm.h                       |  16 ++
 drivers/usb/host/xhci-plat.c                       |   8 +
 include/linux/usb/hcd.h                            |   3 +
 include/linux/usb/ohci_pdriver.h                   |   1 +
 16 files changed, 504 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ohci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-xhci.txt
 create mode 100644 drivers/usb/host/ehci-brcm.c
 create mode 100644 drivers/usb/host/xhci-brcm.c
 create mode 100644 drivers/usb/host/xhci-brcm.h

-- 
1.9.0.138.g2de3478

