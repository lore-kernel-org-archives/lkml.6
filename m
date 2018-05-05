Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1031722-1525486538-2-11363172835245346453
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525486538; b=HSeXHub3cTGe7qTAMlHMxnjypB3TF0XFNomSLzN6xv7m5CYIhE
    ZE+L7UAgS2yAL7SZCzc5IsyBGOuXHLpmgPUhdQCiEkoZxtjaw4wq+hGhb6tC26LU
    ba6oX1gV6oF1FDrzvbHgM44F4MdU/FS3UA7DoFcwy5l5NHwMhTBoMtSkXXyv9/p+
    lu412Vs2emuELihWIVQyOVYT7VqGBH7lTN4PQhWdmk27s3QgPq7C2WSaCeyZhNtC
    zlZgQOLVoI/HXt6giz+7pq6LyR1MRr/b/xTsdYpsiQQILJBtpsZJHCMGo/rG1is1
    G1/MkW+a2s9vOiqyPyKzv/ZyQZf5WroYkRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1525486538;
    bh=65ZPXZNWG6HruAHx4FOqbOWRGBIZrsNPbi7Fh8Tb5Vw=; b=EJI1BxCdjHmt
    6XmngcbfZBulSmjqumOc9WXT3z29a6vveOIZaFlQix+VvHH+T6ac0kq7fMJ/SrH6
    hgaZ7jQIBHG+23jBnnypMcUYBKXmCpHouNK6qJvb946XQLuV0P+xuaXdVp+EalOq
    NRMPBVY2LrNEubRepwz5d6m1IKBx4r0TQ7+YvUfqN/EjVKsOD4zAifLRVbyc/v9B
    +meVQNeQwBnmbnrdBdPXnStfIWZnZ2W3kL93nWC9ySBZSiZwmdpxp9kbSAcKd8MY
    sZicAWC7xPECC2tsrjiB+WmeDW5Sp3OPf2gvQ6kBs2yP0ri0FT8gUOM9jY97s9Q1
    ZFx+d8h0Xg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mediatek.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mediatek.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHPJ4rezpCX3eZofhShB4vGlcDsdicuf5M3z3ZNIWlDPbafZ5qrF5AHX3z9hqckZtn51oZGMaEe3bMWptVNek9drXgqmLi5yRuIbzTO24FZfcBTRUeRP
    qV6P6YnBbrQ5finmjnFJsOaoppEIq3EwMB9DsFs5K/6tod/wXbeaXRXbkRQ3VwGiu+mbwiX4/9KvnVLCOfZAD7zqJVW3xlCTjk/THzGilaz040bz0mBZJ6MV
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=C0-WKrUoQK2x4QJXk8kA:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752042AbeEECPT (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 22:15:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:56954 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751808AbeEECPP (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 4 May 2018 22:15:15 -0400
X-UUID: e57f3e11618d47ec8333b9aeafa2b7cd-20180505
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/2] Add MediaTek XS-PHY driver
Date: Sat, 5 May 2018 10:15:04 +0800
Message-ID: <1525486506-19301-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>From a0814ad7725587a06d273997e0fdf5161f916fd8 Mon Sep 17 00:00:00 2001
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
Date: Sat, 5 May 2018 09:56:59 +0800
Subject: [PATCH v2 0/2] Add MediaTek XS-PHY driver

This patch series support the SuperSpeedPlus XS-PHY transceiver for
USB3.1 GEN2 controller on MediaTek chips. The driver supports multiple
USB2.0, USB3.1 GEN2 ports.

v2: changes in binding (suggested by Rob)
    1. list all valid SoCs for compatible
    2. move required child nodes after parent optional ones
    3. remove status property in example
    4. move banks layout example before dts one
    5. remove phy binding example
    6. add #address-cells, #size-cells, ranges properties for parent node

Chunfeng Yun (2):
  dt-bindings: add MediaTek XS-PHY binding
  phy: mediatek: add XS-PHY driver

 .../devicetree/bindings/phy/phy-mtk-xsphy.txt      | 110 ++++
 drivers/phy/mediatek/Kconfig                       |   9 +
 drivers/phy/mediatek/Makefile                      |   1 +
 drivers/phy/mediatek/phy-mtk-xsphy.c               | 600 +++++++++++++++++++++
 4 files changed, 720 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
 create mode 100644 drivers/phy/mediatek/phy-mtk-xsphy.c

-- 
1.9.1


