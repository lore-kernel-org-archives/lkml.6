Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3775223-1519416538-2-17824833759691836228
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519416537; b=L3nK4UU3WMeGP0ZBHsaQOP/MfrzwBHYH1hdLNkx8XbBXVv9
    KF8r6c5VqQPwggAPVzaJcisZcyKvEoQ5tCGT1SVD7LWu90TwPx4N8GVuEGi6aIHI
    SlC96afdbCVLdKnHa8hYLA6kXKBZjhm9oldsFJnlloKkGTEQHPY6xAUPLKXsv8Tf
    VFtL9Uk3/Q1HS35+KEW1PWZz1RnWfgx+K5C0eDJzhYi2ev3larwhvaAsf3TItHKG
    je/nfF09z6CR1wCVuvGCRYWbIZ6zOboVs/4zJpSgIKYp8gYXyqW0B6JcIKIY7+tj
    BFBKm+zrt55TvOg4a0EoLBlD5spYwW9Xvuna7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519416537; bh=+p/qhO6FyKgUVPO87X2h/RaGo9
    UVlFtz+WlC2t+g2Ow=; b=dgC2dWqYgOgsNPv+bRnC8nulvgNb4o9ZMjx4KxbueN
    qGfNksRbMjlvfC+H/K0xfenYJW5/pnjmHFitW9HcabT6IvTPIgJ2vRqOYiun7x6L
    a+rDHhkqZWrzyk6+Xv+xQKksZVdStp8K7kVyVZI8aLWoEaV8yg4OHiKE7wwcu8GI
    rXzDQlOMrMFF2zVmunJXAvZGJZAbRWTojh5wbT35JzXX64eTutHUw4e5QuA/lnja
    Q1OQZStokq8jXS84C6YdiutllUkee176e+A2EnDxyYpWrgtYkNSIHh15eVwmzoTf
    yPlx0cOrKUOHpiqd8moFNy3sgpgxHQ+hY+BV1cD/MooQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933067AbeBWUIW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 15:08:22 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41610 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933054AbeBWSm3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:42:29 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.9 013/145] Provide a function to create a NUL-terminated string from unterminated data
Date: Fri, 23 Feb 2018 19:25:19 +0100
Message-Id: <20180223170726.377426584@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

commit f35157417215ec138c920320c746fdb3e04ef1d5 upstream.

Provide a function, kmemdup_nul(), that will create a NUL-terminated string
from an unterminated character array where the length is known in advance.

This is better than kstrndup() in situations where we already know the
string length as the strnlen() in kstrndup() is superfluous.

Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/string.h |    1 +
 mm/util.c              |   24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -123,6 +123,7 @@ extern char *kstrdup(const char *s, gfp_
 extern const char *kstrdup_const(const char *s, gfp_t gfp);
 extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
 extern void *kmemdup(const void *src, size_t len, gfp_t gfp);
+extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
 
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
--- a/mm/util.c
+++ b/mm/util.c
@@ -80,6 +80,8 @@ EXPORT_SYMBOL(kstrdup_const);
  * @s: the string to duplicate
  * @max: read at most @max chars from @s
  * @gfp: the GFP mask used in the kmalloc() call when allocating memory
+ *
+ * Note: Use kmemdup_nul() instead if the size is known exactly.
  */
 char *kstrndup(const char *s, size_t max, gfp_t gfp)
 {
@@ -118,6 +120,28 @@ void *kmemdup(const void *src, size_t le
 EXPORT_SYMBOL(kmemdup);
 
 /**
+ * kmemdup_nul - Create a NUL-terminated string from unterminated data
+ * @s: The data to stringify
+ * @len: The size of the data
+ * @gfp: the GFP mask used in the kmalloc() call when allocating memory
+ */
+char *kmemdup_nul(const char *s, size_t len, gfp_t gfp)
+{
+	char *buf;
+
+	if (!s)
+		return NULL;
+
+	buf = kmalloc_track_caller(len + 1, gfp);
+	if (buf) {
+		memcpy(buf, s, len);
+		buf[len] = '\0';
+	}
+	return buf;
+}
+EXPORT_SYMBOL(kmemdup_nul);
+
+/**
  * memdup_user - duplicate memory region from user space
  *
  * @src: source address in user space
