Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-616870-1526293412-2-11572751501550989941
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES enfrda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526293412; b=EyRwkYAQC04QqlavUQZJEJez4Q4UJ1OZ2ejJxJNl1U36PYouMp
    /QNfdFgUcbFC5yxyJYXTUssWPeUu89ZJ99pPZloB5I/k8J/6rqyke0HzCbOSSkCI
    f8VpIqyXk/lQYIlaOuE+EeAgJTkb2gX7QgJpLkUOVgjYeIOiKR/iKL3eNNNV03aj
    YakMTycrpq21FmqrmqX6sfOQqwODDVpbaX0Og6ZMW0CXZKuCmlSHIwLgVq9ogobS
    MB0EAQe3HhqNYpB9XUxfy2Fl0ncRjOGR0MmDpKmj81Y3Rc7lmzZ83ZKSoBn9ns5H
    qy2Bq9MnGJy5Yoj5T9SCsnhE+5UPJMc/zJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526293412; bh=+hMT3vhK6c+E8uNdJ5XKUYVPWZyyAh
    x641JM4jOTkqg=; b=Yov1Xxd4pU+EqJ+fJbrwQv+XBRs57pWsqNqyxFXy0GIwQ9
    EfB94v7Kss6P61rk5MO07bbkCZCmXbDnriufVZmWJGba3Ear69bcNU31UnzkyVAN
    9atm1JDWxSGbXS2+GHSiJkOJTiXk3SypiE7ZS5T0Sc8Zh8Vyj/AdjGnPf1FtKLx6
    9G0MZG+xB6XxId3Srb9f0A1hcJaAx+AMIf9NqPATtV21/5+dqfJ8TYWw2LVozYC1
    WVENtakGS/dYa9cdzvFWZSVKAoqxSp1yKkmNzs3EYZ5KS3r/P7VtlDbBvxp3tRj6
    hi9pfJJJBY5Frm45oetjOOXeXMD0BbJA7ARfNDFQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfOfXLGKD/DgDxVMXqr746lYJeqVDk3XfzvYA7ffGB+a4weVLPd/JDGIGyXcC4Ng7EW5970f5fXILpsc3a4d/xK4FIm7/s/D5N2IIXSlH4dI/LxywAgfM
    aQ/PJ4zg3JuIfhQERpXcpNxQQU0gIwT9LoCsD2G9TbArKo5G8f5d/N5wNrsz0388VzlTBvHT/4DZHgAtV7Hk9aayjuGf4ajN5clRD3yAiCGONu9bv8mAJ+6g
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=DZ5kIsXVIk4IAhlZaa4A:9 a=x8gzFH9gYPwA:10
    a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752104AbeENKXR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 06:23:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:30580 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752147AbeENKXL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 May 2018 06:23:11 -0400
X-UUID: 8e5c3922d80846d69b98a89f02a045e3-20180514
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
Subject: [PATCH v2 3/4] dt-bindings: serial: Add compatible for Mediatek MT8183
Date: Mon, 14 May 2018 18:22:30 +0800
Message-ID: <1526293351-32794-4-git-send-email-erin.lo@mediatek.com>
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

