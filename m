Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-422553-1519831404-2-10275081889922275372
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
    t=1519831404; b=LECHFXH2zbMGDUi7mdEPB65S6k8xiKOW2DHEh2OG/DPfNjl
    mm+XdyzGSmLjxt+S7la/q77C72VHJXUI/cpDtl0jZuY0xWBF2vlb9EJht4XyoKCe
    wx3Q/SVopOCvP5l5dJ8mB9LGwElPc+AJQ5KpXv4VSKlUYKb4jCPnKL/Gn3LGBZ2t
    xfGxm0QJ6/k1x0gXcFeil56aIdKYxgcLA6k7NHYUoED8FM8RdbM6YkvJVP09OCJQ
    pnNAzsHvXjqgfuPXH9lhDy+ylEM58lT3Kq6iQNZA6O69CCOrM3K/EdqkUK3ixogE
    Rn/teoJUgx4pv/8sGsxK2nyqYShX46SCgmWyavQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519831404; bh=lw480g0p728cFqvjq0N
    X/84SMjtp4+SYO/ZCZoGewHo=; b=KEwnRRxOhGFs0iX8mXG1rZ9OLO8iWXxg3a1
    +F8bRewF0lXrLov22xcVvJMCWAqNQxuIbXW7QYsIrKQCJvyvBfzlaIZYAXykG+dG
    jxCN5p2nBwCqFvLL8kvbpvhRn2z11MkeICZRa+pTXieqwpMofy3LeRGS1K4V4vYj
    snxOiGFwdfTfuIwG+c9NFxYidzVetPqihL3TWQYRlWgrkyoAoyu/OGdX03Tzfsiq
    nVCw8P33iVMPT2ww5GMtzQI/u7KEvkaUWGws5/UloIWXTunrZyuvlTno8gwYcnGT
    whmyKh7Hd1FZ4zHzDhZwFvBfyBByYVrzI16c1a1K9D0N6NabdHg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932400AbeB1PWr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:22:47 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33210 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752631AbeB1PWc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:32 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "James Morris" <james.l.morris@oracle.com>,
        "Takashi Iwai" <tiwai@suse.de>,
        "Eric Biggers" <ebiggers@google.com>,
        "David Howells" <dhowells@redhat.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.233655938@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 075/254] X.509: fix buffer overflow detection in
 sprint_oid()
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

From: Eric Biggers <ebiggers@google.com>

commit 47e0a208fb9d91e3f3c86309e752b13a36470ae8 upstream.

In sprint_oid(), if the input buffer were to be more than 1 byte too
small for the first snprintf(), 'bufsize' would underflow, causing a
buffer overflow when printing the remainder of the OID.

Fortunately this cannot actually happen currently, because no users pass
in a buffer that can be too small for the first snprintf().

Regardless, fix it by checking the snprintf() return value correctly.

For consistency also tweak the second snprintf() check to look the same.

Fixes: 4f73175d0375 ("X.509: Add utility functions to render OIDs as strings")
Cc: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: James Morris <james.l.morris@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 lib/oid_registry.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/lib/oid_registry.c
+++ b/lib/oid_registry.c
@@ -120,10 +120,10 @@ int sprint_oid(const void *data, size_t
 
 	n = *v++;
 	ret = count = snprintf(buffer, bufsize, "%u.%u", n / 40, n % 40);
+	if (count >= bufsize)
+		return -ENOBUFS;
 	buffer += count;
 	bufsize -= count;
-	if (bufsize == 0)
-		return -ENOBUFS;
 
 	while (v < end) {
 		num = 0;
@@ -141,9 +141,9 @@ int sprint_oid(const void *data, size_t
 			} while (n & 0x80);
 		}
 		ret += count = snprintf(buffer, bufsize, ".%lu", num);
-		buffer += count;
-		if (bufsize <= count)
+		if (count >= bufsize)
 			return -ENOBUFS;
+		buffer += count;
 		bufsize -= count;
 	}
 
