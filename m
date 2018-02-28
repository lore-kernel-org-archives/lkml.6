Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516026-1519834663-2-18349849041192659575
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
    t=1519834662; b=WKDqODusv6n4dn8Co7azT24RH8DxCQZAg4WkpCv51jQu9LR
    /HTAnhlSrhzq6lSjgZQEzfISKcrb+5GJVvWEYRGi2B6iUAkaIXHta5VPG7ThsWD6
    2ldWuCDoqGfhNWmZGqFq/44cl61q+JDGhhHmoTYJxbtbnDdm+Bnb1JTANTPMxHf/
    HNbzFNqO9fy2CyI0Bh6ETLD0iPY4HnHsJptY54CpUXif9lVJgOpZ5XTv+oQaE1ai
    1OIlFZwRwWbNeWNN1OtdW2fAJ45gG212kIXRDXQ1FB4B0EUOT4utOBsGA6YeODMN
    ZVgjiea0GfNbpxky3upt/IN4UpGP4c3kee+QlGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834662; bh=s59l1YlcE8nRAq+R8Hg
    Fa1yi9iRSGsPUGFgBHLxpc/k=; b=cGS/uE/ZfxHYTyGa8MRXvTR0aQ0NV9E4UmH
    q5C2NolzpQM/ifJW19OGQWgx81qgrwBjQEP2GPie9+yVaD7tYDfYsJtxBUyW3hKV
    7S881tyCWTQK/JlYD8FpEln1OBHSICPv+kJJ64wJWFTTJvEvs3uqZd7XQB5CODD9
    kHqjIMolQEH0IVShtlGi4F4vGGw7isP8UYpd6UJx9aX2WvzzRmyMzYkIx9vS0Syq
    LDaCIGOHzogPgEuHChf6r0b5I/1yjxUPpJYsO3eNy8BTWkxHQKhxDLnh7ZELyIT6
    KB7x9RLZSwbFX+4NG4/oVIPO76lCr7XEiqjGOQtlWXgnefj039A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934942AbeB1QQN (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:16:13 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35226 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934923AbeB1QQL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:16:11 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Denys Vlasenko" <dvlasenk@redhat.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Frederic Weisbecker" <fweisbec@gmail.com>,
        "Will Drewry" <wad@chromium.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Alexei Starovoitov" <ast@plumgrid.com>,
        "Andy Lutomirski" <luto@amacapital.net>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Oleg Nesterov" <oleg@redhat.com>,
        "Steven Rostedt" <rostedt@goodmis.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.121753986@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 148/254] include/stddef.h: Move offsetofend() from
 vfio.h to a generic kernel header
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
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/stddef.h |  9 +++++++++
 include/linux/vfio.h   | 13 -------------
 2 files changed, 9 insertions(+), 13 deletions(-)

--- a/include/linux/stddef.h
+++ b/include/linux/stddef.h
@@ -19,3 +19,12 @@ enum {
 #define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
 #endif
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
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -76,19 +76,6 @@ extern int vfio_register_iommu_driver(co
 extern void vfio_unregister_iommu_driver(
 				const struct vfio_iommu_driver_ops *ops);
 
-/**
- * offsetofend(TYPE, MEMBER)
- *
- * @TYPE: The type of the structure
- * @MEMBER: The member within the structure to get the end offset of
- *
- * Simple helper macro for dealing with variable sized structures passed
- * from user space.  This allows us to easily determine if the provided
- * structure is sized to include various fields.
- */
-#define offsetofend(TYPE, MEMBER) \
-	(offsetof(TYPE, MEMBER)	+ sizeof(((TYPE *)0)->MEMBER))
-
 /*
  * External user API
  */
