Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8061DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2505B2154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SFXlbhdp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2505B2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeI0Efj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:35:39 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:57258 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbeI0Efi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:35:38 -0400
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 5DB7C30C010;
        Wed, 26 Sep 2018 15:20:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 5DB7C30C010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1538000431;
        bh=B5NLqBKceQNGHktJNd4GbFY4dqOawzPHYPOo9T4BygI=;
        h=From:To:Cc:Subject:Date:From;
        b=SFXlbhdpw5MAM+xByldqUuD/CLWI9zBFuv/tt/2YtO0gSTACRFXdGm7AcYlZUid0w
         DWf0RmBVjl7karx7OcL4+e1FapQdCyJ8YmiL8qAQLlDE52/dO0hURKpPIF9reFl7Wm
         wHjdux43RSTam/OTuYM+BAEiDdc0vXb54flWbSPE=
Received: from stbsrv-and-3.and.broadcom.com (stbsrv-and-3.and.broadcom.com [10.28.16.21])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id 17FAEAC0729;
        Wed, 26 Sep 2018 15:20:29 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        James Hogan <jhogan@kernel.org>, Alban Bedel <albeu@free.fr>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 0/5] Add XHCI, EHCI and OHCI drivers for Broadcom STB SoCs
Date:   Wed, 26 Sep 2018 18:20:09 -0400
Message-Id: <1538000414-24873-1-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add XHCI, EHCI and OHCI drivers for Broadcom STB SoCs. These drivers
depend on getting access to the new Broadcom STB USB PHY driver
through a device-tree phandle and will fail if the driver is not
available.

Al Cooper (5):
  dt-bindings: Add Broadcom STB OHCI, EHCI and XHCI binding document
  usb: host: Add OHCI driver for Broadcom STB SoCs
  usb: host: Add EHCI driver for Broadcom STB SoCs
  usb: host: Add XHCI driver for Broadcom STB SoCs
  usb: host: Enable building of new Broadcom STB USB drivers

 .../devicetree/bindings/usb/brcm,ehci-brcm.txt     |  22 ++
 .../devicetree/bindings/usb/brcm,ohci-brcm.txt     |  22 ++
 .../devicetree/bindings/usb/brcm,xhci-brcm.txt     |  23 ++
 MAINTAINERS                                        |   9 +
 drivers/usb/host/Kconfig                           |  27 ++
 drivers/usb/host/Makefile                          |   7 +
 drivers/usb/host/ehci-brcm.c                       | 304 +++++++++++++++++++++
 drivers/usb/host/ohci-brcm.c                       | 204 ++++++++++++++
 drivers/usb/host/xhci-brcm.c                       | 294 ++++++++++++++++++++
 9 files changed, 912 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,ehci-brcm.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,ohci-brcm.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,xhci-brcm.txt
 create mode 100644 drivers/usb/host/ehci-brcm.c
 create mode 100644 drivers/usb/host/ohci-brcm.c
 create mode 100644 drivers/usb/host/xhci-brcm.c

-- 
1.9.0.138.g2de3478

