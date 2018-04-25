Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-318979-1524642372-2-15608853086935005989
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524642371; b=OB8vvYPCBwFFP4f8TJ6YMhKPBQ9BSuWsmbYT++DPMiiYTbcvOC
    CXUX+6As3eTXZRchN4aXBtbPdT01PsoIBbEe8DrPAwS+3WU25yyO2FCTwdttCt0y
    t28E43njbZlGVdOwiygHp4Ned4/npfEBLx2k77K965YBX3YTlt5Rom97GOigUyPw
    ka9sNep9YnXt5T8h988nxyCfzTTSPIX4h806rALf2n6eQVdqFHflUJX6oEd/jN2S
    BlDsfVVB4XxkyeLuEJ2BjPAiUxW7sa5LeG9GZDBkaDvDnYT6zQjHE78E/MINOPAC
    MYdThfSKaa0u8aQeijj8mmSHS9W8q6WsRTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524642371;
    bh=cIFrvLJQxZz89c8lxwcGCkLfBsB5r+CvmNkezPzoSco=; b=T99s5kNTfUDu
    r4e2MEyEUyIi4eXW3X289YxMNGXYYjyeQ4KJeYS0mJIjRlUKKrwmyKleeXMBxFf0
    O+QYEgVypL6IesNrHBn1Nled+XmnYAalbWxn26wXBeeV7FeRMSPOzlltG3Rb6igT
    +EVsLtVY6gUphdFoYPdiip18nRET11Wp5M/m7nwdgbWCFjNNopyBOAvf4YofgnjR
    jChIdKi5pK6FWMY2lTW6c85MNwnl5toHJr3MGosfCOfsvrOPr181w2vNe0L4J0uc
    cz8wXSozj2IGeTMNss4fyA1mGtnGezzeg0Ab/zqsTr2aAfElqfsczhvarZywRpWp
    V6yjFFnDkg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBo4+Zesn0SrDLbwqyIc+SMmW+Ls9RxF8xWbtyJQBijPq4Hh7C38Tew74dbQxFrpfGejsDFG+rnf7mekFdNVDQ4MYBZt6S/gHwHamGjysM7RG49OHcz9
    JU8c1CpEv6Jt5nVSCzPHqfw5vbcnMGRx7M1nImHBBe4WHfb2SGqL1fFDUokbOQc983lKOJpjNcltcQJYrzNL7IawW5BzJhnF2vDGfU0LbzKtbm1k2opSBOUv
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=C0-WKrUoQK2x4QJXk8kA:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751281AbeDYHpo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 03:45:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56518 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750841AbeDYHpm (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 25 Apr 2018 03:45:42 -0400
X-UUID: a4f3be6729104e1dbcbf3296e7d3b1f8-20180425
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
Date: Wed, 25 Apr 2018 15:45:27 +0800
Message-ID: <1524642329-12255-1-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>From dfce031e29c5fddbd1ea46bb2db0cde0ba62bcb0 Mon Sep 17 00:00:00 2001
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
Date: Wed, 25 Apr 2018 15:24:40 +0800
Subject: [PATCH 0/2] Add MediaTek XS-PHY driver

This patch series support the SuperSpeedPlus XS-PHY transceiver for
USB3.1 GEN2 controller on MediaTek chips. The driver supports multiple
USB2.0, USB3.1 GEN2 ports.

Chunfeng Yun (2):
  dt-bindings: add MediaTek XS-PHY binding
  phy: mediatek: add XS-PHY driver

 .../devicetree/bindings/phy/phy-mtk-xsphy.txt      | 127 +++++
 drivers/phy/mediatek/Kconfig                       |   9 +
 drivers/phy/mediatek/Makefile                      |   1 +
 drivers/phy/mediatek/phy-mtk-xsphy.c               | 600 +++++++++++++++++++++
 4 files changed, 737 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
 create mode 100644 drivers/phy/mediatek/phy-mtk-xsphy.c

-- 
1.9.1


