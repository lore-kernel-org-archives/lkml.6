Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-667456-1519839336-2-235174734108452331
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519839336; b=Ohy/nzXfZAOiIk5GHlSjolusMtIVCXd/ez7nAVmOGPfkq67
    7d4fYHe75E/s7HtqT/zwMQvRs9dATxvRsSj9TiJsM9aCztbfl0nNa9/xG3RRyc0p
    6NHyIos3hDhhv7n9J6TtaXGBSs6J0TLGp+bOpDwc3yzW2LTfnsHNb639ckLnS8P3
    l1Vgh0Fzz9fctdo1X1jwSJo2mgiD19PZRJr3Ln8By227hJBWDWUhH5aScXN+pG4g
    J+X5I5RKvjYD1gz7JcIU91ocWdwtlHp2WU+HrPa/6LwsbLBFFILCKjdN6zjhgfEY
    5gBuzTus3e0C93WU6VMnAkz5/kdKviawj1HshvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519839336; bh=HPR+gVKAC0eHJohBGJq
    WDzCexZoe5g9aWVBgychgsdI=; b=YeD51OrosidMn/lAAOwFNS7URO9XlL+hOPO
    uB3mfFS5RpYAWu5xlxH/Fv1LMB7brmd77Tp5QA124TaFoDSfCvGMNllkKC3WEAhL
    7KWW873P9fZ1EmNwsSOVSEozGub2nZyaBcc3XVt3on3TfSdqAXjBFCK8y09pC95h
    PPnaihhOLkSx6Gl/UCjz13jFLn25hENWWSslQAQoQFEePI/PlTswvmOAC0SqMWd5
    Kt4/C2NgwO7qi1a/gaLsJNSCnQcyRdceqVIJxvisUmCzY3a9KV3Gt/0KtzF+D/5/
    ROz/CEGi4ezw/RCGlRHVHm1nS3L/Yj3mdP90GayFxTpUhhhUBeg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933918AbeB1RfP (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:35:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:33196 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932549AbeB1PWO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 10:22:14 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Joe Thornber" <ejt@redhat.com>,
        "Mike Snitzer" <snitzer@redhat.com>,
        "Alasdair G Kergon" <agk@redhat.com>
Date: Wed, 28 Feb 2018 15:20:22 +0000
Message-ID: <lsq.1519831222.555274688@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 105/140] dm thin metadata: introduce THIN_MAX_CONCURRENT_LOCKS
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

From: Joe Thornber <ejt@redhat.com>

commit 8c971178a788c70e8d6db5c3a813de1a1f54e5b7 upstream.

Introduce THIN_MAX_CONCURRENT_LOCKS into dm-thin-metadata to
give a name to an otherwise "magic" number.

Signed-off-by: Joe Thornber <ejt@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/md/dm-thin-metadata.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -80,6 +80,12 @@
 #define THIN_METADATA_CACHE_SIZE 64
 #define SECTOR_TO_BLOCK_SHIFT 3
 
+/*
+ *  3 for btree insert +
+ *  2 for btree lookup used within space map
+ */
+#define THIN_MAX_CONCURRENT_LOCKS 5
+
 /* This should be plenty */
 #define SPACE_MAP_ROOT_SIZE 128
 
@@ -669,13 +675,9 @@ struct dm_pool_metadata *dm_pool_metadat
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/*
-	 * Max hex locks:
-	 *  3 for btree insert +
-	 *  2 for btree lookup used within space map
-	 */
 	bm = dm_block_manager_create(bdev, THIN_METADATA_BLOCK_SIZE,
-				     THIN_METADATA_CACHE_SIZE, 5);
+				     THIN_METADATA_CACHE_SIZE,
+				     THIN_MAX_CONCURRENT_LOCKS);
 	if (!bm) {
 		DMERR("could not create block manager");
 		kfree(pmd);
