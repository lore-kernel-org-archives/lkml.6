Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA43C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01DA20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 20:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="0B+gpffK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01DA20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeJXEow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 00:44:52 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36270 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbeJXEow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 00:44:52 -0400
Received: by mail-wm1-f68.google.com with SMTP id a8-v6so3116891wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 13:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RASX/Smb3EA5sXLLVUGDcgBPZGM9PSCodDkNGI26Joo=;
        b=0B+gpffKeqD4NJWFfzN5FmtMp1VHFZrKBa3Fp9jSV1C1smaMW70sT5c1iRgQwClCDV
         NLYMypUpSiQo+btpuMhsqRY3AwEeMI4j2X/HlE2WX1TCqw5blgw0zXaL4if4NaXARBma
         /1m6Jl0MnOxxzllp1r5qg+tnnkY4FIs34Bud55St1e50PR8dfADdtyVGIPeNSJ+iEsLX
         WZBOUqcF5OrZwPA3wg9JTZijriy1VPt3P57UceLjRmStaMC7HTOj3YNarCTrU5xYZroR
         /OnKxX3ObG0r9fukdnuU5WEqcwqQuZtC8GihHKbd84Y9MWEigB0vOSPSsq/lOjpbyO5G
         JxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RASX/Smb3EA5sXLLVUGDcgBPZGM9PSCodDkNGI26Joo=;
        b=Tee8YjKj2LlXfrSxBTUl2oQ8+3VmSqsVvSIz5CTSOiAJTWUcRAyGGzJL3/26w6RlAr
         xkkVKvAlPvdutxPNi0w1Ivi8JuJEHZXj63/EMo5IAx/eqYq3rcGxPBMPV+F9YwkQnGSO
         c3E9BGD/yKP+k5XkzRnp/jtDTg/MLmXPMegOlPlqbukoN3ttItr86CnsxQxBVfd0JzDk
         HEIT7fqWQwwJ1CjAvbIutsge5sHY2mxS6UIiMpXZkAGiSCYI/pVFgN9R0Iybvcg+roJz
         KHT66B26Nrs9TWMJl0JEtY2y0V9+E+YPIBTWjgnWrrf7MroKAU4M/sKa+GpKbsZwEuiV
         gH4g==
X-Gm-Message-State: ABuFfoidXDjxHOJejU4vQy4wGbGzlJ/qkU3pjlXt+Or/bKbjyLmcp1Bn
        ZVWN9Wmk+6EVNeqcy5i3xeuamQ==
X-Google-Smtp-Source: ACcGV60IQW5qtDyFUR2WfqyjhTO32ydTg83Gp0DtFunwJBj8afWukKUKFV0M2Luvh3RLYupdF5ilWw==
X-Received: by 2002:a1c:a90:: with SMTP id 138-v6mr22427628wmk.49.1540325993790;
        Tue, 23 Oct 2018 13:19:53 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id v129-v6sm1425788wme.45.2018.10.23.13.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 13:19:53 -0700 (PDT)
Date:   Tue, 23 Oct 2018 21:19:52 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 00/11] common implementation of dirent file types
Message-ID: <20181023201952.GA15676@pathfinder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This cleanup series is a respin of Amir Goldstein's work, created
in late 2016. It removes several instances of duplicated code. Most
of the duplication dates back to git pre-historic era.

The controversial aspect of this cleanup is that it uses common
code to handle file system specific on-disk format bits.
All 7 file systems use a single byte to store dirent file type
on-disk and all of them use the same conversion routines from
i_mode to 4bits DT_* constants to 3bits on-disk FT_* constants.

Patch 1 places a common implementation in file_type.h and
add some useful conversion helpers.

Patches 2-3 make use of some helpers in ufs and hfsplus
without any on-disk implications.

Patches 4-10 replace the specific implementations in ext2, exofs,
ext4, ocfs2, f2fs, nilfs and btrfs with the common implementation.
These patches also now include compile-time checks to ensure that
the file system specific on-disk bits are equivalent to the common
implementation FT_* bits. These compile-time checks are only
included once per file system, as my reasoning is that regardless
of their location, the build will fail/succeed anyway.

In addition, where needed (for patches which no longer apply),
I've rebased them to apply to the newest 4.19 kernel sources.
Each patch is independent of the others, except for the
common implementation itself which they all depend on.

I would love feedback as newish kernel contributor, particularly
from the original author Amir who suggested this task for me. I
hope the various subsystem/fs maintainers will see fit to accept
this work also.

Phillip Potter (10):
  fs: common implementation of file type conversions
  ufs: use fs_umode_to_dtype() helper
  hfsplus: use fs_umode_to_dtype() helper
  ext2: use common file type conversion
  exofs: use common file type conversion
  ext4: use common file type conversion
  ocfs2: use common file type conversion
  f2fs: use common file type conversion
  nilfs2: use common file type conversion
  btrfs: use common file type conversion
---
 MAINTAINERS                        |   1 +
 fs/btrfs/btrfs_inode.h             |   2 -
 fs/btrfs/delayed-inode.c           |   2 +-
 fs/btrfs/inode.c                   |  35 +++++-----
 fs/exofs/dir.c                     |  49 +++++--------
 fs/ext2/dir.c                      |  51 ++++++--------
 fs/ext4/ext4.h                     |  35 +++++-----
 fs/f2fs/dir.c                      |  43 +++++-------
 fs/f2fs/inline.c                   |   2 +-
 fs/hfsplus/dir.c                   |  16 +----
 fs/nilfs2/dir.c                    |  54 +++++----------
 fs/ocfs2/dir.c                     |  32 +++++----
 fs/ocfs2/ocfs2_fs.h                |  13 +---
 fs/ufs/util.h                      |  29 +-------
 include/linux/f2fs_fs.h            |   8 ++-
 include/linux/file_type.h          | 108 +++++++++++++++++++++++++++++
 include/linux/fs.h                 |  17 +----
 include/uapi/linux/btrfs_tree.h    |   2 +
 include/uapi/linux/nilfs2_ondisk.h |   1 +
 19 files changed, 256 insertions(+), 244 deletions(-)
 create mode 100644 include/linux/file_type.h

--
2.17.2

