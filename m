Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-659992-1519838132-2-1215031283150122719
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
    t=1519838132; b=T4jfKvhqvph2uhHjUVUrW3m4g9/aNwM5APIEgfiW8qOSrmv
    iGXNzdpP294LO0z7y2+5CHoUhBoqARsJy4Q4FIB1Tlj6gxUNG1XgVX4q9jyftE9W
    ERj6bNPa7riRJEzYfd5QfvmnofoxZamA42bW8rk63NELv9xFVH8Or66vWpvO7Nu4
    OJVjZwE3tRMlkd2ZtYHoCDQSp4e1UoCtaMHA7kxJ9BV+cOtnvRT1u049YLa3J7jk
    Tinw3F2XP2on2UfuvW8CE90e5tXQtqtqPQDQ42+r+Wk6O/G+K4wa7V0vceNF98MJ
    kCoOtiU/YSbeQrPIU6pCXet/QuwPzBsXaXQ8/IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519838132; bh=KrwUX8otOokyreuF+sw
    ehrolTbR+ACNf/Hoq20kz3r8=; b=ov6ripSd9nn/xPCklABrVYx/zGwK0IWNNoG
    pSF++OweuICCvVkjxOr/ZV0I4x8wTkn+iOgvMfZk8Zr6V9AwIzhLivgQ62GeB+xE
    VWcdHWoZUeO5VNPcpMwnZCIhQF3PYTUr4xdYNFg07TipOiaGRTCJAJNcOjGezx/E
    mMieq7Hj4BCeYLGvuGMVzEvfc1Gbs7FcFIKlAO/Fr4SO3LbDgouiftDU0dk1nlYY
    MHsH1xsfRfZrWNNhanKersd6Bs49UObggVD8frcJp4hnOvz0s9KzCbvlSnwqK9IP
    y6ADbtfM1HUXQX/g+GfKWb4abfFjj1PQBAMD63Z9Ea71kFwxVOQ==
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
        id S933534AbeB1PsU (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:48:20 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34249 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933190AbeB1PsR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:48:17 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Johannes Thumshirn" <morbidrsa@gmail.com>,
        "Mike Snitzer" <snitzer@redhat.com>
Date: Wed, 28 Feb 2018 15:20:21 +0000
Message-ID: <lsq.1519831221.433567897@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 028/140] dm mpath: simplify failure path of
 dm_multipath_init()
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
@@ -1661,16 +1661,15 @@ static int __init dm_multipath_init(void
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
@@ -1683,16 +1682,23 @@ static int __init dm_multipath_init(void
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
 
