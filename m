Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3869068-1524811237-2-8117362796827096348
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524811236; b=G9Dum+/gw2jNRISlBTrF63VVO2x2NPxnCBumRDzSd1fPyeoce+
    DmFuOmZywWbSFtxKDUCoezFRD66hH7JIui1c7WogfnRtgqI5A+/uYgma+SdHUjhq
    c1KCQn1xjbMwNIEj0SBhaXYzeOkOb/Ch200CTxrHKcJQIH34b/nhMgr8HYQrmftn
    xDrkt6fQjNmfX2C8TxrL+IdHUOqznj3D6o2VeqF3Tlg8G1sxzK9RToPFFLpJhvsE
    ovhYajaAzYqVK3Mz810zs1O4M4+uKyLac2hMD8S99RRC4ts3rXoq4y3S9nd2S8Lj
    8I8Sko/ORwdWKiPXo8pJEYDZHBTZRx5sEHxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524811236;
    bh=p4MIyNCgzjfEHaASMyvKr4nY6PQg61Ot9AqBKdHb+n8=; b=L57cAQI+kxPB
    6q50VehV9HiCOSiPv3k0oLSaQvP/kKq0cJpJdYDnq+2T4fBj027IEtIsIffNeXYY
    B3q3zwL4AE5dKlo9kJLjadbbk743HFQRxdM/OLzOy2fDfOxKSuvAfVkHdl4wvZdz
    PJlTo0yraX/Rh4Nl9/pTZaaQrWkQfNIQflGoRqgYpmQ7kmPuQAg/nLCONHGmSG18
    xpIoSm2eKxjNB8DfRInpxO5sdROCXKNZoWTEFtX5tLL4ErgT+H4XvP3siHIYhKoN
    7iepGLKKHtopE3Xur4bCiNP9dlbLXuL90/wnux5r5Nlk0vGL0+vAD8DrmY0t75qD
    4v7FVqwn4Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLgn66AIdtD6TisitG4dO9leMmw1fqqWwa3Jovxza9650JTfk2qkctgqX3QEFqSxzxH3QMgtYtSe/wmZ0nf+sZzRkmrxcgRca4zyPuQ45E8u6NOJhYqI
    7sH4KeCieOv23+O6++IUFwF3SDVZzP4GfWVXLnz8FVm75ClHndmJK1ulv/NlW7LFnZEhGxYmCxCLDAX9kOFWmJoI69UPsK5tHdE9CBLNPEOZb1AG6QIZlT8y
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=Ke8Jehkl8E0rIBd1d0QA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752969AbeD0Gkf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 02:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751140AbeD0Gke (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 02:40:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276982168C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
From: Masami Hiramatsu <mhiramat@kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jon Medhurst <tixy@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v3 1/7] kprobes: Make blacklist root user read only
Date: Fri, 27 Apr 2018 15:40:09 +0900
Message-Id: <152481120919.22588.16126591608892708741.stgit@devbox>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <152481117776.22588.1210388093668905564.stgit@devbox>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since the blacklist file indicates a sensitive address
information to reader, it should be restricted to the
root user.

Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index ea619021d901..51096eece801 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2621,7 +2621,7 @@ static int __init debugfs_kprobe_init(void)
 	if (!file)
 		goto error;
 
-	file = debugfs_create_file("blacklist", 0444, dir, NULL,
+	file = debugfs_create_file("blacklist", 0400, dir, NULL,
 				&debugfs_kprobe_blacklist_ops);
 	if (!file)
 		goto error;
