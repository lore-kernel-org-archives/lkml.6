Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2459081-1519376155-2-2712190547688699086
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519376154; b=MiKnOvwpx8iagI/ijuD2JX98C9jYju+FChZ2sRotcBPY3N5
    58qYPxMm4ctABbvMJ4pK2mge2Lgc56kO2UNdc6q7DbrqK37goK+PyKNQV5wXsjL6
    v/6D94ATfINIoVAQCEFh/kdMsbBG6ihgtH1mxT4xvXsP9pErHylymyy2BacT/2Pa
    Yil3RTQ4Ble6zCw9yDrEWFIa/NtNbTfKOgfr1cL3/syo6Py1WGyrHHtsvMiCLVzH
    umKontA9HLj1X7EnGCyHSFvVZr0QoJW5ys4M7jQaAF0eIj5P8S6WMFcx2YC86IsI
    UMXZX3iE6Dd6DuD59JDXwCOd6IoKH0+5ywRpL0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519376154; bh=UqfLLXZPByBDrWP6yXWEuMlxMa
    4z6RGIVVLvLBzG0Nc=; b=AUTiswTYQgNRjN6pqcNTOrWbZ6MrRxjXIesVR3X4Oc
    lem0ZgF8IP97TFTzFnQUjX49mrnqkf1Ep2qmhE98SKs+CAdf7yPpz5eYF0U86PIL
    maFqJwfXof9LWLVh1fpDIXW/pePGubc6WVKs1Wz0XnVqQaXLt6wiI2q4Lk0y796V
    F9nIlCHHyjil+FVl5QsguPw4dIciGGjVT/2SQ/84I9HBTLzGW2fQElH+YupiMVkb
    NXHzijgCbpuHwWJQzAY0YuNZYs8XhYYvi5wA3Ya8Nr10b7957zZMHJUd05Hee7Wp
    0I11US5UQa2y7Ww1YV2X1XVL9qu3gziPhKTqK8rnZTWQ==
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
        id S1751360AbeBWIzw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 03:55:52 -0500
Received: from mga14.intel.com ([192.55.52.115]:45254 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbeBWIzv (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 23 Feb 2018 03:55:51 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,382,1515484800";
   d="scan'208";a="30085610"
Date: Fri, 23 Feb 2018 16:55:47 +0800
From: Haozhong Zhang <haozhong.zhang@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, Michal Hocko <mhocko@suse.com>,
        Jan Kara <jack@suse.cz>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, Alex Williamson <alex.williamson@redhat.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        kbuild test robot <fengguang.wu@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/5] vfio, dax: prevent long term filesystem-dax pins
 and other fixes
Message-ID: <20180223085547.3kkbo5lbt3orkqqn@hz-desktop>
Mail-Followup-To: Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm@lists.01.org, Michal Hocko <mhocko@suse.com>,
        Jan Kara <jack@suse.cz>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, Alex Williamson <alex.williamson@redhat.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        kbuild test robot <fengguang.wu@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <151937026001.18973.12034171121582300402.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151937026001.18973.12034171121582300402.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20171027
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/22/18 23:17 -0800, Dan Williams wrote:
> Changes since v1 [1]:
> 
> * Fix the detection of device-dax file instances in vma_is_fsdax().
>   (Haozhong, Gerd)
> 
> * Fix compile breakage in the FS_DAX=n and DEV_DAX=y case. (0day robot)
> 
> [1]: https://lists.01.org/pipermail/linux-nvdimm/2018-February/014046.html
> 
> ---
> 
> The vfio interface, like RDMA, wants to setup long term (indefinite)
> pins of the pages backing an address range so that a guest or userspace
> driver can perform DMA to the with physical address. Given that this
> pinning may lead to filesystem operations deadlocking in the
> filesystem-dax case, the pinning request needs to be rejected.
> 
> The longer term fix for vfio, RDMA, and any other long term pin user, is
> to provide a 'pin with lease' mechanism. Similar to the leases that are
> hold for pNFS RDMA layouts, this userspace lease gives the kernel a way
> to notify userspace that the block layout of the file is changing and
> the kernel is revoking access to pinned pages.
> 
> ---
> 
> Dan Williams (5):
>       dax: fix vma_is_fsdax() helper
>       dax: fix dax_mapping() definition in the FS_DAX=n + DEV_DAX=y case
>       dax: fix S_DAX definition
>       dax: short circuit vma_is_fsdax() in the CONFIG_FS_DAX=n case
>       vfio: disable filesystem-dax page pinning
> 
> 
>  drivers/vfio/vfio_iommu_type1.c |   18 +++++++++++++++---
>  include/linux/dax.h             |    9 ++++++---
>  include/linux/fs.h              |    6 ++++--
>  3 files changed, 25 insertions(+), 8 deletions(-)

Tested on QEMU with fs-dax and device-dax as vNVDIMM backends
respectively with vfio passthrough. The fs-dax case fails QEMU as
expected, and the device-dax case works normally now.

Tested-by: Haozhong Zhang <haozhong.zhang@intel.com>
