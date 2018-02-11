Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326345-2-3668322702899087450
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
    t=1518326345; b=QFRvljIX7p5S/21CfQlvS3IV4NEISrdi/MjVD671pHno1y3
    zA3RGbzvKfAz0PU6nJzbJsroO0EhJj9jW1qPUQFB2cSFA4ww+oCglVKCtn1ERxEe
    m+EhpZTP2ii0x19l9sX+QzwubteUPfBYnswVwPPmJg+iUD+NNSaf7uYNeaJhtPYl
    VXUSm9GwJouqXcKt0xgxcelUiyYnGnUQDGpUWXs4N0R6AZa5J3M7zN0sPKJaEpnI
    TFmunceN/gWXczFsg2PKeShQ2/01jzvCr7a9rS/NKw83d+NjjTn75PHAeLnIW/OA
    g3pc+MOJ2OfgwD1DJPKT3WvbgJ8e4/hgXQtSbRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326345; bh=1UHxEoZdgQfE3Y7WGK1
    VVDdTRGLRZkQFBL/jsV+leOo=; b=DzZuRRzdNSmAHe9Taz5Qmau5ziQD+zccPVH
    /X8VxR1CnM+7RfzSbsDxaUAJMcmLGwxMj9yGkb5gBzwTq5JIOGvnatM9BHK4J6/X
    8ULCFIk81C8YEZFnGecIrZszG+OxC9/lwuCosJnr/QkHXZRG+hCeRCnA+w04WONb
    tTmLvZxWgWairdb81t2daq+nQ7KA3R0upHudvQNX9QJPnCJ6cfgpraHWumvgwfzP
    RH3wM59UrnLIP7rcYgkzmTyKzlK1P6JB0CTgsDXKys80yPqDXqnt6CBeZE9q9dPq
    ArJUdqSvz2Qde8XSJ3OkuMYcuKyFNt8urBMPPlpe+kS5fjdz0Cg==
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
        id S1752774AbeBKFSr (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:18:47 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:42726 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753796AbeBKFSc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 00:18:32 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Kent Overstreet" <kent.overstreet@gmail.com>,
        "Junhui Tang" <tang.junhui@zte.com.cn>,
        "Eric Wheeler" <bcache@lists.ewheeler.net>,
        "Michael Lyle" <mlyle@lyle.org>, "Jens Axboe" <axboe@kernel.dk>,
        "Nix" <nix@esperi.org.uk>, "Kai Krakow" <hurikhan77@gmail.com>,
        "Arne Wolf" <awolf@lenovo.com>, "Coly Li" <colyli@suse.de>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.119885799@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 038/136] bcache: only permit to recovery read error
 when cache device is clean
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

commit d59b23795933678c9638fd20c942d2b4f3cd6185 upstream.

When bcache does read I/Os, for example in writeback or writethrough mode,
if a read request on cache device is failed, bcache will try to recovery
the request by reading from cached device. If the data on cached device is
not synced with cache device, then requester will get a stale data.

For critical storage system like database, providing stale data from
recovery may result an application level data corruption, which is
unacceptible.

With this patch, for a failed read request in writeback or writethrough
mode, recovery a recoverable read request only happens when cache device
is clean. That is to say, all data on cached device is up to update.

For other cache modes in bcache, read request will never hit
cached_dev_read_error(), they don't need this patch.

Please note, because cache mode can be switched arbitrarily in run time, a
writethrough mode might be switched from a writeback mode. Therefore
checking dc->has_data in writethrough mode still makes sense.

Changelog:
V4: Fix parens error pointed by Michael Lyle.
v3: By response from Kent Oversteet, he thinks recovering stale data is a
    bug to fix, and option to permit it is unnecessary. So this version
    the sysfs file is removed.
v2: rename sysfs entry from allow_stale_data_on_failure  to
    allow_stale_data_on_failure, and fix the confusing commit log.
v1: initial patch posted.

[small change to patch comment spelling by mlyle]

Signed-off-by: Coly Li <colyli@suse.de>
Signed-off-by: Michael Lyle <mlyle@lyle.org>
Reported-by: Arne Wolf <awolf@lenovo.com>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Nix <nix@esperi.org.uk>
Cc: Kai Krakow <hurikhan77@gmail.com>
Cc: Eric Wheeler <bcache@lists.ewheeler.net>
Cc: Junhui Tang <tang.junhui@zte.com.cn>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/bcache/request.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -698,8 +698,16 @@ static void cached_dev_read_error(struct
 {
 	struct search *s = container_of(cl, struct search, cl);
 	struct bio *bio = &s->bio.bio;
+	struct cached_dev *dc = container_of(s->d, struct cached_dev, disk);
 
-	if (s->recoverable) {
+	/*
+	 * If cache device is dirty (dc->has_dirty is non-zero), then
+	 * recovery a failed read request from cached device may get a
+	 * stale data back. So read failure recovery is only permitted
+	 * when cache device is clean.
+	 */
+	if (s->recoverable &&
+	    (dc && !atomic_read(&dc->has_dirty))) {
 		/* Retry from the backing device: */
 		trace_bcache_read_retry(s->orig_bio);
 
