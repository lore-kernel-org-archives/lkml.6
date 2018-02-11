Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326464-2-11567460337539121679
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326464; b=AIA10AD74EO6uk/2jBfor73xwRYOfW899/NX8TGhQP2b9go
    EYZETIpeWffAI50LdSeYhN0grFia9J9mFyDhkyacxS6+XYE1opTleBG31ECtpW5A
    XqNPYtuVZ+Ceunky4QA+xhaNYyiU78qmAkUYdcWrlh7KHMN4+xs6Sz6nLWx4xUrk
    1WvlEyiZDjNIASqerCFok4piyC6NejKpou4DfKHzevMEc7bMQrvRLQhPnnpzJxds
    oarxOejSA/8QDkf3cAUfj81d78SULGhVf0VUgo1Se4olNm7wCFz+GLO3e+6PSXDB
    tu7KdYL/a8N8Iz293RsRfhGqN0J9dlYhcnEL1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326464; bh=Ts6MjaIPQ15Z9MRpeor
    O0Fz0R9QuqaXHMnbjD7P/p18=; b=TrLgmfG+gZeiO7DlZvsrs+66FxQtNxNisBp
    4/LLmjJnXbjK6GhbKCnOuYdysoB6iS+VC44r3S8oLr1zJuQj+bwe4CGOpYRNZ0Ng
    miAMAmgVs+PyjvQfNgcdNOcHaDZlOre+kSvPnRfdkB006GFEjVuafCURpnI0VuzX
    5fP/VWleVuxYTBN8qVzzMG1qkvbij7Wvl58oxW20GupuK/y7gILUz5xuyQEstIqb
    52v0m+ZzC0AH1TtmJG8EaroPqNHO91eA9fQdtMtYNF2nVecxQ9fMZTuVjH2p2YAJ
    aLZLqjn9j50jDnNaURMr0bykhjuYzFswqtmKPwKcmUXPerz9V3A==
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
        id S932171AbeBKFSJ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:18:09 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932162AbeBKFSH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 00:18:07 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jan Harkes" <jaharkes@cs.cmu.edu>,
        "Al Viro" <viro@zeniv.linux.org.uk>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.294155194@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 052/136] coda: fix 'kernel memory exposure attempt'
 in fsync
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Harkes <jaharkes@cs.cmu.edu>

commit d337b66a4c52c7b04eec661d86c2ef6e168965a2 upstream.

When an application called fsync on a file in Coda a small request with
just the file identifier was allocated, but the declared length was set
to the size of union of all possible upcall requests.

This bug has been around for a very long time and is now caught by the
extra checking in usercopy that was introduced in Linux-4.8.

The exposure happens when the Coda cache manager process reads the fsync
upcall request at which point it is killed. As a result there is nobody
servicing any further upcalls, trapping any processes that try to access
the mounted Coda filesystem.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/coda/upcall.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -446,8 +446,7 @@ int venus_fsync(struct super_block *sb,
 	UPARG(CODA_FSYNC);
 
 	inp->coda_fsync.VFid = *fid;
-	error = coda_upcall(coda_vcp(sb), sizeof(union inputArgs),
-			    &outsize, inp);
+	error = coda_upcall(coda_vcp(sb), insize, &outsize, inp);
 
 	CODA_FREE(inp, insize);
 	return error;
