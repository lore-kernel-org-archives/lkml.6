Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-560692-1519836231-2-15849497466911814890
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
    t=1519836231; b=QSZIYXvig2Tc97uMf2qcZ1hTfiEXd0dDO9nGeiinODG/XwD
    XqfRBvT+exmPP/gLAYol1p3+Aa1N9sH0blmo9ofRxk9TKibNJlE2p2eFKxG25rFJ
    PW+/M08bTtaONliTvRBmmNFD4YLjiTpIbKgY5zJctzrdcBsyp/xeMBx1XTS5H1Va
    LOS+fueKgBLj2dImyeQMtBfs+orSwvqE1AQLeN1ASBJFbEAHFo6KHALyeq7itCmk
    8Im8AS55RnJkbOryYqxgSMy3yfBKk8UjEHYSAr4xO0GaJ75lk8fLq+Y0QvSnoxOF
    vpUUDQfo6N23eIo98ltTWshR1ej/K47erJISlkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836231; bh=KITtndeFmBqtKJfT8Gy
    fVKkNTdMyWQItG4uEyRGKnzs=; b=mC3NHMljIOXZBDc/iGBJcUPj8aw82i8FI5O
    YdhfEEVry0fJiXcXzTJC0wT2zi2aVZc2LbiqIYAX5qjZvSn2YuNVe5HNOVK+WjvX
    ivUjAsRIhoG3wjxMGXxJtUC12qf0gy+LtmznZf9JYbIGgY3TY7tqDxFOCY0S9Yod
    +UdRDHr86EopPsNNfqkXRWJ69PTM84+qKLNt2lLzmH1w9EI4F7lu2jCgvtSc6ah5
    TJaDwEPPyfoUGMxcPHnScJgAa3ZanN8eC1aB5NNuAnoF+X13xFTm+QKb9ElJo4Wf
    xKqV5gLhZ8Av5H8PrH5s8+Xs5dg09GskJQrqmei+G+anwrNv6NQ==
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
        id S1753162AbeB1QCj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:02:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34720 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753147AbeB1QCi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:02:38 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Jiri Slaby" <jslaby@suse.com>,
        "syzkaller" <syzkaller@googlegroups.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Tetsuo Handa" <penguin-kernel@i-love.sakura.ne.jp>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.327404054@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 137/254] n_tty: fix EXTPROC vs ICANON interaction
 with TIOCINQ (aka FIONREAD)
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

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 966031f340185eddd05affcf72b740549f056348 upstream.

We added support for EXTPROC back in 2010 in commit 26df6d13406d ("tty:
Add EXTPROC support for LINEMODE") and the intent was to allow it to
override some (all?) ICANON behavior.  Quoting from that original commit
message:

         There is a new bit in the termios local flag word, EXTPROC.
         When this bit is set, several aspects of the terminal driver
         are disabled.  Input line editing, character echo, and mapping
         of signals are all disabled.  This allows the telnetd to turn
         off these functions when in linemode, but still keep track of
         what state the user wants the terminal to be in.

but the problem turns out that "several aspects of the terminal driver
are disabled" is a bit ambiguous, and you can really confuse the n_tty
layer by setting EXTPROC and then causing some of the ICANON invariants
to no longer be maintained.

This fixes at least one such case (TIOCINQ) becoming unhappy because of
the confusion over whether ICANON really means ICANON when EXTPROC is set.

This basically makes TIOCINQ match the case of read: if EXTPROC is set,
we ignore ICANON.  Also, make sure to reset the ICANON state ie EXTPROC
changes, not just if ICANON changes.

Fixes: 26df6d13406d ("tty: Add EXTPROC support for LINEMODE")
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Reported-by: syzkaller <syzkaller@googlegroups.com>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/tty/n_tty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1809,7 +1809,7 @@ static void n_tty_set_termios(struct tty
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
-	if (!old || (old->c_lflag ^ tty->termios.c_lflag) & ICANON) {
+	if (!old || (old->c_lflag ^ tty->termios.c_lflag) & (ICANON | EXTPROC)) {
 		bitmap_zero(ldata->read_flags, N_TTY_BUF_SIZE);
 		ldata->line_start = ldata->read_tail;
 		if (!L_ICANON(tty) || !read_cnt(ldata)) {
@@ -2520,7 +2520,7 @@ static int n_tty_ioctl(struct tty_struct
 		return put_user(tty_chars_in_buffer(tty), (int __user *) arg);
 	case TIOCINQ:
 		down_write(&tty->termios_rwsem);
-		if (L_ICANON(tty))
+		if (L_ICANON(tty) && !L_EXTPROC(tty))
 			retval = inq_canon(ldata);
 		else
 			retval = read_cnt(ldata);
