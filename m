Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1890438-1521039202-2-18348993652330186311
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
    t=1521039202; b=ZIap4DMpCDWBIT4K4YDVfanAL6jEoWZrorajU23epBiWfxz
    X44Zhr58UoPN6oefaD9W3n9w28tSuUptjxT1ViQ77OoK9g4TGljOGQkbVwsERUN0
    5O0W3ltO+ASKkogbQgDBs38CgUWSLx5MEdVwlTRAjnvsBXo8zziB2djPWDsaUSoY
    Q+4u0WNdqeJDy/8HkJGdUPzl0HBZ7m+ZYTkjcFSkUsc7cMjpjLk8B6yqganV5oUo
    pSa69OG9oWM8gdkYm6i2Ea3Iv+KV8F4Nl+Y8AsmthsJIfv9gzcRfJhVLjnGPsHVP
    6h6LsGG5M4gnyiYKS9aTeITJtfi/2yQVQlrhLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521039202; bh=PgzzEZzGJVAuQ9sDW/D3g5Y1J9MvghSd5/RSCAZwD8E=; b=U
    8Uud4ydIv1RTaksutV692sJIB4aUZdhH8OI8KIo0uOee4aAT5fG590fvFdJmkC0x
    NduuLkUgGGw9fljmfwdb/3uVYgGxM/4IcAfeAObO3I3SW0C5NlPGgWwLbWd29I83
    5msg9QrpDuVfCuecAkx/aG/LwpabEChAciyp59bK1exH2nb0ywy6eRmaSmXS2L7M
    +zYbVmjBBcx4X5r3AdTjVM9xvcmsuWYh7JE96TSzGDo70DzbNA2D0vQTVIbaH/b2
    jzTPGKvscEXAKsxo1cirTZYi591fl76LK1hzQZt9RTCL2OjUogkdH77diCpmQiwq
    UKP9JgDYkwipmCkC9fWuw==
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
        id S1751459AbeCNOxU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 10:53:20 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13867 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751456AbeCNOxU (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Mar 2018 10:53:20 -0400
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [RESEND PATCH v4 3/3] ARM: dts: STi: Remove console=ttyASN from bootargs for STi boards]  ARM: dts: STi: Remove "console=ttyASN" from bootargs for STi boards
Date: Wed, 14 Mar 2018 15:52:39 +0100
Message-ID: <1521039159-16655-1-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_07:,,
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
index 37f2ddbfa099..a7a0f76e9cbc 100644
--- a/arch/arm/boot/dts/stih407-b2120.dts
+++ b/arch/arm/boot/dts/stih407-b2120.dts
@@ -14,7 +14,7 @@
 	compatible = "st,stih407-b2120", "st,stih407";
 
 	chosen {
-		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
+		bootargs = "clk_ignore_unused";
 		linux,stdout-path = &sbc_serial0;
 	};
 
diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index a6f00a6687a9..6c6b4cc37e97 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -14,7 +14,7 @@
 	compatible = "st,stih410-b2120", "st,stih410";
 
 	chosen {
-		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
+		bootargs = "clk_ignore_unused";
 		linux,stdout-path = &sbc_serial0;
 	};
 
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index 62770496e328..50d36758391c 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -15,7 +15,7 @@
 	compatible = "st,stih410-b2260", "st,stih410";
 
 	chosen {
-		bootargs = "console=ttyAS1,115200 clk_ignore_unused";
+		bootargs = "clk_ignore_unused";
 		linux,stdout-path = &uart1;
 	};
 
diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index 36f40f58155d..7f5f3252bfc7 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -14,7 +14,7 @@
 	compatible = "st,stih418-b2199", "st,stih418";
 
 	chosen {
-		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
+		bootargs = "clk_ignore_unused";
 		linux,stdout-path = &sbc_serial0;
 	};
 
-- 
1.9.1

