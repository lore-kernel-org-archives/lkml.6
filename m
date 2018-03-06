Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4005293-1520323716-2-15229659464553104001
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
    t=1520323715; b=dF9soUffRC3aoeOvAl6hrxiWpbv5Sy4kzU0onV78VxClNEV
    zzKPtVZVNfV5pxUS2PF1itJPzcXqxssvFyKhhqF0VrwIwaaCIa/dU5JqpQn1/QfR
    1mHdEq9L8oLuzSkTzXZuK/URaUsjBE0TYoSVFHOdytCZgjo+duNJoSFcHuU95tpr
    8i6guDbKo+9y6HTgr9FGEDdO/bpdDqxNIDo62/v0hkWjIcUu5HEyilY0SKGvuETr
    WM28AH/j2NUHBIdt6FEYp+jF6zKtDZYeH2InEHXRBpIuOZ8g8JzGipKRuAvgIEUO
    jNOtJb4Oon/Y77Ivk6VYkvxLEUp5tiBT8tH7JJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520323715; bh=xK/AB1lKqBuaSocFvuZ5DK7nrf
    oM23OjBsSAcUlgxv0=; b=HKZ7LEg090GStG7BluKf6+LRmj8Sun6mNhYTtwnvxl
    VIrUGDacGTd7LlplSAFKYwGzAUEAnrpfceaQ/nRqkACZWp39CLW8C2OiD29T9Cd0
    i1QwStwIiQcB9su/2hSuQfhXneNrVaql6G6N5+wIsN/iKGeuYugJD6z/tSuQXH5K
    dfaOi2/dGnhKwR9pgVedvqjTSV/3tlVpQ1oIp9hZoDn0rr7M7KdFshNuA3Dmdbku
    w6D8UGYLe73i+9vb1mz/UIdCR3CYJsAn/ev9+OTVngojCecb/wO4FELx2VSdF9WT
    xYKxAgodYrS2ZHl5/L10YCM7lAb7dAcei5d0FuExenUg==
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
        id S1750972AbeCFIIP (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 03:08:15 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22166 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750782AbeCFIIM (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 6 Mar 2018 03:08:12 -0500
From: <patrice.chotard@st.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>
CC: <patrice.chotard@st.com>
Subject: [PATCH v2 2/3] ARM: dts: STi: Remove useless stdout-path for STi boards
Date: Tue, 6 Mar 2018 09:07:29 +0100
Message-ID: <1520323650-11030-3-git-send-email-patrice.chotard@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520323650-11030-1-git-send-email-patrice.chotard@st.com>
References: <1520323650-11030-1-git-send-email-patrice.chotard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG6NODE3.st.com
 (10.75.127.18)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_04:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Patrice Chotard <patrice.chotard@st.com>

As serial interface is already specified into bootargs,
stdout-path can be removed.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v2: _ none

 arch/arm/boot/dts/stih407-b2120.dts | 1 -
 arch/arm/boot/dts/stih410-b2120.dts | 1 -
 arch/arm/boot/dts/stih410-b2260.dts | 1 -
 arch/arm/boot/dts/stih418-b2199.dts | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/stih407-b2120.dts b/arch/arm/boot/dts/stih407-b2120.dts
index 2c4d6033b448..074b4cd0ca89 100644
--- a/arch/arm/boot/dts/stih407-b2120.dts
+++ b/arch/arm/boot/dts/stih407-b2120.dts
@@ -15,7 +15,6 @@
 
 	chosen {
 		bootargs = "console=serial0,115200 clk_ignore_unused";
-		stdout-path = &sbc_serial0;
 	};
 
 	memory@40000000 {
diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 5422850641e8..eae3050984d0 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -15,7 +15,6 @@
 
 	chosen {
 		bootargs = "console=serial0,115200 clk_ignore_unused";
-		stdout-path = &sbc_serial0;
 	};
 
 	memory@40000000 {
diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
index ca347160e35d..c26e388bd1a4 100644
--- a/arch/arm/boot/dts/stih410-b2260.dts
+++ b/arch/arm/boot/dts/stih410-b2260.dts
@@ -16,7 +16,6 @@
 
 	chosen {
 		bootargs = "console=serial1,115200 clk_ignore_unused";
-		stdout-path = &uart1;
 	};
 
 	memory@40000000 {
diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index dbf7bb704a1a..d948f774fee7 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -15,7 +15,6 @@
 
 	chosen {
 		bootargs = "console=serial0,115200 clk_ignore_unused";
-		stdout-path = &sbc_serial0;
 	};
 
 	memory@40000000 {
-- 
1.9.1

