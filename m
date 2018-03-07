Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2757900-1520412688-2-8348951858225608445
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
    t=1520412688; b=N9s09BkKLap+xDC9sPsGAw6jPWFuYUzXRtsLwc6uQBSgYTR
    u4y8ipJJAA0o6YMxCP2YZVvFHbZqIm8rcdsf4N3xo3sSFYfSISkDRHWqsez9zDOe
    ednGApvzJUPlTzU1kkeX0l6B/AWAf4EOsY2bMLw5g9IUYjos8hJLDRH/aSDODPyU
    JTNxJb8whAU5ySe4XwsVdt39vcVDJr40DHoLvx6J3cMkZaICvLLID1OzydaMaP7X
    pDD9mmIi1+Wz/dcAyCtTJErRZZqPBswmsnCdeHRTv6NZCdzn/gTvKoci1KuJreKk
    Iy74JlSVmtdjirbRRDY99hmCtlDn+lFTswngjPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520412688; bh=tti6IQ3TIrmDliJC5sPcI29Aql
    ufk0kWZA82UPm8UOU=; b=Pek0YW136kAFGpgXL93pP2Q3jTNcBeR+zGF9Nhdswl
    k8TgJK/6B7y53jou921CsftggnAr1BEL8foxitDgSNJ+WD0rEHDjvONDeY+x2i9+
    S3kDtGmkt6IUvTQWhbdVx0Lku0sHSQASSJybgnx/JIbn/LpL7N5RnHBj6VYgOU3S
    Kvkzpk9Z2vLe5H8zWgAbk/VE1KUD+5hH9atpfUNoXefvowX2cSafAo9HfNary3oM
    FUj22J6i6tQGDysaH7UZlw2vpMbyFfqweN/IkeI/h8kCyizlXm5T0eS1fsonsFME
    St4vir8b80XT2bi/CImHMrn46uQhfDYwzkF9+Dc1B+Ug==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S1754219AbeCGIvF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 03:51:05 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:44909 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751299AbeCGIuj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Mar 2018 03:50:39 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v3 1/3] ARM: dts: STi: Fix aliases property name for STi boards
Date: Wed, 7 Mar 2018 09:49:55 +0100
Message-ID: <1520412597-30545-2-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520412597-30545-1-git-send-email-patrice.chotard@st.com>
References: <1520412597-30545-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_03:,,
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

v3: _ none
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

