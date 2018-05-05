Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-977734-1525484904-2-14231824329366982310
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
    1525484903; b=aCLOacuZftqy44R3Bp0G8SiUU45KYpE+7/QdvsD1NK0hrsHRi9
    kXxUiAOiStcxrmoqpWMW/pp8letPbjMnAGC8HFaKB/Zvc7+im2l79CR9zkrOkhcN
    Zf1DtKGvK+LvC+FmrSp8XQP9MejT+iUwEbkawAm4kx6ZCcr5mwXbjIE2ZuloFoN5
    vrt77n+hWvvsSpiSevEo6PchP2IXglQgdhMRjGShghu9feqMrUmc0HSBpguxlwHi
    KYdbgwRdo2jdUuULXOMB/upK0q4zSgQ51eX1yBP+m7JxX4iCqQzDUDArMMc5I+i1
    ZCevDNG+2kL8PgOhIyZt49HZhKP9MxhhI5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1525484903;
    bh=aUahQTHjHS740rBSmYKx94vewUWOT1Fz5AblbasSznY=; b=BNHWtkUcpUZR
    LLPUxgdoUxeP8aqgqmC2+Xg7e96ZDUYqdV0hywx9N4LrkTk58Mv6PkquQzvkDt+r
    LnAOhRXrMqSJS56h+PHy49820A/NyCvVtkFr2Zcyk7xBxvyLm1Fo94EyWJfgsDg5
    po9HOKjFouFoS5GnMveFIflFC5Lh2xnLtGSUTuLNUeDiVMT1WzyY7MvC1byIDn1m
    AtWaK8Ua4H88ABeMl1O4gKxzSwGVZaNdMJ78eD6ZPTzq+C8Eiy/MyWT8lxzOUOEF
    y0OCojgRPQ+cwEVcREGM4j9wdkJ1jjTC1f2PYv8mg7/OBGWFnQmYvlf9kcUn0g3L
    TXvGPgmQ2w==
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
X-CM-Envelope: MS4wfO3ZmdWo8I8OStZbGGpLRn6sO1X5FjHt2Pr9zkA0HR32kRzAe9FBeQN583vJh6gkY55crCfxq10e8tCU2l1OazU62ZjlBfAKcyjTmA88VRs8ac/Z0Jez
    vqMpHjZdTH4PCVXqSsDzxXHZF80FTuSTD6iBenIm/I+pphfFFCT4VJgbDdb33hT5VErlXWkEZun5dSnr982v9Vk9B6NhvFHbhxXsK4iZQ4y2uNsYwsxmrqns
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=MIK1vUhpFAYyWxR2ApkA:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeEEBsL (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 21:48:11 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:33793 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751711AbeEEBsK (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 4 May 2018 21:48:10 -0400
X-UUID: 617b22dc2f3343b289fb7461095255ba-20180505
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2] phy: phy-mtk-tphy: use SPDX license tag
Date: Sat, 5 May 2018 09:47:41 +0800
Message-ID: <e650d3f5f586e6282a5bbbc4007e4920d4a9147f.1525484369.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use SPDX-License-Identifier tag instead of the GPL license text

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: change subject line to fix checkpatch warning:
    "A patch subject line should describe the change not
    the tool that found it"
---
 drivers/phy/mediatek/Makefile       |  1 +
 drivers/phy/mediatek/phy-mtk-tphy.c | 10 +---------
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makefile
index 763a92e..1bdab14 100644
--- a/drivers/phy/mediatek/Makefile
+++ b/drivers/phy/mediatek/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Makefile for the phy drivers.
 #
diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 38c281b..b962339 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -1,16 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2015 MediaTek Inc.
  * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
  *
- * This software is licensed under the terms of the GNU General Public
- * License version 2, as published by the Free Software Foundation, and
- * may be copied, distributed, and modified under those terms.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
  */
 
 #include <dt-bindings/phy/phy.h>
-- 
1.9.1

