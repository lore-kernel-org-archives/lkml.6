Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754596AbeBGPnz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 10:43:55 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:55663 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754528AbeBGPnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 10:43:52 -0500
X-Google-Smtp-Source: AH8x224kDIAig0xbE0lqrblsLclIEUH3kvGQxRZuUxAxayLf9LtzFqAByE8D9rZRCn4A56KZYwI7CQ==
From: Dongsu Park <dongsu@kinvolk.io>
To: linux-kernel@vger.kernel.org
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Alban Crequy <alban@kinvolk.io>, Dongsu Park <dongsu@kinvolk.io>
Subject: [RFC PATCH v5 0/2] ima,fuse: introduce new fs flag FS_IMA_NO_CACHE
Date: Wed,  7 Feb 2018 16:45:11 +0100
Message-Id: <cover.1517999503.git.dongsu@kinvolk.io>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset v5 introduces a new fs flag FS_IMA_NO_CACHE and uses it in
FUSE. This forces files to be re-measured, re-appraised and re-audited
on file systems with the feature flag FS_IMA_NO_CACHE. In that way,
cached integrity results won't be used.

There was a previous attempt (unmerged) with a IMA option named "force" and using
that option for FUSE filesystems. These patches use a different approach
so that the IMA subsystem does not need to know about FUSE.
- https://www.spinics.net/lists/linux-integrity/msg00948.html
- https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1584131.html

Changes since v1: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1587390.html
- include linux-fsdevel mailing list in cc
- mark patch as RFC
- based on next-integrity, without other unmerged FUSE / IMA patches

Changes since v2: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1587678.html
- rename flag to FS_IMA_NO_CACHE
- split patch into 2

Changes since v3: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1592393.html
- make the code simpler by resetting IMA_DONE_MASK

Changes since v4: https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1598387.html
- add Acked-by from Miklos
- change ordering of patches as suggested by Miklos
- improve commit messages
- code diff since v4 is empty: only commit messages, ordering were changed

The patchset is also available in our github repo:
  https://github.com/kinvolk/linux/tree/dongsu/fuse-flag-ima-nocache-v5


Alban Crequy (2):
  ima: force re-appraisal on filesystems with FS_IMA_NO_CACHE
  fuse: introduce new fs_type flag FS_IMA_NO_CACHE

 fs/fuse/inode.c                   |  2 +-
 include/linux/fs.h                |  1 +
 security/integrity/ima/ima_main.c | 15 +++++++++++++--
 3 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.13.6
