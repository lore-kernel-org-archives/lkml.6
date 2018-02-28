Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834191-2-6625327374773163988
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
    t=1519834190; b=U+w+UT6Sv11ARaeSM69sJG7vU2gdZU6A4x1xgYXpi03M4fR
    +LT7UXvKMKp7pnrYfwgHP0/qOEohKei2DDZRjvxi7txwmmUUwkkc+4tSQbvNxTKd
    3VKcp1GHyF7wjURjiI+XYnGU9fo5MI2mcX22S9s62quR5iMIy35g7gsnIlJNzeNm
    OS60IlTeCsZftvwC+JG9EoWJ6SSD9QjkVqc8a0/Lb2DYLbnNGeJywtJ6oPJt3P4/
    hT/mTi7PeTRwh3aqiH4SmlWoUltD+5+b1znj0lRFF3erYy9vGTlnBadg5AopR6Xe
    2CoGVXLuS8WfiOMxZg5tDTMIfPPRwzaZUk+euUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834190; bh=xqQIw33gSIjhvbooUTh
    sOpO7gmZTaNl1cK2v3RwDQNQ=; b=jpb90LBZsb7zcjxBkLTECBmyz7XCaJrnUWX
    heffJYBt7pxw3GCgJLpseBgkE0t1ynLzOsPME54mLEptNTQ5yaYF/2wNEaxc36VS
    1Dc1Y9F6hda49/f6nCiiHm7yTlfZIrb2DNss4Y4klf2n0LtFGw77TvCvOqJtmnoQ
    IEnlAI9xqIa2ekNMr0NAkpRgjZMIbBdcwpTVe+vL3jUDZ1+UBxJYlILLle00i3k2
    6ewPD9nUlr9PaZPoTGN/N7E9lKuZDb3VBA7ISnQoFc9DYizj+qVr8mLQ/KztdiSF
    djB8hN4Vd3dhUxJfc/4Y7kVdeD4Z/wHqR/Q7jEKbvJWl4XMmi3g==
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
        id S933081AbeB1QJK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:09:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34986 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932875AbeB1QJI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:09:08 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Michael Lyle" <mlyle@lyle.org>,
        "Jens Axboe" <axboe@kernel.dk>, "Coly Li" <colyli@suse.de>,
        "Rui Hua" <huarui.dev@gmail.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.940308417@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 011/254] bcache: recover data from backing when data
 is clean
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

From: Rui Hua <huarui.dev@gmail.com>

commit e393aa2446150536929140739f09c6ecbcbea7f0 upstream.

When we send a read request and hit the clean data in cache device, there
is a situation called cache read race in bcache(see the commit in the tail
of cache_look_up(), the following explaination just copy from there):
The bucket we're reading from might be reused while our bio is in flight,
and we could then end up reading the wrong data. We guard against this
by checking (in bch_cache_read_endio()) if the pointer is stale again;
if so, we treat it as an error (s->iop.error = -EINTR) and reread from
the backing device (but we don't pass that error up anywhere)

It should be noted that cache read race happened under normal
circumstances, not the circumstance when SSD failed, it was counted
and shown in  /sys/fs/bcache/XXX/internal/cache_read_races.

Without this patch, when we use writeback mode, we will never reread from
the backing device when cache read race happened, until the whole cache
device is clean, because the condition
(s->recoverable && (dc && !atomic_read(&dc->has_dirty))) is false in
cached_dev_read_error(). In this situation, the s->iop.error(= -EINTR)
will be passed up, at last, user will receive -EINTR when it's bio end,
this is not suitable, and wield to up-application.

In this patch, we use s->read_dirty_data to judge whether the read
request hit dirty data in cache device, it is safe to reread data from
the backing device when the read request hit clean data. This can not
only handle cache read race, but also recover data when failed read
request from cache device.

[edited by mlyle to fix up whitespace, commit log title, comment
spelling]

Fixes: d59b23795933 ("bcache: only permit to recovery read error when cache device is clean")
Signed-off-by: Hua Rui <huarui.dev@gmail.com>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Reviewed-by: Coly Li <colyli@suse.de>
Signed-off-by: Michael Lyle <mlyle@lyle.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/bcache/request.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -698,16 +698,15 @@ static void cached_dev_read_error(struct
 {
 	struct search *s = container_of(cl, struct search, cl);
 	struct bio *bio = &s->bio.bio;
-	struct cached_dev *dc = container_of(s->d, struct cached_dev, disk);
 
 	/*
-	 * If cache device is dirty (dc->has_dirty is non-zero), then
-	 * recovery a failed read request from cached device may get a
-	 * stale data back. So read failure recovery is only permitted
-	 * when cache device is clean.
+	 * If read request hit dirty data (s->read_dirty_data is true),
+	 * then recovery a failed read request from cached device may
+	 * get a stale data back. So read failure recovery is only
+	 * permitted when read request hit clean data in cache device,
+	 * or when cache read race happened.
 	 */
-	if (s->recoverable &&
-	    (dc && !atomic_read(&dc->has_dirty))) {
+	if (s->recoverable && !s->read_dirty_data) {
 		/* Retry from the backing device: */
 		trace_bcache_read_retry(s->orig_bio);
 
