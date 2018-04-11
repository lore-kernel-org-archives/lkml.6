Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1888220-1523436991-2-2007758766276468163
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523436990; b=WOiRtSfI+F7vF+++QWJNOFn9jgn+2QmhezZeX/JLlf75WFFlWi
    AerNwsecp7Cdihhqotzyrg9phmSYGIcmMxvI1GEUq7jg4tjQ3Mk+3hsgKGKecMtD
    XdGiJy0K74VyijaJK/6lI2SVUGUGD4oBTFl4MJ/g/MaYRbeogoLy1E3ASEAG+dyX
    YV3JlZwomrMMVhZB4O1G5P1tDZ8Z2R0xmFjGxUNc/Ahw3j6BqewetTKydcVedNi6
    1Dir/mS6AIq5AC00g1IR92aTNu6EcRSIZQgokRMoQOSTeTjHWDWnGUiwDPt5jOOA
    RXo9cgSUSSmX9syFGbi47aZaz+aTFiqIrwdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523436990; bh=kfERyZrdtlqlr2G3RcfnBOadKlEGgy
    7z1AhEWeZGksM=; b=kMc/ntH9l4cf+qSrY5n3atXloUZKPmjf/1jdGt78LI8aQn
    nlsDFthcwtsGHWr/QdDKfgT3j7M0FQcRfVY86UTNtM9jrKAI7Ca9lEVcYhGuSuQq
    awTbrf2GcYFHRvHv0zBPzYpaeR/dWNSE9Ge8llL3XSKbWWloNF3hIpk/SiWy3y1n
    eiQSH7Ak4Z3Hry0UpArWxjdZaOgiKiosWxp6dX/zpk/hXR7NGp+tkqz5JEku3JIS
    ZG+0uH+q2QYgvA30GY2H9cCr/Haa0RY4qk4qND5HDK1Kp1kMP2HUlqcnqKwDrua9
    4xvkbL0a7bLxnihzCPgGZRH6hBAVEWPaypycG/DQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMc2fkc1ZZMkRXFXUXWztK+ighzgDwqGJOPxGNZhPck5/9QMsFdiN9Olo+skSXRLVjmN6P5EGJ8HKGN6QrQ6e25F76OQhetJ1kQp7CpJ1s20xFhFnOmI
    aahyD3XwtFnO6d5L3pHnOfrAwU9A52RBWq90uLvFKTcTIgUTjfchNM2LTRR3rM6EuUMeyY0PFl00bjAbooR7DnQOazYuiBC2bTgSpwWN3FjvD66eV/oJvctZ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=mpaa-ttXAAAA:8
    a=VwQbUJbxAAAA:8 a=Lb_IFRlCcSXnnaBftdoA:9 a=FnnYBucQgfmAYgWN:21
    a=GAJlXZeZjd8Im98q:21 a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752736AbeDKIzx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 04:55:53 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:20664 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752335AbeDKIyR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 04:54:17 -0400
X-UUID: 16e08e73fea744159465fa28bfae12e4-20180411
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2 03/12] arm: dts: mt7623: fix invalid memory node being generated
Date: Wed, 11 Apr 2018 16:53:56 +0800
Message-ID: <d887b72e1839c7e476179e384cfc712216096f20.1523434758.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1523434757.git.sean.wang@mediatek.com>
References: <cover.1523434757.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

Below two wrong nodes in existing DTS files would cause a fail boot since
in fact the address 0 is not the correct place the memory device locates
at.

memory {
        device_type = "memory";
        reg = <0x0 0x0 0x0 0x0>;
};

memory@80000000 {
        reg = <0x0 0x80000000 0x0 0x40000000>;
};

In order to avoid having a memory node starting at address 0, we can't
include file skeleton64.dtsi and instead need to explicitly manually
define a few of properties the DTS relies on such as #address-cells
and #size-cells in root node and device_type in the node memory@80000000.

Cc: stable@vger.kernel.org
Fixes: 31ac0d69a1d4 ("ARM: dts: mediatek: add MT7623 basic support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 arch/arm/boot/dts/mt7623.dtsi                 | 3 ++-
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 1 +
 arch/arm/boot/dts/mt7623n-rfb.dtsi            | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mt7623.dtsi b/arch/arm/boot/dts/mt7623.dtsi
index fec4715..406a9f3 100644
--- a/arch/arm/boot/dts/mt7623.dtsi
+++ b/arch/arm/boot/dts/mt7623.dtsi
@@ -15,11 +15,12 @@
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/reset/mt2701-resets.h>
 #include <dt-bindings/thermal/thermal.h>
-#include "skeleton64.dtsi"
 
 / {
 	compatible = "mediatek,mt7623";
 	interrupt-parent = <&sysirq>;
+	#address-cells = <2>;
+	#size-cells = <2>;
 
 	cpu_opp_table: opp-table {
 		compatible = "operating-points-v2";
diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index bbf56f8..5938e4c 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -109,6 +109,7 @@
 	};
 
 	memory@80000000 {
+		device_type = "memory";
 		reg = <0 0x80000000 0 0x40000000>;
 	};
 };
diff --git a/arch/arm/boot/dts/mt7623n-rfb.dtsi b/arch/arm/boot/dts/mt7623n-rfb.dtsi
index a199ae7..343e8ef 100644
--- a/arch/arm/boot/dts/mt7623n-rfb.dtsi
+++ b/arch/arm/boot/dts/mt7623n-rfb.dtsi
@@ -40,6 +40,7 @@
 	};
 
 	memory@80000000 {
+		device_type = "memory";
 		reg = <0 0x80000000 0 0x40000000>;
 	};
 
-- 
2.7.4
