Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BB8C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905B721841
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 23:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TRxhdT79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeLQXun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 18:50:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41616 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeLQXun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 18:50:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id u6so6875222plm.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 15:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=uNFJcBxYzAt3IWV0K1p5fNwSr/rEdiGL+jhGldmIaTw=;
        b=TRxhdT79r/wI/mvCS2sjPdCRxCGDQIOK8zDIRZ0Wtigfn31UMIFdE1IJ15KnFKtlA0
         oGQqcD+lxPQzWnmdby1TiR4rRYWnm6jDoUxj2kVqh6TZYI241uKWNUp8kzdoIbbMnHCE
         GWVBpWiS1xx5Wfnsuq8ab5T823hMCp1bNKWXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uNFJcBxYzAt3IWV0K1p5fNwSr/rEdiGL+jhGldmIaTw=;
        b=hoHRbtV2UnQHNYItHBPKCSSaPIoKpdeoRmncvnM8a6yn0fLg5YBKcyZc7AyvySM+CO
         T4x3eRGZAe6MDIL4EZY1K1ML1aErjIgAPNOMTW30ic6H3TzhILW1meKIn3indw2krZOx
         Z+FMbIYgDg+ldduhAYfibjoyjKZXcaSN7IXWQwKp1ZiRljHtSVioZ3nsFyggbqHMsCta
         m3AjaWE8zGGPW3aJjYU0f/Rl3iwAAu5qR/clkd2QU54zKWvJIK5ZU2bS+K4wIkTC3QA0
         B16cLSJxtXQPzU9xzpDpp/7390eO1opXILJGeasKJhA64OKHmWono2yHVecga2u+Yp4w
         JNVQ==
X-Gm-Message-State: AA+aEWZNtH4KOBL+imXD1A9GRV2PzYi/xcofR5Q+pUyA7QguayH0syeD
        lg8eQ5TWP9/9kRr4D7k379oSMw==
X-Google-Smtp-Source: AFSGD/XS4BEwF6X4rT2ixpihNLiDsDy50ejE6oL22uhcGzAUS+DPM0BF4d97lo6nKXeVv+1XdHHnFg==
X-Received: by 2002:a17:902:2862:: with SMTP id e89mr14652128plb.158.1545090642341;
        Mon, 17 Dec 2018 15:50:42 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id n70sm19494286pfi.185.2018.12.17.15.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 15:50:41 -0800 (PST)
Date:   Mon, 17 Dec 2018 15:50:40 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Peng Wang <wangpeng15@xiaomi.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Meyer <thomas@m3y3r.de>
Subject: [GIT PULL] pstore updates for v4.21-rc1
Message-ID: <20181217235040.GA18678@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these pstore changes for v4.21-rc1.

Thanks!

-Kees

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v4.21-rc1

for you to fetch changes up to 8665569e97dd52920713b95675409648986b5b0d:

  pstore/ram: Avoid NULL deref in ftrace merging failure path (2018-12-03 17:11:02 -0800)

----------------------------------------------------------------
pstore improvements and refactorings

- Improve compression handling
- Refactor argument handling during initialization
- Avoid needless locking for saner EFI backend handling
- Add more kern-doc and improve debugging output

----------------------------------------------------------------
Joel Fernandes (Google) (3):
      pstore: Map PSTORE_TYPE_* to strings
      pstore/ram: Simplify ramoops_get_next_prz() arguments
      pstore/ram: Do not treat empty buffers as valid

Kees Cook (11):
      pstore/ram: Correctly calculate usable PRZ bytes
      Merge branch 'for-linus/pstore' into for-next/pstore
      pstore: Do not use crash buffer for decompression
      pstore: Remove needless lock during console writes
      pstore/ram: Standardize module name in ramoops
      pstore/ram: Report backend assignments with finer granularity
      pstore/ram: Add kern-doc for struct persistent_ram_zone
      pstore: Improve and update some comments and status output
      pstore: Replace open-coded << with BIT()
      pstore: Convert buf_lock to semaphore
      pstore/ram: Avoid NULL deref in ftrace merging failure path

Peng Wang (1):
      pstore: Avoid duplicate call of persistent_ram_zap()

Thomas Meyer (1):
      pstore: Fix bool initialization/comparison

 arch/powerpc/kernel/nvram_64.c    |   2 -
 drivers/acpi/apei/erst.c          |   3 +-
 drivers/firmware/efi/efi-pstore.c |   4 +-
 fs/pstore/ftrace.c                |   2 +-
 fs/pstore/inode.c                 |  51 +----------
 fs/pstore/platform.c              | 173 +++++++++++++++++++++-----------------
 fs/pstore/ram.c                   |  78 +++++++----------
 fs/pstore/ram_core.c              |  45 ++++++++--
 include/linux/pstore.h            |  39 ++++++---
 include/linux/pstore_ram.h        |  50 ++++++++++-
 10 files changed, 241 insertions(+), 206 deletions(-)

-- 
Kees Cook
