Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-564561-1519836505-2-12722313464491721006
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519836505; b=qooNot+qq6cTHRqA7Y6n4VjCR/znSADJ9M+KAX/xoGjOVqy
    f/VcZtgCYItXlKMWuXYWcJbF48fcwd/f2npbsiERmTcS/V8evBxDyBnX+wXqvTHh
    NecpckrASAPJ+LsiHiNiANWho9H8BRMOME/XJx9GmmtbAPWVvXkt0HSFS8U7pTpF
    R8yKZnJPNRLEHl1WKFIzc2lCz15P9m4h0gkrUaDTm5LBJc53WOLPMXCnOcBIp52Y
    qftH4xs7fYbbGjpXo8O+zRCEUNjn1iwrFi5DvPPsTG2XcBtRu1Z/NVQ15/ILkdh4
    yqJX9/ZDsTtZrIbvtENwiDfIkLHMsUJEuxCrYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836505; bh=4P/lSpeZXBf95rHmGOu
    /AmHwMygXOIkZFRvUC2wUTdk=; b=WpexCHAC1fZ4NPkFpghiI8pioyDp0s2SSjF
    342hapxYUjEw6lM4+7kUfPYi2QF9Z25R0UsIVaIWl3SuP8mig+zbmwFSZB7OTwY2
    /ubClhAIP0py6Gm5rKb4rC1yDvj3XihnF1XaJqbyPISSbSMZRl2Jaj4BV1kS+TvX
    b/0eGepmsgYFuPpxf4K/16pJAfkNqz44XCRcqR/248UtmXdVtHmqYk22ROq6JX1J
    kwJmT9EoJHE9D+K7HQF+SvjoFkFB52tF6CLFZnXw5yt7YXGVXolAW6nk6ogZWWAO
    lSyd/ZcBM6MpZvt47J4BtNFeMfBY/Xww4l8Xkeb9aYmZsE8lsRA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934312AbeB1P6x (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:58:53 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34584 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934293AbeB1P6v (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:58:51 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Eric Biggers" <ebiggers@google.com>,
        "Steffen Klassert" <steffen.klassert@secunet.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.748200960@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 151/254] af_key: fix buffer overread in parse_exthdrs()
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

From: Eric Biggers <ebiggers@google.com>

commit 4e765b4972af7b07adcb1feb16e7a525ce1f6b28 upstream.

If a message sent to a PF_KEY socket ended with an incomplete extension
header (fewer than 4 bytes remaining), then parse_exthdrs() read past
the end of the message, into uninitialized memory.  Fix it by returning
-EINVAL in this case.

Reproducer:

	#include <linux/pfkeyv2.h>
	#include <sys/socket.h>
	#include <unistd.h>

	int main()
	{
		int sock = socket(PF_KEY, SOCK_RAW, PF_KEY_V2);
		char buf[17] = { 0 };
		struct sadb_msg *msg = (void *)buf;

		msg->sadb_msg_version = PF_KEY_V2;
		msg->sadb_msg_type = SADB_DELETE;
		msg->sadb_msg_len = 2;

		write(sock, buf, 17);
	}

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/key/af_key.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -513,6 +513,9 @@ static int parse_exthdrs(struct sk_buff
 		uint16_t ext_type;
 		int ext_len;
 
+		if (len < sizeof(*ehdr))
+			return -EINVAL;
+
 		ext_len  = ehdr->sadb_ext_len;
 		ext_len *= sizeof(uint64_t);
 		ext_type = ehdr->sadb_ext_type;
