Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC5EC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31C020866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 18:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="q+hT8K8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D31C020866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeIMXlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 19:41:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35490 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeIMXlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 19:41:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so7456388wre.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 11:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Xuj3J3b7RKm4bZA5vXrYtI4DUipNNC2jopPp91czlrM=;
        b=q+hT8K8AkhYpxSZu1rlShN+z5x0S9IP5yikDFgcZLm9kb/G04+Cgh4vxG1dew+PpQy
         +ix5VKxzyr3K2NBUgz0AQtua8GZfxJqtAJUkqmZKJcGeNqFt7p2dOKKAVfsNUPMYRN2D
         Gt+bRkt8Xg8ui8aDBmWEKI/kI8Pn7mbHBN04w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Xuj3J3b7RKm4bZA5vXrYtI4DUipNNC2jopPp91czlrM=;
        b=GyiIuBb5CTk29UQl5/L6iQlk3A/15ciJ9qKFJCa8Rnjsu0nInBT/QByYjWUTM+ZYnR
         UKjr8fyVyX+CT1N8Lj+MdCnVzECbiCvQGOt0lKj5fFBn81KRV99SUgGnOlJKmS3AX7fA
         z3ECSUcYvB2Botl0dx079jtvyiFRWYP0JIv8MjJFBIYIiDBNVetH3woahRJ9wpo9GwAD
         qh6RqG037BgNIBZOcSE8eVHB51ldwy855QM7kWVuczzON39hqLCIwC/iFlu35EP9U43M
         fnJUr7bSc5Pg7+54IfrGvn6+G+y6cAtFXhQ4L1oLL+vAN/PMwU2mOfaWqAqDmh+JkDwg
         X68g==
X-Gm-Message-State: APzg51CLdxbgi+1t93A5nMOfr+7MdodBtz3UVmJxxu27XURezXdj4qBN
        GWiLwYnUZ7LeWmStt/zMIBJ7+xe9yPs=
X-Google-Smtp-Source: ANB0VdYukanjcphHaoG02TTHLR0fBneP1sMwTA2MG0pgyCR4YFM5g6jUHTAoQPg1pkuwHjxZNMpSLQ==
X-Received: by 2002:a1c:7e92:: with SMTP id z140-v6mr6461956wmc.48.1536863434441;
        Thu, 13 Sep 2018 11:30:34 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id v2-v6sm4837308wrs.54.2018.09.13.11.30.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 11:30:33 -0700 (PDT)
Date:   Thu, 13 Sep 2018 20:30:30 +0200
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 4.19-rc4
Message-ID: <20180913183030.GB23439@veci.piliscsaba.redhat.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-fixes-4.19-rc4

This fixes a regression in the recent file stacking update, reported and fixed
by Amir Goldstein.  The fix is fairly trivial, but involves adding a fadvise()
f_op and the associated churn in the vfs.  As discussed on -fsdevel, there are
other possible uses for this method, than allowing proper stacking for overlays.

And there's one other fix for a syzkaller detected oops.

Thanks,
Miklos

---
Amir Goldstein (6):
      ovl: respect FIEMAP_FLAG_SYNC flag
      ovl: fix GPF in swapfile_activate of file from overlayfs over xfs
      Documentation/filesystems: update documentation of file_operations
      vfs: add the fadvise() file operation
      vfs: implement readahead(2) using POSIX_FADV_WILLNEED
      ovl: add ovl_fadvise()

Miklos Szeredi (1):
      ovl: fix oopses in ovl_fill_super() failure paths

---
 Documentation/filesystems/vfs.txt | 21 +++++++++-
 fs/overlayfs/file.c               | 23 +++++++++--
 fs/overlayfs/inode.c              | 10 +++++
 fs/overlayfs/super.c              | 26 +++++++------
 include/linux/fs.h                |  5 +++
 mm/Makefile                       |  3 +-
 mm/fadvise.c                      | 81 +++++++++++++++++++++++----------------
 mm/readahead.c                    | 45 ++++++++--------------
 8 files changed, 134 insertions(+), 80 deletions(-)
