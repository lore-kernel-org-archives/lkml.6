Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519832865-2-9411583544414264125
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
    t=1519832865; b=d+OuxgEeFQKw42HOWppcv8RgzLaCaXt/6uhPYkXX0GtWoZU
    dWoILWf8V99yk1wfJbcY3ul6XLXWHHFqYCL9t8xAx40QbLDm7w5RWQJasi5dRNI8
    cLV+JHLycbxXtcP65OULwkkqIZa6xfxfpVltx6/H2cbfxXLn420HfGlO9dfeEpd1
    45P4eeID+kQ1gZPOpm/GJzRV8ASNrAoGAfFOFtCfjt9EI7ZyIG17Xh+r1u9p3Onu
    IWLqkYL40e8bWs1Ne/CQj+UqScrs1W0zClHsdsrs0Y0RG8EdsXdrsxoIVRNzUes6
    8odntHyPV2raS0TvXAD9U3XIDcjhDoFgqlRjexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832865; bh=I7It1HfDwJrBciEZRvV
    Gd3VtTbdOmZyYLTCj3wlyVhg=; b=fZRxgdwCV/RvpMT/NvBOgE3XgKI2vvFK2/X
    Rja8MBK0kIjKxJxKWxuWzTzfk/Ey9tjFbn/gm4KJvkVu2oBFqMx0gS5xJTGGuVVj
    62iHPvBuEWOItaQw6B6wiuM20gamkPSk0JpA4I++E52m7qPnI8TgYavJY7nWlDKJ
    /F96CfxThi+u7UhfEL4cf8l1D+xmxA/3aTUtMkpuoSaUwa/m5TAN1NbNQwya/EH+
    ro/ClcAyWpJnZADH2hSDU/2IRe0mioFJmQJN1TjwQ8Xhyb4Kw2u2yFMygpLN574d
    yt7OBimFLGbbvEdNyPhI+EaaDlkLM+1+pdDmNXJnBZzoDZq9Hqw==
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
        id S932922AbeB1Prl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:47:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33338 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932631AbeB1PWQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:16 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "syzbot" <syzkaller@googlegroups.com>,
        "Eric Biggers" <ebiggers@google.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.706618044@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 083/140] crypto: algapi - fix NULL dereference in
 crypto_remove_spawns()
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

From: Eric Biggers <ebiggers@google.com>

commit 9a00674213a3f00394f4e3221b88f2d21fc05789 upstream.

syzkaller triggered a NULL pointer dereference in crypto_remove_spawns()
via a program that repeatedly and concurrently requests AEADs
"authenc(cmac(des3_ede-asm),pcbc-aes-aesni)" and hashes "cmac(des3_ede)"
through AF_ALG, where the hashes are requested as "untested"
(CRYPTO_ALG_TESTED is set in ->salg_mask but clear in ->salg_feat; this
causes the template to be instantiated for every request).

Although AF_ALG users really shouldn't be able to request an "untested"
algorithm, the NULL pointer dereference is actually caused by a
longstanding race condition where crypto_remove_spawns() can encounter
an instance which has had spawn(s) "grabbed" but hasn't yet been
registered, resulting in ->cra_users still being NULL.

We probably should properly initialize ->cra_users earlier, but that
would require updating many templates individually.  For now just fix
the bug in a simple way that can easily be backported: make
crypto_remove_spawns() treat a NULL ->cra_users list as empty.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 crypto/algapi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -163,6 +163,18 @@ void crypto_remove_spawns(struct crypto_
 
 			spawn->alg = NULL;
 			spawns = &inst->alg.cra_users;
+
+			/*
+			 * We may encounter an unregistered instance here, since
+			 * an instance's spawns are set up prior to the instance
+			 * being registered.  An unregistered instance will have
+			 * NULL ->cra_users.next, since ->cra_users isn't
+			 * properly initialized until registration.  But an
+			 * unregistered instance cannot have any users, so treat
+			 * it the same as ->cra_users being empty.
+			 */
+			if (spawns->next == NULL)
+				break;
 		}
 	} while ((spawns = crypto_more_spawns(alg, &stack, &top,
 					      &secondary_spawns)));
