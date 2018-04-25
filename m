Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-144809-1524637109-2-8351713420420782243
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
    1524637108; b=SPqamdR3bafbmUXwEaz9zwuOo939RXYdIN1yZluLzh8K6cB4dh
    lMUm1aaNCtNLTj+Pz7ELwC4fPLoWPM/YuHP3fA8CT55d7RqfUcl4ZeyRn3X4RGmB
    KvaVGxjC1yu6DlqnmPg74YfahfKnjemU5lZgvz/XArXi8YQtCOK3cKx+g9PPEET8
    Sr3arHqmNcak1yCiCBeYZxVmtZHAFR8mHtI6r9XNBA2Zdvlcba7d267dkg/gRoDY
    ZWRi97WkTe4jVvlkcncEFFX+9/jCrnCZCQGO9ODnX39M04unykgTdAGt5OkLoJ/8
    sE+4ee3EhNPa4Lt1dFeykZqAqtVFQgcQmM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524637108;
    bh=2/GosktaF+ti2RN5OZO1p2KdVQ2xJujoPIfAI+22joI=; b=KVkunBPra15B
    Iu1QVYN9IBzWkvIO98FWqWXpRwfATRFq2FzbP4OUgbMiaLTswEP5/8it9CUpt5lQ
    nb3ajwqXn9Frn0idGEiiliLUmIp0oMsz2KrxDUFGN1ivNSagD0WLqmBRz8a/plLn
    sWrBCrKLS/42pqH6m5TizW1kcLU1jdJHa/n0F1UZlfCwxc01CJU1fYfdlAMohYzH
    SL2RfbL2flDCiFWG8y6rl8yOR0MZpMHjUqdlnpvscvo8XCe3S4Hd4DnHDmSNdUHI
    a5ortNQywkb9dT+EOAmdW+dbAnrIjampXc15+VLcJbJGEWFbadlCfJq1inmS/nsB
    S8rKvDqCcA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfCHx8UrsyLxv0jyZLQ1NBwHAZT6p5dCRJXtOWOAAcPAbk0nAGWb+N9IgVvrxwXsjQEr0m24OrBbv0FbFJLElEIfIhzGV9/2EMt1UimnIxO4xvnh5KhAk
    0zE4F1BJxXZasoj0Yjo9lX4oHW+380HdabJ1EuQxd1ENRYi7iAd+g2SaR/W/ULX3aXM80rqwpP1O7KVPCUU6y5Y/DtimGMnnbTg4Cu0cS8QNEBzfCob7daHA
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=MIK1vUhpFAYyWxR2ApkA:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbeDYGSQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 02:18:16 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:52614 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750949AbeDYGSP (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 25 Apr 2018 02:18:15 -0400
X-UUID: c18ede16b6764f30bd2b59d172e5a641-20180425
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH] phy: phy-mtk-tphy: fix checkpatch.pl warning about SPDX_LICENSE_TAG
Date: Wed, 25 Apr 2018 14:17:55 +0800
Message-ID: <13d5ecd89f312af71dde347aadb18b65b1fac462.1524636174.git.chunfeng.yun@mediatek.com>
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

