Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3281902-1517861000-2-2302998398810992546
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
    t=1517860999; b=uRHtm66IJLrscqpxETWJ2cRPYMwMHGvRVx7oUZt0kly7zHD
    OgJCy+LMQs4/C2oZhh4wm3BbiU2wSGG87Lv3n0Ovr4RLAWqplKiygJ9fXyu/CmLO
    fsAX21nSf3ZP5veNCEODSYN3+2b+hGDs6avO5vnCHx2zHtu6XzQtCQgRsa9qygzR
    BYL3lTAO0biZsI/HoDT3hBIcIv0xhyTrpxWwepGoFDhcYc+Rsi/K/teDue/E/eLA
    HpwJMGVEqs83buzpYlY59dV3o4O6dl1jforAXFYKGGQK8HzPDU8PQb3c10YMUTwe
    pLOVFM4yT1rrJlkMprzkDURR6B2ROo2CUg41mVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1517860999; bh=8ZB65BZPe50/BHY876N4JslTJN
    qTT5A2Tmwyd0OK2cM=; b=Olsh7ecQP8hglvTVkLJNz9SQY5HVHwX6QS3jd9mGXc
    ksZDfysyuTDN07q6DX5qVSO1mfxUw8t0bVj7+eYzvNBu8TZK1XmIOFIzyIByKMbh
    lBtAYXpgVotDnjxHOOyXudTIS/sx5AJ1bSe6tFJFz1mCWYcpvVcffPCDdMzZoeWO
    TqRSTKVXbhmcz1LTt2A72mBggucw/bmxviR+yfKeh12ZRAT4savS1PpN3v0pOs4u
    wSSgkRDct390emm2O2PIYxisj2+RnrQIqE/72Cz3NvgtO1o1sHrULE9B9EV7p+XS
    kcmNLWungT7IBPhxP8ZDOtSfRui7Stb6vxC/8+FxEYFw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=HeHkKh85 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PoNInVo5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=HeHkKh85 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PoNInVo5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751625AbeBEUDD (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 15:03:03 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40723 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeBEUDB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 15:03:01 -0500
X-Google-Smtp-Source: AH8x226GPNCv1qoz8EYZJEuTx4oyA/EQZLgqkw4U1kHsDZ6+IOJPIUk/lIZSpFcpu/E0oiZfYBt/rA==
From: Jin Qian <jinqian@android.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Safford <safford@us.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <james.l.morris@oracle.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org,
        Jin Qian <jinqian@android.com>
Subject: [PATCH 1/1] KEYS: encrypted: fix buffer overread in valid_master_desc()
Date: Mon,  5 Feb 2018 12:02:46 -0800
Message-Id: <20180205200246.12253-1-jinqian@android.com>
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

Cc: stable@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <james.l.morris@oracle.com>
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
