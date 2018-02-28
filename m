Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519835013-2-15155939025158896293
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
    t=1519835012; b=DO8S8MnEzjW8L1abHL8zXaiSJ1LACVoXzKtazA/A50Uktwp
    JLSebJUL0pVC/W11iXCRK1gH8eJrzJhduU7SEtm+3cM6azkqz1Tl/mbJEYskcZYA
    FiGHYAzOmrrJWQoO5aSNMoZ6xVkPr4vsYvRbP2UttsuIEsZuc9aoznHJfu2zPr3F
    lSFtgOGK2mXH/7RtYLy6nkj5t7b2kGQEcdz3lSGhlN10nfV6kUy/BDT1ScSpNZWc
    O+VYwMEYhLVTOeCdu85qofgLiExDX6wEQfIIyR+DBh+lqDDl1gctl5Yk9rP4/qXz
    KnEufd2pXPRxIhyK75cJv0Sp7jj2UJYSXSEElKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519835012; bh=b0O666utzqZToqcXdGc
    5Q86pqu9+oy9HB/r9niBimog=; b=EJYtktnk5M/IKAZbBTfTDo/TiX13WUJesuc
    P7eGt7fcVVHqzTJVclr5D8UPOJgEuI2WmUpqTzz25hMGevEX8PgXs8lRcot67pI2
    +aqL6JtnZyxLrgWJMgoTAUWStJcOb6xD4tXbVNtNNfRPYMPUJHv5TlU/+5Kl/fM+
    EAQJ46YedhFoIDpjkVkLTMu0sogNJNhaFdVDOlnn5wOOkH0DYYohoLfkezlomypO
    Eh/nxdk+NKQEO54YJTJH908k5XCmJ4hAqYFPwpnNBwmqcSpPVwJpnpUdBs5Mi0YC
    5JW8/I4SKWvHDRqGk14vIgt5kI2En06OfyZGPh9Vsbd/Cv4pdIw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935068AbeB1QXJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:23:09 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35392 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935067AbeB1QUu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:20:50 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Eric Biggers" <ebiggers@google.com>,
        "Eric Biggers" <ebiggers3@gmail.com>,
        "David Howells" <dhowells@redhat.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.244210866@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 076/254] 509: fix printing uninitialized stack memory
 when OID is empty
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

From: Eric Biggers <ebiggers3@gmail.com>

commit 8dfd2f22d3bf3ab7714f7495ad5d897b8845e8c1 upstream.

Callers of sprint_oid() do not check its return value before printing
the result.  In the case where the OID is zero-length, -EBADMSG was
being returned without anything being written to the buffer, resulting
in uninitialized stack memory being printed.  Fix this by writing
"(bad)" to the buffer in the cases where -EBADMSG is returned.

Fixes: 4f73175d0375 ("X.509: Add utility functions to render OIDs as strings")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 lib/oid_registry.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/lib/oid_registry.c
+++ b/lib/oid_registry.c
@@ -116,7 +116,7 @@ int sprint_oid(const void *data, size_t
 	int count;
 
 	if (v >= end)
-		return -EBADMSG;
+		goto bad;
 
 	n = *v++;
 	ret = count = snprintf(buffer, bufsize, "%u.%u", n / 40, n % 40);
@@ -134,7 +134,7 @@ int sprint_oid(const void *data, size_t
 			num = n & 0x7f;
 			do {
 				if (v >= end)
-					return -EBADMSG;
+					goto bad;
 				n = *v++;
 				num <<= 7;
 				num |= n & 0x7f;
@@ -148,6 +148,10 @@ int sprint_oid(const void *data, size_t
 	}
 
 	return ret;
+
+bad:
+	snprintf(buffer, bufsize, "(bad)");
+	return -EBADMSG;
 }
 EXPORT_SYMBOL_GPL(sprint_oid);
 
