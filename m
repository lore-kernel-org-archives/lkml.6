Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1521860-1525932689-2-9999738665291105159
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525932685; b=ImyAXf72UIa71LsrNmRqUCoXJcNUeYwRLyZ12sTF5FWB0NhmOm
    B0XIAtTpNpm4a/2xfZ40csjsrGORtFgLkhLNbXKZ5Wwm9db6TJfS/3FELuttE3AB
    Mjksg/tvrgQMrUEkhxDg5nNF2L3IzEOwds2TOjR2vfqP7b6LPUzUhALQdWCYLFOv
    Eta3MH6cJ610cBM85H8/6EQkY5iDOzhQ40jYpJG70/WPbkb8Nro1Nevn19079lD8
    8y+YMD4jlsS6WfZiS78CkSZqe/QshVJs28aPwqDf3wDFxK/GdxA+yQLAG5u7ct1a
    wHFCxwOmiDeBI/NVe8gnF5XeGlmKnmiR77nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1525932685;
    bh=yz093+M+VVqGmxgnpbx5hBmVg4WRs3oGMfKX5UxbtY0=; b=fdrxJn1qaFtc
    t51kXFJOMkl5MpuPbIYZadq6xpfFU6cFwACOIsL7Ddu9luDhQdaQk9MAJSC9c/V0
    7QOdV6OyqQ7PjQEyzTy53LwX5wmrY+7LcRQc3jhtz1sE7KWrA90NTAyrCWz2LHrJ
    sECoikQXqbtV1YiLfGigeNP0c4/azig9/n1OzEEsO8IFtI2tjFFZaRo3QE81p9ST
    cVdbcUiY8m8E2NQ17Vp8W4VZEU1vW5OL/L+UxJkAqFuM0nlmVDJsLQKEfjizf1YD
    XjRVZHnVSR39HCpPi1Y+OffJDd4bH1SMI8kc94zPt/1yTNQE5sjeEiewST5ZKmnZ
    ztWcU9pfpA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfGejeuTf6WzfrQ11gQq5h/fLSp3fget51M9t5+70Q98nJxzoETJfb8T3a92ebX2JQqpjUPzPgVZwTyNnymZP93rijIwTGxvv32dQqrVz0ZJy9HTY7F9Q
    7Apb89KfP7RZyrahaeot8jTxlQHQ5efCs3LfcGRdAlS6S6mdNG4udNq/v2StAX9Z/gXFge6gCXjJ0frkFR1aM0N+61OrGHZcXfP7r2aa059/aB4F98jg9t1w
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=C0-WKrUoQK2x4QJXk8kA:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753693AbeEJGKk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 02:10:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:53483 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750746AbeEJGKj (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 10 May 2018 02:10:39 -0400
X-UUID: 941666ccf12a47f99e6dd52cbeb3d5a5-20180510
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
Subject: Add MediaTek XS-PHY driver
Date: Thu, 10 May 2018 14:10:27 +0800
Message-ID: <1525932629-10603-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>From 2ca1243f228633ca9dd96d3e4068af9e2936cd51 Mon Sep 17 00:00:00 2001
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
Date: Thu, 10 May 2018 13:55:52 +0800
Subject: [PATCH v3 0/2]  Add MediaTek XS-PHY driver

This patch series support the SuperSpeedPlus XS-PHY transceiver for
USB3.1 GEN2 controller on MediaTek chips. The driver supports multiple
USB2.0, USB3.1 GEN2 ports.

v3: changes in binding (suggested by Rob)
    1. use the correct name of SoC as soc-model's example

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

