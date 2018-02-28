Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-438867-1519832339-2-2276783373704363116
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832338; b=q7933afqc1qOBXouj8VtavYz6ZGoUMF2OjCMMPX+b1N7PDk
    glZHAAnoyR4v5ZIcvtbk4+/nJ+Zyw96ym7TQ6E1TxCYLWjmNDr7aq63cmaynAT2T
    M8W4VHq4jhL/WF+0LXuXqMOhsNxFhoq1TPrsiXWX8qpaNCn/cNvgBs89ncEfzGJZ
    wwTDIxXcqrNJ+SCK6+QY966uuFb5XdSZATsWQp0AfpjeBwD68rsPPFHshGKi6is6
    153Bs0lAwufX1uxgVUdhG/JsIjRuT15zxS2XoQxQXl6NncXDOv+z0gNDvavWXyhJ
    dtGPTRfP81bVs3Q2Hpo0C8aOPksSnXWM4W7sI3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519832338; bh=zC+Vg6pVFEvIFUYdPat
    7k8mwYmglBkyP3KC2V4sOKtc=; b=ownDbD+EUagPDyqHG3iAeB1MuBXbS/K9KNC
    MbRklRA/fVbeI6Bsah5ekXAntuRhzbtEjkZE5iZKSSb+NBiVb3q58rQEQSVwk6Ns
    h0YHBhswx2+wliiU3xl+aGKtkP64cLqfr5X0LTwC3q82m8ry28D7acT+KKAx7pVO
    9rKC5dBOg2xeVmT1gzrj2GB4pNvzutUbuXfe67Uzqj06FF2ETHf4URtqcezG7znu
    T9PjvDrizToCd04shuYUqHpa2VYENIJrFmGgOKRziDnn6LbEJnP7Yy+QNh47Z0xb
    YOzpzkW+B1C8maRoFRnfJa4Qo55ulJ2vsEy0yHdpO4wqMMeAB8Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932896AbeB1Pgj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:36:39 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33284 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752812AbeB1PWf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:35 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Johannes Thumshirn" <morbidrsa@gmail.com>,
        "Mike Snitzer" <snitzer@redhat.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.290831003@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 053/254] dm mpath: simplify failure path of
 dm_multipath_init()
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

From: Johannes Thumshirn <morbidrsa@gmail.com>

commit ff658e9c1aae9a84dd06d46f847dc0cd2bf0dd11 upstream.

Currently the cleanup of all error cases are open-coded.  Introduce a
common exit path and labels.

Signed-off-by: Johannes Thumshirn <morbidrsa@gmail.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/dm-mpath.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

--- a/drivers/md/dm-mpath.c
+++ b/drivers/md/dm-mpath.c
@@ -1691,16 +1691,15 @@ static int __init dm_multipath_init(void
 	r = dm_register_target(&multipath_target);
 	if (r < 0) {
 		DMERR("register failed %d", r);
-		kmem_cache_destroy(_mpio_cache);
-		return -EINVAL;
+		r = -EINVAL;
+		goto bad_register_target;
 	}
 
 	kmultipathd = alloc_workqueue("kmpathd", WQ_MEM_RECLAIM, 0);
 	if (!kmultipathd) {
 		DMERR("failed to create workqueue kmpathd");
-		dm_unregister_target(&multipath_target);
-		kmem_cache_destroy(_mpio_cache);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto bad_alloc_kmultipathd;
 	}
 
 	/*
@@ -1713,16 +1712,23 @@ static int __init dm_multipath_init(void
 						  WQ_MEM_RECLAIM);
 	if (!kmpath_handlerd) {
 		DMERR("failed to create workqueue kmpath_handlerd");
-		destroy_workqueue(kmultipathd);
-		dm_unregister_target(&multipath_target);
-		kmem_cache_destroy(_mpio_cache);
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto bad_alloc_kmpath_handlerd;
 	}
 
 	DMINFO("version %u.%u.%u loaded",
 	       multipath_target.version[0], multipath_target.version[1],
 	       multipath_target.version[2]);
 
+	return 0;
+
+bad_alloc_kmpath_handlerd:
+	destroy_workqueue(kmultipathd);
+bad_alloc_kmultipathd:
+	dm_unregister_target(&multipath_target);
+bad_register_target:
+	kmem_cache_destroy(_mpio_cache);
+
 	return r;
 }
 
