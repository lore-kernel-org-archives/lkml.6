Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2751116-1520412664-2-1817314725010638880
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
    t=1520412664; b=RuCpJOj7R/3KSdDDh0WaYrUn9ro4KMmJoTlAL0kgePtr6x7
    t5k1g3R9vtj/qGe1T1ao8M2L2L2eO/rjihSbs306Q9PM7pqEXy60xnCb2jnpZ2Jq
    5NsfmpDLsa1DMz8OxZH99NXrK0Uc+Hmai0oy0vySe28wBdKVOe/FYlGL9T+gnHHX
    YFSXQjnCAY75e/T7wYGsB3VfK7tpJ4LgPGlpSAQUT//eEYI0FqXCIp3Z8oqKBwzc
    CX7U2YccREof7mv0YOQS/DL0B1fSFJ6q280A4IyBDNaO8Nin7fpgc9o6iI/CNPN2
    48JwgsHrDpTK0rF+LQiZUGybmPTDVorAHhdUJLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520412664; bh=9qHe2p38To7fKsFwznJfs1rJN0
    OQdZ1aJv2P0URy3zM=; b=OLMiPY+1RRod79Cz7qNF3eNKLNW6AKI3Q9/WcNvIR+
    aeYnLBlvw/P6D5axkFcQgljqt/Vf1qcYH/lDnW/t5qg42O8eRatjWNDFXAruVAxB
    c6oS0euCxZqnBPk9G9+E0QwGIE5VFWfZRQ45kvT2Z0POFjfIqNCQIx7MfdDJLSHd
    wNCCyzlW2i0ynbACIdUh1MqywyJmya/+lQHJdyLAlC1mIlyGAUGbYargEjUb9FDH
    P/Ebo9KSYxblclOxpxsEcjEBCFCqgc1EMhED4K2Z29sG7BFJzQgly4U4c3YhNElu
    iiYkvyiIEoqUGZvqNF4UPw038FvoP4L+zUGUmpYlX7sA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
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
        id S1751316AbeCGIuj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 03:50:39 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41607 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751196AbeCGIug (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 7 Mar 2018 03:50:36 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v3 2/3] ARM: dts: STi: Remove console=serialN from bootargs for STi boards
Date: Wed, 7 Mar 2018 09:49:56 +0100
Message-ID: <1520412597-30545-3-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520412597-30545-1-git-send-email-patrice.chotard@st.com>
References: <1520412597-30545-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-07_03:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Patrice Chotard <patrice.chotard@st.com>

As serial interface is already specified into stdout-path property,
"console=serialN,115200" from bootargs can be removed.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
v3: _ remove "console=serialN,115200" from bootargs and use prefered 
      stdout-path property
v2: _ none

 arch/arm/boot/dts/stih407-b2120.dts | 2 +-
 arch/arm/boot/dts/stih410-b2120.dts | 2 +-
 arch/arm/boot/dts/stih410-b2260.dts | 2 +-
 arch/arm/boot/dts/stih418-b2199.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
index 2c4d6033b448..62ce1cecbb1f 100644
--- a/arch/arm/boot/dts/stih407-b2120.dts
+++ b/arch/arm/boot/dts/stih407-b2120.dts
@@ -14,7 +14,7 @@
 	compatible = "st,stih407-b2120", "st,stih407";
 
 	chosen {
-		bootargs = "console=serial0,115200 clk_ignore_unused";
+		bootargs = "clk_ignore_unused";
 		stdout-path = &sbc_serial0;
 	};
 
diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 5422850641e8..2a5a9802a5ec 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -14,7 +14,7 @@
 	compatible = "st,stih410-b2120", "st,stih410";
 
 	chosen {
-		bootargs = "console=serial0,115200 clk_ignore_unused";
+		bootargs = "clk_ignore_unused";
 		stdout-path = &sbc_serial0;
 	};
 
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index ca347160e35d..155caa8c002a 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -15,7 +15,7 @@
 	compatible = "st,stih410-b2260", "st,stih410";
 
 	chosen {
-		bootargs = "console=serial1,115200 clk_ignore_unused";
+		bootargs = "clk_ignore_unused";
 		stdout-path = &uart1;
 	};
 
diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index dbf7bb704a1a..cd0d719e31b7 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -14,7 +14,7 @@
 	compatible = "st,stih418-b2199", "st,stih418";
 
 	chosen {
-		bootargs = "console=serial0,115200 clk_ignore_unused";
+		bootargs = "clk_ignore_unused";
 		stdout-path = &sbc_serial0;
 	};
 
-- 
1.9.1

