Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951738-1517591708-2-962575333768768474
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
    t=1517591707; b=nvbS/caI8Mbbk3+QMwdSnAAhuhrDsuybIAK0zs3wRe952+B
    pGeN/80UZjwg+um68olZ1qx9Fproj6aRtKV+Ze/cC2uNic6XqrrAOU5OKIJgwXMz
    kQSUUwpYNmqcwg14osX35glDQrXhH+hV5t1yM05S+GU2RcBwDMR6fUu61usmCIDn
    ouka/Yjkg9mQuJXjAipqiTdKNJKOxMjZWenfo/r+2W6kD3I7uQEoUZnzeXg4fTTf
    8CpPQFGqv55scDadVQ+eEZyCO0o1FKI7hzZXhiQ89NKwkdd3RklnJA76RGlTF3g/
    pTvvrdIHkBFGZQ57T8/ZPP+q4b5qShJxkjkNmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591707; bh=FjVij3vwgHk86QgU8Fto7I0W7W
    Hm4jJB7RdMG68BZ/A=; b=Kp6JJumb4l/9eLLt4KUIIt6WkMsXVipIE5wUdsbQR6
    8O79qRX6x4voJjtW6tVlz5HgkMOfCk+KAL4KFhVkk0wECVeXtpbnXSMKjGe1CJGw
    Ha5VfJ1/9ydICVRdqFhm/Bll4cqxH7Px9MbhPCp4BJ+qkCskgu4+0vyIwiZiy6Yk
    /kl7VN+e0iEIRY82Gh49x+wWVe+OXvsT3FKdjzKNUyTfnaa72jT8r8jnXnDMp1YN
    7EvlNm85JcFz2BjrXdz9glOpL4jxLQYde8cQclLp3XINZULNj2GlHfvqRqb6Nm19
    ZPK0VDkctB1nG4k4mxoGUOZr0BFROzuLGMB8/iMHsD0A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753703AbeBBRPD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:15:03 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:40646 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753698AbeBBRPB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:15:01 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Stephan Mueller <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.15 15/55] crypto: af_alg - whitelist mask and type
Date: Fri,  2 Feb 2018 17:58:33 +0100
Message-Id: <20180202140827.628846872@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
