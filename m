Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518323898-2-11705836542944422914
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518323897; b=HX12xv6Mpa/2akoXhQBp23xUL7M9muEoqnrloAVhuHGt0j5
    oTKCOV5zQLICbz0ZBJbMm4ZWvJ4nBZGyxi3+TvPntIIjWCKnL9lB2pb1lP42LBOJ
    wymuQ/Tg1nM/Gv/MKhpuWiMudPYAcZ4zBJwUsP5MO4D7cDfAo8B6j0WdqI4l8wLg
    /1ZGtL7ruGjMsNPuj2SxBOIXRMtcjxbJOG0EI+0XgwqIjY0G5k6hcw7lgtZAQiSm
    mAZdntmS+AF0tRY3/JaGPMf3aUQoSw3UFYrcnMWbr2rwwgmfcB7dQzA2Jp/g3YKI
    RI9ca9lusRQfIt6IQR2i4Ml/OU2kw08iIk/dFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323897; bh=tA05e4SYEVLN8dqFqBN
    5CG8E13Jt0/8OuJcAUonXFds=; b=HbolfJ5BDwN2m0Y4qzeDnb5Cfi9yVqrU58S
    f4OQxodoL0Mi9E7KF+aJ1GygVPGGAjIkCv9Ize6nhCyfZ2nIQw6W6ts0hBAa+Duf
    8N9NeQwULzgXc7s7s9MHKcgy8/lwjFwLAKSlDPJNxf1jArtlNwRyabCVWaFhrNVF
    A/yAxiNeWFagd6+1HvdZ/qAjTIqJQcIRX9iFYzBJ3JnchS6IYyV/dL+U0uj4n+sb
    fLj7WtxvUsxJAqC4DUXBq+O7kzz5tb6DGm7plilLTPsziQtiH5zoahcqhlIybovV
    B9THKNSmNgsUbmMSawhoj/NsGa8NJQIVZNhP4KtKw0d8tEdPOyQ==
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
        id S1752901AbeBKEho (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:37:44 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41737 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752972AbeBKEeL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:11 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "William A. Kennington III" <wak@google.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.19123212@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 057/136] powerpc/opal: Fix EBUSY bug in acquiring tokens
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "William A. Kennington III" <wak@google.com>

commit 71e24d7731a2903b1ae2bba2b2971c654d9c2aa6 upstream.

The current code checks the completion map to look for the first token
that is complete. In some cases, a completion can come in but the
token can still be on lease to the caller processing the completion.
If this completed but unreleased token is the first token found in the
bitmap by another tasks trying to acquire a token, then the
__test_and_set_bit call will fail since the token will still be on
lease. The acquisition will then fail with an EBUSY.

This patch reorganizes the acquisition code to look at the
opal_async_token_map for an unleased token. If the token has no lease
it must have no outstanding completions so we should never see an
EBUSY, unless we have leased out too many tokens. Since
opal_async_get_token_inrerruptible is protected by a semaphore, we
will practically never see EBUSY anymore.

Fixes: 8d7248232208 ("powerpc/powernv: Infrastructure to support OPAL async completion")
Signed-off-by: William A. Kennington III <wak@google.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/powerpc/platforms/powernv/opal-async.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/powerpc/platforms/powernv/opal-async.c
+++ b/arch/powerpc/platforms/powernv/opal-async.c
@@ -38,18 +38,18 @@ int __opal_async_get_token(void)
 	int token;
 
 	spin_lock_irqsave(&opal_async_comp_lock, flags);
-	token = find_first_bit(opal_async_complete_map, opal_max_async_tokens);
+	token = find_first_zero_bit(opal_async_token_map, opal_max_async_tokens);
 	if (token >= opal_max_async_tokens) {
 		token = -EBUSY;
 		goto out;
 	}
 
-	if (__test_and_set_bit(token, opal_async_token_map)) {
+	if (!__test_and_clear_bit(token, opal_async_complete_map)) {
 		token = -EBUSY;
 		goto out;
 	}
 
-	__clear_bit(token, opal_async_complete_map);
+	__set_bit(token, opal_async_token_map);
 
 out:
 	spin_unlock_irqrestore(&opal_async_comp_lock, flags);
