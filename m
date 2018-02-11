Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518326439-2-10690129278369727450
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
    t=1518326439; b=l+UuIep/JHT6iZFQMsbPsBLW+KtXIzkJLQD0eOpw8aXfFvt
    q/WYxwKiN18tqX7TVrrlStKO1SqZP5ia1f3mnuFLG9DG6yFdjyjflblgO2AXv1Uy
    aoof8ijKzz0UBYCg8ZyouSDQWfP/AM4oGxrQ/LkwSgg75CZKxglqvdGuNlpjQ44I
    mBAnBrucCn6Ytulj0zlBdrlmqkeWpXqlfTwlK46dRuT+d9Rsb7e5U91ZfI+ppLuN
    IoFs9Fjnu9CE60Xxl9p9psOWlAXYhWMAO5kZZVXJbLynmGcMT2LOs10l6pStjKnB
    16HjPbjcRPBmRIRX/X1Y+wYXUudD07PlgIui0tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326439; bh=tBghGxHgO/i6P4OMwPk
    VTs53PQ1rm+yUR/Ga7T3w91s=; b=iQz/Bxr5uTXf6PezdI4Fu/I4NxctrOr9R8O
    NQ4ECKtK1cHx1CWdgu/0YT02RgBNpLm3aiXoh6HJhn6kcGFFjAhf6/HJQsghlLPD
    Xrrs9sptzzTZSRaa+Ffwjx13yZViSkautzRNyJx50gzfGdBFuZLsqIfLiNr8tc6r
    Tlcxy/SSoKHY8T6ix90PapMCDMuxz+pSt6qTECw6HjsQAbnOE6C0sapsvAzdYfdm
    zLeuFQEBYXxsEcQSIHpYnWlHp1O+4syP1Tm5xNwxgVHyzFDq1pJeH15nwi8ZCa3o
    Ust00dO0qYy3ARfoUdEyr7tRzvpBrHdJSy7HHn64bNVfliI8xSw==
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
        id S932191AbeBKFSO (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:18:14 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932162AbeBKFSM (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 00:18:12 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Jens Axboe" <axboe@kernel.dk>,
        "Michael Lyle" <mlyle@lyle.org>,
        "Kent Overstreet" <kent.overstreet@gmail.com>,
        "Jorg Bornschein" <jb@capsec.org>, "Coly Li" <colyli@suse.de>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.915496956@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 022/136] bcache: check ca->alloc_thread initialized
 before wake up it
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

From: Coly Li <colyli@suse.de>

commit 91af8300d9c1d7c6b6a2fd754109e08d4798b8d8 upstream.

In bcache code, sysfs entries are created before all resources get
allocated, e.g. allocation thread of a cache set.

There is posibility for NULL pointer deference if a resource is accessed
but which is not initialized yet. Indeed Jorg Bornschein catches one on
cache set allocation thread and gets a kernel oops.

The reason for this bug is, when bch_bucket_alloc() is called during
cache set registration and attaching, ca->alloc_thread is not properly
allocated and initialized yet, call wake_up_process() on ca->alloc_thread
triggers NULL pointer deference failure. A simple and fast fix is, before
waking up ca->alloc_thread, checking whether it is allocated, and only
wake up ca->alloc_thread when it is not NULL.

Signed-off-by: Coly Li <colyli@suse.de>
Reported-by: Jorg Bornschein <jb@capsec.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/bcache/alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/md/bcache/alloc.c
+++ b/drivers/md/bcache/alloc.c
@@ -406,7 +406,8 @@ long bch_bucket_alloc(struct cache *ca,
 
 	finish_wait(&ca->set->bucket_wait, &w);
 out:
-	wake_up_process(ca->alloc_thread);
+	if (ca->alloc_thread)
+		wake_up_process(ca->alloc_thread);
 
 	trace_bcache_alloc(ca, reserve);
 
