Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2533607-1527197309-2-11167908116182058869
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
    1527197309; b=h0i3P50EL2/NpN/PG7gpRHRLwrq1MuMTFFmpM8ELBOUbv+asg0
    aIpU9hGrDCUxwp509Z6SmG+oCTLP29nCT2dtpe3Hg9MSEyLMvmTSpUeke7kjireQ
    xlFAQtwMEj4KfMNX9xaCFXUnhx+O1OwQrkyWLBhuOctgPI95jLI5S9yQOGxo8H6Q
    xmfiEV9XrgbT7AzH0T6Z/7I/pq2Iw1+p45ARMAi/+49zQ2pjHTAfKcrCBwHqxD71
    /dfDQorD48EXhHGAh+jh7P0vQL8nLocE6hLUpNvMnQoGxWox2nnPHe/R7EZRBJpq
    9UPFHNOTgjZS8swhL4+E6aQu3jrRlYdWs7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1527197309; bh=
    5aATGwcE3zWoFQ/1suLEZp33tfcbfacYJ++7B/g+1c8=; b=JXW1S/hQh88Iyrol
    yE3m8h8gk1qS5GdRr7FvIKVUueOpj7VnPgcVktD4pVmiSmpMuyr9MU43qzQLrXyg
    EhM8o4x9FfUKUvmYkwY1/FsRstI97W5OgONKjm0CvwHAzX66fvE3cQPk+LVxzEqj
    UtJ6X+l3Dm4FDmZfLv+f++b25wTe/XBS3dRl5w4frHa1H741La7P3UPQkGr/PaNf
    b4KnEoJ4oVa145rc8txV92/UdO6xbE6f54N2yD4NnNMacTRQp9mvOh1LrwMocLhD
    Tn0XDhepfsGqMOAlvVLtLAOAISAEsALSriUJp0Wu8uYi6GKLM5o4gtzutl26oiO7
    smiaqQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfIcZXPQ8pUT6wIAsWyxwjR43a/HigRXUu2Gmk9aiWNfWmRlSfnSYVphneeke6AmW2je3acmZMfMqbdx/VNsY7TUFmlO0BMtDs2CazP3S18GSI2XuMQjs
    YJWEwLo1UalVkJQn5dKbi7A3+H5lTpO/BlqrN0ryN753X4ZNI4cbPZxs1MUfxidBV+pLit+hS7AhIcWDVZVXfJvA0tMedoAu5vsfzWPLhuOs33SoS1LhOflo
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=1LY7DLSOhxCY-yNVVBAA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161332AbeEXV20 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 17:28:26 -0400
Received: from smtp2.provo.novell.com ([137.65.250.81]:54450 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161324AbeEXV2Y (ORCPT
        <rfc822;groupwise-linux-api@vger.kernel.org:0:0>);
        Thu, 24 May 2018 17:28:24 -0400
From: Davidlohr Bueso <dave@stgolabs.net>
To: akpm@linux-foundation.org, torvalds@linux-foundation.org
Cc: tgraf@suug.ch, herbert@gondor.apana.org.au,
        manfred@colorfullife.com, guillaume.knispel@supersonicimagine.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 1/6] lib/rhashtable: convert param sanitations to WARN_ON
Date: Thu, 24 May 2018 14:11:30 -0700
Message-Id: <20180524211135.27760-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180524211135.27760-1-dave@stgolabs.net>
References: <20180524211135.27760-1-dave@stgolabs.net>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For the purpose of making rhashtable_init() unable to fail,
we can replace the returning -EINVAL with WARN_ONs whenever
the caller passes bogus parameters during initialization.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 lib/rhashtable.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 9427b5766134..05a4b1b8b8ce 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -1024,12 +1024,11 @@ int rhashtable_init(struct rhashtable *ht,
 
 	size = HASH_DEFAULT_SIZE;
 
-	if ((!params->key_len && !params->obj_hashfn) ||
-	    (params->obj_hashfn && !params->obj_cmpfn))
-		return -EINVAL;
+	WARN_ON((!params->key_len && !params->obj_hashfn) ||
+		(params->obj_hashfn && !params->obj_cmpfn));
 
-	if (params->nulls_base && params->nulls_base < (1U << RHT_BASE_SHIFT))
-		return -EINVAL;
+	WARN_ON(params->nulls_base &&
+		params->nulls_base < (1U << RHT_BASE_SHIFT));
 
 	memset(ht, 0, sizeof(*ht));
 	mutex_init(&ht->mutex);
-- 
2.13.6

