Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1581498-1526538184-2-5437676814305333753
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526538184; b=fS01UOtA6SjfC2wiKGWrwV3zZhvoN1lbmeekzqwfpFkkap4Wtc
    mGnzAY4TtW/k5pVFIL/Vw/3N47ylSda8U/ZG5vzxXz2J0FcAgI2sQIPXepDFt1YN
    6Lkejj7MucGuYjUzyYxawOPnVLrB8nR6wdDQuY0CGI80wQqPrw7lvsCCq6lh8BH6
    59AYLLJ6+xJMjMNQJ1ygjpVD+cjo7rrNILCwM/+Td/1sq9QosMHJcK61EkcPZzVG
    fjftudAduRlXPZUY4rO3JjuYLzT2fXynvhVJYhFdVmeiqOsDTwsKiAlqE3n6pdHa
    i0Zvv7E2ON9cwK1KGtEBbwDezeyrSUXkSXxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526538184; bh=4nIZyQVZPOvUN5Bj0dvDWHoEfOd+nd
    85Mp96I1w5Uik=; b=FGB2/UAcqNpDqcecK17r6QprhUIDPP8vbhaYGS6yaR4KQU
    BaUJVyRPDBvO/R4AXvsjFKOEpxAYBAKF58GtdUnJI+UUdfej3v2ZMVTLOoMDk9B/
    dKbK/1txls7JgPT/ecIHDSrZK+3cXO7hkw3rdqo6K92jE7N3NbyE9JxkQ9E4GCVW
    OnPqJVHpyx1LkRv6I8ojQ0Hg0spGMJ6+tjQFArUCOAPG5UCJ4OERAoQ1zJDC/F0B
    S5ztyKdVOUPt6PojJ2xvrDYtT6nko6shXNr/yWLoiSO/5ZRdDRvVTG8/FB+buaRI
    QE8ug+noXwrTB3HHxinrLT6KDwuuwMxQsDReX5KA==
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
X-CM-Envelope: MS4wfIegelGdujDquaZo+jV/qtPPWTsc4HDNLtspiR63QNGVTXV2yA1punFOYcr9ce49AC6CieFqigqXRgjcIe2VSZYB0cncKf1vYTL0R2oMeQHdA9wq2gds
    14MIwYWgGoNm4QKZml09HZUyVL9ffJUnwhuUvQZgFJbA6ggggPfMzPoNz1OuxD3170/msxnzNcwRE6v3bZWmrKINZzsVj2CUNQm9m3dskvxsLN0aIiWAoWyS
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=AYVfP_-Pn8nHgOjBFCMA:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752566AbeEQGW1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 02:22:27 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31165 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752491AbeEQGWZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 May 2018 02:22:25 -0400
X-UUID: e96f007d03ef49c88b8d9d38f5f18a29-20180517
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
Subject: [PATCH v3 2/4] dt-bindings: mtk-sysirq: Add compatible for Mediatek MT8183
Date: Thu, 17 May 2018 14:22:04 +0800
Message-ID: <1526538126-51497-3-git-send-email-erin.lo@mediatek.com>
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

