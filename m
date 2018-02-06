Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2173738-1517951968-2-15411578143532735566
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517951967; b=X6NRnZa2xRCNVGUKsYOWcx5Yj82LOoJvIhkNVOURW3zHJq/
    sAG2PteXjgoVUy9Y5zMCwKETqoQh14htcos6XiBbhPQt+R9TpM4ssXgIp4LwLFjI
    yiOrJHgPFq3xuK7KKlOIESc/faw6K8zm7SoEBMwyof94Dw5sYhmhZPGobDGZzbBb
    0X5a/RuI1zOsoeDwwq8UNBMNsLkEnxdDYHITZ0lcVWUWj7xxigmwpwODJrSCoQYz
    S+cKl4eT5/a+nfj9H7GduvUi7QfT5z0cr4/SuXBDVKAxzAAU1o3fS8a8Vo0ULxGf
    JP3PwkHPCdm9TVntKs5nkD4w+6LSzvxVOPRnlTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1517951967; bh=NfkxbBKlXqKeRo2gKV1asQteXk
    oyCREeDxqrrzIAgzw=; b=NvG+a2FL1N+la3oya5ZoeJDqqfR3eFojsPNOvt5YeS
    sDMNE8Q5Z2vakKMGxWP4mAUVBKVSjoRVFiyumJO+U7REmWkcfiBL8jLexUN++P1x
    YmfaK0A5mvJyRgL8nmNfB7gXAzUTiuuMqw98GG0Y0tVKHrF8f+6fVt6Qh5Q7Psih
    vZ1jNBu/KAjF6WWO9I4RSsMHqatq/0B/9ArPwPr8zBfEccmuOKdXQ/po/bQP0elo
    uhZnw0ByPIv0r2KZL1+uMaaYYssgWHhIm4uK/sEGGnGHOsLSpCgIQ2MX8KQrJLhl
    f6HUv0Lalq0xSkV9yTHPDJZ3fIwFh5U9nanBWAblbdMw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=ZQxd+v8Y x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=G7FNAmJw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=ZQxd+v8Y x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=G7FNAmJw;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753976AbeBFVTM (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 16:19:12 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40406 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753172AbeBFVTL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 16:19:11 -0500
X-Google-Smtp-Source: AH8x2240YiUUi9tNy7Yo7Qz8RnfrZlPD6qRD3m7Cg4T3mTvoZOiUpJl2Nw9g3T12kKqyuZguRftjeQ==
From: Jin Qian <jinqian@android.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Safford <safford@us.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, keyrings@linux-nfs.org,
        linux-kernel@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
        linux-stable <stable@vger.kernel.org>,
        Jin Qian <jinqian@google.com>
Subject: [PATCH 1/1] KEYS: encrypted: fix buffer overread in valid_master_desc()
Date: Tue,  6 Feb 2018 13:19:00 -0800
Message-Id: <20180206211900.3565-1-jinqian@android.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

commit 794b4bc292f5d31739d89c0202c54e7dc9bc3add upstream

With the 'encrypted' key type it was possible for userspace to provide a
data blob ending with a master key description shorter than expected,
e.g. 'keyctl add encrypted desc "new x" @s'.  When validating such a
master key description, validate_master_desc() could read beyond the end
of the buffer.  Fix this by using strncmp() instead of memcmp().  [Also
clean up the code to deduplicate some logic.]

Cc: linux-stable <stable@vger.kernel.org> # 3.18.y
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <james.l.morris@oracle.com>
Signed-off-by: Jin Qian <jinqian@google.com>
---
 security/keys/encrypted-keys/encrypted.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 89d5695c51cd..20251ee5c491 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -141,23 +141,22 @@ static int valid_ecryptfs_desc(const char *ecryptfs_desc)
  */
 static int valid_master_desc(const char *new_desc, const char *orig_desc)
 {
-	if (!memcmp(new_desc, KEY_TRUSTED_PREFIX, KEY_TRUSTED_PREFIX_LEN)) {
-		if (strlen(new_desc) == KEY_TRUSTED_PREFIX_LEN)
-			goto out;
-		if (orig_desc)
-			if (memcmp(new_desc, orig_desc, KEY_TRUSTED_PREFIX_LEN))
-				goto out;
-	} else if (!memcmp(new_desc, KEY_USER_PREFIX, KEY_USER_PREFIX_LEN)) {
-		if (strlen(new_desc) == KEY_USER_PREFIX_LEN)
-			goto out;
-		if (orig_desc)
-			if (memcmp(new_desc, orig_desc, KEY_USER_PREFIX_LEN))
-				goto out;
-	} else
-		goto out;
+	int prefix_len;
+
+	if (!strncmp(new_desc, KEY_TRUSTED_PREFIX, KEY_TRUSTED_PREFIX_LEN))
+		prefix_len = KEY_TRUSTED_PREFIX_LEN;
+	else if (!strncmp(new_desc, KEY_USER_PREFIX, KEY_USER_PREFIX_LEN))
+		prefix_len = KEY_USER_PREFIX_LEN;
+	else
+		return -EINVAL;
+
+	if (!new_desc[prefix_len])
+		return -EINVAL;
+
+	if (orig_desc && strncmp(new_desc, orig_desc, prefix_len))
+		return -EINVAL;
+
 	return 0;
-out:
-	return -EINVAL;
 }
 
 /*
-- 
2.16.0.rc1.238.g530d649a79-goog
