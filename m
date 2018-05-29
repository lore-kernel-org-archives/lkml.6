Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2266183-1527606170-2-7134868944380034300
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527606170; b=IpWTF0lgfQMbMMgJiBBDk7cEJYTT88pVedIbAT8qa0G6M3NdgU
    fZRqfVPkVuksJ2ojN9nrUNRve4hLPNz2tyB12uzT1Ki0eAC/IS0B9DE3OMaYpMf2
    MbZZJZkgnlqHLovF98Y8WG95pMZhioKVL2JpQ1wAOgUK7T4vAt7bQXV10m+tFBrP
    jymF/MXrD9Aj89SUDqZ9VeoxIoiKg9uR43LNRYVRLbv5Ex6bwg9Ox0Fcr1deJw2B
    WEIJ4dDVdkS+CuY1Mu0fpeDCNfwXh3HJJpitYleYI0iHUq2j/TzHvkCR0KgH9yZw
    ISNQ8bO4Eim4TcqcuN+UGHTAfkpHBS7Hdk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1527606170; bh=xFlCErCmH+lISq+vSL/pIbET5PEG4w
    u3w+qxw+1ObJo=; b=JbjUgZKK4NtrNgy1wNyl7sG2dE76sNTcNEG+i5HPrdXHn3
    uUsSZIlkxBKNt9OoLHK5n6dZDzFQhC5aDCiCxlW5djVOwomPzuTp3D/hAtmNbSPj
    to4b7zpE8zIyR1nGHQVw6TYM9T9FCFuYLldMr3SydMBaGY/ViTct4v+0GLMXI3Fm
    HaAEmbWbAbiW8tnlW8KBqH1IysByvUgTV/umru6BMY2aRy9vVyfBw+9u43wLzJAO
    IImYJcEIEH2GAzMLUVev97gWNBI/lxWJ1JRCOcQd3xXnwSyssHP5wjHC46bgIjOU
    sDghqrDZZ9bILSWiK6jN80l724eFoN1zMGGuXjeA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=iPCl0i5R;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=iPCl0i5R;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA41ga+L1qzrk9DLPGe6Riu4Ih/IYCpSAxYO0dhHyY4rPN28xllG/Yepj5OSZaaOp2hxvP2JCuHp+iWa/Svf8rsGbl1jsMekK7oYXe+GoCu5ywd5Nr64
    eTHaXtr7IA5Ue661ao45akjuMY43sAX9TbBdCwGkTv+x84ctRQ3qYc9VbhULemvZY7eZaWQYydwnh3HiAoFnNS2swT1p6dL1ECup8/3JtjmWWGsPnFz0ETeR
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=377o92pKoen1FR3zB3wA:9
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935574AbeE2OqR (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:46:17 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46907 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935276AbeE2OqP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:46:15 -0400
X-Google-Smtp-Source: AB8JxZopv9SZMK8H1PtoZ41SLnYSXszPAfMCTKv23UZ94789TxU1rBzvK+fna566WsHbl/0cBlND7A==
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/28] overlayfs: Delayed copy up of data
Date: Tue, 29 May 2018 16:45:44 +0200
Message-Id: <20180529144612.16675-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In one of the recent converstions, people mentioned that chown/chmod
lead to copy up files as well as data. We could optimize it so that
only metadata is copied up during chown/chmod and data is copied up when
file is opened for WRITE.

This optimization potentially could be useful with containers and user
namespaces. In popular scenario, people end up doing chown() on whole
image directory tree based on container mappings. And this chown copies
up everything, breaking sharing of page cache between containers.

With these patches, only metadat is copied up during chown() and if file
is opened for READ, d_real() returns lower dentry/inode. That way,
different containers can still continue to use page cache. That's the
use case I have in mind.

---
Vivek Goyal (28):
  ovl: Initialize ovl_inode->redirect in ovl_get_inode()
  ovl: Move the copy up helpers to copy_up.c
  ovl: Provide a mount option metacopy=on/off for metadata copyup
  ovl: During copy up, first copy up metadata and then data
  ovl: Copy up only metadata during copy up where it makes sense
  ovl: Add helper ovl_already_copied_up()
  ovl: A new xattr OVL_XATTR_METACOPY for file on upper
  ovl: Use out_err instead of out_nomem
  ovl: Modify ovl_lookup() and friends to lookup metacopy dentry
  ovl: Copy up meta inode data from lowest data inode
  ovl: Add helper ovl_dentry_lowerdata() to get lower data dentry
  ovl: Fix ovl_getattr() to get number of blocks from lower
  ovl: Store lower data inode in ovl_inode
  ovl: Add helper ovl_inode_realdata()
  ovl: Open file with data except for the case of fsync
  ovl: Do not expose metacopy only dentry from d_real()
  ovl: Move some dir related ovl_lookup_single() code in else block
  ovl: Check redirects for metacopy files
  ovl: Treat metacopy dentries as type OVL_PATH_MERGE
  ovl: Add an inode flag OVL_CONST_INO
  ovl: Do not set dentry type ORIGIN for broken hardlinks
  ovl: Set redirect on metacopy files upon rename
  ovl: Set redirect on upper inode when it is linked
  ovl: Check redirect on index as well
  ovl: Disbale metacopy for MAP_SHARED mmap()
  ovl: Do not do metadata only copy-up for truncate operation
  ovl: Do not do metacopy only for ioctl modifying file attr
  ovl: Enable metadata only feature

 Documentation/filesystems/overlayfs.txt |  30 +++-
 fs/overlayfs/Kconfig                    |  19 +++
 fs/overlayfs/copy_up.c                  | 160 ++++++++++++++++-----
 fs/overlayfs/dir.c                      |  74 +++++++---
 fs/overlayfs/export.c                   |   3 +
 fs/overlayfs/file.c                     |  43 ++++--
 fs/overlayfs/inode.c                    | 112 +++++++++------
 fs/overlayfs/namei.c                    | 195 ++++++++++++++++----------
 fs/overlayfs/overlayfs.h                |  33 ++++-
 fs/overlayfs/ovl_entry.h                |   6 +-
 fs/overlayfs/super.c                    |  62 +++++++-
 fs/overlayfs/util.c                     | 241 +++++++++++++++++++++++++++++++-
 12 files changed, 780 insertions(+), 198 deletions(-)

-- 
2.14.3
