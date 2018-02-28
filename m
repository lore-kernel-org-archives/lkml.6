Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-617694-1519836654-3-5346169929827777840
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
    t=1519836653; b=swmYvQLDEStERMmB8T67uchriTXxFEDrVoIR4CVnmBFG0f+
    IB4n+HN88fANAOjFXfR7CgU8YViDAlOFKzl6wWY8u5zONX5CfO5CddggP6QgdzQg
    7UPiF2mKJzovyMvBqeWEfswyxYsArs9toGXOt1EdZ/Y8L8N3KbeU/3LI52UczJxH
    N0iqOAyuE6zywNEI6kteirOo9r9LoneeiPqUGSEjqTDMMnj4xxObS+FESqKwOxFN
    0HE678MdCdANOI1kYerk55/Lh2gIGODz3D8bQnxKq03E7xa7dJzAjas7mK5R0Jjz
    PzyH4uaHQ5YqjUBCXxSPvaoPZE9DU034en0J20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519836653; bh=tJuOYHWoAlkH2pfoWqv
    PzTUXb/6em9vyz0rqJFnTFVk=; b=UhaJjn6KU0LcAsFrYp9ss/6e/mehCZxxDyi
    Q8nf0870inH4iYvAnlxZl7G+9pajSyFOekG5u94v5WrvQbzmm0i7NMjui1cVjD3Y
    2jhOS/X+CBJ09VyY3B5VLJMmEoDqhHSdFlIVF8UYWOY6Vjfzix52pphDdKXYVWqk
    eXpykTqgk0tBaRnCrAMTuvh9umi4mg0KsBdnOl6nCrPuKs4KQ70soqOlExhGrMfR
    +2xbOb7ZeuNNuaJmsT0iPKzveo0Ns05L0HuV348faPml4AbZVOd3ttYzhqh7AYiT
    K5t8ZrNHyw3Z4bc7r565dhLS6K7ZnxlXQojxFWEHfL9WOhLCIaw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753008AbeB1P6W (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:58:22 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34554 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753002AbeB1P6T (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:58:19 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "syzbot" <syzkaller@googlegroups.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "Eric Biggers" <ebiggers@google.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.766402431@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 171/254] crypto: algapi - fix NULL dereference in
 crypto_remove_spawns()
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
@@ -147,6 +147,18 @@ void crypto_remove_spawns(struct crypto_
 
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
