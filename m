Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3369064-1520825218-2-16128563666003202104
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520825218; b=vwhdE1qXYXntp8rJpYnNdRSTkabAYqli6UAYy/xyZhDOkDz
    0qEB5qa5cXn706SHmZY69tU2y6qKPqeU6oVkohlIoj9gOOxkeBQRu5+6mvnyFwgj
    PNnTL83NEQ+76Z/e5Q3BfiPC4K5qlMGwTJqzvXKLCl3IVJ2CLZZTu0yRk5sk8EOt
    sHCoki0bRqUMRN61peuRL08c3aja2HAADbK/DyNYKqbB92JifIOd+iCoArd3wpSc
    +HiCxQzAz+Vqv3LJyFrEF8hkbkkyotGur/XnSjIIFGUWUAIGHrBR0cPW9Cr21wEK
    3ZAVFvid6BNdbXrcBrjy27fUm1PY12zCgbgil9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520825218; bh=0l36Rlghu0mIP1CSBsx
    w1JdsnPB09UBviavxXrZBk+I=; b=JiY/lsanfMjKd1Ru91RY6jHfUJjiXLSQ1xc
    OyP13QztfVu0i5IqCjkHX5d8d+X+5QAhR7jEnkd+Bb3EVpSTpQv5eJnxr8V0v7XM
    OIuFTfOW04NvY/SVNYI1WcEAPRNExjrf+I5LkpoNDViZs9Y8UPe4KMo9hxQGb1Du
    obIZ+KMR3wHvgwJHk4YzjTrudkpzWcFnk3yWXv1CL2Fu6kDpWjQnXPMWneS9fHfS
    iX2FRLIHOjpv7auA+IRnBfg94D4Xv5H1+caZghwa6MmpSOp0OTBaJLkc3D3kSktI
    YoYENsogUC5gpG9wmq7XSNUmBJrK1Ly6GJD7mR+iRIOOnZhqXjA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
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
        id S932750AbeCLDZ2 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:25:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41232 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932686AbeCLDHn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:43 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <mchehab@redhat.com>,
        "Danny Kukawka" <danny.kukawka@bisect.de>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.800740796@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 023/104] [media] max2165: trival fix for some
 -Wuninitialized warning
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

From: Danny Kukawka <danny.kukawka@bisect.de>

commit 32d7e63c1f4f86ad18404e3f36be99c9910fae9b upstream.

Fix for some -Wuninitialized compiler warnings.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/common/tuners/max2165.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/media/common/tuners/max2165.c
+++ b/drivers/media/common/tuners/max2165.c
@@ -168,7 +168,7 @@ int fixpt_div32(u32 dividend, u32 diviso
 	int i;
 
 	if (0 == divisor)
-		return -1;
+		return -EINVAL;
 
 	q = dividend / divisor;
 	remainder = dividend - q * divisor;
@@ -194,10 +194,13 @@ static int max2165_set_rf(struct max2165
 	u8 tf_ntch;
 	u32 t;
 	u32 quotient, fraction;
+	int ret;
 
 	/* Set PLL divider according to RF frequency */
-	fixpt_div32(freq / 1000, priv->config->osc_clk * 1000,
-		&quotient, &fraction);
+	ret = fixpt_div32(freq / 1000, priv->config->osc_clk * 1000,
+			 &quotient, &fraction);
+	if (ret != 0)
+		return ret;
 
 	/* 20-bit fraction */
 	fraction >>= 12;
