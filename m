Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518709792-2-15655036016768475345
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
    t=1518709792; b=wGB2w050IGiGukFMyaJyyhGM86kB+RFGYwu9Ovr/qx85H0Y
    0d3QgggXK/bDh7f0qWaurzL7vspMqCvRaFfEj5ixIjpjsqdUmK12wd6WPaDqjITR
    kRoo5oHRoASta9NWLgBXWxM5UJZpP36QyGpEzYjktbKwEZYjx4AvfPuePY7O3k07
    F7G34GTp0EGO0+jkf7jKcNoffF5OV7225/KmVMvXwk+JJWa+poMHd75OgRgVr0+i
    A1TZD5uabnHqXp3z4Te8KETA+fJ2DzjFbvahRmETtK6H8EAyvDxK9jLPkoi23+VE
    HV1ts2hdWC24rtxlrg5WpRPfdEdAmwQ4GTcZemA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1518709792; bh=UkFO0MA9Bdt5eF6E+gixuxzpza
    x4+99otMPDsnMnFU4=; b=p3zZwatDtYXG3FPl9S0ZIBmsJc0hpXh0Qwij+wlfVR
    LzQDMFCYNVkmtFJs1oTqnk8+qxJIoGDCE6ffQuV31usxbxVgLmi2Rr0Pko1fGJPP
    A1VH5oVrUYWHV7Kgtv/34qm67DvpKjSCaICVb2X1TpsdzSJRkSJz1TG4swVyMdM+
    0as5479z2bTQR+huV/wgi4tD8ubHECqog4D9EXVv+fDCvFwzTy/QhLtYphom5ayB
    tyK+83bGVXzfdtBqZS8BSMbQu2MbszbodiNMKrmlq8Y9XsMp8r/xCjXJQYHS2YF5
    XWxxs/2GBQhEWUlXrjgOG/2VDBNB+cFZ9EZMfYjO1ubA==
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
        id S1425038AbeBOPsJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:48:09 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36426 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425022AbeBOPsE (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:48:04 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>,
        Matt Turner <mattst88@gmail.com>
Subject: [PATCH 4.15 170/202] alpha: Fix mixed up args in EXC macro in futex operations
Date: Thu, 15 Feb 2018 16:17:50 +0100
Message-Id: <20180215151721.755805971@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151712.768794354@linuxfoundation.org>
References: <20180215151712.768794354@linuxfoundation.org>
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

From: Michael Cree <mcree@orcon.net.nz>

commit 84e455361ec97ea6037d31d42a2955628ea2094b upstream.

Fix the typo (mixed up arguments) in the EXC macro in the futex
definitions introduced by commit ca282f697381 (alpha: add a
helper for emitting exception table entries).

Signed-off-by: Michael Cree <mcree@orcon.net.nz>
Signed-off-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/alpha/include/asm/futex.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/alpha/include/asm/futex.h
+++ b/arch/alpha/include/asm/futex.h
@@ -20,8 +20,8 @@
 	"3:	.subsection 2\n"				\
 	"4:	br	1b\n"					\
 	"	.previous\n"					\
-	EXC(1b,3b,%1,$31)					\
-	EXC(2b,3b,%1,$31)					\
+	EXC(1b,3b,$31,%1)					\
+	EXC(2b,3b,$31,%1)					\
 	:	"=&r" (oldval), "=&r"(ret)			\
 	:	"r" (uaddr), "r"(oparg)				\
 	:	"memory")
@@ -82,8 +82,8 @@ futex_atomic_cmpxchg_inatomic(u32 *uval,
 	"3:	.subsection 2\n"
 	"4:	br	1b\n"
 	"	.previous\n"
-	EXC(1b,3b,%0,$31)
-	EXC(2b,3b,%0,$31)
+	EXC(1b,3b,$31,%0)
+	EXC(2b,3b,$31,%0)
 	:	"+r"(ret), "=&r"(prev), "=&r"(cmp)
 	:	"r"(uaddr), "r"((long)(int)oldval), "r"(newval)
 	:	"memory");
