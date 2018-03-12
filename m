Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3579367-1520832439-2-15118272078071426057
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520832439; b=P3USNS6AKQH/ojFijF2hTubK4NNBQy3JtaPY8ZaG4XXvL/6
    UluSiAOw9j8rC0Dvd6UeZ4iIzw+LaLNviv0kNKSXTNuMUh/moP8TcDgdTOhbXQ81
    sTNeVrvqqjQ/S6FBHQHiQWKAV2+1PqO2U3bLKgA2uNF+q6YWPNGsXWDnZUkNpHHS
    3CLq8cgu0b502DAvZ5bIzlo7ChrfIh5KdoyZetU0HSxDVPkJkchv97C6ympLfVUr
    8oVz1jUycPKACHFGfMsx3yEJM/y5FRKnVmpS3ofpqUHDF8I4SVMvZp22eNfDSSNe
    KWUQT1HQH1TXo60atiA56zvfOijwDTS+DAIKdNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520832439; bh=a3Ie4uvt16vCDwDhOnSj8b9FI/
    YmMR0sFUmNbsFCcbo=; b=aukiHFzOT338ik4JZBe/R4idBtjYbg523baAON9DlN
    vCh9dKkYcFDnKA62RZa8micpA0oxH65YNNzzz3GRCVOgVTmOo74lYC/p+pvKeWAL
    rmPjYgvXD4BHNDMgChhLm6JZp4nad2XXkwOrV5y7EkJ3lueGaOF1CFH7KqzGpmQ9
    0/iVyii5Z0tY36Rn5mbedYPUi07Hniz3wQ4srVfdeo6QdyjVyTjbeWxYlN+qXow6
    gClMsTItkQ1VXMOdeZtBBLo+7HMehy2Ki/UEZ+vRV3LeDFCP87Mtdf++PYhnkonw
    D1kJKhFFEDIfuJ8uMB6s2i1L6NWzzTPzVilbucCmGXaw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751599AbeCLF0O (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 01:26:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31679 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751312AbeCLFZu (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 12 Mar 2018 01:25:50 -0400
X-UUID: 35f840c5283940dbaaf5576f5258dbfb-20180312
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
CC: Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Chunfeng Yun" <chunfeng.yun@mediatek.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v2 3/3] dt-bindings: phy-mtk-tphy: add properties for U2 slew rate calibrate
Date: Mon, 12 Mar 2018 13:25:40 +0800
Message-ID: <94a7d3b1240297cd0cac82df52954d0a53d50d36.1520832210.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c9679bc6e969ebf0f97a01c6d1aff3bbc0e8e4f7.1520832210.git.chunfeng.yun@mediatek.com>
References: <c9679bc6e969ebf0f97a01c6d1aff3bbc0e8e4f7.1520832210.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23714.005
X-TM-AS-Result: No-2.578600-8.000000-10
X-TMASE-MatchedRID: y/MOm6ldwRIoMmKpHm2CtdBX0gKZ7oz4KhNpTcvbdULfUZT83lbkEKML
        LA0X7NGu00qMv6F9X+5OSWjh7PrRHyjrjvzj49dingIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPIadN
        +LNryVbvbFSuvRidU3PQvhLmRdgshLSG2HXYsKN/Mtxao5UbE9uKcm7/7fIIacKewl4qmyozv3B
        Pf2eyVbaamblpDwGRJaP/4Bex22oXw7JxwU0EvZMqEROLb/+yO4/0Jvn0rwAJmtL4Dw+zNb5hXf
        xzgoU6P
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.578600-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23714.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add two properties of ref_clk and coefficient used by U2 slew rate
calibrate which may vary on different SoCs

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
index 41e09ed..0d34b2b 100644
--- a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
+++ b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
@@ -27,6 +27,10 @@ Optional properties (controller (parent) node):
  - reg		: offset and length of register shared by multiple ports,
 		  exclude port's private register. It is needed on mt2701
 		  and mt8173, but not on mt2712.
+ - mediatek,src-ref-clk-mhz	: frequency of reference clock for slew rate
+		  calibrate
+ - mediatek,src-coef	: coefficient for slew rate calibrate, depends on
+		  SoC process
 
 Required properties (port (child) node):
 - reg		: address and length of the register set for the port.
-- 
1.9.1

