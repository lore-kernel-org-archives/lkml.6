Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443661-1520825976-2-2149091748210787239
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
    t=1520825975; b=Up7KsmY22Qw7quudFsyk5Zc/EL7W+60ffN5MJGxtXe+Nz93
    yL2nu6AhD4/TDrLE6fFvTBXQmmbN54H5MEj8eI2tTZE5X2zcGWyA/KROfyufPavE
    uyHeGe0QeRagj+rNkJQeEZLjI0w3/XRbqrTKjGEHitiLK6dnpVsbsOYQjon4Wpyi
    rULxOdIgDqA3R6Lkcy9A7SBrl/otJ83wmzb/P8yHrYQIAOYRYyRzpge7FZJhQHNT
    njrX+iJ/wG0Z6Nr34qv6n8Q1b43UVIIPr01PX8HFxT6SrHMCRCJhilRBVjKv1Mf9
    2KyY64DYXW8B+gHxoYegr/KGFjv4K/UObeaQjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520825975; bh=a3Ie4uvt16vCDwDhOnSj8b9FI/
    YmMR0sFUmNbsFCcbo=; b=qoorTX3D6qR01YULxiRpxEI+ary0pckqgWQysobCIq
    RvOHyBgQtivwj3nOvhf4otwIUgSovCFmy8Xc21BNtWCp+6ZwzfvEMSgln6eX03QO
    VCWu8wAOxcTQruvRWfItcxs5hlKIBsED+1AY5QNXYMlV2FinDOY7bCa5TK2bbbj/
    hUol73Syy+yFRqrPWWvHtYabP3N7a7Df0HicceKJ1n8NEAEk1kwM1wrzy9qW55Bq
    4KiCxmMCb6yaDuNzNsFMxTZQA438O/wa0XXVbv07DmAouK6Fpv3m8fcN1jiCPep0
    Ao8H2IM170wzqeptklwQ7PeWgxPxzkXWKfSlFbBRJ8vw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
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
        id S932762AbeCLDjV (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:39:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37527 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932717AbeCLDjT (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Sun, 11 Mar 2018 23:39:19 -0400
X-UUID: f0546771bece4768b6f7943cc591d204-20180312
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
Subject: [PATCH 3/3] phy: phy-mtk-tphy: add properties for U2 slew rate calibrate
Date: Mon, 12 Mar 2018 11:39:08 +0800
Message-ID: <49dff54ceb0c2f4b820af48a87818e935e23447a.1520824899.git.chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c9679bc6e969ebf0f97a01c6d1aff3bbc0e8e4f7.1520824899.git.chunfeng.yun@mediatek.com>
References: <c9679bc6e969ebf0f97a01c6d1aff3bbc0e8e4f7.1520824899.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23714.000
X-TM-AS-Result: No-2.578600-8.000000-10
X-TMASE-MatchedRID: y/MOm6ldwRIoMmKpHm2CtdBX0gKZ7oz4KhNpTcvbdULfUZT83lbkEKML
        LA0X7NGu00qMv6F9X+5OSWjh7PrRHyjrjvzj49dingIgpj8eDcAZ1CdBJOsoY8RB0bsfrpPI34T
        9cYMsdwzbFSuvRidU3PQvhLmRdgshLSG2HXYsKN/Mtxao5UbE9uKcm7/7fIIacKewl4qmyozv3B
        Pf2eyVbaamblpDwGRJaP/4Bex22oXw7JxwU0EvZMqEROLb/+yO4/0Jvn0rwAJmtL4Dw+zNb9T2H
        03zzU1J
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--2.578600-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23714.000
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

