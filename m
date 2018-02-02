Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2879036-1517591268-2-12272333507570141588
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591268; b=cb6hdYfWhXewEftZxDhrlxVnqxPhflXks8RauAFiBRPc55O
    FOr8VZoNx+RR9i5AyeFRkH5zHpgn8UMUNlhCbcqB05wRVchcYb+PPiLqC3q9FDtQ
    m58JQ3gh5gIGBzcqxqAWPZK/KgVfcq3ew6dv8tEiwqEjEXoEvGx+XF3Z3aw+eBU8
    am0Ejq784r3GoWLZaKFDhLgFm/BsRreID0pyGuUe5HVvBHbReOYcDf+CThScrQcT
    Yz5ZiaQFo766Igr/TbjB/eF7EjwfyPTClwkNTABpK6gt7esv776DqCwcFOetprSI
    soIvtTAghQVo90t5S4P95undz8rmSRpLQ5e3/vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591268; bh=fwKa0CmToxr4Y2cOWIu4fIzqZP
    h/6ZvNh3FTsm4ki+c=; b=qFkG1woOj4xU7jLvhmdMFIfQ+JmyPzgupcw/PO8WXS
    8dHvMbVuXKeO6OCkP/FH3+ff0Pv8AORGHPifd0ZrqOMOHgivMQ/9jvFpROq+PPFg
    ZheAmS0fQWU0sXRT54N+Son0DnBlyovqe406/xV9ZOBoNd/ER/59sXgJ0Z7lI6yi
    PU7Y8QHjoOJckwRGuoon6Vi6Zfl+b95DscIcDaKHfUDX3nWW1Umh1wT81IWpaTfV
    A9dxGrGb9dTmsTVYKlP/b/wiX20FD7SzkroKBcS8+aLsVrPNjOliVJg2V+f3h9oz
    W5CSbh3hD2px6lK5Ei9Hw+uWy6YEs91igkxKB2yzxzVg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752077AbeBBRHo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:07:44 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37096 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753163AbeBBRHk (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:07:40 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Stephan Mueller <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 019/156] crypto: af_alg - whitelist mask and type
Date: Fri,  2 Feb 2018 17:56:40 +0100
Message-Id: <20180202140841.185966767@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140840.242829545@linuxfoundation.org>
References: <20180202140840.242829545@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stephan Mueller <smueller@chronox.de>

commit bb30b8848c85e18ca7e371d0a869e94b3e383bdf upstream.

The user space interface allows specifying the type and mask field used
to allocate the cipher. Only a subset of the possible flags are intended
for user space. Therefore, white-list the allowed flags.

In case the user space caller uses at least one non-allowed flag, EINVAL
is returned.

Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 crypto/af_alg.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -150,7 +150,7 @@ EXPORT_SYMBOL_GPL(af_alg_release_parent)
 
 static int alg_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 {
-	const u32 forbidden = CRYPTO_ALG_INTERNAL;
+	const u32 allowed = CRYPTO_ALG_KERN_DRIVER_ONLY;
 	struct sock *sk = sock->sk;
 	struct alg_sock *ask = alg_sk(sk);
 	struct sockaddr_alg *sa = (void *)uaddr;
@@ -158,6 +158,10 @@ static int alg_bind(struct socket *sock,
 	void *private;
 	int err;
 
+	/* If caller uses non-allowed flag, return error. */
+	if ((sa->salg_feat & ~allowed) || (sa->salg_mask & ~allowed))
+		return -EINVAL;
+
 	if (sock->state == SS_CONNECTED)
 		return -EINVAL;
 
@@ -176,9 +180,7 @@ static int alg_bind(struct socket *sock,
 	if (IS_ERR(type))
 		return PTR_ERR(type);
 
-	private = type->bind(sa->salg_name,
-			     sa->salg_feat & ~forbidden,
-			     sa->salg_mask & ~forbidden);
+	private = type->bind(sa->salg_name, sa->salg_feat, sa->salg_mask);
 	if (IS_ERR(private)) {
 		module_put(type->owner);
 		return PTR_ERR(private);
