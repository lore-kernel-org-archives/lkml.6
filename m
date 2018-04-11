Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3303684-1523479263-2-13559024336354971288
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523479263; b=NflUlh1+3/2OkUU2wmmWE4Fus+28MehcJSHjA7DAxNTBKGXKqz
    aiVHrfS/UOxinxUBsceu12P5d8JV50Gb8q3t4GhmlfEcABVk3PGRMakwUeNo/Las
    ILjvlUwdgPK4DDJR7wGtOfB572R1eEe+syVImXns6fsCjPCbGxIXfNZnERNoviuM
    8DIlYqs8fG0j9Aum/MPHcQfoIf3i1p+ef4HJJdhTwnTMTLuBVbuNg+a/M/CWxEcm
    useQ4kOfaAOakFQGsLzuGqmvIiut3YAvOHoCfZpqakcrIDH8zjnTCxZLPF7Twzq9
    szZ9MfZwMGcKNFP4KZOgMLn//eZUwDnCQBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479263; bh=DDnruhlAUg8m+h2cTQXR3WdeSAh+cO
    v9NECn0m1hHBM=; b=jUe/qWfCRi0xAJwRjjnTSXkhgynfeZeVhn0MMzHtf8JgUK
    X86DlDON+XUqe7QZ08KXV7sUFjdudYT78jNiXM+z5QFCpykRCPFE5fotVJY/gJQw
    Bk7Ugk+YVGSqmw1u/t54oHbKSqz1OBc399s8HN4wZWKY73DktwJ5skHNC3Ycoubl
    Qlt0ZUUAk3kzZNaEBsvGmLAYngZapBhxVxII5d30RykODQZSPTuPt8OT1gEu9pMW
    dlTpdcdN7w4vTJgHimYU7geZ5gqulF+NYORevGc76mb0e19D7jDZ860cURAvJFih
    9ftWTkcL0b3KVHt5vHiUQ6Zcq7f/CkwT0d/g3w/w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIQVT1AmEyN9GJodr8xB/oR05kzRBDQ4h3CjtntSK2WqNebk/1XzKDGhAtRPX8oixaW6ESpUkr1JtsCCVUSkApXCFKOehKqYAQYEUScUyxmrDrkKjngx
    m3mVclsfnoBIsE8hB1RdMJZ2pT1ayh5tiHV3gliQZ8a7BGJ9lbu7mvUX/l8fwyt2TFzZGzXXLQ92E8C46AZ0143GwqIlKlIvSNv3GgNMDxa0jZiZcOuvCe8P
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=FOH2dFAWAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=c5uIHsn1P3uz29lLov8A:9 a=QEXdDO2ut3YA:10 a=i3VuKzQdj-NEYjvDI-p3:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756002AbeDKSrz (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:47:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59474 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755970AbeDKSrx (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:47:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Jens Axboe <axboe@fb.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 065/190] block: fix an error code in add_partition()
Date: Wed, 11 Apr 2018 20:35:11 +0200
Message-Id: <20180411183554.100266835@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit 7bd897cfce1eb373892d35d7f73201b0f9b221c4 ]

We don't set an error code on this path.  It means that we return NULL
instead of an error pointer and the caller does a NULL dereference.

Fixes: 6d1d8050b4bc ("block, partition: add partition_meta_info to hd_struct")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jens Axboe <axboe@fb.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/partition-generic.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -309,8 +309,10 @@ struct hd_struct *add_partition(struct g
 
 	if (info) {
 		struct partition_meta_info *pinfo = alloc_part_info(disk);
-		if (!pinfo)
+		if (!pinfo) {
+			err = -ENOMEM;
 			goto out_free_stats;
+		}
 		memcpy(pinfo, info, sizeof(*info));
 		p->info = pinfo;
 	}
