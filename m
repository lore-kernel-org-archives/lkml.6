Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4187132-1520848275-2-8803349561649113793
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520848274; b=OwT7SF0aKR+9CTojfIM1xVbryg5e2AhVIq/cKdLxYQy1HiA
    fmRpOMuOZvzXiNr8le5+SF219eWCp0nS+AHJlSUYXcMk1yufoOjj//Rr2gRH9oZr
    2pKCfIhJ//p5NKlnVvWp3nezN0ArKswCF4hASYFGYhkU25DbyTwJP1oISfjuGrMF
    qYDGT78Fjqp/XpOnrBrz4FKKfsIfAOUbizM+c/uOMdJTBYXWnncnsbsE+WTwlJjL
    m2Mg+V03QczOpPVVvp8THZfY97/koxUBz7MHi+zM4c8U9Pfo3AI/0HcBdrS+DwzN
    Thtl/chn2aNk9oUt02hWi16qXG8IdQLk9teFUpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520848274; bh=gvp0RO
    vf/4GiNANw3BbDyxOI3HahitCZQjC0+sU/K3M=; b=qtajV5ZjMLruzENYwBI+oe
    7Dhl2k6Jkvh6RMSI/EDmq6ihsFP/CgkrjIqennw3JM5+c3y3R6Xo4NkTLjHUK1nL
    P3WjHBNi4V+wnT1RAryZT7X8Ljzyi5VwjOM8alstsQRSjTRZkwEFiavwKx4/49zc
    uRl8EA7cJkgsPfoiMOHIsuwYhG0n5T2mNsN9XNRzcf91kBpyjLrspo1RCldYkNAg
    JQWjL4XGEN03S7d/QYh+7SfpdT6l1dGxntGUqyrw615L/OMuu7CM0rWRScwD5mb4
    jEqoS74m5NL87kL1gs1oknYXsSdwF0OzN5sDtCjeCaUmp8w9/SeAlX31IRvAbScA
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeCLJud convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 12 Mar 2018 05:50:33 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:27779 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751229AbeCLJub (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Mar 2018 05:50:31 -0400
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
CC: Bich HEMON <bich.hemon@st.com>,
        Yves COPPEAUX <Yves.COPPEAUX@st.com>
Subject: [PATCH v2 1/2] dt-bindings: serial: stm32: add RS485 optional
 properties
Thread-Topic: [PATCH v2 1/2] dt-bindings: serial: stm32: add RS485 optional
 properties
Thread-Index: AQHTued/ENVr3ErzzUuPUNOVJTRsDQ==
Date: Mon, 12 Mar 2018 09:50:04 +0000
Message-ID: <1520848188-7343-2-git-send-email-bich.hemon@st.com>
References: <1520848188-7343-1-git-send-email-bich.hemon@st.com>
In-Reply-To: <1520848188-7343-1-git-send-email-bich.hemon@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_05:,,
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
index d150b04..9d3efed 100644
--- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
+++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
@@ -15,6 +15,8 @@ Required properties:
 Optional properties:
 - pinctrl: The reference on the pins configuration
 - st,hw-flow-ctrl: bool flag to enable hardware flow control.
+- rs485-rts-delay, rs485-rx-during-tx, rs485-rts-active-low,
+  linux,rs485-enabled-at-boot-time: see rs485.txt.
 - dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
 - dma-names: "rx" and/or "tx"
 
-- 
1.9.1
