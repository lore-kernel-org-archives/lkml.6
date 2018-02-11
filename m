Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324564-2-3707820570638446148
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
    t=1518324564; b=i/rwIi4dMtXfxWJl2le+6qG8UsBRXVp+P6szT5lKb7iv9aO
    +JVohULkLXHFNK4ZPtg5YvzPbdNNRGCMa2yW51ClcMs/57JtzqWMrG7RDJdb9B9p
    diMNsmobSI+jHeAGx6M0FT0DPUcKz1IE8QAwzpJex1XZf5pQFolm80RdZkGigqFL
    vxwvwAmQIEunHJmCOdN+Fek+ey78Z6HlJpVt9I2R0PgH/T3XybGiIV/gvZ60NkKA
    Nw4WkDc85MjH/w5jrPHE2YYa8w6EMopdHvG4ItjxPB81pM6zugt7VpYc9oDg7Lid
    EDcO+ctTrELDlyjhUitpP5psnSXcn1tvuMI+BaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324564; bh=3R86Yf9GDaDiwQYCkVF
    Jqp0kDiT8OJE40FdH7BN7r6A=; b=E5fwUkQPrzzTejptTmqS5Ff6k+knYVU2JMb
    giU0jUeq1dwJMYpOW1cCIItRjIat6pM065JwKvRPmQCHbm/gxqjA5sSU507bHKUg
    d+iKp60xnVaWGEB+FX3jrhGUCvW94oM1+mP8/Gtp2X8+U8BZJQzahw6uFP6iI04G
    GQ+8/PqDDJYIx1i6kG3jMBS8afXlW7q1BQgmSx6V+K5JgE74aR6H8R9Q8N/C19rE
    Gao1kihtdFnRsNQUzVu/DeCUnVbV1sBep2lfznx9WPsFngKK9BVs5simfedYgrGT
    +tcbe4SM1BCFJWouRU/VyTkUUcaEiONpZBmELF2m+Ts5nUaCPQQ==
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
        id S1753433AbeBKEru (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:47:50 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41823 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752846AbeBKEd6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:58 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Ian Kent" <raven@themaw.net>,
        "NeilBrown" <neilb@suse.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.780186949@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 095/136] autofs: don't fail mount for transient error
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

From: NeilBrown <neilb@suse.com>

commit ecc0c469f27765ed1e2b967be0aa17cee1a60b76 upstream.

Currently if the autofs kernel module gets an error when writing to the
pipe which links to the daemon, then it marks the whole moutpoint as
catatonic, and it will stop working.

It is possible that the error is transient.  This can happen if the
daemon is slow and more than 16 requests queue up.  If a subsequent
process tries to queue a request, and is then signalled, the write to
the pipe will return -ERESTARTSYS and autofs will take that as total
failure.

So change the code to assess -ERESTARTSYS and -ENOMEM as transient
failures which only abort the current request, not the whole mountpoint.

It isn't a crash or a data corruption, but having autofs mountpoints
suddenly stop working is rather inconvenient.

Ian said:

: And given the problems with a half dozen (or so) user space applications
: consuming large amounts of CPU under heavy mount and umount activity this
: could happen more easily than we expect.

Link: http://lkml.kernel.org/r/87y3norvgp.fsf@notabene.neil.brown.name
Signed-off-by: NeilBrown <neilb@suse.com>
Acked-by: Ian Kent <raven@themaw.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/autofs4/waitq.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -87,7 +87,8 @@ static int autofs4_write(struct autofs_s
 		spin_unlock_irqrestore(&current->sighand->siglock, flags);
 	}
 
-	return (bytes > 0);
+	/* if 'wr' returned 0 (impossible) we assume -EIO (safe) */
+	return bytes == 0 ? 0 : wr < 0 ? wr : -EIO;
 }
 	
 static void autofs4_notify_daemon(struct autofs_sb_info *sbi,
@@ -101,6 +102,7 @@ static void autofs4_notify_daemon(struct
 	} pkt;
 	struct file *pipe = NULL;
 	size_t pktsz;
+	int ret;
 
 	DPRINTK("wait id = 0x%08lx, name = %.*s, type=%d",
 		(unsigned long) wq->wait_queue_token, wq->name.len, wq->name.name, type);
@@ -173,7 +175,18 @@ static void autofs4_notify_daemon(struct
 	mutex_unlock(&sbi->wq_mutex);
 
 	if (autofs4_write(sbi, pipe, &pkt, pktsz))
+	switch (ret = autofs4_write(sbi, pipe, &pkt, pktsz)) {
+	case 0:
+		break;
+	case -ENOMEM:
+	case -ERESTARTSYS:
+		/* Just fail this one */
+		autofs4_wait_release(sbi, wq->wait_queue_token, ret);
+		break;
+	default:
 		autofs4_catatonic_mode(sbi);
+		break;
+	}
 	fput(pipe);
 }
 
