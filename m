Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1511654-1518326254-2-10203571076491878194
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES encaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326254; b=BIp53CLLBgWUGxjJzF+Q+C2UGRE1gzmrQidMRXcGNXGiqN+
    S9MgE4tCkG7ISkDqQUVns7qfnhSISVClT0haxaMRSpa+ZEucjMZuK6E8PF3nbSz0
    7vKHmWEVwCx7j1vvN58zbDxcx19bmN3Xh7y0q2xkoqyR3OC/zsLAHph/gPX9hJpe
    zakJrkI2fX1mbaldqbdmKGlTCnI6pxZij5hyuFmxhzqqNGwHuRCKh3KMSZIS0Ohr
    BJhx3GoriPxuVUViNeTDHJ5OlWcA/hIxr9xJ1UsewO4Cks75G4jjgKP3NFg14FGt
    OeMmnP+J4P7Hy3Jzo8K5fPfnn4hpZm50Ajt5uFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518326254; bh=2cvaIscfdjbHE17aB/j
    AlbmgqWIzBZUz5Z5ALQTBFK4=; b=J0/qOkiRwTt0GLsvlJnliBYMaGUAcR1Ih1E
    CGqmYGCZqQJeS/v8ZKh+Jnj3suSGZX2D23t/+fWnFcjq2RItcizaGiQBqxbez0gM
    MyDimXGtxUpalskcx3hCyEZClQvREjgvSPmCc7LAqw2Bq7EoVtBv0yruABU1qyei
    N0vjGiZX7aZqN5QolQkoHNPYig5p7UcnSSwIPONCF+EwLS0488iylJnDGL1BM4bx
    +ZXtgtzpR9sNLZ5PbMPhOYl+qU0dXMG0DKT/Eq3CGvkkgNYavpLIwASi+INbRjcA
    UBkQPe0/yYlVR8jMLcRYfISpBYtkN7HYH/SJH4RLi7gx9xicHOg==
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
        id S1752697AbeBKFQv (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:16:51 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41363 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752584AbeBKEdl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:41 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Mauro Carvalho Chehab" <m.chehab@samsung.com>
Date: Sun, 11 Feb 2018 04:20:06 +0000
Message-ID: <lsq.1518322806.400379635@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 77/79] [media] cx231xx: Fix the max number of interfaces
In-Reply-To: <lsq.1518322802.943358572@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.99-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mauro Carvalho Chehab <m.chehab@samsung.com>

commit 139d28826b8e2bc7a9232fde0d2f14812914f501 upstream.

The max number of interfaces was read from the wrong descriptor.

Signed-off-by: Mauro Carvalho Chehab <m.chehab@samsung.com>
[bwh: Backported to 3.2: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/video/cx231xx/cx231xx-cards.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/media/video/cx231xx/cx231xx-cards.c
+++ b/drivers/media/video/cx231xx/cx231xx-cards.c
@@ -1070,8 +1070,7 @@ static int cx231xx_usb_probe(struct usb_
 	dev->vbi_or_sliced_cc_mode = 0;
 
 	/* get maximum no.of IAD interfaces */
-	assoc_desc = udev->actconfig->intf_assoc[0];
-	dev->max_iad_interface_count = assoc_desc->bInterfaceCount;
+	dev->max_iad_interface_count = udev->config->desc.bNumInterfaces;
 
 	/* init CIR module TBD */
 
