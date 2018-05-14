Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-610692-1526293387-2-14070028415956947394
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526293386; b=EAh9rvu7aZKd/1Dgq9AXDXQIcN/UiuBdxl7BQLzksCJhVBQNeY
    FEMMJxcGH+mk3Qkmw5ZrgxULfwmFKdZMpBlbVjDTOwctaXGGRoDSoF0XdtCAvDqa
    C7dYB7AsjDUV1NAH0cGvgGYxLpvCISi4RrWHqFp1rzh9+FtW5IxA0ZeH1ViN6pWc
    Vagr6DzY5cKO4Bl/dQrhW6IBHSgOn98GCHWd5O/sxiOoqG0AbaOEndJHbO1YtGvl
    NtJw4IkbzXTfN9oEY5Qe44IYHa0U9yLgKWY45WcRc6JwEwOAC1kCG7Kphrx1+2kf
    +SMRplrxJPzzPLjWdRisnXmElD3kUFE1JI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1526293386;
    bh=V9zVap+LnqZ3I27nmacdpyLE5+mJt6WHoFA1dGNj0tc=; b=LWMqr9RGGWN/
    3qBIeW9PvIJAgPlTC5B1hS+rStQBd4fpwfVhWyWquSDz6/B9yTY+V7bELwFkPOSv
    Q7plh2W7Rv/4buC0M5VRL2ZEcTlDK+/gUZOD+YzQ7+asAY1KLbP+mQ3AGa0hWgKW
    uh7TlAL/UmxbJowDcpa/piyEP1qVXfxmEZ5jJVNRMeNMm83AefnbeWClklbjSGWn
    pHg55Wuoqhs6soXotYVUeWUJX/GAeEQcEoalV3mexfsOU/691IUvT9c0THwrRfjN
    A4w0pWlfC10KB8uKQ2lJUxmJL4vT2Ie2raSNwpR34dE1kqtQXrKtxxlhUdGnX3Da
    i3SoFOIRwQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mediatek.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
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
X-CM-Envelope: MS4wfDA/S2LQQ3ksSX8Kp4aAFNNKg5MNS4PXJTp90Zjy0yQ44ivdXkxzGv4hduPyu8mHpcrxp9mQybkmMRAElFJ4RhKgZ5L5H4WBNAocZNWd+c33nMTSoI6u
    CYNXeM+b7Kwy9Hu+U4aSwMBE6XBYUIUT5z776hOB77il1M2JD3F4lJr/ICENrYohtUnypaALanwQA+7eHf5P/w6Ysoe6q5tt//dfE7fHXNGXe62K81NgWilX
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=xmyZ8f8SxgjA0YyvIm0A:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbeENKXD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 06:23:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:23598 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751487AbeENKXC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 May 2018 06:23:02 -0400
X-UUID: 6c5359011ba5465892850a763576e24e-20180514
From: Erin Lo <erin.lo@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <yingjoe.chen@mediatek.com>, <erin.lo@mediatek.com>,
        <mars.cheng@mediatek.com>
Subject: [PATCH v2 0/4] Add basic support for Mediatek MT8183 SoC
Date: Mon, 14 May 2018 18:22:27 +0800
Message-ID: <1526293351-32794-1-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

MT8183 is a SoC based on 64bit ARMv8 architecture.
It contains 4 CA53 and 4 CA73 cores.
MT8183 share many HW IP with MT65xx series.
This patchset was tested on MT8183 evaluation board, and boot to shell ok.

This series contains document bindings, device tree including interrupt, uart.

Change in v2:
1. Split dt-bindings into different patches
2. Correct bindings for supported SoCs (mtk-uart.txt)

Ben Ho (1):
  arm64: dts: Add Mediatek SoC MT8183 and evaluation board dts and
    Makefile

Erin Lo (3):
  dt-bindings: arm: Add bindings for Mediatek MT8183 SoC Platform
  dt-bindings: mtk-sysirq: Add compatible for Mediatek MT8183
  dt-bindings: serial: Add compatible for Mediatek MT8183

 Documentation/devicetree/bindings/arm/mediatek.txt |   4 +
 .../interrupt-controller/mediatek,sysirq.txt       |   1 +
 .../devicetree/bindings/serial/mtk-uart.txt        |   1 +
 arch/arm64/boot/dts/mediatek/Makefile              |   1 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts        |  31 ++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           | 178 +++++++++++++++++++++
 6 files changed, 216 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183.dtsi

--
1.9.1

