Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-542515-1517786092-2-13196311420240464483
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517786091; b=We2pC2c5FbHMGVud7152NWzNrpa4yOLNgFTjqiPN6ZANtxM
    ezLpkA/WdjeJkMwl0tQ1tYyN6DtbKh3Z5CfQx2dzs1F0P27LTp7Xa7iQ1y0LXIbB
    36D361E57Uup+INVTMq+bcB6TA380UjGqgiccEzbTtiDsp6DnNI2TdLr8KTvPTyq
    EC1Q6L0hFtgPEWegiYUIrUKABFi5VD7fhcv+zerwqLOdmEuXQH5CYJ/xeNfXGlCx
    Y6g1/7XRbQhmk1yYQmsTkcxJLIbJ/VPQs8ir+cAmmvs8tubwEN9USE/iCAReCeMz
    j4H+7ZCP1e2r3hA+Z5L+kNtxZ/cGKJqaZg9NRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1517786091; bh=4vI1ys3nOVHjun+dpGyOzf8A1U
    oVe0O7Y+qrzTDjU8k=; b=S/WfAoFjo7WoVLIYdzqWX8T5iHFZFzV03kE7q9dz58
    UFN9P5ViqHePYHp8cb8+AOaqWdH2xqZRN1hooNpTwkRaYfgYv8NxMnKUFT0SQVl2
    OCUXezV5kCE/2PIEjbQuDz7hds/ukI1F9prnbH3+jn6clPJHf+dvfkGN0ykWeMe9
    alwGU9P/TiDz7vFBeq00L7wTKF/Hu+Wx1/wMDBlmIptctahQD3il4oLhNceSVqwA
    0IVbpYwqnp914Ta0bumcK0uBvM3qiaJ/9rpCa9uqt42TFU4+3YPksklkIkDlUOx+
    lk0bF7SgAjUW0ofbX9VeRSqbcG4SQ6do7U+iNeKoKrbw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751979AbeBDXOW (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Feb 2018 18:14:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:32349 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751797AbeBDXOV (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 4 Feb 2018 18:14:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,462,1511856000";
   d="scan'208";a="15387531"
Subject: [PATCH 0/3] vfio, dax: disable filesystem-dax and minor fixups
From: Dan Williams <dan.j.williams@intel.com>
To: alex.williamson@redhat.com
Cc: Haozhong Zhang <haozhong.zhang@intel.com>,
        Michal Hocko <mhocko@suse.com>, jack@suse.cz,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, hch@lst.de
Date: Sun, 04 Feb 2018 15:05:15 -0800
Message-ID: <151778551496.7139.17808629759104553625.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.17.1-9-g687f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Alex, here is a change to vaddr_get_pfn() that we discussed in this
thread: https://lists.nongnu.org/archive/html/qemu-devel/2018-01/msg07117.html

Namely, drop support for passing Filesystem-DAX mappings through to
guests. Perhaps in the future we can create some para-virtualized
passthrough interface to coordinate guest-DMA vs host-filesystem
operations. For now, this needs to be disabled for data-integrity and
guaranteeing forward progress of filesystem operations.

If you want to take this through your tree please grab the other dax
fixups as well. Otherwise, let me know and I'll take the lot through the
nvdimm tree.

---

Dan Williams (3):
      dax: fix S_DAX definition
      dax: short circuit vma_is_fsdax() in the CONFIG_FS_DAX=n case
      vfio: disable filesystem-dax page pinning


 drivers/vfio/vfio_iommu_type1.c |   18 +++++++++++++++---
 include/linux/fs.h              |    4 +++-
 2 files changed, 18 insertions(+), 4 deletions(-)
