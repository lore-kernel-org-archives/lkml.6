Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-494696-1519963603-2-3719804177391959387
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519963602; b=PwgxoFSqrpgaNvRghYxFqMF/RWpD8RO3DEVWxaHOomeduOx
    o+qSNuC8CGRUQkehL4C2KLS+cuWKs2JZmarbM5CfhLZI0O/eWqaH6bmRR+QJt2QX
    WZegdeGF3vPRbodcTwsyapx11vIv0u72OcNr759NU1XHKIHxYDRrS6oZaWzoponM
    GMNsNxBlH6MWOA+uxUWMPWDO7CTEkrdPf5SavtDNwrmUrOg0TVKmtq0K+W390N0U
    olTCoBRQDZ1gtp+RQNqLFRn4x7uRHN6i0+85mmTy70+pmoJYIyRVFOiE920506hV
    7bfh2hn3/Orj9I691lU9vHXH1mXcVyDAQ7bunkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1519963602; bh=aE2QBStWHO9FABnDJIvZw/bC6J
    QJbz9+OOEsXbOnpDk=; b=iganM9CYtzukK3YdSSDU8nRVMc4F9qB0nQwsjlySy9
    OCdmmXsvP+HLKpHQq80LbNwRjOQuCLNrieygPdmx3N44U/4s3ERJynQExh4uOIUJ
    pdnD7tDN78U3g+aEfqde/u3zGRwjIzb78MqGKaaYwpwZAlyLvsFT7sIlTwXsJsAJ
    G75YlmxHA93ewTmJHwqvaF4pSUsAITxk1dV1vyInM0wlFV7KrD+yMoaBjzyldfzi
    GsznV3zqw7l7Rhf19VLEqBnjXcc9M3kZ1ZnYuoov0huUGw/r1tA7pLAeK5IkmLnl
    sbk9uqPLnsAVKlEVq2W2+HOPNbEiq+Aq8cQwtD8yVjIw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164120AbeCBECm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 23:02:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:20032 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163935AbeCBECk (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 1 Mar 2018 23:02:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,409,1515484800";
   d="scan'208";a="38656139"
Subject: [PATCH v5 00/12] vfio,
 dax: prevent long term filesystem-dax pins and other fixes
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>, kvm@vger.kernel.org,
        Haozhong Zhang <haozhong.zhang@intel.com>,
        Jane Chu <jane.chu@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Gerd Rausch <gerd.rausch@oracle.com>, stable@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Christoph Hellwig <hch@lst.de>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-fsdevel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Mar 2018 19:53:33 -0800
Message-ID: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changes since v4 [1]:
* Fix the changelog of "dax: introduce IS_DEVDAX() and IS_FSDAX()" to
  better clarify the need for new helpers (Jan)
* Replace dax_sem_is_locked() with dax_sem_assert_held() (Jan)
* Use file_inode() in vma_is_dax() (Jan)
* Resend the full series to linux-xfs@ (Dave)
* Collect Jan's Reviewed-by

[1]: https://lists.01.org/pipermail/linux-nvdimm/2018-February/014271.html
---

The vfio interface, like RDMA, wants to setup long term (indefinite)
pins of the pages backing an address range so that a guest or userspace
driver can perform DMA to the with physical address. Given that this
pinning may lead to filesystem operations deadlocking in the
filesystem-dax case, the pinning request needs to be rejected.

The longer term fix for vfio, RDMA, and any other long term pin user, is
to provide a 'pin with lease' mechanism. Similar to the leases that are
hold for pNFS RDMA layouts, this userspace lease gives the kernel a way
to notify userspace that the block layout of the file is changing and
the kernel is revoking access to pinned pages.

Related to this change is the discovery that vma_is_fsdax() was causing
device-dax inode detection to fail. That lead to series of fixes and
cleanups to make sure that S_DAX is defined correctly in the
CONFIG_FS_DAX=n + CONFIG_DEV_DAX=y case.

---

Dan Williams (12):
      dax: fix vma_is_fsdax() helper
      dax: introduce IS_DEVDAX() and IS_FSDAX()
      ext2, dax: finish implementing dax_sem helpers
      ext2, dax: define ext2_dax_*() infrastructure in all cases
      ext4, dax: define ext4_dax_*() infrastructure in all cases
      ext2, dax: replace IS_DAX() with IS_FSDAX()
      ext4, dax: replace IS_DAX() with IS_FSDAX()
      xfs, dax: replace IS_DAX() with IS_FSDAX()
      mm, dax: replace IS_DAX() with IS_DEVDAX() or IS_FSDAX()
      fs, dax: kill IS_DAX()
      dax: fix S_DAX definition
      vfio: disable filesystem-dax page pinning


 drivers/vfio/vfio_iommu_type1.c |   18 ++++++++++++++--
 fs/ext2/ext2.h                  |    6 +++++
 fs/ext2/file.c                  |   19 +++++------------
 fs/ext2/inode.c                 |   10 ++++-----
 fs/ext4/file.c                  |   18 +++++-----------
 fs/ext4/inode.c                 |    4 ++--
 fs/ext4/ioctl.c                 |    2 +-
 fs/ext4/super.c                 |    2 +-
 fs/iomap.c                      |    2 +-
 fs/xfs/xfs_file.c               |   14 ++++++-------
 fs/xfs/xfs_ioctl.c              |    4 ++--
 fs/xfs/xfs_iomap.c              |    6 +++--
 fs/xfs/xfs_reflink.c            |    2 +-
 include/linux/dax.h             |   12 ++++++++---
 include/linux/fs.h              |   43 ++++++++++++++++++++++++++++-----------
 mm/fadvise.c                    |    3 ++-
 mm/filemap.c                    |    4 ++--
 mm/huge_memory.c                |    4 +++-
 mm/madvise.c                    |    3 ++-
 19 files changed, 102 insertions(+), 74 deletions(-)
