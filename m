Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756E1C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3175D2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAXcWCBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3175D2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388043AbeKFGyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:54:37 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40763 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387628AbeKFGyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:54:37 -0500
Received: by mail-pf1-f196.google.com with SMTP id x2-v6so962066pfm.7;
        Mon, 05 Nov 2018 13:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=X1FHSfOfOGOcLrKYsE799XOc611EoTbCuwrL4mJ+Dvc=;
        b=GAXcWCBk9HkoYEWh+tY0IOuaaFQv5EcCeiOxsAD4u86WyJQKflJv9Dsn7jQBlcKfdu
         Tp6cr5fQVoasZ7jKY0+T7roP2UEv0hmdRLnFxNdUSS2Cz6kU9Fs2XwffBiQH69BQjLcI
         ulCLwb8QVENuRjVnVpKJcordkIIMhVa4nKE1NvQjfn5zpDuH6GaqCEimIQxzAFnWrjrA
         LX3HbIahpefsHQ8uUgIDvHNrXvE5uFCEVDKC0lHf05xlwPsbyoddgZ5duKkpW+9awGox
         qL5TgmenqsVUj6pn8P8DFIiZ9vD/f8w7LmdA2v1xN23yJkXJibUcd2+F5YbHt4RHB5tM
         mAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X1FHSfOfOGOcLrKYsE799XOc611EoTbCuwrL4mJ+Dvc=;
        b=uVMnAQwd0afrxt6I+faCN+d5ZAhfz8QEScbnKWOu5wCEY/QtFJUcrBK6Q+KxY3r7tz
         SyCZroMq3PGEX5N9WJ8gwIdqcsS2xFTH7aXOCitElkvrbwzX4dwkGNAiAbaJDETsK3I+
         +DWx3pSI+d76KHKcp41ToIE8W01TU5lUql2Y5SS2ycZjN8wJODT7F16hl/LdyG7k6IZF
         nOCYTUkLL02XYVdRNKr3i946qu/A/6kuZzFy9zh9FLguJwFO23xgJheYNYPqV4ylQqA5
         jyreo78UMps8rKKXSRjHMhq3AzR6Q2hIs6GzHYBngQcFbd0lZuxsfQfH/qPbgvOkyFMm
         6dAg==
X-Gm-Message-State: AGRZ1gLPAUtq4G93rrNQuPEQfMals/kbY6B5eijXX1uDTu8mr0ZRx6Aa
        mXp7EcbsEQOPw8xGY1KdMfFLnTfbOJM=
X-Google-Smtp-Source: AJdET5cIgzI4iqJDKdz50Ep/Rfr+nGYkI/4w+S5fKj/yGAlxOdl02aJDd+XuUdoMzJFiM4KNzlzOLw==
X-Received: by 2002:a62:5ac3:: with SMTP id o186-v6mr24145394pfb.40.1541453575345;
        Mon, 05 Nov 2018 13:32:55 -0800 (PST)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id m129-v6sm14328440pfm.78.2018.11.05.13.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 13:32:54 -0800 (PST)
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
Subject: [PATCH V3 0/6] Add XHCI, EHCI and OHCI support for Broadcom STB SoS's
Date:   Mon,  5 Nov 2018 16:31:27 -0500
Message-Id: <1541453493-34981-1-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V3 - Based on feedback
   - Patch 3/6
     In xhci-brcm.h, fixed incorrect function name when
     CONFIG_USB_XHCI_BRCM is not defined. Found by kbuild test robot.
   - Patch 4/6
     In ohci-platform.c, use devm_kmemdup() instead of demv_kzalloc().
   - Patch 5/6
     In ehci-platform.c, use dma_coerce_mask_and_coherent()
     instead of dma_coerce_mask_and_coherent(). Remove unneeded
     #ifdef CONFIG_OF.

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
 drivers/usb/host/Kconfig                           |  29 +++
 drivers/usb/host/Makefile                          |  18 +-
 drivers/usb/host/ehci-brcm.c                       | 287 +++++++++++++++++++++
 drivers/usb/host/ohci-platform.c                   |  34 ++-
 drivers/usb/host/xhci-brcm.c                       |  17 ++
 drivers/usb/host/xhci-brcm.h                       |  16 ++
 drivers/usb/host/xhci-plat.c                       |   8 +
 include/linux/usb/hcd.h                            |   3 +
 include/linux/usb/ohci_pdriver.h                   |   1 +
 16 files changed, 499 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ohci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-xhci.txt
 create mode 100644 drivers/usb/host/ehci-brcm.c
 create mode 100644 drivers/usb/host/xhci-brcm.c
 create mode 100644 drivers/usb/host/xhci-brcm.h

-- 
1.9.0.138.g2de3478

