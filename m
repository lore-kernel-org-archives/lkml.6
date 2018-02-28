Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-422553-1519831453-2-15632702333847204649
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
    t=1519831453; b=gpAZQMiSAHcE2GM4iAybof/HoyDHv1sezzhEntMJFMNtWWA
    xTY/OldRrQ1yhfvP01YPj8gMBwSIMzL9bhkqtqJqMr2701A5qOYnSfY4LWPYg8b8
    niwoMh/Jn0cU4j4GEU46zVigJC2t5cAAM1vXZGFDqtkg8cpEq3rmcJPsfmPgYU4u
    9hdwzC5F+B+ll4+ADaY9aA2y3pd6fAYOgq9Vv5p3Dvpgp7I1/Q0pUc3rNJmzC8+I
    84lxSD6QDDXPF1yX/vybzK9yyw0ZkuHMPXokV5LbEXFXloohdlzmi3td/9ZfAPCo
    WDgQTKMRBy53m2dyFEdXSqOd1sfq5TmoX+U6/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519831453; bh=VQPvk+djEAyOHVzOEon
    vzBfsG84Fnc3ZDsesIxbbuXU=; b=lEbmyHMQedoEWW85sHVcuL9bVOwIeU4q4nl
    PeXxBhwuquQnb+FLjZdJbvlKFi7OUDcMYZH/Zfo/odh5ZwD3FJ3cP5cPPzMiJ9x1
    w6+XPGNpoKmzgTp6fTQYn+6QPKXN6f7XQlSkvP7QguG/Kw4maMioTe/1k6m6bR85
    QJaGaYpirtBdy/f0fDSDEI43C2CK6RL0ByGFZ6l4ZLTNulcoLFn4O1R9DKHvh0p9
    sj/npM3X6NXZDur4+vo3a6TeK9d1Ky6BLOqdhxLjiCf9RrvmbgGImEx1doc52kgK
    pLaccEuoHpXeg7ofKFQD/2SE7PH/qRj/qAzIZ2ym8PmntP4rS8A==
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
        id S932836AbeB1PYK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:24:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33406 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752886AbeB1PWp (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:45 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "J. Bruce Fields" <bfields@redhat.com>,
        "Ben Hutchings" <ben.hutchings@codethink.co.uk>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.214002495@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 047/140] nfsd: auth: Fix gid sorting when rootsquash
 enabled
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Ben Hutchings <ben.hutchings@codethink.co.uk>

commit 1995266727fa8143897e89b55f5d3c79aa828420 upstream.

Commit bdcf0a423ea1 ("kernel: make groups_sort calling a responsibility
group_info allocators") appears to break nfsd rootsquash in a pretty
major way.

It adds a call to groups_sort() inside the loop that copies/squashes
gids, which means the valid gids are sorted along with the following
garbage.  The net result is that the highest numbered valid gids are
replaced with any lower-valued garbage gids, possibly including 0.

We should sort only once, after filling in all the gids.

Fixes: bdcf0a423ea1 ("kernel: make groups_sort calling a responsibility ...")
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Acked-by: J. Bruce Fields <bfields@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/nfsd/auth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/nfsd/auth.c
+++ b/fs/nfsd/auth.c
@@ -60,10 +60,10 @@ int nfsd_setuser(struct svc_rqst *rqstp,
 				GROUP_AT(gi, i) = exp->ex_anon_gid;
 			else
 				GROUP_AT(gi, i) = GROUP_AT(rqgi, i);
-
-			/* Each thread allocates its own gi, no race */
-			groups_sort(gi);
 		}
+
+		/* Each thread allocates its own gi, no race */
+		groups_sort(gi);
 	} else {
 		gi = get_group_info(rqgi);
 	}
