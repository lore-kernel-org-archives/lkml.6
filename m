Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834894-2-2897157559130335250
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834893; b=ins8XFl0D0qtvKbDMJ4qJlDIm2hfimm5EO4kJWrcxjRNM9P
    Vxcu94op0qs28H10XKHi24x3bBluM/6gQqdYqE5D+0DcMBEsQuu10Mc5I1kpYYQ3
    iUCuswJDYRmlvq7qYNEeRxwlD/GLRHsR/0Tbb9MsnJSYtpp5K846NFqs3bvkXoe8
    iVf/W6MCyUvnhw+OcO7rAkFM2yqiRBRYY9bPt263XpXa0EnM93zgKU0UMDCgy51b
    DikDHcuVKt0hYszwhBT4Kut8hXeO5bIFVX+al6VsRzxeVCf7K8FiIzcPcaCQhRzi
    8sEqyJrCRTkTSuHVqMV8LmBRp3MIy6xfWNXUT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834893; bh=Isj0k/CRHlZ66CPsFXh
    qE6TFvEb34CYlaNtxrs3JEq0=; b=Ul8YkD+lbTUoekly5UjKmTTTguFurZMavqN
    vXpwpSm7mfxtGDBfkSJUfMxqkG1r0AfNhl3LLwVwwvofi+FKs+son5/0jxTC1Bbt
    BzWNP9d8OzgEKX+mmc8KNhq2Z6trKycPy/CiUnCoA1RHjGtHs29KTBQk2BieP1cM
    ap6YG8xv0uOgu0JUWNstk5kOo7ElXwjagtIB5duSxQa0DdEwCRlM14+LI2zIW/rY
    rwcCIzUD/cmma/UFSegcLt/a52WelC/gvriSlT3d3fYJN8Em4INuRRCGZeKo/wN3
    HlKwaPT1vxu04ITwdHR3lr0byypRT3HDf4cKnPAO15z9HHkk5Lg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934936AbeB1QVC (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:21:02 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35410 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935261AbeB1QVA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:21:00 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Thomas Gleixner" <tglx@linutronix.de>,
        peterz@infradead.org, "Li Jinyue" <lijinyue@huawei.com>,
        dvhart@infradead.org
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.39324522@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 204/254] futex: Prevent overflow by strengthen input
 validation
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Li Jinyue <lijinyue@huawei.com>

commit fbe0e839d1e22d88810f3ee3e2f1479be4c0aa4a upstream.

UBSAN reports signed integer overflow in kernel/futex.c:

 UBSAN: Undefined behaviour in kernel/futex.c:2041:18
 signed integer overflow:
 0 - -2147483648 cannot be represented in type 'int'

Add a sanity check to catch negative values of nr_wake and nr_requeue.

Signed-off-by: Li Jinyue <lijinyue@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org
Cc: dvhart@infradead.org
Link: https://lkml.kernel.org/r/1513242294-31786-1-git-send-email-lijinyue@huawei.com
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 kernel/futex.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1531,6 +1531,9 @@ static int futex_requeue(u32 __user *uad
 	struct futex_hash_bucket *hb1, *hb2;
 	struct futex_q *this, *next;
 
+	if (nr_wake < 0 || nr_requeue < 0)
+		return -EINVAL;
+
 	if (requeue_pi) {
 		/*
 		 * Requeue PI only works on two distinct uaddrs. This
