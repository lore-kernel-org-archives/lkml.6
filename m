Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1883814-1518710766-2-7580633864632366084
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710765; b=q2ZUXEOXPdhirsm8qib4ZcseNqEN4LYFkqq9Z6XG5UBW7Vn
    mseRGKf8Yjn81dJFiKm7DbJH1hPvrc3K+CrmPcmCqB5kQ1yTt6AF32taCGLrML0g
    oEV8jUbfmO+pKogoAbEkiVtR14k6tujrq2yul7ZIxL+h/gtsTzV502v6tpFAEdy/
    O+qc5PLfUnCNMh8RrCTJ8p9kgSMFuZohjLQuvGkupJVis+GUbNOlDjuz4vCFgbQV
    ogcTch+KbJPiRpQyunQl9VIiWkBj/UFrwNvgaFGqAC8iK73d81T+7Mo6JIOQcG6N
    W/19W4vB5ToyA/wl0Kr0HukWETezM3hGOnEhksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518710765; bh=VV8yCdFHA/XpPqGSnY1pmS8WQw
    7dPf2+06rUoakpwFk=; b=l9pepbRF+b6JB6uQzwSKKTNX1NpUQEySTJU8dll8TH
    bUM95yRwcCkE3ocZNUOKcGt7DZfHKOSEUwLVs9kVbxCqtIQ7EmZK5kvU8Rtd5+XU
    rMDrbKzhgeX51kkI7Wtxnum6Qe0UndG0W0qtA7FU6zqSD9w6e5Na8uOif5jrxjHy
    zRWTSPI/bJkcoWelax4p5PDqg+oW34Ax0H8AAtumdXlIqxYNuMM3qAhv0Talw4Og
    7TIsYr2vmprUM4nn2fTEdJLA+M4oavEkVcapqbjp2/uB/MXM1DVJd8NOLFXOTXwg
    uMFcnIOr6kcbDnFSv3dnyuhY/D5tnbWSr96XMaaxB/Zg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424589AbeBOPqD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:46:03 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35212 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424588AbeBOPqB (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:46:01 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Willy Tarreau <w@1wt.eu>, Kees Cook <keescook@chromium.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 160/202] pipe: fix off-by-one error when checking buffer limits
Date: Thu, 15 Feb 2018 16:17:40 +0100
Message-Id: <20180215151721.258637616@linuxfoundation.org>
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

commit 9903a91c763ecdae333a04a9d89d79d2b8966503 upstream.

With pipe-user-pages-hard set to 'N', users were actually only allowed up
to 'N - 1' buffers; and likewise for pipe-user-pages-soft.

Fix this to allow up to 'N' buffers, as would be expected.

Link: http://lkml.kernel.org/r/20180111052902.14409-5-ebiggers3@gmail.com
Fixes: b0b91d18e2e9 ("pipe: fix limit checking in pipe_set_size()")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Willy Tarreau <w@1wt.eu>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: "Luis R . Rodriguez" <mcgrof@kernel.org>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/pipe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -610,12 +610,12 @@ static unsigned long account_pipe_buffer
 
 static bool too_many_pipe_buffers_soft(unsigned long user_bufs)
 {
-	return pipe_user_pages_soft && user_bufs >= pipe_user_pages_soft;
+	return pipe_user_pages_soft && user_bufs > pipe_user_pages_soft;
 }
 
 static bool too_many_pipe_buffers_hard(unsigned long user_bufs)
 {
-	return pipe_user_pages_hard && user_bufs >= pipe_user_pages_hard;
+	return pipe_user_pages_hard && user_bufs > pipe_user_pages_hard;
 }
 
 static bool is_unprivileged_user(void)
