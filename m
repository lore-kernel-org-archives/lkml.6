Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-616870-1526293479-2-10352798935972793110
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526293478; b=UaEuHIpGgNE1Kr5r+TWstlSfIbVDLkbyYzfGCzM1K/DVUPAnPY
    9lfb3wQ89OiO5rA26XSS/BZRF0XQgcfPkNopgqggDekklVaRFBUEUfs3TaT7KYkG
    2ewz+Gk7kIZP75+E4WwnI2jdbkopFlwl9gip5ZwSH0Re/g4L6xvG0z1jvZ1OBHzZ
    dxEDc6VzrqYBix1r4Q4QgKhWempoiOIH85oFYS8LJOao41c3U1VMT235CyQB6YLm
    8awqPNSteVlIS3Y05sn0VNb8SoBJslbinGBcvj52kX3nLI7kE9dMNPFmuEQKOG7C
    sDcwss453ReYYmas4S6NrxRe8cr4Z2/8In3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526293478; bh=4nIZyQVZPOvUN5Bj0dvDWHoEfOd+nd
    85Mp96I1w5Uik=; b=en40Q9xWdHfvczNinmBeL2WMG8HM9IaWdTItZ5e/8cU30p
    QWTTQFR/tNd4T4d7EXda0/0JBDAHfoWZCw2YkIRWEXEizTPtcvlACdyti+y3ALMI
    4deqBUnTOjtk9XfO5KQAXwmoL5O12+wdn3Qo+qRjKRHlzdXAmyZH+jE9ZtYVwY93
    HZy1tx6XLecWz1SL7hbZz9x6/dZi578SKZlHD3l/8E/Kf2TCMBggmrydOyd8pvaY
    hT872olMUQYTQLwXzgDhn487mbkzKb2+9wOyBZOz94nAWSF5HlRXCF1oAX65pCTS
    jzMcX68PoNWTRMoWOOks9lLF1kc9y6dtfzv4aF0w==
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
X-CM-Envelope: MS4wfK4XKGxu8837iCUAnHNKVRgcPvPRwTpXCxRyM0HPJY8xE3oTIx8qkMlpaInurs4F6A6LvibCHatDT55cvbgIkF9KE/OqvzE9OLPaDJTGsGvw66nYVV/U
    85EUqCY35tLJ/2jVW4HGipi5rL2yoEmceE/efl7/du8AGBT0CahEsD4EjF9NGTFh0hCOtRQKnIjwbrIhtgEa+vnmohqvSqjoZokZe0CWgDiXxHR9+AUhK05N
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=AYVfP_-Pn8nHgOjBFCMA:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752149AbeENKXK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 06:23:10 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51059 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752130AbeENKXI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 May 2018 06:23:08 -0400
X-UUID: cf05d103c80349fb9a711ea56b58613a-20180514
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
Subject: [PATCH v2 2/4] dt-bindings: mtk-sysirq: Add compatible for Mediatek MT8183
Date: Mon, 14 May 2018 18:22:29 +0800
Message-ID: <1526293351-32794-3-git-send-email-erin.lo@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526293351-32794-1-git-send-email-erin.lo@mediatek.com>
References: <1526293351-32794-1-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This adds dt-binding documentation of SYSIRQ for Mediatek MT8183 SoC
Platform.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
index 07bf0b9..5ff48a8 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
@@ -5,6 +5,7 @@ interrupt.
 
 Required properties:
 - compatible: should be
+	"mediatek,mt8183-sysirq", "mediatek,mt6577-sysirq": for MT8183
 	"mediatek,mt8173-sysirq", "mediatek,mt6577-sysirq": for MT8173
 	"mediatek,mt8135-sysirq", "mediatek,mt6577-sysirq": for MT8135
 	"mediatek,mt8127-sysirq", "mediatek,mt6577-sysirq": for MT8127
-- 
1.9.1

