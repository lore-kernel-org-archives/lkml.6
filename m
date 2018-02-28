Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4127268-1519815425-2-12547335278766794320
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519815424; b=Xcnmjrt7alH3QKeMdcsM9/dwLYDScLG8jW4vICZq4b72SsN
    liwQuOPHtndO1mSzkok+qac0R/1CF5DBqJYcQWoTCQMen1C99ixOZHfwaZPCbc3e
    CxzC/K/WVCnggZzkwgcVWnaV1wZp11OZaXT+EqT9yM5FQ/JV8l22aOQyhaHYGWhT
    vZqXR96kV5iuSKQ7Ycr+jg3L3ibsr9m897U/4g8fvlBMVIA7ycz75jk9FrrPvzFg
    DoXjcTvo1g2gkHfCJdghOwZhz6NYIMn+WUbRDrITW9fy+uVuutO3qKth2OCP97Ub
    jvWcHj8ZU5nPurtz5ltk5tYoO+2GDV15fCu7kVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1519815424; bh=UxGj5x
    Nhlq9WlM5ZN6DC8/lPVSPo/gg1cgz303PinfA=; b=moB9AJe17Gugbea8+owgdk
    OZmJzgqz7kH/VyynLDgvNPI0CChIjkYV5pf3Sf5z3d/M6AyBgU//w4aoTeZ/rFFE
    CkbrT62ZqalXqgSjlhRdOEZKi3CS9jeBDHhnuTonMTZAeBKyiearsmcNAqk/AigI
    auxVHYzoFbWnMiJ+e8DiSBk4l/rEOnueX9pCBmFH3JsUA/18VBxclsAJn1YKT1hi
    tahgiFZIrThQH4A9kIudmgIMGxk54Pk5Tcc7pVBftX1YdpD/KW7b0tZYY4pK054E
    CRl8WmepAiy0FO+l7lo5Q3YT/bHs/fJybleu96XeEDvvJY1PCLg8KHx2apTF0xhQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752526AbeB1K5C convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 28 Feb 2018 05:57:02 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:33187 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752583AbeB1K47 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Feb 2018 05:56:59 -0500
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
Subject: [PATCH 1/2] dt-bindings: serial: stm32: add RS485 optional properties
Thread-Topic: [PATCH 1/2] dt-bindings: serial: stm32: add RS485 optional
 properties
Thread-Index: AQHTsILD+3mLFjGajEW9eJJfj3p8HA==
Date: Wed, 28 Feb 2018 10:56:18 +0000
Message-ID: <1519815373-22940-2-git-send-email-bich.hemon@st.com>
References: <1519815373-22940-1-git-send-email-bich.hemon@st.com>
In-Reply-To: <1519815373-22940-1-git-send-email-bich.hemon@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.50]
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

Add options for enabling RS485 hardware control and configuring
Driver Enable signal:
- rs485-rts-delay
- rs485-rx-during-tx
- rs485-rts-active-low
- linux,rs485-enabled-at-boot-time

Signed-off-by: Bich Hemon <bich.hemon@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
index aaeb564..81e0011 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -16,6 +16,8 @@ Required properties:
 Optional properties:
 - pinctrl: The reference on the pins configuration
 - st,hw-flow-ctrl: bool flag to enable hardware flow control.
+- rs485-rts-delay, rs485-rx-during-tx, rs485-rts-active-low,
+  linux,rs485-enabled-at-boot-time: see rs485.txt.
 - dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
 - dma-names: "rx" and/or "tx"
 - wakeup-source: bool flag to indicate this device has wakeup capabilities
-- 
1.9.1
