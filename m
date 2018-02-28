Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-620147-1519838050-2-6625893155302809763
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
    t=1519838050; b=AGzhIUrADkUonbsnaUpccih/Q5nni71G3SKyS/VI+nkVTtf
    KGMawXl8qzV3IF4pSzO0MlGAEEY8b4GJ4IXz/aD1ew262zHdU9UG6TBTnPl1rFk2
    ihA/rsQmrXxcXQFL5JV6bIFhlPBpu7pTS5Q2SPM4HhZ0ta2rJ73/GGpD8A1qjAyG
    wPIAovWjOK5ryxgHBev3D8ISNdziHTtzhFiclDymqXLmfJWYMFHOa1EL2SNdfjZd
    IadwEFi5KCSy2AT3u0eEerh9swqz8FVd2zjJarvd8V0fixPswwj0ZpHzTndY0MlX
    1lMo7xgHUsmE1N05iibDqIAZs5BuBIq5CQi0T+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838050; bh=0XBsSQKWBwSxDRcgC4d
    gyo33mEmIf76uKkMGZczJkWA=; b=OYsgGaSlzBJUZ/klGvKctG8lX20d71dikKD
    bLd5X2+CD/rxIW0fto/4g2J1uqaVbmdZtwE59HYlXzsZEfaMZAY5iqe1tI7xTuMU
    Digiye2BstW/dZhfQFfAsJIpKPlvCqkGsOcJ3nnX+F7SIqeaVhGd6Z1oiGJMG4us
    62ND30OhzWEcKSRRbgLF9qTGKDYyYFJuFhT10qeafa5VOYTJJA5T+jnsItdKw4pO
    +lPFrNZ8Es/OJyzY1/HclpbqDIXZg+IjGIONkXHjiZocTvslpbH8JNSKNo/aaCwp
    Vxns7bxaUpVxHSz1mbP6/misoXb71gx79LdGQfnVtl+EmjljA+w==
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
        id S932696AbeB1RNi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:13:38 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34284 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752848AbeB1Ptu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:49:50 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Eric Biggers" <ebiggers@google.com>,
        "Steffen Klassert" <steffen.klassert@secunet.com>,
        "Alexander Potapenko" <glider@google.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.790897683@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 150/254] af_key: fix buffer overread in
 verify_address_len()
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

commit 06b335cb51af018d5feeff5dd4fd53847ddb675a upstream.

If a message sent to a PF_KEY socket ended with one of the extensions
that takes a 'struct sadb_address' but there were not enough bytes
remaining in the message for the ->sa_family member of the 'struct
sockaddr' which is supposed to follow, then verify_address_len() read
past the end of the message, into uninitialized memory.  Fix it by
returning -EINVAL in this case.

This bug was found using syzkaller with KMSAN.

Reproducer:

	#include <linux/pfkeyv2.h>
	#include <sys/socket.h>
	#include <unistd.h>

	int main()
	{
		int sock = socket(PF_KEY, SOCK_RAW, PF_KEY_V2);
		char buf[24] = { 0 };
		struct sadb_msg *msg = (void *)buf;
		struct sadb_address *addr = (void *)(msg + 1);

		msg->sadb_msg_version = PF_KEY_V2;
		msg->sadb_msg_type = SADB_DELETE;
		msg->sadb_msg_len = 3;
		addr->sadb_address_len = 1;
		addr->sadb_address_exttype = SADB_EXT_ADDRESS_SRC;

		write(sock, buf, 24);
	}

Reported-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/key/af_key.c | 5 +++++
 1 file changed, 5 insertions(+)

--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -397,6 +397,11 @@ static int verify_address_len(const void
 #endif
 	int len;
 
+	if (sp->sadb_address_len <
+	    DIV_ROUND_UP(sizeof(*sp) + offsetofend(typeof(*addr), sa_family),
+			 sizeof(uint64_t)))
+		return -EINVAL;
+
 	switch (addr->sa_family) {
 	case AF_INET:
 		len = DIV_ROUND_UP(sizeof(*sp) + sizeof(*sin), sizeof(uint64_t));
