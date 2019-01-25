Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10A8C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2DB21915
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2J2Xwos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfAYI2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:28:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44122 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbfAYI2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:28:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so4226930plt.11;
        Fri, 25 Jan 2019 00:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=V8hJoKyXaoUESl3aFsZMgQYMtfaGubDrCWRZkqTGBCQ=;
        b=j2J2XwosZBnDTSBcO1+TgSCFvGX54cqFQqdZaVRW+TmuIqlkbfpzaPtEoek3msyxgb
         XXSFp6SwCsMfzf3Lbluy+egA8wg8RdI7GiT2oIKDfW/gzPxyQ4bVMhO7wfxIF34dg9Tc
         7CAx+Hyxn+CNphBQjVUwg61C5zhHILEatsEuRDrsM/2q1mGPGSO76cYo2YCh0+aLm0ah
         EJVUx3VYG2rX5p7O4A6rQyOJLpxQN01ekWc/YfAEd05YwlxDEfJ9TLisGjT0gfop6/2G
         vlN2Aho18yB6sUBmsI0UwO+H+6eAa4TnrKZ0pzJ4GYQF1tfnvyxg8a59bjVlHXDZaZkK
         fN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V8hJoKyXaoUESl3aFsZMgQYMtfaGubDrCWRZkqTGBCQ=;
        b=OP0fBuy+rcPXLoNQvkSiBBi2T+4ir9HAUQKBUo/JQCxruV1jhm37e6IDWHOx6uLIl9
         duBVW2OdKDff/GCs46RQj+1PegjUZZqAdFcWnEMbjRgKjDNvX43XX7o0DB+y9GZfGLgO
         HTLl/zY981jTFQnv4JSnaLojLFZ6gnvTnTWFw/oH5K0SuaKyo8tV/vTntOt8NA02qL5U
         cEG0BnQQf5CmDCAmgfPH3JAeXRJ8xV+M8X7gYGbsD3spxr74PRpkLKw3uMCppE1w036E
         UVBe1ciQGgRsVT/exaRhx+nifKGClDNsWGj12P5+KDslJhbz9uJa2k4GyGmXhGKrSuZq
         k4zw==
X-Gm-Message-State: AJcUukf86eIkVMbZY8dVzopTa7UPUXyPpDSWkxlKmCsJgUs4rf1FziYm
        2hLTr9qwwK5Wsg9+RoRrZLM=
X-Google-Smtp-Source: ALg8bN5+m6xS97ECNh2XNm1uwWV9pHk2I4HcJ/inW1OkpG3gWbOIQmzRNGXoSKw1OBysc9uO85vT4w==
X-Received: by 2002:a17:902:be0e:: with SMTP id r14mr9454206pls.124.1548404880339;
        Fri, 25 Jan 2019 00:28:00 -0800 (PST)
Received: from localhost ([43.224.245.181])
        by smtp.gmail.com with ESMTPSA id v89sm34880711pfk.12.2019.01.25.00.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 00:27:59 -0800 (PST)
From:   Geliang Tang <geliangtang@gmail.com>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Coly Li <colyli@suse.de>
Cc:     Geliang Tang <geliangtang@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] squashfs/squashfs-tools: Add posix acl support
Date:   Fri, 25 Jan 2019 16:27:46 +0800
Message-Id: <cover.1548403955.git.geliangtang@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use mksquashfs tool to create a squashfs image from the files which
have POSIX ACLs(Access Control Lists), we get these errors:

Unrecognised xattr prefix system.posix_acl_access
Unrecognised xattr prefix system.posix_acl_default

This patcheset adds posix acl support to squashfs to fix this problem. Patch
#1 for kerenl tree and patch #2 for squashfs-tools tree.

---

Testcase:

$ mkdir root
$ getfacl root
  # file: root
  # owner: tgl
  # group: tgl
  user::rwx
  group::r-x
  other::r-x
$ setfacl -m u:tgl:rw root
$ setfacl -m d:tgl:rw root
$ getfacl root
  # file: root
  # owner: tgl
  # group: tgl
  user::rwx
  user:tgl:rw-
  group::r-x
  mask::rwx
  other::r-x
  default:user::rwx
  default:user:tgl:rw-
  default:group::r-x
  default:mask::rwx
  default:other::r-x
$ getfattr -m . -d root
  # file: root
  system.posix_acl_access=0sAgAAAAEABwD/////AgAGAOgDAAAEAAUA/////xAABwD/////IAAFAP////8=
  system.posix_acl_default=0sAgAAAAEABwD/////AgAGAOgDAAAEAAUA/////xAABwD/////IAAFAP////8=

$ mksquashfs root root.img
$ sudo mount root.img /mnt/squash/

$ cd /mnt
$ getfacl squash
  # file: squash
  # owner: tgl
  # group: tgl
  user::rwx
  user:tgl:rw-
  group::r-x
  mask::rwx
  other::r-x
  default:user::rwx
  default:user:tgl:rw-
  default:group::r-x
  default:mask::rwx
  default:other::r-x
$ getfattr -m . -d squash
  # file: squash
  system.posix_acl_access=0sAgAAAAEABwD/////AgAGAOgDAAAEAAUA/////xAABwD/////IAAFAP////8=
  system.posix_acl_default=0sAgAAAAEABwD/////AgAGAOgDAAAEAAUA/////xAABwD/////IAAFAP////8=

---

Geliang Tang (1):
  squashfs: Add posix acl support

 Documentation/filesystems/squashfs.txt |  2 -
 fs/squashfs/Kconfig                    | 11 ++++
 fs/squashfs/Makefile                   |  1 +
 fs/squashfs/acl.c                      | 69 ++++++++++++++++++++++++++
 fs/squashfs/acl.h                      | 31 ++++++++++++
 fs/squashfs/inode.c                    |  4 +-
 fs/squashfs/namei.c                    |  6 ++-
 fs/squashfs/squashfs_fs.h              | 12 +++--
 fs/squashfs/super.c                    |  3 ++
 fs/squashfs/symlink.c                  |  6 ++-
 fs/squashfs/xattr.c                    | 31 +++++++++++-
 fs/squashfs/xattr.h                    |  8 +++
 12 files changed, 171 insertions(+), 13 deletions(-)
 create mode 100644 fs/squashfs/acl.c
 create mode 100644 fs/squashfs/acl.h

---

Geliang Tang (1):
  squashfs-tools: Add posix acl support

 squashfs-tools/read_xattrs.c |  2 ++
 squashfs-tools/squashfs_fs.h | 12 +++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

-- 
2.17.1

