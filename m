Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2173738-1517952164-2-15107602399718293670
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
    t=1517952163; b=fYnIZ6qzPtLYrw/V4dYeahubhdXJOIH/kJ6p3GFzIWmPGtD
    Fn4YNPehbEr8UrnuLIh24ylE3/2PXpd2rtBgV8Hai9P1/tUKIsmosOxeoLmjxxQO
    1kTfK6sNCqo6hysrdynxDRjiQLgSbtdX/wzxI1SzREWGFS9tfw2YwmWaY3Glyo9x
    5CzY+CYGGqwoelZsNtaSWimxtD1ZmaC7QGMTsO92Zu6sqXBYFAOZ2Gr/2Y1+RZd9
    +xF8oEUL46C9nBRqQaZ47UwJGul9Xr6C3B14uF9U3yV38GjqBo5tETWxKeN8nhHK
    5i/IwKOnevrDaiHLCmL/vSgohwVXyxxz/hMmalQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1517952163; bh=I3EKxUCaqbWslawdgHp111fpss
    kG1Wh+H9bu79LclxM=; b=r/k7ynj9ZwJDGsUORhCE683SA28kpoLNnd9w8JoDeN
    A4CH1xbzqgU2g9gB+BluzFYLt2zutN5fUmC2zxpWnWdd2ka0P+JA6Mb7N2p86Q6m
    AYbYw7Rwydncv7+wCSUUlxplXToka8mDuFUeHhje7y7JHYesQsJuUnnMt6FpwsJl
    tsg4Kfa9ZyIs9H92pHtLhxuv0DhM1GZn2qR5TZDDrpafiECkcbDD7sKXm1475zz4
    jUNiLQ64qkwrh0FsGSdGJojQPOSXYQe1yxbG4IVUVl5DV1BT039cHs6+lkPNaOrS
    XIa4umI/A2uv+WkypLOHlB//DwFVP+HuG/SN9JmhaTXA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=f+sux1Lm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MM4EPjPs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=f+sux1Lm x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MM4EPjPs;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754005AbeBFVWk (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 16:22:40 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:33303 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753523AbeBFVWi (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 16:22:38 -0500
X-Google-Smtp-Source: AH8x225I81oOc8hGYAXkHhfx083hw5FL35G5RiKUtoq5h+iqgLE/Qt11y06O5/0xYlst+g2yN/0KSg==
From: Jin Qian <jinqian@android.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Safford <safford@us.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>,
        linux-stable <stable@vger.kernel.org>,
        Jin Qian <jinqian@google.com>, Jin Qian <jinqian@android.com>
Subject: [PATCH 1/1] KEYS: encrypted: fix buffer overread in valid_master_desc()
Date: Tue,  6 Feb 2018 13:22:15 -0800
Message-Id: <20180206212216.4845-1-jinqian@android.com>
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

Cc: linux-stable <stable@vger.kernel.org> # 4.4.y
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <james.l.morris@oracle.com>
Signed-off-by: Jin Qian <jinqian@google.com>
Signed-off-by: Jin Qian <jinqian@android.com>
---
 security/keys/encrypted-keys/encrypted.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index ce295c0c1da0..e44e844c8ec4 100644
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
