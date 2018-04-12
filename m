Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1055825-1523541435-2-6455127058478336084
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523541435; b=D4E/6SzbvPx5q2HQi0o82e6HeT71CRzWi6tOQb+/z45GNJy4/u
    NRfF1ORRNTPxpiXTU+BI6coqVJ5w7safwIzKgXWSojOGeWpbOpcEu0gvpatYOaka
    Tv3pPMsgEcwoxzOnnYoFDyAlOz0zHYQFbi1HaBKB7dapTlx0G7foeYx5M1hwPHEm
    xTGJigseCNSOAJok25cym6M2D6Gv+j2rH2cTOl2QEMHo1BWi7ABbMhfzRwJpm6eg
    +1eIrhblhutbxOCycgXUyy8NlmDx8rsoj3DpYrIz3cxw9lkt/DpJrO99SAOzynkL
    UzMXGzdqEBgc3Io/1NUOuiMP0VW4ZuNZ7WqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523541435; bh=B0NrUJjwor4VtxwgzThXxosAaNBgrb
    GVBsrytqvh3pA=; b=RK3PHcjo9AfheqsfjAxNPRFByK2x98RfzL/4k7iwW6qnuH
    o142CckHvSYu4QKitLS6SYGPIC7wGKEUddKdu/MMTCONqOTSYB18ImrTbo7/iaUR
    X2/bIDTcIzAcVLOq9v8/Ypf+U1jrkxDcKSazgp4waIkPkpQ/KuGAGUZI3JDZaZAi
    LRyxsRw41jvkZUxkEnEMSEU4i59zyweZigtaDLGPDYl1mr0jK5C0kCewKkyEUx9Q
    Qd9FFxjkYi5cdvD142qMNhh5uLSZM3JM5cmWwq1ZvL6ioZqcdsgTH3A3JVO672TE
    NnaH5YAJl/EozVFDAJ4jHQdGEr75N2S85a9aNNIw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=aXMmgpky x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=fKBLUXFi x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AL9yX8bg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=raspberrypi-org.20150623.gappssmtp.com header.i=@raspberrypi-org.20150623.gappssmtp.com header.b=aXMmgpky x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dkim=invalid (public key: invalid data, 0-bit  key sha256) header.d=raspberrypi.org header.i=@raspberrypi.org header.b=fKBLUXFi x-bits=0 x-keytype="" x-algorithm=sha256 x-selector=pp;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=raspberrypi.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AL9yX8bg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=raspberrypi.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA72hklf5TY8iGNXrz8uUgBLOdR860bz4kt30sb8SOKN3tDYO9FI7LkYvxdM43d3IMnc+cPaXHkPm9O6OsGIQzgrecCZK1U0HMohPr4TqmTUAUJDOcer
    suEaflOeX6NCyi1/t/Y3K7OSAckH2e5lEvFrz5NdsinldxBqUV+cXLgH43ikt09Kdlf+4TwapX6Kh9Hrft/qxe4JOIB92ZtOdCeMn535gd4x2/d4yKag4gNE
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=O7L2bwDtsCMSXQpecP0A:9 a=QBriDqMDdu-Dqmz_:21
    a=DQ92T5ThYJiZ69Rv:21 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeDLNzv (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 09:55:51 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:40324 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752355AbeDLNzt (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 12 Apr 2018 09:55:49 -0400
X-Google-Smtp-Source: AIpwx4+jz7jmPOm1F3O86yC4bidejCNb5ztpVi3mRMVSVk0qYBKtKvv7ZvHxbRj16Z7L+ecgTQF68g==
From: Phil Elwell <phil@raspberrypi.org>
To: Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH 0/4] lan78xx: Read configuration from Device Tree
Date: Thu, 12 Apr 2018 14:55:32 +0100
Message-Id: <1523541336-145953-1-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_07:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Microchip LAN78XX family of devices are Ethernet controllers with
a USB interface. Despite being discoverable devices it can be useful to
be able to configure them from Device Tree, particularly in low-cost
applications without an EEPROM or programmed OTP.

This patch set adds support for reading the MAC address, EEE setting
and LED modes from Device Tree.

Phil Elwell (4):
  lan78xx: Read MAC address from DT if present
  lan78xx: Read initial EEE setting from Device Tree
  lan78xx: Read LED modes from Device Tree
  dt-bindings: Document the DT bindings for lan78xx

 .../devicetree/bindings/net/microchip,lan78xx.txt  | 44 ++++++++++++
 MAINTAINERS                                        |  1 +
 drivers/net/usb/lan78xx.c                          | 81 ++++++++++++++++------
 3 files changed, 105 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.txt

-- 
2.7.4

