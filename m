Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519832715-2-17529576892287315258
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
    t=1519832715; b=pyq2gW/jU3h/7JwgP5NDnR4jnjJ4vGCmVx2qM51MiErtMPe
    8Q6QO0gGK+QFKwVo83XM+2Iqxyg9XqtzPdrNqslTBLsr7up9zGk1RLUHB5h6+zma
    0Yzh9ZnskejJJURk5b8jdeAob9qD1/CaB/396QDikBxhSo4Q3kBrLfTp4Vw1e8wg
    +2FJkNTF8F+J4dXc24Ny4R+RKethoKEInJL6XwFZcC3waqR0AYAUiqzchrsXMfYi
    wZCp9I+RxVivgZdRCHkwOHmILrhtCdXbaUMTmEeQMkPIqKcxbzrDTrrnLnxvArD0
    xUjjrUU9b5MjyjF14/lVH1meKhX2aF9wFfQ7taw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832715; bh=HyfM3pMmvUeu+CWGYqM
    cBv4aPeSs3mAydT+BM7ad5Bs=; b=vVq42gzHg9TK3My9eQRCx0CrNcUEnR/GOCd
    jei/xg9hG6MbIbUrP8OS7lNhbVju+1q66vUDd9OVZT8soTvJ2gR5umB1NT0yqM3w
    8SUjPM9OzF1RPibI/DdjNz48++LWEz8ifDwpSDV/qCiM8elBVw2U3K+wrIwx1sxb
    X8hVjTMQL4jTWzmPv6bJrYUCUqnE7PaxNKlXJfbDbhFNAo1mC3B7/C8YEtP6BUK2
    g/cBithqqPM4YDF7l5Q+JT8T3QNRUm8OFrYSpc3PP0g7+oXs1RTRd+rY0Y1zN97m
    pHBARose2VnSJrKW2c4mzADeUfK6fCdak4JtokBmkQAYzFvoygg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932750AbeB1Pol (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:44:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33395 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932653AbeB1PWQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:16 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Steven Rostedt" <rostedt@goodmis.org>,
        "Borislav Petkov" <bp@alien8.de>,
        "Andy Lutomirski" <luto@amacapital.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Will Drewry" <wad@chromium.org>,
        "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Frederic Weisbecker" <fweisbec@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, "Ingo Molnar" <mingo@kernel.org>,
        "Alexei Starovoitov" <ast@plumgrid.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.933053267@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 069/140] include/stddef.h: Move offsetofend() from
 vfio.h to a generic kernel header
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Denys Vlasenko <dvlasenk@redhat.com>

commit 3876488444e71238e287459c39d7692b6f718c3e upstream.

Suggested by Andy.

Suggested-by: Andy Lutomirski <luto@amacapital.net>
Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexei Starovoitov <ast@plumgrid.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Will Drewry <wad@chromium.org>
Link: http://lkml.kernel.org/r/1425912738-559-1-git-send-email-dvlasenk@redhat.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.2:
 - There is no definition in vfio.h to move
 - Put the definition inside the #ifdef __KERNEL__ section]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -23,6 +23,16 @@ enum {
 #else
 #define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
 #endif
+
+/**
+ * offsetofend(TYPE, MEMBER)
+ *
+ * @TYPE: The type of the structure
+ * @MEMBER: The member within the structure to get the end offset of
+ */
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER)	+ sizeof(((TYPE *)0)->MEMBER))
+
 #endif /* __KERNEL__ */
 
 #endif
