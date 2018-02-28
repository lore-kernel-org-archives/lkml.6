Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4104350-1519815167-2-3592258833219275833
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519815166; b=pAt2AXRb9ce+rVFkUwot2/DyPSHcTDbjf8qP+kf9acd114H
    o7lUK4x2JJIXFgYKXFEMh29P582c5J8GSmtEjBuZ5CrZ3a9LqLvYwg8RmsQ2NF4t
    HM/h8R/UO0Np9CAKSY19WTonYs7SQhkErJgUsq0ia3TOkKe5LfLcCBY+Xg3K7qGf
    QWEURIDnlawLpHP9gblefs5+4tjCQ3cj34nm5efDJnhb0xWVlJAAVf8fcuXYCnWc
    /FYOqCCL/vePncR2lw89tWLVcRgft1JNaifF7RGNT3r8m7gSD7TNVF+rrZXxke0Y
    BiklKy1O6wzQIfZY93IN2BYDEeOq78CDGck+hmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1519815166; bh=NBze4y
    e5XYSVI33+n3zWUO58SCTO9C3xYR6EJMXmRzE=; b=gCWkYX+SXyiZ8geqC4OvHO
    RCLJOjoG8utDYbkpSt1R4AUNi1nLAib7Hk/Zj2Ct/NhsL+6Xof4XBbnNrXSi2dCc
    r75Ge0JSfExTseJRhTu1wawEtnycOdqaZFTW/YZrR04IOHrpJRYjIQVqeMy8Be7o
    HQ6kv/NCTPIz0ZzPfq2KyIA/JgJVlnncSRI8wGnNbaaWCUdpHTi5nKUfLB4zCfhJ
    kc3o7m8sVXCLZXcESVBN0Z6rje/Wl7LczFtFzoHNtyi+qAgbTK3aCsuCO/wCQ7R/
    WIRe+2e1skdRH1NzIrHSzNVZu+GQtLUZpZ48YkTqgq04x533EH7/IK4qTZCsFkZQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeB1Kwo convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 28 Feb 2018 05:52:44 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40125 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752649AbeB1Kwj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Feb 2018 05:52:39 -0500
From: Bich HEMON <bich.hemon@st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Jiri Slaby" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 1/2] dt-bindings: serial: stm32: add wakeup option using note
Thread-Topic: [PATCH 1/2] dt-bindings: serial: stm32: add wakeup option using
 note
Thread-Index: AQHTsIIPgGCLJFJ+jEGH1YLV7cEg3w==
Date: Wed, 28 Feb 2018 10:51:17 +0000
Message-ID: <1519815044-22669-2-git-send-email-bich.hemon@st.com>
References: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
In-Reply-To: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_06:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Update bindings with interrupt-names and wakeup-source information

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index d150b04..aaeb564 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -10,6 +10,7 @@ Required properties:
 - interrupts:
   - The interrupt line for the USART instance,
   - An optional wake-up interrupt.
+- interrupt-names: Contains "event" for the USART interrupt line.
 - clocks: The input clock of the USART instance
 
 Optional properties:
@@ -17,6 +18,9 @@ Optional properties:
 - st,hw-flow-ctrl: bool flag to enable hardware flow control.
 - dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
 - dma-names: "rx" and/or "tx"
+- wakeup-source: bool flag to indicate this device has wakeup capabilities
+- interrupt-names : Should contain "wakeup" if optional wake-up interrupt is
+  used.
 
 Examples:
 usart4: serial@40004c00 {
-- 
1.9.1
