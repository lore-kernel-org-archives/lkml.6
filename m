Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7714C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C1121915
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 19:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfAET5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 14:57:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:33432 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbfAET5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 14:57:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jan 2019 11:57:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,444,1539673200"; 
   d="scan'208";a="133230013"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga004.fm.intel.com with ESMTP; 05 Jan 2019 11:57:39 -0800
Subject: [4.19-stable PATCH 0/2] dax: Don't access a freed inode
From:   Dan Williams <dan.j.williams@intel.com>
To:     stable@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        sashal@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 05 Jan 2019 11:45:02 -0800
Message-ID: <154671750268.249397.710993904552440547.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original upstream fix, commit 55e56f06ed71 "dax: Don't access a freed
inode", prompted an immediate cleanup request. Now that the cleanup has
landed, commit d8a706414af4 "dax: Use non-exclusive wait in
wait_entry_unlocked()", backport them both to -stable.

---

Dan Williams (1):
      dax: Use non-exclusive wait in wait_entry_unlocked()

Matthew Wilcox (1):
      dax: Don't access a freed inode


 fs/dax.c |   69 ++++++++++++++++++++++++++++----------------------------------
 1 file changed, 31 insertions(+), 38 deletions(-)
