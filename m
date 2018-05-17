Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1516388-1526538192-2-3056743395305552839
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES enfr, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526538192; b=Us/PmDsgrqWhQAMCSbfj6qle0/9r1aQwvnuojxYmhnSouyIs+b
    57iRE/TetOk+KJWE3HG36v7VCcl7/at2vgYiVIL/qF62qaWMhSX5woRep6dzjPFR
    W/oItVRV8yAYMZI0LsP/JjPYZpJa1tRRxo2FmhaQL/9XiwBj1axsHbcHfBdeiyjl
    dSEGZ544Iu/aBgJw/zpuzjqLsZ1G/R1GC6K7AXFfKSuMNp/rxuyP37fmWIGb6knO
    Qy6B2laOPZRKYbDPikVe8RzVyAcbgWPSZFJowmNST9OBk2LcCjXoTQrQ6mdld9ig
    uCCSZUkRDu1dHOTJ7M6FgHej5Q9yqEFoNKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526538192; bh=+hMT3vhK6c+E8uNdJ5XKUYVPWZyyAh
    x641JM4jOTkqg=; b=XbFhjQQzkdqI0phmbZrInYKHgGqWGYZPxL+Oo7htLig2O5
    6c1hP+7K/k2EpN5BLWDecxhdMDFxm7PoXO7nFW85vUe3WYVnyKKfueaQEdsJUCkL
    XISdL0Y2wdBbYpxFKYIJNrebjryM6yllgn5UIyoonAjwJ3w0dmrP/IisuG2OQT22
    jJaq+SHqSzeB8HbHg/Ag9+YILifpoYk0iWfdJ4dSropWoUPN9zDqWo+RLVRc5fDY
    yXDiAOakpAVZBIOlWpQI4dvAou4B9Vqd/TFfdamWwxl0yfC5Cm5fYkH9pa7erSte
    hPwmJ2AnD0rpYCZ6LiaKu2btnXHP6ln7vDQYeRaQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfLeDwzj5ud30+xi1xPZc98g070oLXmyAABbqKu/xPmY/KQ+fyRhSsN6EYdlfqluDDssqypOuI7l/ijDx1aWmozUYzw4WDwlEAkmm5e5JKsx7/fvsTw/I
    9hyn4T2SqW80+RcPitXY+bHlKquMvz5zdfaW/APIhuToBsTqUw1rP75SpWPuZdC6Nxar/lI3DF103KrwtiMPu2tHbG/QIMHgxX82Ntj64RImShR2l6bHcb5s
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=DZ5kIsXVIk4IAhlZaa4A:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeEQGW1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 02:22:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:43769 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752243AbeEQGWZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 May 2018 02:22:25 -0400
X-UUID: 13d5c88b3ea741dfa4ca027bc1cd1f58-20180517
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
Subject: [PATCH v3 3/4] dt-bindings: serial: Add compatible for Mediatek MT8183
Date: Thu, 17 May 2018 14:22:05 +0800
Message-ID: <1526538126-51497-4-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526538126-51497-1-git-send-email-erin.lo@mediatek.com>
References: <1526538126-51497-1-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This adds dt-binding documentation of uart for Mediatek MT8183 SoC
Platform.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 Documentation/devicetree/bindings/serial/mtk-uart.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
index f73abff..4783336 100644
--- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@ -15,6 +15,7 @@ Required properties:
   * "mediatek,mt8127-uart" for MT8127 compatible UARTS
   * "mediatek,mt8135-uart" for MT8135 compatible UARTS
   * "mediatek,mt8173-uart" for MT8173 compatible UARTS
+  * "mediatek,mt8183-uart", "mediatek,mt6577-uart" for MT8183 compatible UARTS
   * "mediatek,mt6577-uart" for MT6577 and all of the above
 
 - reg: The base address of the UART register bank.
-- 
1.9.1

