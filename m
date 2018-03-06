Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4005293-1520323751-2-1184919508453957328
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-ascii,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520323750; b=orMrk2aXeSIR7Yro0irsN+9mqZYLuJ+f14MnNPmpDqPtEg/
    GbCnZJ4keWtJs/Xs3JPbFoWZ1/QRnYI14n/NOONIPVIe/jth0fmKLqAnos4uAQSB
    3wMoBhfX1Nq1PUcG/WGXSAxn3GTdzXE2sp8jG+oQkaFm77rl9K/LfHijahG7UiuT
    cSmT++gHEDs200xUG6v5TyXM/FFvtGV5mUtlhOWA1p29OVrkFXgNsbAP61IsCyOs
    P/yFHnXkQdG3hQ96uXwszUEVd7xbnS59OAiR5zGMP9byJZif4ZMr4xQ3AaK3mm01
    OjWI235tK8DABXC7kPd0MR5Tcz7mgbGabBOgcSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520323750; bh=N//NVIFGsIDZaC8O7wqPBtkrsN
    4rExyO2gtc+gXrS8I=; b=G4Z9wdvILbb8TmBIjXZqJ8nF0Wu5sJiR0ilLEV9vVb
    PTA9t3fhOOrw+oc3c7Jo48N4krQ7suLsvT0Ogaphf8A6w9i6Qjo1DNCycc9LqiUY
    42jFY7ZpKDNCKq0VBEgYX3i7fkt8syIAFXqgB7cfy0RnvDLPi+ZN1DbytYXfVJCy
    04a23gmRQHfUfQka5K2eMPyfGOE5f/OppWA+IgyNqfX1uW112ThyVrD57lprQmAZ
    j7Ozckm/grFC2fbJlDhmfs5xgKiWz+hgIT4DbVGU0ZEcSBXzVspfKDz5cdXs3/Ge
    hMBdIP8xU8HbJre/ksJWAUJjaP/o6vv4Ep4XaiXDEkiA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
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
        id S1753002AbeCFIIj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 03:08:39 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58681 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750817AbeCFIIN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Mar 2018 03:08:13 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v2 1/3] ARM: dts: STi: Fix aliases property name for STi boards
Date: Tue, 6 Mar 2018 09:07:28 +0100
Message-ID: <1520323650-11030-2-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520323650-11030-1-git-send-email-patrice.chotard@st.com>
References: <1520323650-11030-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_04:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Patrice Chotard <patrice.chotard@st.com>

Update serial aliases from "ttyASN" to more common "serialN".

Since dtc v1.4.6-9-gaadd0b65c987, aliases property name must
be lowercase only. This allows to fix following dtc warnings:

arch/arm/boot/dts/stih418-b2199.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
arch/arm/boot/dts/stih407-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
arch/arm/boot/dts/stih410-b2260.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
arch/arm/boot/dts/stih410-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v2: _ use serialN instead of ttyasN aliases to not break ABI


 arch/arm/boot/dts/stih407-b2120.dts | 4 ++--
 arch/arm/boot/dts/stih410-b2120.dts | 4 ++--
 arch/arm/boot/dts/stih410-b2260.dts | 4 ++--
 arch/arm/boot/dts/stih418-b2199.dts | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
index de3c8bf129b5..2c4d6033b448 100644
--- a/arch/arm/boot/dts/stih407-b2120.dts
+++ b/arch/arm/boot/dts/stih407-b2120.dts
@@ -14,7 +14,7 @@
 	compatible = "st,stih407-b2120", "st,stih407";
 
 	chosen {
-		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
+		bootargs = "console=serial0,115200 clk_ignore_unused";
 		stdout-path = &sbc_serial0;
 	};
 
@@ -24,7 +24,7 @@
 	};
 
 	aliases {
-		ttyAS0 = &sbc_serial0;
+		serial0 = &sbc_serial0;
 		ethernet0 = &ethernet0;
 	};
 
diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 0a59b7b0f4b2..5422850641e8 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -14,7 +14,7 @@
 	compatible = "st,stih410-b2120", "st,stih410";
 
 	chosen {
-		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
+		bootargs = "console=serial0,115200 clk_ignore_unused";
 		stdout-path = &sbc_serial0;
 	};
 
@@ -24,7 +24,7 @@
 	};
 
 	aliases {
-		ttyAS0 = &sbc_serial0;
+		serial0 = &sbc_serial0;
 		ethernet0 = &ethernet0;
 	};
 
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index feb8834478fa..ca347160e35d 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -15,7 +15,7 @@
 	compatible = "st,stih410-b2260", "st,stih410";
 
 	chosen {
-		bootargs = "console=ttyAS1,115200 clk_ignore_unused";
+		bootargs = "console=serial1,115200 clk_ignore_unused";
 		stdout-path = &uart1;
 	};
 
@@ -25,7 +25,7 @@
 	};
 
 	aliases {
-		ttyAS1 = &uart1;
+		serial1 = &uart1;
 		ethernet0 = &ethernet0;
 	};
 
diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index 39b4db2e3507..dbf7bb704a1a 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -14,7 +14,7 @@
 	compatible = "st,stih418-b2199", "st,stih418";
 
 	chosen {
-		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
+		bootargs = "console=serial0,115200 clk_ignore_unused";
 		stdout-path = &sbc_serial0;
 	};
 
@@ -24,7 +24,7 @@
 	};
 
 	aliases {
-		ttyAS0 = &sbc_serial0;
+		serial0 = &sbc_serial0;
 		ethernet0 = &ethernet0;
 	};
 
-- 
1.9.1

