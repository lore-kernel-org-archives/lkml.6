Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA55DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED3E2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rawWQjyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED3E2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbeKAFb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 01:31:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52994 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbeKAFbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 01:31:25 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so16417881wmw.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 13:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4utPwJWdoU2jyQiTxPU3m5sA0bDgNZnr1421XwHYzyU=;
        b=rawWQjyRoSt9HjnIBjRl0DpPJ2kDry7Ll1T2MPAVAN929aFdJMqb/hPt+y44EwEoAG
         tXQ+pZp3ZhweSY6/GudNV0Cv9hzzk6y08Tjqxw/ZVyjbg1uttnXXjblDZ66viVUF/m6T
         sA/rz/5O5+csyrhyYR9cMODxap0hcv7Q+/2h8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4utPwJWdoU2jyQiTxPU3m5sA0bDgNZnr1421XwHYzyU=;
        b=THvrfWAhccny11+8Y+/laoLlNPl8EsP95upbAKhk6S5ps3g/qQj2EO1ymZJcVL2UW8
         DzYO5ZWyRcGKEdFiZA0zJEUleHKvlgqGulzRZnHFfXoskXDdo2w7iJF/MCgqE+VWea6N
         NrDfciWIa1QIfTjBUbpFB1gfDl4IuceFIt4oKmTcHDVY1BiGwg5U22tiXjv66+Qr9kSN
         TWXtyQ7BAWao4W6rNLj48Juf25AGoLsIy3fB3iyLiR29lQgh85ymtJafQakYryGv9aON
         fElD8ebaFc7nNpSvXsb3ZmaXGKptGfDgVDW1NcSb2+Qnz5w0ziqcJrxgmXg4RIy1FZzy
         Am1A==
X-Gm-Message-State: AGRZ1gIrQrLliTscLtmEHQ+h2BPAw7LloCD39mCXrUolnBtEWNYcYXQ4
        FEKrWzn7fw5hnwZr83b8Hd7C59jh7xf9Og==
X-Google-Smtp-Source: AJdET5fFenhZriQIplYwh5jYxsygVDN+DtFsPsvinIZSPqyMKswW3fHCGJvGD6Ua1ie+68erEWxBcw==
X-Received: by 2002:a1c:410a:: with SMTP id o10-v6mr3585145wma.19.1541017906226;
        Wed, 31 Oct 2018 13:31:46 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id x139-v6sm4370033wme.3.2018.10.31.13.31.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 13:31:45 -0700 (PDT)
Date:   Wed, 31 Oct 2018 21:31:42 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [GIT PULL] fuse update for 4.20
Message-ID: <20181031203142.GG23439@veci.piliscsaba.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git tags/fuse-update-4.20

As well as the usual bug fixes, this adds the following new features:

 - cached readdir and readlink
 - max I/O size increased from 128k to 1M
 - improved performance and scalability of request queues
 - copy_file_range support

The only non-fuse bits are trivial cleanups of macros in <linux/bitops.h>.

Thanks,
Miklos

----------------------------------------------------------------
Constantine Shulyupin (1):
      fuse: add max_pages to init_out

Dan Schatzberg (1):
      fuse: enable caching of symlinks

Kirill Tkhai (10):
      fuse: Fix use-after-free in fuse_dev_do_read()
      fuse: Fix use-after-free in fuse_dev_do_write()
      fuse: use list_first_entry() in flush_bg_queue()
      fuse: use READ_ONCE on congestion_threshold and max_background
      fuse: add locking to max_background and congestion_threshold changes
      fuse: introduce fc->bg_lock
      fuse: do not take fc->lock in fuse_request_send_background()
      fuse: change interrupt requests allocation algorithm
      fuse: kill req->intr_unique
      fuse: Use hash table to link processing request

Miklos Szeredi (18):
      fuse: set FR_SENT while locked
      fuse: fix blocked_waitq wakeup
      fuse: split out readdir.c
      fuse: add FOPEN_CACHE_DIR
      fuse: extract fuse_emit() helper
      fuse: allow caching readdir
      fuse: allow using readdir cache
      fuse: add readdir cache version
      fuse: use mtime for readdir cache verification
      fuse: use iversion for readdir cache verification
      fuse: reduce size of struct fuse_inode
      fuse: allocate page array more efficiently
      fuse: realloc page array
      bitops: protect variables in set_mask_bits() macro
      bitops: protect variables in bit_clear_unless() macro
      fuse: allow fine grained attr cache invaldation
      fuse: don't need GETATTR after every READ
      fuse: only invalidate atime in direct read

Niels de Vos (1):
      fuse: add support for copy_file_range()

---
 fs/fuse/Makefile          |   2 +-
 fs/fuse/control.c         |  34 ++-
 fs/fuse/dev.c             | 221 +++++++++++-------
 fs/fuse/dir.c             | 381 +++++++++----------------------
 fs/fuse/file.c            | 158 ++++++++++---
 fs/fuse/fuse_i.h          | 124 ++++++++--
 fs/fuse/inode.c           |  53 +++--
 fs/fuse/readdir.c         | 569 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/bitops.h    |  30 +--
 include/uapi/linux/fuse.h | 119 ++++++----
 10 files changed, 1201 insertions(+), 490 deletions(-)
 create mode 100644 fs/fuse/readdir.c
