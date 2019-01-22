Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20B5C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75FA420861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 03:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gsDra5MN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbfAVDbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 22:31:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59518 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfAVDbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 22:31:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=K2KBZWg5m1d0B0OHmfatq46ArqrU7LqZaRCEyPfQZa4=; b=gsDra5MNOBQl9BmHml4g13a6Jy
        VVQH2uuAJVwjcHSXwOGIX4zMmT2t3Df/UcwrqS1eMSqzfNow5GvUp35s3FwhDuaDMb+PhN6bNrF7u
        se2d7xjeLLXYkh2j7xBloKN7gSrOhPR3G5b7kqu6/LbBvOZdbYtjZ5UO1iMuQRhQq+TwJZWfKqMAu
        ffiGESJna7G0DLc8lA72mi2qWQs7vXHiCGLOYNPfz3vlxX3PBQkJerrPeqIGvhfTajZDCxkC9drMd
        zygxmHFXJDCVDQmRyb65fVxP7NNm0mqKsuul4rGp4pp3YbGEIp04Tan+U52+Et8RvxbcYn4/FkzXD
        AtAo/37A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glmml-0007Eu-Uo; Tue, 22 Jan 2019 03:31:35 +0000
Date:   Mon, 21 Jan 2019 19:31:35 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] XArray for 5.0-rc3
Message-ID: <20190122033135.GA18123@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3bd6e94bec122a951d462c239b47954cf5f36e33:

  arch: restore generic-y += shmparam.h for some architectures (2019-01-06 18:16:11 -0800)

are available in the Git repository at:

  git://git.infradead.org/users/willy/linux-dax.git tags/xarray-5.0-rc3

for you to fetch changes up to edcddd4c879af48ec922d680b2d56834c085683b:

  XArray: Fix an arithmetic error in xa_is_err (2019-01-17 07:19:42 -0500)

----------------------------------------------------------------
XArray updates for 5.0-rc3

Fix some oversights in the XArray porcelain API:
 - support for m68k's two-byte aligned pointers
 - reserving entries using xa_insert()
 - missing xa_insert_bh() and xa_insert_irq() functions
 - simplify using xa_for_each()
 - use lockdep correctly
 - a few other minor fixes and improvements

----------------------------------------------------------------
Cyrill Gorcunov (1):
      XArray: Fix typo in comment

Dan Carpenter (1):
      XArray: Fix an arithmetic error in xa_is_err

Matthew Wilcox (6):
      XArray tests: Add RCU locking
      XArray: Turn xa_init_flags into a static inline
      XArray: Change xa_for_each iterator
      XArray: Permit storing 2-byte-aligned pointers
      XArray: Honour reserved entries in xa_insert
      XArray tests: Check mark 2 gets squashed

 Documentation/core-api/xarray.rst |  15 ++-
 include/linux/xarray.h            | 227 ++++++++++++++++++++++++++++----------
 lib/test_xarray.c                 |  57 ++++++++--
 lib/xarray.c                      |  92 ++++++++-------
 4 files changed, 278 insertions(+), 113 deletions(-)

