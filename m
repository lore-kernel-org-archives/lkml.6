Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-449106-1519833312-2-16449905721684381328
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
    t=1519833312; b=duS7haHEK/2qJTsQUE+fK6suTeu5DGO8RkbdP4+cMHjTYCw
    Qc7gBHFYKUqV1wznBq03FydZl7Lkk8aG6CgtFfeiRX7PiGFsOqtcpiHRTKBgpGog
    lM17eAI3ziw7Ky5H74hLae4hoaofsYtRGKZM/aYiBxfmhMZ1dXZO7lw1LFcyp57D
    fSfSB5NHyLYOIC7AosoSBUoOzTe3zxF0jG4vRUcXFgWV8Ed9+UeSMrR2pmAY8Hdl
    5jEnhMj9YzuZiyVbxg56Z58Xo+ruABtN5XIlUUrk/iZGmM7zSYZQtE+jm3TfEqYV
    ZsmD9QeKD8PfdMymlGbbHGynGNADqkZ9SFdqHUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519833312; bh=KWG6p3qumO30HvKGLFI
    LQbsEMIfC/gusQ9ysnqplXkU=; b=cPQxIJlFGP9imamiWJo23ZjcBWTr+vy03GM
    OMcPO8jzwS4gfv5lWT9G8e7p3z09sGHgoPRKZkrtAqOiJYcsT+EiT1atIGn+TyeJ
    M8LgtDzw95Uc6dGQX1a52Zm6v3WuC9OvPyXslkfnNw1NV01n6zbuNbYXSJ1b9NiM
    pY/7LylWrvW57uEOjhI6ImyL+DKH/ZtD3IMlZ4fGAiei1qahu7+b5hcoU7AmRko1
    rGJAF+Vb9E0k1zcS3I7pWl0UVBkuWNF3cL1LRZx5jE+jAgeaiTSX7cGKmGsHDmrd
    rt2C09NOPpFxjBA9L2shsSxN8Md0GeCQSlXkP9NWKcqWaKVymPQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932678AbeB1PzI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:55:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34449 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933722AbeB1PxY (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:53:24 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Nicolai Stange" <nstange@suse.de>,
        "Stefano Brivio" <sbrivio@redhat.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.307656752@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 195/254] net: ipv4: emulate READ_ONCE() on ->hdrincl
 bit-field in raw_sendmsg()
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: use ACCESS_ONCE()]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/ipv4/raw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -497,9 +497,11 @@ static int raw_sendmsg(struct kiocb *ioc
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
