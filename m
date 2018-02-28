Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519833534-2-10899959220380098925
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
    t=1519833533; b=FHENrWyj4EXW0NW3lwZPZgraoTcBv9MURNd2jXUhLW9Vd6b
    O8V2rk7Fzmko3/SmIXhk3t9EiDSjxEI1UF3ADoxUFTiNEFyALFpktGTHHF6H77fk
    oGBW2Hhmrtaq8PbLDlU5fhs+q45UFCAiVj0SUzoP14SsVxm45iYAoOiNVF/Q6usD
    iup+eU0NQ4ZrfV0wfhR4Hy7cR0erULmF7rd0qTc818OpNNxN3jgJUGVW6+hfW2AQ
    DV7fzFBwkjC8PGR8Mzu413oEu7kOmNfykYurCotu7K7/mpRttuBI2IX5nIzpIrED
    7KOalAPQ6ix58Bb3m3DY4QqeK1fjRs3f/3E7wrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833533; bh=30/lAAojNiu7P1h876q
    VMz5Pog0rOR3fOjAHQ3r++oY=; b=N83/izEdwxr8MfEFr+583VbgZRRoz32Zk4x
    OXkzBACySAAWstPRO8Sl9zPV2AfFhr1jUsVoZ6WyiVu0R+gItpRNc/BYuF4DJu2X
    YU4eBQXFCeBHHyb/wuU050fiMvQzgR0jvSd6c1+KsQdqvimSWa1wDypTliGkMtjx
    ZUjlfAwcxwUG4/GW66LIGhv9iG3HFqcBCgfjC5mGNlPMkhfrD7c3x2fpl0TqBl4y
    Rt70WDE5Sfpv7S9BoXEMzqgndRYzhAYdJtIeQz5L/hGoS4DREoYbGfTTi26tU6tR
    aBgj5bgOr2mvec0C+h0F6MLXOERQp7l8emmVmh0yTDb3NSMvTqg==
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
        id S933833AbeB1P6t (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:58:49 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34578 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934293AbeB1P6r (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:58:47 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Ben Hutchings" <ben.hutchings@codethink.co.uk>,
        "J. Bruce Fields" <bfields@redhat.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.840871204@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 115/254] nfsd: auth: Fix gid sorting when rootsquash
 enabled
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
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/nfsd/auth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/fs/nfsd/auth.c
+++ b/fs/nfsd/auth.c
@@ -59,10 +59,10 @@ int nfsd_setuser(struct svc_rqst *rqstp,
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
