Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527163248-2-14329085004774026134
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163247; b=e6cszHgpBbunabMfep5RdCvBFh7A2KdDyBy+ljHhMsBtuJbpiQ
    rVcGhHqKveFwL7hiDTjjun45+kAukBz/dwGsW5Uof9816s9qHr8Ld+PxaSEWSbV3
    5eKO4mB+SXlAbjF/30JWLEquostRm5suLxHyPtR3LphDfGsm95y12DdqioCq7Vn4
    hyQr0y796brRt4U2ibL+lDPNiApQ5R2b0rs6Iqo5hRrt/gXj/Oxv+l6ItH401Xw0
    Z69/A8V2YPEGr7A+svCMqJiM9rs8VX/3bufQrXLdv7zcaNCu3A4uIHWYXlT7Jo8Q
    RKL6ltedBuHo8U8dD1VM8ZX/UirX8hcwXHZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163247; bh=Cs9pt71wZX4ooE/LmbHZ0up6ISc12N
    UqBfcQYwi8F4o=; b=GFIlz/pccocFPtavJmgaQQFzfWLu/sxOkZr3txvbQ8MjLN
    EGSDbcVipGxVv2PZk8K2ZgsLUWIRdggSJcnDcDbG3sRKgAPQy1cuySkWXiRLviTF
    Mp6DLgMazP5AZwfafyP6Nl9qJ1GF7O6vcE/yAShohRdH6Z4XwqLsaBFjQZGu/Se8
    Q9GU4/01dmgowsZHySud9b0zRS0dp76dKtotMHR+PPMRbMk1i9ilvFmbxi8AOGqh
    qgzWSYz4cWnNzD9IppkMbuBPiZ30WXYIseaqzy/SGg3Z7DZ50L5+b3dqiTf4Ti8U
    2eivutcm68W0fNeB2AsCwRWtgNTbGDOoQWhdKLOw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=eEnlN6+b x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=eEnlN6+b x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ4CRPYsXG48PsPs4LPXusTYQ7ZKTIlUVgkaxcdTbI60ALitmeiflOJ+blY0lqrf9pVv/jfQal3uRBSR6WdZHQAiG0NZFTT9OpIZtGDioPwJRCX3oaiM
    r8s1v/AsSZZU4Y/ShpbQm/F7D0nfl66ZNPDczvCY0ItOqRoikJoaqmUACgwK7GrfwWMNvLsEH60VwiPSYsMLtyHxIUgLq4vVK8OxxJn/fE7d2YfYg5SeG6f1
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=_Gl1HcQ-4U4wQ9qHoBsA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966724AbeEXMAc (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:00:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:56226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966717AbeEXJpC (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:45:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 56/92] powerpc/powernv: Fix NVRAM sleep in invalid context when crashing
Date: Thu, 24 May 2018 11:38:33 +0200
Message-Id: <20180524093204.697899221@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit c1d2a31397ec51f0370f6bd17b19b39152c263cb upstream.

Similarly to opal_event_shutdown, opal_nvram_write can be called in
the crash path with irqs disabled. Special case the delay to avoid
sleeping in invalid context.

Fixes: 3b8070335f75 ("powerpc/powernv: Fix OPAL NVRAM driver OPAL_BUSY loops")
Cc: stable@vger.kernel.org # v3.2
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/opal-nvram.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/powernv/opal-nvram.c
+++ b/arch/powerpc/platforms/powernv/opal-nvram.c
@@ -44,6 +44,10 @@ static ssize_t opal_nvram_read(char *buf
 	return count;
 }
 
+/*
+ * This can be called in the panic path with interrupts off, so use
+ * mdelay in that case.
+ */
 static ssize_t opal_nvram_write(char *buf, size_t count, loff_t *index)
 {
 	s64 rc = OPAL_BUSY;
@@ -58,10 +62,16 @@ static ssize_t opal_nvram_write(char *bu
 	while (rc == OPAL_BUSY || rc == OPAL_BUSY_EVENT) {
 		rc = opal_write_nvram(__pa(buf), count, off);
 		if (rc == OPAL_BUSY_EVENT) {
-			msleep(OPAL_BUSY_DELAY_MS);
+			if (in_interrupt() || irqs_disabled())
+				mdelay(OPAL_BUSY_DELAY_MS);
+			else
+				msleep(OPAL_BUSY_DELAY_MS);
 			opal_poll_events(NULL);
 		} else if (rc == OPAL_BUSY) {
-			msleep(OPAL_BUSY_DELAY_MS);
+			if (in_interrupt() || irqs_disabled())
+				mdelay(OPAL_BUSY_DELAY_MS);
+			else
+				msleep(OPAL_BUSY_DELAY_MS);
 		}
 	}
 
