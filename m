Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326043-2-3264863811027786052
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
    t=1518326042; b=Zq3iSMYSAnBexFKGfYa/s5T6vHeneXwbJCoI6BOHyFhdIxi
    hlcoyXEB7ZuVOiPBFz2mJaUJb60UDFJWSjoI0MfpXCmnDmopEIEqbD9+364XFBka
    R5K9tuzDYq9KXjbXSIa6Xs6T6T9TnkrgJRLDQHBQwZX6oSRLrvR8gpnVyoefCF86
    wxDM7lJYNoa7mjrJ+Bipwu86fMY0rxjf3h0+SVn+3OLh91Wbyub8N4eA8Necf3rM
    zaCN9isPi13xZ7Jb7todgi8ptjZRniCHLfD8XkAgUI87/I8Y8YiAKXyx412vzGn1
    JuUiK2+q3Wp1Ou6VpVYcMt8DAUKRgoAuEH+wA8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326042; bh=y0mZqfPUiAZ+upshjlp
    NiQr3t3cARq973qsUUedzfFI=; b=g60XhMyuVFBJjfYlnUGJBRSEFeQ/TJF2slD
    mjKBj/xp3SldvWDgALn2uaW5TA0pyyhFOK9/FmFshM1Gy1JMv+OQx088l6IN6yl8
    H9XH3qV1t4Zan85rei1k1F6gQddPYFSlU8ep6igVvBY0/nJlc1DxgK3+etDe4L6I
    X5ofK+MVjCx3JJ3MzCe5PvtOaQXt4oS+4C78kli0+/VmZzt1KH/xESChtl2HomGl
    6Pg7+8WeOeyhN2ZpUisBS3rtVFArgehIdpGcZDcO4rvGRmBRcIRtbH/ekmqoNnEo
    zvHsI7FtBG1szcQpGMgsvCKfFH1f+fcZw1lo7esDk/E8q6C6BZw==
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
        id S1753672AbeBKFMZ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:12:25 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41404 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752623AbeBKEdl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:41 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "NeilBrown" <neilb@suse.com>,
        "Ian Kent" <raven@themaw.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.393313279@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 51/79] autofs: don't fail mount for transient error
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.2: autofs4_write() doesn't take an autofs_sb_info
 pointer]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/autofs4/waitq.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

--- a/fs/autofs4/waitq.c
+++ b/fs/autofs4/waitq.c
@@ -88,7 +88,8 @@ static int autofs4_write(struct file *fi
 		spin_unlock_irqrestore(&current->sighand->siglock, flags);
 	}
 
-	return (bytes > 0);
+	/* if 'wr' returned 0 (impossible) we assume -EIO (safe) */
+	return bytes == 0 ? 0 : wr < 0 ? wr : -EIO;
 }
 	
 static void autofs4_notify_daemon(struct autofs_sb_info *sbi,
@@ -102,6 +103,7 @@ static void autofs4_notify_daemon(struct
 	} pkt;
 	struct file *pipe = NULL;
 	size_t pktsz;
+	int ret;
 
 	DPRINTK("wait id = 0x%08lx, name = %.*s, type=%d",
 		(unsigned long) wq->wait_queue_token, wq->name.len, wq->name.name, type);
@@ -180,7 +182,18 @@ static void autofs4_notify_daemon(struct
 	mutex_unlock(&sbi->wq_mutex);
 
 	if (autofs4_write(pipe, &pkt, pktsz))
+	switch (ret = autofs4_write(pipe, &pkt, pktsz)) {
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
 
