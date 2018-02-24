Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-52214-1519433696-2-9777873385320883459
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519433695; b=PjC3keUOLNQsEldY25qAdgvKYua+QiTWzOE/ImgfY2sqNmJ
    TYY09O6Cb6PaoppjGgAAcP1y4GSfM6ryaw/wK68H+9Sw4KmpJW6TzF75U2/gU5fm
    yJTX6o4mnzSAKkBcuMHxCiWVGgaiaOUTPiWEQ8uRXf6fJdZo6u6V3TKRH8XFkyuz
    fIUFBZiqUpeoJNXskNvRQ8YP8pucn/cUl7xMAgS6rUJLO3X1DCoHOgiZNUuJkIZp
    HpjxKM1vM8IxdncTy1cooh9EIjZavT6zEXV36EmrO/oHHNcD2kLIgvMpQ9SpUS6u
    FQxcGbctVvdFkHAzu15J7l8kYYy3IsZHgbQfvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1519433695; bh=JoaBVOIJJOugoGTuuZfFPMWZra
    z/qzXfiZDMuE7gvgE=; b=hRwLNq4EH4DGxvQ//FwqE8j6AbE2QCTEIacb0q2+Qh
    +e89xt7SgpKTBsJvpVQt0FybTeqDyzXjRgwXgj2IrKGcjDjc85PPrztUF3h8K+TZ
    Aj9PsyjpW7zZOPKJx2JHbdl3rgAvowl8YlX4pmSlcNauflOCZoL7/EWSmgA6QHCW
    fJOeIH58EqQ9qBLssRDdnTbD8obh238StOqxIdmA3ZtfXx0/rcQfTw79RycjlLfe
    fPzIkiR30sbjAEKBl7CEJdsLxhmpsnWW4sb6bT4I5b7KNMbZnt3sePKmdtbs8HQo
    eyp+jQ0zDOulrwFJ/ZOkvaAqXotHD6d6DGzpvtDfnYMg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751955AbeBXAwO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 19:52:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:3929 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751425AbeBXAwM (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 19:52:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,385,1515484800";
   d="scan'208";a="206547859"
Subject: [PATCH v3 0/6] vfio,
 dax: prevent long term filesystem-dax pins and other fixes
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Jane Chu <jane.chu@oracle.com>,
        Haozhong Zhang <haozhong.zhang@intel.com>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        kvm@vger.kernel.org, "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        kbuild test robot <fengguang.wu@intel.com>,
        Christoph Hellwig <hch@lst.de>
Date: Fri, 23 Feb 2018 16:43:05 -0800
Message-ID: <151943298533.29249.14597996053028346159.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Changes since v2 [1]:

* Fix yet more compile breakage in the FS_DAX=n and DEV_DAX=y case.
  (0day robot)

[1]: https://lists.01.org/pipermail/linux-nvdimm/2018-February/014046.html

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

---

Dan Williams (6):
      dax: fix vma_is_fsdax() helper
      dax: fix dax_mapping() definition in the FS_DAX=n + DEV_DAX=y case
      xfs, dax: introduce IS_FSDAX()
      dax: fix S_DAX definition
      dax: short circuit vma_is_fsdax() in the CONFIG_FS_DAX=n case
      vfio: disable filesystem-dax page pinning


 drivers/vfio/vfio_iommu_type1.c |   18 +++++++++++++++---
 fs/xfs/xfs_file.c               |   14 +++++++-------
 fs/xfs/xfs_ioctl.c              |    4 ++--
 fs/xfs/xfs_iomap.c              |    6 +++---
 fs/xfs/xfs_reflink.c            |    2 +-
 include/linux/dax.h             |    9 ++++++---
 include/linux/fs.h              |    8 ++++++--
 7 files changed, 40 insertions(+), 21 deletions(-)
