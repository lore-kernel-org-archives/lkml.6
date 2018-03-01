Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2663868-1519898929-2-7460252653854349752
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519898928; b=cm7LlzdFB3+/zJPm5LErdmsrqDWbFQ+5bs6KzfcvZLFVMcr
    /pJ1iAAL2yVJQ8E+TKuCMyOgDujTWCt6qnO2HDgOVWemrgdTvfKmRO2keCLn9viv
    he0B/7P+OLi/lnT7ygu0Q2FJFwh5dXrsTyOcq0dReoVDlBrJqxrGVHrnebBDyIt+
    GTjMrPX3BgUBU+X3nDGDAMM2yqCUhefdLpUpaCWO5zo1WJHotqruvyEHdq0vvnd9
    xgaGxQRsZpGFwj6dV0eVzRfqCY6sS+b9I5ULGnNTlmOSpc3bRo8NEnmI2v5ogr65
    qkIJ9i4VB+h3+9RMGXxzUDBoS40pXHk5+MNGTIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519898928; bh=eWUpLn3sT6nncqLt+AAs7d7mO/
    VLUzE9m3jNYi61SJI=; b=u9DDRrhX4FBTegRoDaXYkMfNNfm/OrOhstN9i/fPFz
    sHHJ4LAOhLrB0ZWaQtKJTSZDPhJvk/1I80PWMTaLNeCzQ/9pWs5X4sV8R24SBlkW
    1GHVA/qG9quOCS8RQ7+B90uALewnskDJ0PZ4/6rl3VQoNn5/gLJJ1R7BP95mk9t+
    DfMvEwgErUebR2MrmsHm2jhZzFzQR+8cCC4ZBk7DLK4pP0OrkM3hPZkZlhx9+vdG
    /+jdQHUrPZO0w8yeMshep2PoQFAR9cOGpjPuRhMq6YTIfIRiLl7YzBD8CHePspnY
    bOuDYqqcxZfiTFiEzsxtz45VTmnM6a1mILBPstSjPNXQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967354AbeCAKF5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 05:05:57 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:61561 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S967232AbeCAKFy (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 1 Mar 2018 05:05:54 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: John Youn <johnyoun@synopsys.com>, Felipe Balbi <balbi@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC: <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH RESEND 1/2] dt-bindings: usb: fix the STM32F7 DWC2 OTG HS core binding
Date: Thu, 1 Mar 2018 11:05:34 +0100
Message-ID: <1519898735-10319-2-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519898735-10319-1-git-send-email-amelie.delaunay@st.com>
References: <1519898735-10319-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-01_05:,,
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
Reviewed-by: Rob Herring <robh@kernel.org>
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

