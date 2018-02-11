Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324820-2-6544691931952226330
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324820; b=fXb8Kpse5b1Jo5L+0e9kFKaXdtbb5SNIIpwmDAQCTNV5gtZ
    Pvn/cL6Fl+uwp4qc0KvrGlD/NxTSRyejz2vMhkJCKOUblKxK/XFP7c7hFcm9bgbf
    8wVlVlUWXtj0CHGmqZ5sOyB/AlHFGB3Pe3i87NJ8LIEd4iJpHwmsKE0vHNtVmqGZ
    MFby9XwYNu20pVQ98/jT+aGwo0WowJGVK2FZRrgkWy3kzAITfqYGm1oegD3WHh1g
    H4MkprlWskYWeIuILRVrB55yvi6nhnOAiRs6Fhx4ra/U7aCh8e6zTDnantyZUqDY
    UdxjHaDLWK7DrGDGHTZpS3TTsUTv6MgVv5nMi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324820; bh=nTLPQI+Ju2Ad0i1Q8YP
    1yexi3fGyAetmsuG0p9qiarE=; b=A/9g9Kf4nO2+WjJQ0m/2RjEHZVmNCnQwU2v
    pu7Arp2ycNTvbGjeqRsqGKJkVWJkWlz20itQXttM7xznDC11DrD3widHvUjP1nYY
    0sJDBUwq06YRt8J6HACkNBF1RMACsMPP2eDjFQVqBG1BecV/YUe3ZqnhTYOcPZYA
    3SF2+YSuIt1xqPVTRf3/+D7UMiUFdOUGsegtu0lYg2d4Tw3kDelcIrm0gU9eR8Na
    zFdVhD1IVplAChIfYbTd1HmJQiAWAL6mD/QIzUaI6oM7RhgXMrAMXfBaOvm1wCtI
    RIvhDeSM/Q94JjkzHs/h2zWkLvQxV8xdd7NkH0Lj0eTkfGFo0BQ==
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
        id S1753600AbeBKEvl (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:51:41 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41756 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752820AbeBKEd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Mohamed Ghannam" <simo.ghannam@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.389317812@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 119/136] RDS: Heap OOB write in rds_message_alloc_sgs()
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mohamed Ghannam <simo.ghannam@gmail.com>

commit c095508770aebf1b9218e77026e48345d719b17c upstream.

When args->nr_local is 0, nr_pages gets also 0 due some size
calculation via rds_rm_size(), which is later used to allocate
pages for DMA, this bug produces a heap Out-Of-Bound write access
to a specific memory region.

Signed-off-by: Mohamed Ghannam <simo.ghannam@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/rds/rdma.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/net/rds/rdma.c
+++ b/net/rds/rdma.c
@@ -516,6 +516,9 @@ int rds_rdma_extra_size(struct rds_rdma_
 
 	local_vec = (struct rds_iovec __user *)(unsigned long) args->local_vec_addr;
 
+	if (args->nr_local == 0)
+		return -EINVAL;
+
 	/* figure out the number of pages in the vector */
 	for (i = 0; i < args->nr_local; i++) {
 		if (copy_from_user(&vec, &local_vec[i],
