Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2294769-1518724343-2-11602319357442241919
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='dk',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518724342; b=cAI7z+AJnwF55udrGFmufQl13dfFw/gtENQpqla9dpbnxsd
    zm855a4ZGjBbmE7MiG2HAVp7/QqcMRdy/hhS0fe0FO2vNupMOYQrtpV8AKRuSQ9L
    yPCnHUtAAKY76gwkIYFAPdY6sSoW2AoRUWj7PxVjeXIZGwcfFo0uLZiOmmL29ABr
    xY4oueOxR2xBVAbf3Hg9BkbI3PI8tQvftxUhmECqSVQeKaAru4hDoxn27otTIN61
    Oczv5cpXI236r6plDuMBvR59Pca/OMrFGNQSBX6BnQEUT/XY2p2FH5w3zDXBx2zW
    V1gmfO2Bp9kr+gh8Y872fEBYV1mbDzP+LhLGt8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518724342;
    bh=2idyaWE5G/QhfDNkGSXewicSNkoUYYWZ1yx9A6IXOUk=; b=I5dr98+r0ph6
    kgPGokMpFeainELKV4x4Sk/r/VMPlonWbWU32VN3vHj5B2N01cB+Y79TEUHb0Kt3
    696rUEULvbgm3jNKQS1Zy4E+amT0NPqgNIDna30Y99aXa6ay5VSQjpfCklAHgrVR
    EyjnCCqIevmYDVoZ6kurEXxJI/ebekTxZK9qPmamXMSl+bSlyn3aqC+fPi2ZspN/
    gRbcQFYQlqaznlN0TYmMi8A+xXu5i5AFotBYkfqANTU3rVP+HeSpENyCWYTivDPk
    bT3D9bgTfNxYr8VdIiJbiVEWxDSDxudiZeepjOqw3K1/0XiaDvn1S4eCpuJt21Ir
    aJGnuXF/7g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=dRpulLUW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rasmusvillemoes.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=X+zZq9gC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rasmusvillemoes.dk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b=dRpulLUW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rasmusvillemoes.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=X+zZq9gC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rasmusvillemoes.dk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033824AbeBOTwQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 14:52:16 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53911 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033454AbeBOTwO (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 14:52:14 -0500
X-Google-Smtp-Source: AH8x227QRDKntZzIp5W+NIqj6bERvFYALcbQAWP3yI2hluK9Zpwd90FDEUFyyOx6J7QwtdiIi4JEMQ==
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] linux/nospec.h: allow index argument to have const-qualified type
Date: Thu, 15 Feb 2018 20:52:07 +0100
Message-Id: <20180215195209.15299-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <CAPcyv4i-bULZp1WTUgUVtdEY5i_fTGkFWKBsVLDu6dsuxUwoug@mail.gmail.com>
References: <CAPcyv4i-bULZp1WTUgUVtdEY5i_fTGkFWKBsVLDu6dsuxUwoug@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The last expression in a statement expression need not be a bare
variable, quoting gcc docs

  The last thing in the compound statement should be an expression
  followed by a semicolon; the value of this subexpression serves as the
  value of the entire construct.

and we already use that in e.g. the min/max macros which end with a
ternary expression.

This way, we can allow index to have const-qualified type, which will in
some cases avoid the need for introducing a local copy of index of
non-const qualified type. That, in turn, can prevent readers not
familiar with the internals of array_index_nospec from wondering about
the seemingly redundant extra variable, and I think that's worthwhile
considering how confusing the whole _nospec business is.

The expression _i&_mask has type unsigned long (since that is the type
of _mask, and the BUILD_BUG_ONs guarantee that _i will get promoted to
that), so in order not to change the type of the whole expression, add
a cast back to typeof(_i).

Cc: stable@vger.kernel.org
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
cc stable because if this is ok, there will probably be future users
relying on this which also get cc'ed to -stable.

include/linux/nospec.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/nospec.h b/include/linux/nospec.h
index fbc98e2c8228..132e3f5a2e0d 100644
--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -72,7 +72,6 @@ static inline unsigned long array_index_mask_nospec(unsigned long index,
 	BUILD_BUG_ON(sizeof(_i) > sizeof(long));			\
 	BUILD_BUG_ON(sizeof(_s) > sizeof(long));			\
 									\
-	_i &= _mask;							\
-	_i;								\
+	(typeof(_i)) (_i & _mask);					\
 })
 #endif /* _LINUX_NOSPEC_H */
-- 
2.15.1
