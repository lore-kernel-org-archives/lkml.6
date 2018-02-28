Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-667456-1519839259-2-12742711268732907679
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
    t=1519839258; b=AEUXwP+cJkbFoAfnq0Ujps60DKLAEaYR6Oyj2lIzgYW+N8g
    BDf5i0lRRQJeVAqB64AzON76x327tnfVIdiuIE016BjaCvzaKs2/Xv7Rjyl7ShKI
    ymWm32S5mLnY3xUdh/dFAQxsBBgdE+rm5lNx1VVFWSiupOrYvGAmhVSie/LmyWqy
    ZBXmDhwrgkx5tm56jWWTwytz1yC9tphAcIv2uHIEZkU+3u/D3kFr+YXfYRqBOcTz
    RKgCdYVX91QO/A3QfN6l7JhIMTKRIiztaFLJQEHv17rjJACP1O5ZW1we2BjcwzOW
    C6YEdyedyv5SsGPhnpsaRU/6/FgbsOZewmaR2og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839258; bh=IxIYp6iE4qNuH6tllKt
    oegrw3T4CPKae51cVvZlRzbc=; b=roEukWQon0I7G2IJCh3/eRQj69rAML/pjSt
    2rWUuVh2XYmZ/W6HFytxjIdOowYNlGThTDmWUoCwPGFUbX8RObTXNOqoNUCpHlEC
    pWXe+u2i6EjkIbty3HK9lzP1HsvC5jATZlVu+9wts18IqYvZa869aXx1aGv7JS7+
    IqafKAIJAJD2WUuF9od/CJcPjIs5pWJzKzsPLTwmbL8u7dltbYHU9tDaKG42akVP
    2sogI3mBtlUpbLtK35feIvW0HX1Ok50juATEtG+TJqGHzY7XSLMWPKV0Pyn0E2xj
    Ey2JbpW9DVMeH0JWUX05karWvAmdhuAy7cIkVJ2d7yHfEx96iIA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933412AbeB1Rb1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:31:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33222 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932575AbeB1PWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:15 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Stefano Brivio" <sbrivio@redhat.com>,
        "Nicolai Stange" <nstange@suse.de>,
        "David S. Miller" <davem@davemloft.net>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.504430352@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 092/140] net: ipv4: emulate READ_ONCE() on ->hdrincl
 bit-field in raw_sendmsg()
In-Reply-To: <lsq.1519831221.703311959@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.100-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolai Stange <nstange@suse.de>

commit 20b50d79974ea3192e8c3ab7faf4e536e5f14d8f upstream.

Commit 8f659a03a0ba ("net: ipv4: fix for a race condition in
raw_sendmsg") fixed the issue of possibly inconsistent ->hdrincl handling
due to concurrent updates by reading this bit-field member into a local
variable and using the thus stabilized value in subsequent tests.

However, aforementioned commit also adds the (correct) comment that

  /* hdrincl should be READ_ONCE(inet->hdrincl)
   * but READ_ONCE() doesn't work with bit fields
   */

because as it stands, the compiler is free to shortcut or even eliminate
the local variable at its will.

Note that I have not seen anything like this happening in reality and thus,
the concern is a theoretical one.

However, in order to be on the safe side, emulate a READ_ONCE() on the
bit-field by doing it on the local 'hdrincl' variable itself:

	int hdrincl = inet->hdrincl;
	hdrincl = READ_ONCE(hdrincl);

This breaks the chain in the sense that the compiler is not allowed
to replace subsequent reads from hdrincl with reloads from inet->hdrincl.

Fixes: 8f659a03a0ba ("net: ipv4: fix for a race condition in raw_sendmsg")
Signed-off-by: Nicolai Stange <nstange@suse.de>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backported to 3.2: use ACCESS_ONCE()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/raw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -491,9 +491,11 @@ static int raw_sendmsg(struct kiocb *ioc
 		goto out;
 
 	/* hdrincl should be READ_ONCE(inet->hdrincl)
-	 * but READ_ONCE() doesn't work with bit fields
+	 * but READ_ONCE() doesn't work with bit fields.
+	 * Doing this indirectly yields the same result.
 	 */
 	hdrincl = inet->hdrincl;
+	hdrincl = ACCESS_ONCE(hdrincl);
 	/*
 	 *	Check the flags.
 	 */
