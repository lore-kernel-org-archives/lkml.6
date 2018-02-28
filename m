Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519837010-2-13846038402153825503
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
    t=1519837009; b=FK54mQGF14EeWdoio2xyWd2+0jcSlWmRIxnJ77P0d5hT2zs
    82IOmtKGgSfyPhUBplbWtzjWebdbULkz4rGnHJiQyZt1APimNax6eDbXqw6MIUYf
    PJ8reBTKLnews7FiJ7vlKF6wPWsEk8F3l162+xMbmdpNtee+M2mBZjLz8hevhRqK
    uB5fFXYpaGJVYYwazHcZQ4fqBEpiiIUb19zSKWIagX9E43RSK37AMmsqTvZaCqXW
    eeGoxWMh4jO8ZwYDl5pbXVDlaoFA00Nt7KkADcVGqXZdOIPafnlvxI18j6beR05N
    wfiVvilaDnssQYOZXAzhCBFUg3aHFK0ytuhioVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519837009; bh=+z8eiW8d1FU66R9S0Xm
    9/Mu+gA3FHJuM/kZHwaB3chQ=; b=v3ACqZ2CA4Ow5fRePphPWtqsKmr9gOyXV4A
    hGwWjM7fkmmb9yllD1KwRh0JaiMOpH7b5oNTLb52kqZPAP6JVoWA/AFyt7cVa2Hk
    OYislKE7Zk8gZe/Ev95xdHpwtT8blo8n/+Vn96Bt7uNq4Si3YrAYKMKlrq5hvZF7
    xf07ApN7xC3Rdd6EVxFm/gLyzqOJwsYt0wE+9sNzpGez/y20PZwD3yB/Z0ME21L1
    8xj9LimbGarEgfhD+L5jZ6p3WWTJfXMymkxVM5+M6lOZYv5MYtHyLUgjUHboiEN6
    tt2TCUlqvRw/2FE4S9RrvoPdHlNpOx9hkuA+bb+9X/RDJZKT3gw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752808AbeB1P5N (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:57:13 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34502 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934011AbeB1P47 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:56:59 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Marc Dionne" <marc.dionne@auristor.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "David Howells" <dhowells@redhat.com>,
        "Jeff Layton" <jlayton@redhat.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.761412083@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 154/254] fscache: Fix the default for fscache_maybe_release_page()
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

From: David Howells <dhowells@redhat.com>

commit 98801506552593c9b8ac11021b0cdad12cab4f6b upstream.

Fix the default for fscache_maybe_release_page() for when the cookie isn't
valid or the page isn't cached.  It mustn't return false as that indicates
the page cannot yet be freed.

The problem with the default is that if, say, there's no cache, but a
network filesystem's pages are using up almost all the available memory, a
system can OOM because the filesystem ->releasepage() op will not allow
them to be released as fscache_maybe_release_page() incorrectly prevents
it.

This can be tested by writing a sequence of 512MiB files to an AFS mount.
It does not affect NFS or CIFS because both of those wrap the call in a
check of PG_fscache and it shouldn't bother Ceph as that only has
PG_private set whilst writeback is in progress.  This might be an issue for
9P, however.

Note that the pages aren't entirely stuck.  Removing a file or unmounting
will clear things because that uses ->invalidatepage() instead.

Fixes: 201a15428bd5 ("FS-Cache: Handle pages pending storage that get evicted under OOM conditions")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@redhat.com>
Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/fscache.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -764,7 +764,7 @@ bool fscache_maybe_release_page(struct f
 {
 	if (fscache_cookie_valid(cookie) && PageFsCache(page))
 		return __fscache_maybe_release_page(cookie, page, gfp);
-	return false;
+	return true;
 }
 
 /**
