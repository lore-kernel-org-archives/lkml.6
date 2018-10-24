Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA8BC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C962054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 06:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuhsjVrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C962054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeJXPKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 11:10:16 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44079 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeJXPKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 11:10:16 -0400
Received: by mail-yb1-f195.google.com with SMTP id p144-v6so1651150yba.11;
        Tue, 23 Oct 2018 23:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=44lXhFijXc/WppbtbZeHRUNMlR8HSQS5PODiH30kUYQ=;
        b=fuhsjVrZnBfpx9ADm+BBzuVzDJDKkbNmdfWaDY1/LMbB9S+Y82fRG6+2M3Eku7kuH6
         rrj619TvzOKgb+DxOURDLxqvONxssCZEO7LQ6LRDlAP9TVVAYaiJLeOtRoDGu52CcTZw
         IkYtoAOzxAQUINCL8d/r7HVLYUkVRptwZUbcxSJNdX/oGQuS/9GZYy+EuOe3hd46eQ4+
         CXXlhRDcz4GE3Tc5Yn/Dz2UIMCLQM/KblB6ghG2WxsaJz2aV3vcD89NIG1p3Ipj/KDYk
         arBkt4eFJiJd48Q2out6tkrHsRbUiuXXjzHVRn0s8szsA/eD30WhX3vSEsOmml34JHfp
         a7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=44lXhFijXc/WppbtbZeHRUNMlR8HSQS5PODiH30kUYQ=;
        b=LA/TwYht8CBkf8QpIe3SwgC6EsdaX3NGzjyBZBBCFRPwQwP2msh+qPb3YPHVPvyFJO
         /deB7/gQKuenIuSR2N3FKX0TJbYt+ijigaaNAvDnHLYxzXdopzJchN86KsMhLkdn8EIL
         T42WJytXkB+QULb8Zq9OYqAljn+32/rqPQakZkAQmdQS1f7SmI7GE+/jmXjCPL7y0oIp
         DSAL2GM43rCSuB/3J4jTfjpbatB+Xl75YzyMN0+hia7hQc6MuzWtarOul80Dw0qjJmb4
         wPpv9W262/FVUjVuGjb3r93hVXdXIIPSPG845AE65NKqQBJ9wOykjxVP7BzgsrOjn6v+
         oR4Q==
X-Gm-Message-State: AGRZ1gKyZPnJt00w1KfqHs/epROrvC7dWQz1mAijjDRiisEYrrVRNNH2
        S395o1VlBe2oUePL/HoE3lByIBoQFFc7U2hcgfg=
X-Google-Smtp-Source: AJdET5cty0zimPhZr2DU3M+K6MW+JZDwgpiOSlgKa048L1VcIKCYIK+7+gcqMQVlp2PV6ZI2luT+WTCEu4zbY8sUkCE=
X-Received: by 2002:a25:6607:: with SMTP id a7-v6mr1110848ybc.507.1540363412500;
 Tue, 23 Oct 2018 23:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181023201952.GA15676@pathfinder>
In-Reply-To: <20181023201952.GA15676@pathfinder>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Oct 2018 09:43:21 +0300
Message-ID: <CAOQ4uxgFdquNqcRXETriSvwc24DDQbmu218WFv-a5K3k0nuu7Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/11] common implementation of dirent file types
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 11:19 PM Phillip Potter <phil@philpotter.co.uk> wrote:
>
> This cleanup series is a respin of Amir Goldstein's work, created
> in late 2016. It removes several instances of duplicated code. Most
> of the duplication dates back to git pre-historic era.
>
> The controversial aspect of this cleanup is that it uses common
> code to handle file system specific on-disk format bits.

We handled this aspect with care by placing compile time checks.

> All 7 file systems use a single byte to store dirent file type
> on-disk and all of them use the same conversion routines from
> i_mode to 4bits DT_* constants to 3bits on-disk FT_* constants.
>
> Patch 1 places a common implementation in file_type.h and
> add some useful conversion helpers.
>
> Patches 2-3 make use of some helpers in ufs and hfsplus
> without any on-disk implications.
>
> Patches 4-10 replace the specific implementations in ext2, exofs,
> ext4, ocfs2, f2fs, nilfs and btrfs with the common implementation.
> These patches also now include compile-time checks to ensure that
> the file system specific on-disk bits are equivalent to the common
> implementation FT_* bits. These compile-time checks are only
> included once per file system, as my reasoning is that regardless
> of their location, the build will fail/succeed anyway.
>
> In addition, where needed (for patches which no longer apply),
> I've rebased them to apply to the newest 4.19 kernel sources.
> Each patch is independent of the others, except for the
> common implementation itself which they all depend on.
>

This is still RFC, but since this is an exercise let's talk about social
engineering. First (now) you want to gather ACKs and review comments
from fs developers/maintainers.

Once all comments are addressed and assuming no objections, you have
two possible ways forward:

1. Wait for VFS maintainer to take the common code and patches ACKed
    by individual maintainers (Al practically maintains some of the small fs
    himself). Al's backlog is long, so this may be a long wait.

2. Ask a filesystem maintainer to carry the common patch along with his
   specific fs patch through his tree and let other maintainers apply the patch
   at their own will on the following development cycle.
   The ext2 tree would be a good candidate for such a move, if Jan accepts
   this change, considering that all other fs copied the buggy code from ext2.

> I would love feedback as newish kernel contributor, particularly
> from the original author Amir who suggested this task for me. I
> hope the various subsystem/fs maintainers will see fit to accept
> this work also.
>

I usually prefer to have the revisions log in the cover letter for
a 10 patch series, much less work and more appropriate when
revision log looks mostly the same on all patches, e.g.:

v2:
- Rebased against Linux 4.19 by Phillip Potter
- This version does not remove filesystem specific XXX_FT_x definitions,
  as these values are now used in compile-time checks added by
  Phillip Potter to make sure they remain the same as FT_x values
- Removed xfs patch (a variant of original patch has already been applied)
- Anything else relevant to the context of the series...

v1:
- Initial implementation by Amir Goldstein:
https://marc.info/?l=linux-fsdevel&m=148217829301701&w=2

> Phillip Potter (10):
>   fs: common implementation of file type conversions
>   ufs: use fs_umode_to_dtype() helper
>   hfsplus: use fs_umode_to_dtype() helper
>   ext2: use common file type conversion
>   exofs: use common file type conversion
>   ext4: use common file type conversion
>   ocfs2: use common file type conversion
>   f2fs: use common file type conversion
>   nilfs2: use common file type conversion
>   btrfs: use common file type conversion
> ---
>  MAINTAINERS                        |   1 +
>  fs/btrfs/btrfs_inode.h             |   2 -
>  fs/btrfs/delayed-inode.c           |   2 +-
>  fs/btrfs/inode.c                   |  35 +++++-----
>  fs/exofs/dir.c                     |  49 +++++--------
>  fs/ext2/dir.c                      |  51 ++++++--------
>  fs/ext4/ext4.h                     |  35 +++++-----
>  fs/f2fs/dir.c                      |  43 +++++-------
>  fs/f2fs/inline.c                   |   2 +-
>  fs/hfsplus/dir.c                   |  16 +----
>  fs/nilfs2/dir.c                    |  54 +++++----------
>  fs/ocfs2/dir.c                     |  32 +++++----
>  fs/ocfs2/ocfs2_fs.h                |  13 +---
>  fs/ufs/util.h                      |  29 +-------
>  include/linux/f2fs_fs.h            |   8 ++-
>  include/linux/file_type.h          | 108 +++++++++++++++++++++++++++++
>  include/linux/fs.h                 |  17 +----
>  include/uapi/linux/btrfs_tree.h    |   2 +
>  include/uapi/linux/nilfs2_ondisk.h |   1 +
>  19 files changed, 256 insertions(+), 244 deletions(-)
>  create mode 100644 include/linux/file_type.h
>
> --
> 2.17.2
>
