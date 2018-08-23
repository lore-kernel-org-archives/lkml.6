Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45155C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E5720834
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 12:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s7QCof1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2E5720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbeHWPsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:48:24 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:44262 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbeHWPsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:48:23 -0400
Received: by mail-pg1-f172.google.com with SMTP id r1-v6so2476759pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 05:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LyLnS9WkE9wdU0rZDEt97avDB+5wYUZEoL39Oix8HyE=;
        b=s7QCof1iqsa/e+xVRgmrjFaZG/CCCHmpw2ZoGDkz8eohKWYAzojZ5pt0ffvyxYJEr6
         ay9lVBPq5R7+HV/hnkYlzdQG8OR12zdu+Iio2ypvo5N4eHUapcE1ZPidJYReT7XMLin6
         tCvphNNKSHhQAgv/tyUe1vKEVtyr2ODEcYqLviVndu4btbnr6+bP0eRgwpw9TwurElYW
         44R2FHmW15HCljgt+YdMfLoF9E6THVwYFVfrkO5mebBNhdvkCXGoBfrEuO9+lFHEouA1
         PwrDAppKWs7KacOcFGE87nZUBvyJfL+0iSNa9V4JJDNi2005ps5JLGvi8pWwzpjQ/sMI
         Xk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LyLnS9WkE9wdU0rZDEt97avDB+5wYUZEoL39Oix8HyE=;
        b=KgfkLNJN4EthWAqOSiSPzwDZut9M4ukHh8xHGWtzARMi85cO9wvYfMzJyrdexkoNGT
         hRmLPKH+3j7Mgv++i9B3RRiUuqM+ZngF5OEJeetmC5ET+qBsvWXWRGMCXHAyxXgpbmX9
         4DfZa4b8kwTstZ5ZosQL6EZj1Va/qqPGoQhqYi1eayAYgG9DN8mxspSnWSXorPmiDxiK
         INjtWAZ44NJkiv8mo5gwgEmdJ004+/F0EvoWSGmrWmun/vA3uuZ+bf4THNGhd3Mlk500
         62wGF8Hc3Sv8edLDBCbkNZoxb5rLaMrtH6l403pHtiiYiPb90SHMK2FfEGry6gU8SAmP
         bwNw==
X-Gm-Message-State: APzg51ArIFyB5h6jOfGb12EjdrxQS5BDx2iYAS572nx2rXO6PKL1EYTL
        dp1AwqvH7qYLEonwIPDDxVGqwdci
X-Google-Smtp-Source: ANB0VdZXOjat1uVCHFvi9BBVTQwScPY8Piy5Pt17pemxfmnAhCKOysZ4xoT0zRr86G0NhaQ/6mSI1Q==
X-Received: by 2002:a63:d806:: with SMTP id b6-v6mr2285701pgh.347.1535026735277;
        Thu, 23 Aug 2018 05:18:55 -0700 (PDT)
Received: from localhost (g13.61-115-50.ppp.wakwak.ne.jp. [61.115.50.13])
        by smtp.gmail.com with ESMTPSA id t9-v6sm6159211pgn.64.2018.08.23.05.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 05:18:54 -0700 (PDT)
Date:   Thu, 23 Aug 2018 21:18:52 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] OpenRISC updates for 4.19
Message-ID: <20180823121852.GG9742@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider for pull.

-Stafford

The following changes since commit 1e4b044d22517cae7047c99038abb444423243ca:

  Linux 4.18-rc4 (2018-07-08 16:34:02 -0700)

are available in the Git repository at:

  git://github.com/openrisc/linux.git tags/for-linus

for you to fetch changes up to 5600779ea5f3d29fadc62208e21feb0bb9b813aa:

  openrisc: use generic dma_noncoherent_ops (2018-07-21 13:49:48 +0900)

----------------------------------------------------------------
OpenRISC updates for 4.19

Just one change for 4.19:
 - Refactors from Christoph Hellwig to use generic DMA facilities

----------------------------------------------------------------
Christoph Hellwig (4):
      openrisc: remove the sync_single_for_cpu DMA operation
      openrisc: remove the no-op unmap_page and unmap_sg DMA operations
      openrisc: fix cache maintainance the the sync_single_for_device DMA operation
      openrisc: use generic dma_noncoherent_ops

 arch/openrisc/Kconfig                   |   2 +
 arch/openrisc/include/asm/Kbuild        |   1 +
 arch/openrisc/include/asm/dma-mapping.h |  35 -----------
 arch/openrisc/kernel/dma.c              | 107 +++-----------------------------
 4 files changed, 12 insertions(+), 133 deletions(-)
 delete mode 100644 arch/openrisc/include/asm/dma-mapping.h
