Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF50C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9931D20657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 21:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="g1RLGOHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9931D20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbeKBGKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 02:10:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35684 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeKBGKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 02:10:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id z16-v6so3541007wrv.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 14:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8dGuMLi8shuYtle0yeVROFuQkDRxAaOMJ/BWEdD4lCg=;
        b=g1RLGOHHrYLexTlHWvI6Tcn8ueZAIyNWZDHTMXYcKKhKOJBDMcCBC9C4Z19BUUX0tV
         r/LSWBWEQb4uUfPPzHXzq62Z+F1kuQAub3xVUzJRFYTEXglw4m8o1jUckjEt4W0S7Z6x
         xoFcCONY5hDZOAd2ODhKHsxzd/vMGk+e7fKyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8dGuMLi8shuYtle0yeVROFuQkDRxAaOMJ/BWEdD4lCg=;
        b=pi5ZKSl9adYXkvwY4Pe4hqiUaYxk14MThj+v9UHDAH5ljWvxgUtT8GklM31tIg3KuT
         FQ80V9YewvZfS7EK3GdUd0dKxEpoBCePwk2OV43nha4McX1gCkKv+i4bPOzzDyuWWgic
         BvGq35FyNQw09An4CxyjD+UaZ9ho256gA6blEjO8h+CseizQcwGiuUi/D9HeJvmNjdYf
         X0wEJ9ZDwJ9BQab2LkG3YJVTsoplajmrsmBu8r/vQ6lWWFgLZo+a7lOXZwo1vxGy5sE4
         3tbknm6xau48/i/tbXrA6kP0dawFWNr3+YbXvXyxe7x9kTO6sBSKsUmMioZtlbw2HkUJ
         qKbA==
X-Gm-Message-State: AGRZ1gK3pTKlWRCISYc51wKcbftSB9cAw8/uyM3Y5h1qR6R7NR5w2wxq
        54jFRigmkORGFgl08fLoW67Z/w==
X-Google-Smtp-Source: AJdET5cfiIwrOAqT+0HENU2Cw7IZj91BJqXDwYXbE3KP8v6Zilqg4ZJ+JN5NGNaHrz5j48VPcbyGSA==
X-Received: by 2002:adf:e0ce:: with SMTP id e14-v6mr8093295wri.199.1541106374917;
        Thu, 01 Nov 2018 14:06:14 -0700 (PDT)
Received: from veci.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id g10-v6sm2258184wru.39.2018.11.01.14.06.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 14:06:14 -0700 (PDT)
Date:   Thu, 1 Nov 2018 22:06:11 +0100
From:   Miklos Szeredi <miklos@szeredi.hu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs update for 4.20
Message-ID: <20181101210611.GH23439@veci.piliscsaba.redhat.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git tags/ovl-update-4.20

This contains a mix of fixes and cleanups.

Thanks,
Miklos

----------------------------------------------------------------
Amir Goldstein (7):
      ovl: fix error handling in ovl_verify_set_fh()
      vfs: fix FIGETBSZ ioctl on an overlayfs file
      ovl: fix recursive oi->lock in ovl_link()
      ovl: untangle copy up call chain
      ovl: relax requirement for non null uuid of lower fs
      ovl: remove the 'locked' argument of ovl_nlink_{start,end}
      ovl: abstract ovl_inode lock with a helper

Chengguang Xu (1):
      ovl: using posix_acl_xattr_size() to get size instead of posix_acl_to_xattr()

Miklos Szeredi (5):
      ovl: clean up error handling in ovl_get_tmpfile()
      ovl: relax permission checking on underlying layers
      ovl: fold copy-up helpers into callers
      ovl: check whiteout in ovl_create_over_whiteout()
      ovl: automatically enable redirect_dir on metacopy=on

---
 Documentation/filesystems/overlayfs.txt |   6 +
 fs/ioctl.c                              |   3 +
 fs/overlayfs/copy_up.c                  | 213 ++++++++++++++++++--------------
 fs/overlayfs/dir.c                      |  34 +++--
 fs/overlayfs/inode.c                    |  17 ++-
 fs/overlayfs/namei.c                    |   4 +-
 fs/overlayfs/overlayfs.h                |  14 ++-
 fs/overlayfs/super.c                    |  68 ++++++++--
 fs/overlayfs/util.c                     |  46 ++++---
 9 files changed, 260 insertions(+), 145 deletions(-)
