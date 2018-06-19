Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8505BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B93D205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B93D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937575AbeFSOZO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:25:14 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:34009 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757105AbeFSOYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:24:02 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id w5JEMmw2025147;
        Tue, 19 Jun 2018 17:22:49 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 8441)
        id C408562FF9; Tue, 19 Jun 2018 17:22:48 +0300 (IDT)
From:   avifishman70@gmail.com
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com, brendanhiggins@google.com,
        mathias.nyman@linux.intel.com, bjorn.andersson@linaro.org,
        jhogan@kernel.org, albeu@free.fr, chunfeng.yun@mediatek.com,
        tony@atomide.com, baolu.lu@linux.intel.com, elder@linaro.org,
        digetx@gmail.com, kstewart@linuxfoundation.org,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, openbmc@lists.ozlabs.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: [PATCH v6 0/3] USB host: Add USB ehci support for nuvoton npcm7xx
Date:   Tue, 19 Jun 2018 17:22:43 +0300
Message-Id: <20180619142246.104469-1-avifishman70@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Avi Fishman <avifishman70@gmail.com>

Changes since version 5:
- dt-bindings add 'reg' description according to Sergei Shtylyov comment

Changes since version 4:
- dt-bindings reviewed by Rob Herring

Changes since version 3:
- Follow Rob Herring comments to change dt-bindings commit subject

Changes since version 2:
- Follow Sergei Shtylyov comments to rename the node name in in device
  tree documentation

Changes since version 1:
- Follow Rob Herring comments in device tree documentation
- minor log error fix in ehci-npcm7xx.c
   
This patch adds support for ehci controller for the Nuvoton npcm7xx
platform.
Most of the code was taken from ehci-spear.c + specific initialization
code.

Avi Fishman (3):
  USB host: Add USB ehci support for nuvoton npcm7xx platform
  dt-bindings: usb: new ehci-npcm7xx dt
  MAINTAINERS: add subfolders for nuvoton *npcm*

 .../devicetree/bindings/usb/npcm7xx-usb.txt        |  18 ++
 MAINTAINERS                                        |   3 +
 drivers/usb/host/Kconfig                           |   8 +
 drivers/usb/host/Makefile                          |   1 +
 drivers/usb/host/ehci-npcm7xx.c                    | 212 +++++++++++++++++++++
 5 files changed, 242 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/npcm7xx-usb.txt
 create mode 100644 drivers/usb/host/ehci-npcm7xx.c

-- 
2.14.1

