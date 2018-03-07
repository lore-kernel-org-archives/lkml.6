Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3819521-1520444249-2-9586359477801421880
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520444248; b=uDOe4bjfq/+AnRHkAfWsjDLYm1T63FMPIcjp8HXQSUSBAJR
    wdVUOBwaTx7rSna4Fr/IwSH2wAi5A3jm/SQm8unR7KNgpy8iNdH5tZMtA4hxAJjY
    ixlVkLUe6r1GsxBnkAS+HezGrwkFddFSKgVaa4jClUsFQj2DZ9nq22VuEPVVwBmv
    cTjoz4of3hatGalv6X0vJsETDQxbvb86caslOwFc9cndEDxEqubZTZ4jRz1Ld71Q
    lb0VEX7xhqMhl15wDzfrr4/F8EyG0JYeJA8FJISEV1Z2mVQj2KXLNHuZT5UrJpjs
    FuFisQ1jRgbFXMLII787syTmyCTMD+1dC9b04BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520444248; bh=pQPE1hkAre7E1dUATGd4OrNubT
    DDOL8MC01Xcv8yB+A=; b=uY/W6f6HwJKZv2eA3QKbE9a4LLiiWeKw4oFN00UB9b
    Tge+wu28a5wOpiKoj2ovd+geEFggkTfP2tDAsZgB7bl2zx8WiVGAY2exeE3b6m+l
    j4gRTCd2n3YvG0L3uLdQVatSUVgL4OWxI98Demj+OGxaa/fu1FOmbZcyA980lp5g
    jQTawwjjhfIaj8bq2Can0XlQUtzqNpSkzSVkZolNqT3FWbp2gt2yz+nrsyYg+Df1
    XwMB4jbgfN0G+/i1gCrJ3qqRn4s1Mk1zQfQlSVmlNsAe8co/3uzCzCZFbjS6ZfjX
    V4Ut/48l7WJfbvAv4IkpHHUgBrlVCTKvyZN8GH3jFzsQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933806AbeCGRgQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 12:36:16 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21634 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933888AbeCGRgN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Mar 2018 12:36:13 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v4 3/3] ARM: dts: STi: Remove "console=ttyASN" from bootargs for STi boards
Date: Wed, 7 Mar 2018 18:35:34 +0100
Message-ID: <1520444134-30144-4-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520444134-30144-1-git-send-email-patrice.chotard@st.com>
References: <1520444134-30144-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_08:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Patrice Chotard <patrice.chotard@st.com>

As serial interface is already specified into stdout-path property,
"console=ttyASN,115200" from bootargs can be removed.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
v4: _ none
v3: _ remove "console=serialN,115200" from bootargs and use prefered 
      stdout-path property
v2: _ none

 arch/arm/boot/dts/stih407-b2120.dts | 2 +-
 arch/arm/boot/dts/stih410-b2120.dts | 2 +-
 arch/arm/boot/dts/stih410-b2260.dts | 2 +-
 arch/arm/boot/dts/stih418-b2199.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
index 00de810a3bcc..62ce1cecbb1f 100644
--- a/arch/arm/boot/dts/stih407-b2120.dts
+++ b/arch/arm/boot/dts/stih407-b2120.dts
@@ -14,7 +14,7 @@
 	compatible = "st,stih407-b2120", "st,stih407";
 
 	chosen {
-		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
+		bootargs = "clk_ignore_unused";
 		stdout-path = &sbc_serial0;
 	};
 
diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 07d7969923ea..2a5a9802a5ec 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -14,7 +14,7 @@
 	compatible = "st,stih410-b2120", "st,stih410";
 
 	chosen {
-		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
+		bootargs = "clk_ignore_unused";
 		stdout-path = &sbc_serial0;
 	};
 
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index 0b2129712bef..155caa8c002a 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -15,7 +15,7 @@
 	compatible = "st,stih410-b2260", "st,stih410";
 
 	chosen {
-		bootargs = "console=ttyAS1,115200 clk_ignore_unused";
+		bootargs = "clk_ignore_unused";
 		stdout-path = &uart1;
 	};
 
diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index f88856c36a3f..cd0d719e31b7 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -14,7 +14,7 @@
 	compatible = "st,stih418-b2199", "st,stih418";
 
 	chosen {
-		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
+		bootargs = "clk_ignore_unused";
 		stdout-path = &sbc_serial0;
 	};
 
-- 
1.9.1

