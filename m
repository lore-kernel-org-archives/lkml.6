Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1516388-1526538216-2-2257583526490147445
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
    1526538215; b=CLD5hPixKoZhoX2K7VPx0Vm1UKJKcNUxV27nPB54xAkRLXG4FI
    buEXKr3fNFwY8t6GeNslAipqH9Vsut0s4wLx9kqWSFbHKlfJeKIx90MpBe2ibwdP
    Wjkye0YPxu4L9545BWcc39O8IVfMna4NQjmG8nd9ejz8BerfWrta0v+hhx66MFTz
    sV3cUaYZZqADNgBEBSz5dJMHM40VmlMXdKv4eJNtQ3An/rRXElK/4CXtwCEJgG89
    iam2J5lh0tKuJKjOtBp7noWa9YlsoBiM0ExrgYSQU5yz3tDv5FUNRbTWHWU/F/DU
    fj0BNm/dSJKQ8nW7Zgbujo99AqQruY+T/Hzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526538215; bh=6SrU6/xk162TvKkSNROU2tW8Xukf8J
    +UpFo4Ge1uBfU=; b=DsOMyFRbOwlL7GFOk3+/dJuyRQJ59K6G46G4jvEuKYpf7C
    uSp4OT1nY5mQ4uZxnzROu8sninerfJShcMqXSVXLdRp104FoqZFUdX9ECMfHT6x2
    s/RhBlyDmMxTpLunBHSMv8jM38lkuhWpTe3eO7UzPl3rwWznBzBdAuHKJhHgnq04
    M7S0p0ZEFhlVah1H56OBtV5+8pViUTP43bOlJjnkuosWrp4PwLxZrve1RDH/dPVB
    +K41hCLn87uHs51E0yO97BWRFoH0WxqBsaqVXNp/GwOM/cFRzJ/s7kZvHSqNKmjf
    Imcb1E9aScBoGbSJ/Dr4T6l1+XXkYu9BISRbJUxw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfB9P1z1QBsaM4URx8YRFuRADh+gcsWlkDWYDsqQLylcXLCzhLWxSGXT+WxS8p9Y4nWnBlkzTTyjiHeC6DgOmA9PUDyACWlgAsvCemMk0FSuVWybaW08t
    iu0aDavFkVgemHbfMlaShOYdXYlaA7SbByVH4aj0h9OUgsKbbmZGutJ7PWs2f7j7hf7wLSHoU4dGhgY+CITlOXlPbYj+aLaS35bX7UOgpO+CtJqJ990GU/ND
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=JMjz8RqtuzTeefZ7teIA:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeEQGWX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 02:22:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39070 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752243AbeEQGWV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 May 2018 02:22:21 -0400
X-UUID: 6aa6e36b100d4d2991a3060ae96a2869-20180517
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
Subject: [PATCH v3 1/4] dt-bindings: arm: Add bindings for Mediatek MT8183 SoC Platform
Date: Thu, 17 May 2018 14:22:03 +0800
Message-ID: <1526538126-51497-2-git-send-email-erin.lo@mediatek.com>
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

This adds dt-binding documentation of cpu for Mediatek MT8183.

Signed-off-by: Erin Lo <erin.lo@mediatek.com>
---
 Documentation/devicetree/bindings/arm/mediatek.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.txt b/Documentation/devicetree/bindings/arm/mediatek.txt
index 7d21ab3..2754535 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek.txt
@@ -19,6 +19,7 @@ compatible: Must contain one of
    "mediatek,mt8127"
    "mediatek,mt8135"
    "mediatek,mt8173"
+   "mediatek,mt8183"
 
 
 Supported boards:
@@ -73,3 +74,6 @@ Supported boards:
 - MTK mt8173 tablet EVB:
     Required root node properties:
       - compatible = "mediatek,mt8173-evb", "mediatek,mt8173";
+- Evaluation board for MT8183:
+    Required root node properties:
+      - compatible = "mediatek,mt8183-evb", "mediatek,mt8183";
-- 
1.9.1

