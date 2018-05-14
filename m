Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-616870-1526293493-2-4090259823661001045
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
    1526293493; b=KD7N9jPXCqlsZyFu6r+Hbh3FXrIJ7gdEs9DaUum+k4uEqKdSnJ
    X8fldD86vDFS8Iylp2Dv27OxsgxEkuSiScGxP9q7yglN5ILTaP2HhZe/e/H1owQG
    6W8R5PROG93HhJgHgBlxRB50wQPIr6Qu1DxSLg9ytwlVS3WdjrX3vh7rPiUFKgyi
    iaWfp/KBsl78WSrHb0zOxR/9Jnq1OQH5YntW2Inw8H4kPYIO56eywoO6SGoYk8BH
    8/g1Im9c3ehdnA7ErkqksmOqgjJ7tiBwgjDRAlZrBosSX7CYTwgtNXk4tCkJbOb8
    GZo3EXJ3Eg4XZ0viqubgzARvY8PXeNjFpJ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526293493; bh=6SrU6/xk162TvKkSNROU2tW8Xukf8J
    +UpFo4Ge1uBfU=; b=IhSWwvb4A7jvaeyhoNNRzMJty3hTcYyJd/IGA8gYxdxFG0
    Nr7AwWD5leE83nT5IcVzNpEgWBxi4tmF4zS3okCA5XOUnAmySBRL+lGa008tI8P8
    4qoZnw1VtkmkEsc+m1RzM82BYiuJH6IDc/3utJA1paR6L/1liUPKjR2tXMhCJmF+
    C3wPHz9Ga1BmDVUkWeYHvebjvLIk9mOdTgESIzKNbF2p5wRysaRf/e4Z9xKQkvxw
    N1tS0CZLWNfQ2xCVU2MX44ojWsyeE9QfjV4UyVxwLzpL+73CBHm69D+Q3IQqHfEF
    +rPMQ2SN1YyYUGtqqwjR4SOEHRp3YNtuEtA1kZ0Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfCa8O9/+LbfxbD2XZiCyWDjP27Zpu58ZYS+gzE13fCAiiYGNawN7S75Y/xpXYSRsTGv8FP2RuM1kCpccrrdmKdREJuaS2RXpfXYd8RlSCTbi5Bq/+2L6
    QpGNUE2vkm0DFb3Y74DdLgYEQosaUMDX0JGSXiV+6PEr7Z9aG/JpYWjrOHSf9KSFukkJIZKvGKZKaCgbINwML+uQZrLtGvYJLe+yu4Fr9+T1IV9z1/fG8zTa
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=JMjz8RqtuzTeefZ7teIA:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbeENKXH (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 06:23:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:65344 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752104AbeENKXF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 May 2018 06:23:05 -0400
X-UUID: 714c24f60d744622a54be3a01275e90f-20180514
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
Subject: [PATCH v2 1/4] dt-bindings: arm: Add bindings for Mediatek MT8183 SoC Platform
Date: Mon, 14 May 2018 18:22:28 +0800
Message-ID: <1526293351-32794-2-git-send-email-erin.lo@mediatek.com>
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

