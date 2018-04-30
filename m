Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116464-2-2507655995222005326
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525116463; b=GPIy2nBo74Lv7KXCbnQ+irmz/LzZ56VC4FGjvhLMxs8o18nu5L
    SvLpUpO9Ph9jo1wxBaqN5Y4yyxhbW1Z4rrT3bC32vCdBWk7Zt/BnFm1dVKbhJIL7
    n2j+1NAJKqH/nLRdQltxDK6KeKCQC55jVVhSB2+m9vEvVJ33QGUGcFZ76Y2pQzKH
    zOFmepCIh9Jc9vmudSJoS50wGx6rx3vq2KjahqlKQZX9FtzDNQ9kOULimXxNtitr
    JIMt5ZZqvGJLjBDFvLQhVEgGZMZ8PEaCg31Q3mfbAca2PCs8rdlQPK0rpyL/RygO
    QqAYd2Se2tgiYEZd5eW2cNTKbUD2PhLPv8Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116463; bh=qZA9aSe+4hpuEhCknpBZd1ZVFOlL65
    Mj7AQ2WDZQ6IE=; b=c2lNLSnWPnFwEzdnwqDAfSWCg8sj5q8byO7HJUArx8g+5X
    CdY5+E1dZhQG4+rlqy13sClol27MSqld00qBD/Oh9VI43K+pJej4kLMUioHkcwSd
    4QW9MwL+I5sOhvHh5PGKnTRFzIJ4R5zkK6WjXX2+3cgZvKGnSZ4HP3zmneAldxa9
    6Nx0MZd4Fw7GJCMVY/79ub9gDSnLTfHzFb7xYyHFbHLP2Og/Fx+ZDGxs2cWW0de5
    RNLXeDbLINriHpsrbylwS7sniLjJiIsO2DKH0yupbd6LHGaa8D4yyCEvjYpSCGtv
    tv4TDxcuozUagUNfusi0kpyJVghbEQ9Z3jmcQwXw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO9ouOCDdgjnYZG+rGQ0VzQzPmnXrDjZbsYUmuTsjsTHyzW8/P5LNSn/Vk9XJSTzrIsqsqSLeAy4WaK3m/jcQ6tsKpTFEj3ajc6OscuQv0qgIdWJYNQL
    TZXqtcSXX2LAWmJbfQ+1TR70PJWmRcPJeM+F0Uo1BTV+7wY3UWewrO9WU+8QRM3UdBrWXGvREahNtiWpMSJEjhomyX2shgpOPpJzgyTS683bKoh4281es7Qt
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=P-IC7800AAAA:8 a=ag1SF4gXAAAA:8
    a=9FqWwBC1KffOvyFQjjIA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756032AbeD3T1k (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755263AbeD3T1j (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:27:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775BB22DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 79/91] rtc: opal: Fix OPAL RTC driver OPAL_BUSY loops
Date: Mon, 30 Apr 2018 12:25:01 -0700
Message-Id: <20180430184008.416390019@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit 682e6b4da5cbe8e9a53f979a58c2a9d7dc997175 upstream.

The OPAL RTC driver does not sleep in case it gets OPAL_BUSY or
OPAL_BUSY_EVENT from firmware, which causes large scheduling
latencies, up to 50 seconds have been observed here when RTC stops
responding (BMC reboot can do it).

Fix this by converting it to the standard form OPAL_BUSY loop that
sleeps.

Fixes: 628daa8d5abf ("powerpc/powernv: Add RTC and NVRAM support plus RTAS fallbacks")
Cc: stable@vger.kernel.org # v3.2+
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/opal-rtc.c |    8 ++++--
 drivers/rtc/rtc-opal.c                    |   37 ++++++++++++++++++------------
 2 files changed, 28 insertions(+), 17 deletions(-)

--- a/arch/powerpc/platforms/powernv/opal-rtc.c
+++ b/arch/powerpc/platforms/powernv/opal-rtc.c
@@ -48,10 +48,12 @@ unsigned long __init opal_get_boot_time(
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			mdelay(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
-		else if (rc == OPAL_BUSY)
-			mdelay(10);
+		} else if (rc == OPAL_BUSY) {
+			mdelay(OPAL_BUSY_DELAY_MS);
+		}
 	}
 	if (rc != OPAL_SUCCESS)
 		return 0;
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -57,7 +57,7 @@ static void tm_to_opal(struct rtc_time *
 
 static int opal_get_rtc_time(struct device *dev, struct rtc_time *tm)
 {
-	long rc = OPAL_BUSY;
+	s64 rc = OPAL_BUSY;
 	int retries = 10;
 	u32 y_m_d;
 	u64 h_m_s_ms;
@@ -66,13 +66,17 @@ static int opal_get_rtc_time(struct devi
 
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_rtc_read(&__y_m_d, &__h_m_s_ms);
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
-		else if (retries-- && (rc == OPAL_HARDWARE
-				       || rc == OPAL_INTERNAL_ERROR))
-			msleep(10);
-		else if (rc != OPAL_BUSY && rc != OPAL_BUSY_EVENT)
-			break;
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		} else if (rc == OPAL_HARDWARE || rc == OPAL_INTERNAL_ERROR) {
+			if (retries--) {
+				msleep(10); /* Wait 10ms before retry */
+				rc = OPAL_BUSY; /* go around again */
+			}
+		}
 	}
 
 	if (rc != OPAL_SUCCESS)
@@ -87,21 +91,26 @@ static int opal_get_rtc_time(struct devi
 
 static int opal_set_rtc_time(struct device *dev, struct rtc_time *tm)
 {
-	long rc = OPAL_BUSY;
+	s64 rc = OPAL_BUSY;
 	int retries = 10;
 	u32 y_m_d = 0;
 	u64 h_m_s_ms = 0;
 
 	tm_to_opal(tm, &y_m_d, &h_m_s_ms);
+
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_rtc_write(y_m_d, h_m_s_ms);
-		if (rc == OPAL_BUSY_EVENT)
+		if (rc == OPAL_BUSY_EVENT) {
+			msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
-		else if (retries-- && (rc == OPAL_HARDWARE
-				       || rc == OPAL_INTERNAL_ERROR))
-			msleep(10);
-		else if (rc != OPAL_BUSY && rc != OPAL_BUSY_EVENT)
-			break;
+		} else if (rc == OPAL_BUSY) {
+			msleep(OPAL_BUSY_DELAY_MS);
+		} else if (rc == OPAL_HARDWARE || rc == OPAL_INTERNAL_ERROR) {
+			if (retries--) {
+				msleep(10); /* Wait 10ms before retry */
+				rc = OPAL_BUSY; /* go around again */
+			}
+		}
 	}
 
 	return rc == OPAL_SUCCESS ? 0 : -EIO;
