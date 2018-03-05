Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1837571-1520262151-2-12768317672230307200
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
    t=1520262150; b=pKiQPGIHZk/+uhUMXvzHEBe7sBU3l4uO9E+QSr+RqGhPTcN
    uwUUSak9xNgOlIRxJ/6mnIiwrkgg7ig0sI5Nmr02Wb6oKWfW7XMsrXWMM+zLrTM8
    o0Ve01JMQUIOMjimu/CA0rAtI8L7MNRn+jOb/0iAQ3CTZBQIuZC+x09lLM1VQQYP
    2lh1r3pMEFbRhFW5P29LjiLyJos5wWOrQp+7FbxtCs4/3bwqOvrG2KHxpVbgio5U
    9oX7Y2DCK8ahb3IEE2DH/kafjecG1t86kKxvAzPCVU3wk6Um2SHvNN37NFxfUHSg
    a63Ds3sR8ieNTB07RK1Kesttrb4scuVtCpFhMbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520262150; bh=lfcSxoz4eUSxM+MXC8eEm+zJgj
    QDKTEO47Qoew3ndHM=; b=A1k8X7Hekn483foxewOuiU+XclVreW0aUD6eB67xCS
    yOrjI9+zyznaat3z6vMt2xkfPWCyFI+SxIbHCqvXSLt5gv3HKJCIyHco1Tsxk9MO
    bK9SLS2OuK7byWWPz7ER7BxHVt9arNh98xGSGBDqyc3P4PzNZRfIcOUjAxb2N2Lz
    fwsmbWlC/U+PXI6BIGZW2xVv5wrg0ZIDOauXUw0sZg3mNhiolgS5bBtb99n5w8id
    gJoKDpdE0dSWQuOV4uht92mS0QmLdqBHqXZHRs2VRZwltU+/RduqjbuINT82gQuu
    JZaHrS8XX1dVwrYod3Y0p32IWLQ96JJZD80aCGO+mZYw==
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
        id S1752196AbeCEPBk (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 10:01:40 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13575 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751932AbeCEPBh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 5 Mar 2018 10:01:37 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH 1/2] ARM: dts: STi: Fix aliases property name for STi boards
Date: Mon, 5 Mar 2018 16:00:24 +0100
Message-ID: <1520262025-21088-2-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520262025-21088-1-git-send-email-patrice.chotard@st.com>
References: <1520262025-21088-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_06:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Patrice Chotard <patrice.chotard@st.com>

Since dtc v1.4.6-9-gaadd0b65c987, aliases property name must
be lowercase only.
This allows to fix following warnings when compiling dtb
with W=1 option :

arch/arm/boot/dts/stih418-b2199.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
arch/arm/boot/dts/stih407-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
arch/arm/boot/dts/stih410-b2260.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'
arch/arm/boot/dts/stih410-b2120.dtb: Warning (alias_paths): /aliases: aliases property name must include only lowercase and '-'

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih407-b2120.dts | 4 ++--
 arch/arm/boot/dts/stih410-b2120.dts | 4 ++--
 arch/arm/boot/dts/stih410-b2260.dts | 4 ++--
 arch/arm/boot/dts/stih418-b2199.dts | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
index c8ad905d0309..fa1186af6574 100644
--- a/arch/arm/boot/dts/stih407-b2120.dts
+++ b/arch/arm/boot/dts/stih407-b2120.dts
@@ -14,7 +14,7 @@
 	compatible = "st,stih407-b2120", "st,stih407";
 
 	chosen {
-		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
+		bootargs = "console=ttyas0,115200 clk_ignore_unused";
 		linux,stdout-path = &sbc_serial0;
 	};
 
@@ -24,7 +24,7 @@
 	};
 
 	aliases {
-		ttyAS0 = &sbc_serial0;
+		ttyas0 = &sbc_serial0;
 		ethernet0 = &ethernet0;
 	};
 
diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 9830be577433..00258212b6fb 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -14,7 +14,7 @@
 	compatible = "st,stih410-b2120", "st,stih410";
 
 	chosen {
-		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
+		bootargs = "console=ttyas0,115200 clk_ignore_unused";
 		linux,stdout-path = &sbc_serial0;
 	};
 
@@ -24,7 +24,7 @@
 	};
 
 	aliases {
-		ttyAS0 = &sbc_serial0;
+		ttyas0 = &sbc_serial0;
 		ethernet0 = &ethernet0;
 	};
 
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index c663b70c43a7..3d122c3a1ad6 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -15,7 +15,7 @@
 	compatible = "st,stih410-b2260", "st,stih410";
 
 	chosen {
-		bootargs = "console=ttyAS1,115200 clk_ignore_unused";
+		bootargs = "console=ttyas1,115200 clk_ignore_unused";
 		linux,stdout-path = &uart1;
 	};
 
@@ -25,7 +25,7 @@
 	};
 
 	aliases {
-		ttyAS1 = &uart1;
+		ttyas1 = &uart1;
 		ethernet0 = &ethernet0;
 	};
 
diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index 4e6d915c85ff..8459a3766b7c 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -14,7 +14,7 @@
 	compatible = "st,stih418-b2199", "st,stih418";
 
 	chosen {
-		bootargs = "console=ttyAS0,115200 clk_ignore_unused";
+		bootargs = "console=ttyas0,115200 clk_ignore_unused";
 		linux,stdout-path = &sbc_serial0;
 	};
 
@@ -24,7 +24,7 @@
 	};
 
 	aliases {
-		ttyAS0 = &sbc_serial0;
+		ttyas0 = &sbc_serial0;
 		ethernet0 = &ethernet0;
 	};
 
-- 
1.9.1

