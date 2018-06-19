Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2923C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEE420661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 06:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEE420661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756185AbeFSGOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 02:14:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:16509 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755731AbeFSGOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 02:14:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 23:14:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,242,1526367600"; 
   d="scan'208";a="233701083"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga005.jf.intel.com with ESMTP; 18 Jun 2018 23:14:41 -0700
Subject: [PATCH v3 1/8] mm,
 devm_memremap_pages: Mark devm_memremap_pages() EXPORT_SYMBOL_GPL
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Michal Hocko <mhocko@suse.com>,
        =?utf-8?b?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 18 Jun 2018 23:04:44 -0700
Message-ID: <152938828436.17797.6503178614207917252.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152938827880.17797.439879736804291936.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152938827880.17797.439879736804291936.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_memremap_pages() facility is tightly integrated with the
kernel's memory hotplug functionality. It injects an altmap argument
deep into the architecture specific vmemmap implementation to allow
allocating from specific reserved pages, and it has Linux specific
assumptions about page structure reference counting relative to
get_user_pages() and get_user_pages_fast(). It was an oversight that
this was not marked EXPORT_SYMBOL_GPL from the outset.

Cc: Michal Hocko <mhocko@suse.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 kernel/memremap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index 5857267a4af5..4478e4688bb7 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -257,7 +257,7 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 	pgmap_radix_release(res, pgoff);
 	return ERR_PTR(error);
 }
-EXPORT_SYMBOL(devm_memremap_pages);
+EXPORT_SYMBOL_GPL(devm_memremap_pages);
 
 unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
 {

