Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9EDC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C48208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BBcoBRIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C48208B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbeHMJ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 05:58:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59140 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeHMJ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 05:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wyZH29l/Fw5JPV2MtfWA6em8NY6wujojTCWT/2qoEjc=; b=BBcoBRIBSazy6wzhyvXUCj4vSV
        zEQowYbfBemVLci3DpmWltNPGcftV4wrJDGrgqR/YO+hvCKxMwLKIKwUstReJN+lsIfnUpjT7TMNv
        Kyis+aLm3T5M5Gyf9anX8qYgAYNjT/zqrPt1yZ/7fxmTWaaQxGgOAfOOds8cktqiWZVD1+RmkE5UE
        iS//FLRymQ90W/7N0uAE936JNyR8NvZTl8VHwVxUHpg1LV0ZnLORz37DFmZTBoXTrsk3B54+SscXT
        Ir282XekkXSpr7nWvD0/AOhG9BafPKkU2ikpG4RRz6L5oIEfacgK2G6++1KsZApcgXkjlUeFDWFiB
        b41eIbhg==;
Received: from [62.169.200.78] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fp76S-0005UH-Oi; Mon, 13 Aug 2018 07:17:25 +0000
Date:   Mon, 13 Aug 2018 10:17:19 +0300
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] configfs updates for 4.19
Message-ID: <20180813071719.GA25649@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.infradead.org/users/hch/configfs.git tags/configfs-for-4.19

for you to fetch changes up to cc57c07343bd071cdf1915a91a24ab7d40c9b590:

  configfs: fix registered group removal (2018-07-17 06:14:07 -0700)

----------------------------------------------------------------
configfs updates for 4.19

 - simplify the cide by using kvasprintf (Bart Van Assche).
 - fix a gcc 8 string truncation warning by making the code simpler
   (Guenter Roeck).
 - fix a bug in rmdir() handling (Mike Christie).

----------------------------------------------------------------
Bart Van Assche (1):
      configfs: use kvasprintf() instead of open-coding it

Guenter Roeck (1):
      configfs: replace strncpy with memcpy

Mike Christie (1):
      configfs: fix registered group removal

 fs/configfs/dir.c     | 11 +++++++++++
 fs/configfs/item.c    | 24 ++++--------------------
 fs/configfs/symlink.c |  2 +-
 3 files changed, 16 insertions(+), 21 deletions(-)
