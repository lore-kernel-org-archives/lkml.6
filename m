Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42E3C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F5D20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 00:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oR136Qp5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F5D20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbeLNAEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 19:04:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55116 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbeLNAEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 19:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=H5UX7a2c8B0JHLFH/TVStPQkI1cjAmdqx4cJBvqu2F8=; b=oR136Qp59h/czJsUjyM+GK5FG6
        SCGGRCiurez7peDXLXJWgYGVYqYJrN/itaLsgM8UYplFH0m5fFYXsyQVgJPmyx0EDMAUR5AajyeBx
        3ELRfp/7QPw0D/kAm8tz4vhen6ivKN33uthlpLuX4/fDC+ftUfbP/vePo8S0x3oClbqO5xZxEVN0d
        b/4AqnHqGIc7+bO85iThEpn8tUQH0ES6FStvybc+Yk+jpEGuvfl7jnCZQutc5s7EQdz2nlpkBNTqD
        b/dkbPuxAM5oyg2Njs5ECoAM/PdfGi4uFUcerLldnCxRNg7UVPqpxgxkjbmJcK8/Mlo1s0aZFJ2Zq
        nyGbW4Aw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXayG-0002uG-2b; Fri, 14 Dec 2018 00:04:48 +0000
Date:   Thu, 13 Dec 2018 16:04:47 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] XArray for 4.20-rc7
Message-ID: <20181214000447.GT6830@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


(hope I did the git tag correctly this time)

The following changes since commit cf76c364a1e1e5224af80edf70a1e3023e1fcf8c:

  Merge tag 'scsi-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2018-12-05 17:06:31 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/willy/linux-dax.git tags/xarray-4.20-rc7

for you to fetch changes up to 48483614de97c4f5219abeda630e62b2bebdce62:

  XArray: Fix xa_alloc when id exceeds max (2018-12-13 14:07:33 -0500)

----------------------------------------------------------------
XArray updates for 4.20-rc7

Two bugfixes, each with test-suite updates, two improvements to the
test-suite without associated bugs, and one patch adding a missing API.

----------------------------------------------------------------
Matthew Wilcox (5):
      radix tree: Don't return retry entries from lookup
      XArray: Add xa_cmpxchg_irq and xa_cmpxchg_bh
      XArray tests: Handle larger indices more elegantly
      XArray tests: Check iterating over multiorder entries
      XArray: Fix xa_alloc when id exceeds max

 Documentation/core-api/xarray.rst      |   5 +-
 include/linux/xarray.h                 |  54 ++++++++++++
 lib/radix-tree.c                       |   4 +-
 lib/test_xarray.c                      | 155 ++++++++++++++++++++++++---------
 lib/xarray.c                           |   8 +-
 mm/shmem.c                             |   4 +-
 tools/testing/radix-tree/Makefile      |   1 +
 tools/testing/radix-tree/main.c        |   1 +
 tools/testing/radix-tree/regression.h  |   1 +
 tools/testing/radix-tree/regression4.c |  79 +++++++++++++++++
 10 files changed, 258 insertions(+), 54 deletions(-)
 create mode 100644 tools/testing/radix-tree/regression4.c

