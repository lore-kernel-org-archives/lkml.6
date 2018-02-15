Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518710397-2-1718492695698169232
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710397; b=VvHi46KhF60S0mASAud5F+hjT6+/QpflY/HfWhlEVJXUEWH
    QbjLXsLuc3gaA/wsovI8oGWvSqK8IDqv8k3IXrjhjEKLDIC4/GbpiNFPIyNHorOR
    RQcqsXOXUj8hIcNF7SfysLkhRFEu85SlKjxrtyUPlZqW18fkAb42JkpCME1Pt6Dy
    Oh9pGiw7RL2y4Zv9zD+C+dtfCh6Z8HQbDVFoymokJ7qbof1Hh/mjS/dL9To5xbmS
    5ZWUQCbIk15Ppo08FU1asaH381g5A+zThkLeqw9hi2S6Sn/cjT07kYIgF9tv/zQC
    Bwj2SKi43ldujQRS135SuS43EJCVYiXSjN2VY/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710397; bh=/G7eipE/L415w6vA963YeXfSS3
    BYwtnLe57RbCyMGJA=; b=LXwcf0Dvcm4DUi9+I/Mq9N8eWs2VbIGCudXWWYLt2J
    0oXGhuIyo2E5yj4eFQ6U2Y7TJsPkHmj6b8rBq/bMuW4AFXA4m3iW9GU1zQ21w8bl
    iBUJdRHrcr485EqqItTz6iVZhIh9IQYbGB/vGB88NN0KF3ghJykA7kxwR+bZ/LeU
    ab/vE+Kgd4EcajXrQzu5QLd1fREn9+Em3yF+FiOKj63S5VB10fh3AYDybt/JbkS1
    Vz5D48VJ50PS11UIfCOje/rjcNb2BdVBGJP5In1LYbUexzPQv/MuP7ZI0Oy5ZXHs
    rZq0Va+IwxVrCCkwDmlLldxSZz08cX5Fv1rPxQOk1vGA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424856AbeBOP7j (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:59:39 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34894 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1424749AbeBOPrB (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Feb 2018 10:47:01 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: John Youn <johnyoun@synopsys.com>, Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 1/2] dt-bindings: usb: fix the STM32F7 DWC2 OTG HS core binding
Date: Thu, 15 Feb 2018 16:46:40 +0100
Message-ID: <1518709601-17232-3-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518709601-17232-1-git-send-email-amelie.delaunay@st.com>
References: <1518709601-17232-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_06:,,
 signatures=0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fixes binding documentation for DWC2 controller in HS mode
found on STMicroelectronics STM32F7 SoC.
The v2 former patch [1] had been acked by Rob Herring, but v1 was merged.

[1] https://patchwork.kernel.org/patch/9925575/

Fixes: 000777dadc7e ("dt-bindings: usb: Document the STM32F7xx DWC2 ...")
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 Documentation/devicetree/bindings/usb/dwc2.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
index e64d903..46da5f1 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ b/Documentation/devicetree/bindings/usb/dwc2.txt
@@ -19,7 +19,7 @@ Required properties:
   configured in FS mode;
   - "st,stm32f4x9-hsotg": The DWC2 USB HS controller instance in STM32F4x9 SoCs
   configured in HS mode;
-  - "st,stm32f7xx-hsotg": The DWC2 USB HS controller instance in STM32F7xx SoCs
+  - "st,stm32f7-hsotg": The DWC2 USB HS controller instance in STM32F7 SoCs
     configured in HS mode;
 - reg : Should contain 1 register range (address and length)
 - interrupts : Should contain 1 interrupt
-- 
2.7.4

