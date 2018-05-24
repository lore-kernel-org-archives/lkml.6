Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2597100-1527197354-2-13361656090692831931
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527197353; b=OywfcWk5vL+yVGJl+UkNr4yKK69S6t9YuKhH8JoS2i8yLkixAG
    xaEK5b1uqt838k2HewkGUhW6wrIZdLlNOevZMO43TOh+tsSFk9yQEaUmjAGAfaD5
    L0MAY/jMRth6mhNOvLoN8vYx74l8aX0V6lL3ai1bOuN8hUmMLt4+wYQ/rmpt1qap
    yc2Dqf4slfaAM/cNHRTmv8FKZHa0tlIjY5bjMkYAM7ko3rs3E/RbF5TrdiAw2q+f
    cyiBChEQwBwDNFbTNcDh+vD288f95DSnYoDrxtcJRA/fen14a4EYJQj+WF81eZwT
    JKxqCUJAhcS+8j21UjH5jow1s28XfB3nFxgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527197353; bh=
    smEGRMMan+w+prk9mRuxTJjjwHwAbOXYTre5g45faww=; b=dBKgMUVCZ7BUERkG
    3S6RczYymRy7CPOKGKELMGWs2FQwrkQqNPdtd4m4mjlVGMDgpukn/6uO6ElwGwYn
    Um3sBRu5GeqzD2b4cN+9GAJEEQp3DYb6HTW+rqn9sU9r5xmWIFAVDSJtEShEZhyk
    i5lJadMp4j92zxc3B5jzT6ljg8WbpuCnTeZXdcFRhgrlFH0+eSQowR6B5a4EdTiM
    3BLL/YZJt7fH3OaJxpzIaOvrj2w60+zw+rUbEWa8KkXKQ7Q2VuTCa7QM82HRpl24
    XuUMpZIg3jE/eN4hA90fNw3KzNHDRS+bBM4iCKPYTRkRJ4H5iiEAfNrLIhVirbNR
    CvJ9SQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=stgolabs.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=stgolabs.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGsBfuODH0pnDYk6i/9azTdqlpcfghuNJ/cy7UiDNY9LMtNH0HcyGVal5qwJmP/9/rjbJwz8oHOvXiiJpY7V9zrrLDHwv3gd1R8kqUY0dM72U2ugTDtb
    FofFsZbtMkLICfcy4HQ8stwKDk4DQyU8+aryrjazzSw0NPaPiK60QD8/cyIGc34jDEoiA/m8z6torQa9v81z7Kivl7s9s8TjWcCYpcbKOG4w0HTVZERkOLMe
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=YVNbz6xi1Vcpfad538AA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161379AbeEXV2r (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 17:28:47 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:43496 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161377AbeEXV2o (ORCPT
        <rfc822;groupwise-linux-api@vger.kernel.org:0:0>);
        Thu, 24 May 2018 17:28:44 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc: tgraf@suug.ch, herbert@gondor.apana.org.au,
        manfred@colorfullife.com, guillaume.knispel@supersonicimagine.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 6/6] lib/test_rhashtable: rhashtable_init() can no longer fail
Date: Thu, 24 May 2018 14:11:35 -0700
Message-Id: <20180524211135.27760-7-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180524211135.27760-1-dave@stgolabs.net>
References: <20180524211135.27760-1-dave@stgolabs.net>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Update the test module as such.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 lib/test_rhashtable.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index f4000c137dbe..a894eb0407f0 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -182,11 +182,7 @@ static void test_bucket_stats(struct rhashtable *ht, unsigned int entries)
 	struct rhashtable_iter hti;
 	struct rhash_head *pos;
 
-	err = rhashtable_walk_init(ht, &hti, GFP_KERNEL);
-	if (err) {
-		pr_warn("Test failed: allocation error");
-		return;
-	}
+	rhashtable_walk_init(ht, &hti, GFP_KERNEL);
 
 	rhashtable_walk_start(&hti);
 
-- 
2.13.6

