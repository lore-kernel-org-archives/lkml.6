Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1906823-1518710806-2-1345793764823518488
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710805; b=ktdYFwwFbCMLTobayT5TAi7o2tPAGFyK5R4lSjETLF6Gfzg
    9kiodLFvwddweHxHQ6BgcMXX11kcJRmAqx3+26Ty1WpK9K+ty3ja8vS1zUd9pwI0
    prQYw1MMDVgZJhpO+ZcLYrat6tc9VQtUfSLSwWhDKfcNv99A3b3jAxLApFtYPqJr
    922lLt44gMkHGR/203h9BSd66BXAb+qzFeRKhv90OCtrP2s2NLF8iraR7PW0SeBK
    6Jor9xiibUZAQ0NGUA1RtsFTx7kh9UoMRWmknN+Zg5B47S7+GslfMCt2HNxhSRB1
    5VfVg92A+oi21ybnjQR5EdYb9+GDSd3Rd8m0GBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710805; bh=TSDAIFQugYLPGHTC2LUVUUE9m0
    yYMKE9UbHy5To5tmE=; b=fu8vXYKFzPgQWh3/4a8ULkz4JnSZN/bLuLwbbQlg+f
    u6w4Qy+5MfEGa1L2rgPBRUIEuo78ojCr0eicx4wWF6A/ScalXBr3qNJLDPS1sOUh
    zFCzOX8GKDdEOo+cG3ODKiS3qCS2JOF0UrpIsZAmqWxs+XqEviDIq/I50BZKK5C4
    enV4qiHVPrB5qFK25HkGfa3U3UJENJtiVE/l/ThNk6XNa3c0Dl/uzL5nvAFgcvUV
    9j5eB/8TvF4rk3bx4yHf7eJh+kMp1Ty450TVm2cWoO4G4x95ydz/T2G5lu7uu2RY
    HUfBgw2iFh9tilpXqzxB9miHVJoRFEcKUH6nLKTxswRA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424675AbeBOQGW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 11:06:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35184 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424535AbeBOPp6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:45:58 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Willy Tarreau <w@1wt.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 159/202] pipe: actually allow root to exceed the pipe buffer limits
Date: Thu, 15 Feb 2018 16:17:39 +0100
Message-Id: <20180215151721.204883817@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 85c2dd5473b2718b4b63e74bfeb1ca876868e11f upstream.

pipe-user-pages-hard and pipe-user-pages-soft are only supposed to apply
to unprivileged users, as documented in both Documentation/sysctl/fs.txt
and the pipe(7) man page.

However, the capabilities are actually only checked when increasing a
pipe's size using F_SETPIPE_SZ, not when creating a new pipe.  Therefore,
if pipe-user-pages-hard has been set, the root user can run into it and be
unable to create pipes.  Similarly, if pipe-user-pages-soft has been set,
the root user can run into it and have their pipes limited to 1 page each.

Fix this by allowing the privileged override in both cases.

Link: http://lkml.kernel.org/r/20180111052902.14409-4-ebiggers3@gmail.com
Fixes: 759c01142a5d ("pipe: limit the per-user amount of pages allocated in pipes")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Luis R . Rodriguez" <mcgrof@kernel.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: Willy Tarreau <w@1wt.eu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/pipe.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -618,6 +618,11 @@ static bool too_many_pipe_buffers_hard(u
 	return pipe_user_pages_hard && user_bufs >= pipe_user_pages_hard;
 }
 
+static bool is_unprivileged_user(void)
+{
+	return !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN);
+}
+
 struct pipe_inode_info *alloc_pipe_info(void)
 {
 	struct pipe_inode_info *pipe;
@@ -634,12 +639,12 @@ struct pipe_inode_info *alloc_pipe_info(
 
 	user_bufs = account_pipe_buffers(user, 0, pipe_bufs);
 
-	if (too_many_pipe_buffers_soft(user_bufs)) {
+	if (too_many_pipe_buffers_soft(user_bufs) && is_unprivileged_user()) {
 		user_bufs = account_pipe_buffers(user, pipe_bufs, 1);
 		pipe_bufs = 1;
 	}
 
-	if (too_many_pipe_buffers_hard(user_bufs))
+	if (too_many_pipe_buffers_hard(user_bufs) && is_unprivileged_user())
 		goto out_revert_acct;
 
 	pipe->bufs = kcalloc(pipe_bufs, sizeof(struct pipe_buffer),
@@ -1069,7 +1074,7 @@ static long pipe_set_size(struct pipe_in
 	if (nr_pages > pipe->buffers &&
 			(too_many_pipe_buffers_hard(user_bufs) ||
 			 too_many_pipe_buffers_soft(user_bufs)) &&
-			!capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN)) {
+			is_unprivileged_user()) {
 		ret = -EPERM;
 		goto out_revert_acct;
 	}
