Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2173738-1517952298-2-13293190116714004690
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
    t=1517952297; b=euoBL4L7iQPNTcIVR/5qZ+zd0aluilRDmIBHm9Qv7yg+gVA
    xhJqE4G69ZTc9RyW8mOUWudCMOwYUj93hd4ixrO6bjsPNCWJHhUN9gX8lzYYCeZX
    p80WsomLq74wLNsEFgxkPgTqt8ch48TkY4Evcon/Uf4FGbBUKmwDQhO1vUgbqgXq
    Rys5J0IoyQz3SPHI6q7heTCAAQs9OtOmXM6v39reFNMtufnzZrgdtZLuS5DU8ZcO
    gBK3c9X0Okh9SextlvpdqrDwxxVo1wp2aAISBwEXu4N957ioRKi0psu4Pe5Rcn5I
    G6NWPb8rMCrWwVR13vpg9OpEsFJXmaa9QtVMxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1517952297; bh=mZiOs1ejIbHGIY8UG28ZnhOcE0
    PtAgXtusGN3YqXWcQ=; b=Uz0g1CEng1w49eK0nanpVh2Xc3lpFLTijvcG2Nv+t2
    SaRjLsiK5QiAXURslPUM6iifNVGcCcrzF9kuPg00FuSbfWpMR/W9qubXptPTt5hz
    L+QU92PlJGUwxeI2h5kXcu2IszEKlj8bwgGXYqBjDaq5nacNi3JXksh2sWEASOfJ
    d7CwW24Qmggfs4rCCtNbHC09oF827QvoB6M21ChNFG6UyrIYWdQZWXiUS7Uo1k9M
    35mEuNz5V/pIsg5dJsjGEZ8LxTcXEpKR3XRh1VdoENxTs4q7L6fsO4fFrqh4IoVH
    cqv9J9u2t4b12Vo1VMT7FA8zpQowvdD0ZtnSRo5cc3lA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=SmfLm+dM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VD+xtQvt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=SmfLm+dM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VD+xtQvt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754084AbeBFVY1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Feb 2018 16:24:27 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:35169 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754043AbeBFVYZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Feb 2018 16:24:25 -0500
X-Google-Smtp-Source: AH8x224OyWgbydV0m13qLJA6YBny/5+N3dqnkOq+9iWuvZuGHX1UXvG8sjOCRBumOEg/jDQQ87fFdg==
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
Subject: [PATCHv2 1/1] KEYS: encrypted: fix buffer overread in valid_master_desc()
Date: Tue,  6 Feb 2018 13:24:08 -0800
Message-Id: <20180206212408.5455-1-jinqian@android.com>
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

Cc: linux-stable <stable@vger.kernel.org> # 4.9.y
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
index a871159bf03c..ead2fd60244d 100644
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
