Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4022886-1519424169-2-11001571560678933222
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519424169; b=hxi3r6aDRt3NnFCfitGsxOVeV98T6Tx6S9hnsaqYeOC1o25
    BFRyleh/dROfWfqvLG9BCzo+LkdDPGNSI16yJRLQ7y+gB4Xwl82y9CJX2UP/BgUZ
    KjuxKPJ1tV9LHMyVTRNXopOOGdPjzMQ3AJYht5DgxCUZ/1UwYyV5xz0RZBL8xocP
    iAqFVlIBdsPLyFvFIB57usanB5JlhqhmWcBkomsIt9Ci0JA0VFtiTnE9IWE4Pfgn
    VXhzbVaWgsurXj+vRAyJl45o8rek7fDUJlqIyTUY6gDYGsfmt1+hyuVQpcLKlmTU
    y66dyVh6/s56lUQnDLR+ct0PX6xOr2lfN1vmvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519424169; bh=VqQ+dSQzdameJW2R8J8tLXwHoOAy0y0/XkJcmfrLhp4=; b=P
    PEC3YmPxW0TgvUNNkvHwplybTe23lHvZS5KBrXzPBaRCwk0+RnlgH46K+dx+tlHM
    /jPwIfA3t1gHO1ULuWWoisFoPJgtcNJNXrcZaOJbkszvNUWlkBJOhiYUNWt5Vaf2
    ZAhy4YX/AQmjx3jM11xXdlkmPmtf+Ti2v/1VahUMFUQfh6pChEKNeuogdGduvC10
    f8hSb5WkZ2Ud7PQjXSOOP0dk97bG066gKvxzpae1x+w+pZPOR4VuZZKkjcx0Npsu
    s+6VqYeEJXVOUs1JXxSPYaAy8VGNzTjuVZBH/dqS2M0tiaGJsVV8Mv53MptS1p11
    jEmnIkZuAjuIfodwplcXQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752167AbeBWWPI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 17:15:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:16190 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752153AbeBWWPG (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 17:15:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="19967653"
Subject: [4.9-stable PATCH 07/11] IB/core: disable memory registration of
 filesystem-dax vmas
From: Dan Williams <dan.j.williams@intel.com>
To: gregkh@linuxfoundation.org
Cc: Sean Hefty <sean.hefty@intel.com>, Jan Kara <jack@suse.cz>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        linux-kernel@vger.kernel.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Jeff Moyer <jmoyer@redhat.com>, stable@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Inki Dae <inki.dae@samsung.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Mel Gorman <mgorman@suse.de>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hal Rosenstock <hal.rosenstock@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Date: Fri, 23 Feb 2018 14:06:00 -0800
Message-ID: <151942356005.21775.11352557058864235434.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151942352167.21775.16852023419062929165.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

commit 5f1d43de54164dcfb9bfa542fcc92c1e1a1b6c1d upstream.

Until there is a solution to the dma-to-dax vs truncate problem it is
not safe to allow RDMA to create long standing memory registrations
against filesytem-dax vmas.

Link: http://lkml.kernel.org/r/151068941011.7446.7766030590347262502.stgit@dwillia2-desk3.amr.corp.intel.com
Fixes: 3565fce3a659 ("mm, x86: get_user_pages() for dax mappings")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reported-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jason Gunthorpe <jgg@mellanox.com>
Acked-by: Doug Ledford <dledford@redhat.com>
Cc: Sean Hefty <sean.hefty@intel.com>
Cc: Hal Rosenstock <hal.rosenstock@gmail.com>
Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 drivers/infiniband/core/umem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index c22fde6207d1..8e973a2993a6 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -193,7 +193,7 @@ struct ib_umem *ib_umem_get(struct ib_ucontext *context, unsigned long addr,
 	sg_list_start = umem->sg_head.sgl;
 
 	while (npages) {
-		ret = get_user_pages(cur_base,
+		ret = get_user_pages_longterm(cur_base,
 				     min_t(unsigned long, npages,
 					   PAGE_SIZE / sizeof (struct page *)),
 				     gup_flags, page_list, vma_list);
