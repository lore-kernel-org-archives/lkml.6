Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3369064-1520824062-2-10139512366308525487
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
    t=1520824062; b=mQD+6HMKdAUpbnqtxVPYFHBzbVXeKaryYjcMu6HApXlc3iS
    BeOohYcLk2DL3dJ0EYDmHdMr92u+NB703hTfJOzYyYOaXkcnd0SkpkTeUCdL7lGW
    cc0XCC1lk2XpYK7EyPJBuWAvOp0ahePXQ7y16WL22GjOwf/Z8o/4wyJVtJ0Xs7G/
    /HYFhQvm9XcDdqitMvroQp0WoanLwox+s6kgskQi7O/BkK0FFK/p0UsAFt1QRV1k
    NdCxj3RPUlTybUkXgNHMQqBbI1Ivq6sP/PnOpZNA5ufSsXb4k8eJuAnsbpawH+PG
    rH5w08RQc5J3EJD4XbAA3GDeAxUB5gHX3VKW4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520824062; bh=P3Lcf0qUw9sNOnxosuK
    SNJdlMi9PK/X0UETjyuLzTcw=; b=vwKJ8/rlJ/Vp4EppbA+67IbC8NEINLrwK2Y
    hTRYsX8AcUg/h9mvuk2oViYVY/SR4rEmxDvx+BLtNGx2sZ9yA0yLf27zj6WvIKLZ
    rvm3V47AQP86vbDH+Ml8Vq5JxrIZcx8s3+ljTAujwZ3ggdY2JGQ87fuZ1PXo4EDF
    OOzAu3isNz2Dz/r5NlQC6NT0rc7wQAKuMYFiegCX6TOeAFzGycs05TY9yeVsuXPI
    n9fo8aUgbDreLnRNirut1C4dvSzxRIE3FWwuAIu4wCqpiPaxIuC20+I7Xp8iv022
    DSNJMBN7XdmSULd4qj2BeOa9wpaX9xwWZgBC5SP213p6zJMG7QQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932593AbeCLDHj (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:07:39 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41010 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932437AbeCLDHi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:38 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, Han@decadent.org.uk,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Han Shen" <shenhan@google.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.204216515@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 011/104] Removed unused typedef to avoid "unused local
 typedef" warnings.
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Han Shen <shenhan@google.com>

commit 6b13eb1baa17b8746f96bd536d2897ec86e823d9 upstream.

Fix warnings about unused local typedefs (reported by gcc 4.8).

Signed-off-by: Han Shen  (shenhan@google.com)

Change-Id: I4bccc234f1390daa808d2b309ed112e20c0ac096
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 fs/compat_ioctl.c | 1 -
 1 file changed, 1 deletion(-)

--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -608,7 +608,6 @@ struct serial_struct32 {
 static int serial_struct_ioctl(unsigned fd, unsigned cmd,
 			struct serial_struct32 __user *ss32)
 {
-        typedef struct serial_struct SS;
         typedef struct serial_struct32 SS32;
         int err;
         struct serial_struct ss;
