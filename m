Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520824350-2-1952686379751150794
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520824349; b=NtM/7WFyfXZWK4dIWn3ccVxG5cktnSvzi/0sSWw63peLGke
    2zcKlHKSsD91284EC8QSemP7HTS4g+D8D37S+7PGSfIE53vsZz5MxL/ibxmu0jJk
    iId9DNYXnLfsQstRLU46HRJkSupZUeZdHtDI6aMGJ/bfpmpv3Ik2h5dHbxI3v5jF
    z0JiTdiEcnJ4i5LlIaZDPmfz6Yojeq1jsUvDePv9JA0LIMr5XMkEkNWRZcxhNuGL
    1e7ILNV8l8GYy3LfAjQFmTtduJNdlJJbvikcU1ZGRYysBIukcdAo7R2Dqo/wGECC
    Li1T6a/1arU4EUc3h3uUJofm6TgeBnBBWwW79bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824349; bh=RwGHsn7JtBI0S0ALS8Y
    VUGGwnEFQrslcfodGpOplwkI=; b=G6IIO80KopC97AY3pXl8w3wADdagomdGxGn
    kgDneHVePlVFT9S3MPSIMn2qhyga7DWvXVnSMdizWviNAnXtyLioYl2ZPenWdkvL
    zcB2rTkT0eELSRjiSlUT1DGilhw5KoQJBHltZGqd+FRKIOFG3z4Xn3HenwL/n+Xb
    Ur5yOuGzDES2kIPTXcyLz8l0LMuPrOeBc9YgENQwaqflXYiiYpc19s3O8XmhXBlP
    x2bVBeQKV8X1LaMqXSw5XVIEJEgvx25kKExnschdTo/kmoXCV/ZY8T0GwMWXLrFn
    lvjQalZ41P4hq/b67TPjialCfw8ddvJLF+3LOJ8xG8WLAl9oVjw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932764AbeCLDLx (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:11:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41597 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932807AbeCLDHw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:52 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, peterz@infradead.org,
        "Thomas Gleixner" <tglx@linutronix.de>, karahmed@amazon.de,
        "David Woodhouse" <dwmw@amazon.co.uk>, bp@alien8.de
Date: Mon, 12 Mar 2018 03:06:12 +0000
Message-ID: <lsq.1520823972.918934372@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 63/76] x86/retpoline: Avoid retpolines for built-in
 __init functions
In-Reply-To: <lsq.1520823971.5976735@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.56-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 66f793099a636862a71c59d4a6ba91387b155e0c upstream.

There's no point in building init code with retpolines, since it runs before
any potentially hostile userspace does. And before the retpoline is actually
ALTERNATIVEd into place, for much of it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: karahmed@amazon.de
Cc: peterz@infradead.org
Cc: bp@alien8.de
Link: https://lkml.kernel.org/r/1517484441-1420-2-git-send-email-dwmw@amazon.co.uk
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/init.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -4,6 +4,13 @@
 #include <linux/compiler.h>
 #include <linux/types.h>
 
+/* Built-in __init functions needn't be compiled with retpoline */
+#if defined(RETPOLINE) && !defined(MODULE)
+#define __noretpoline __attribute__((indirect_branch("keep")))
+#else
+#define __noretpoline
+#endif
+
 /* These macros are used to mark some functions or 
  * initialized data (doesn't apply to uninitialized data)
  * as `initialization' functions. The kernel can take this
@@ -39,7 +46,7 @@
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__section(.init.text) __cold notrace
+#define __init		__section(.init.text) __cold notrace __noretpoline
 #define __initdata	__section(.init.data)
 #define __initconst	__constsection(.init.rodata)
 #define __exitdata	__section(.exit.data)
