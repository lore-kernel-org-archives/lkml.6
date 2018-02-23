Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3400184-1519405013-2-1043209302358362354
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519405013; b=sS4sDYIolSrIKpeoisAhJAlMOaafBlvNIQmiUxt92H2XJeK
    qSgEa3kTFmx/0KsEcpdiZfKc46cSLuYWGqjafyx88CAjmbGktvCywnwi+BYplPqd
    KR4vhVPjjIDU7oUCjJEbqDsM9H5gW7MbayllpH0rpAMLr0zT6vqMhPvIiaxHekOQ
    NDwaSeNitxn/XazrqCJbLj4/moI9ZnlAWwQsowgHqnNHMwY/DLT8nyeewmSJPDYb
    +jXMgRZHVPGFSoeb+iV68BJ2/+PcmhbKUj2qm2CHNcsoykeOFujfcUw2Bc4s8RZd
    1nYGpiqgC7JdUyD2N+HVfbCPYC1LlK1tpxHin8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:content-type:sender:list-id; s=
    arctest; t=1519405013; bh=cnurs9Tp0vLSTXJuWmDtGjeYFE+la18anY37Fd
    dRLwg=; b=viA8/qaoVfCbhmbk5BauG4UHXF/n5UT9vWfn3jSeJKYChBi0FX+pC2
    Wp7QdzrV91ty/a9FZPpyTDGhWMcG15cPpKMw5mZRGOT6sPF1h8jo25kXM4Vvp9Pt
    FJlO0Cqx/1Ud7xEADg4RKz/AS3R94cViiAtbykY9pGi9HNVK5c5+jTp1GeRB1k71
    yv8YrKLoUegvlfUqmTQrXebhW/nujfVhDz08W6sg3zOklUw3Z1DIW5LwrLR/XsU+
    0wjHMCrWXo/adEJoeV5lmPNUVUBj8k0fblPVJYv30sLUC+W9QK+cB+os4dtodsN2
    xklLlKhpdoHDf38VdyLAUgP4ido+yMzw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=ev7Lk693 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=erY+ui52;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=ev7Lk693 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=erY+ui52;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751845AbeBWQ4L (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 11:56:11 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33784 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751733AbeBWQ4J (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 11:56:09 -0500
X-Google-Smtp-Source: AG47ELuNT0h61NPevYyxaK95p20NZpzAfwR/vdPZ2ZIGfo4+YskIVbDVH5zV5uC7osqSxfVvKzoc/xuSiYX60NaDVoA=
MIME-Version: 1.0
In-Reply-To: <20180223085547.3kkbo5lbt3orkqqn@hz-desktop>
References: <151937026001.18973.12034171121582300402.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180223085547.3kkbo5lbt3orkqqn@hz-desktop>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 23 Feb 2018 08:56:06 -0800
Message-ID: <CAPcyv4hmzhY6paR+AayNMmbdM3Fg2Rg2dKwH7NoYAQA25GcgSg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] vfio, dax: prevent long term filesystem-dax pins
 and other fixes
To: Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        KVM list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Gerd Rausch <gerd.rausch@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 12:55 AM, Haozhong Zhang
<haozhong.zhang@intel.com> wrote:
> On 02/22/18 23:17 -0800, Dan Williams wrote:
>> Changes since v1 [1]:
>>
>> * Fix the detection of device-dax file instances in vma_is_fsdax().
>>   (Haozhong, Gerd)
>>
>> * Fix compile breakage in the FS_DAX=n and DEV_DAX=y case. (0day robot)
>>
>> [1]: https://lists.01.org/pipermail/linux-nvdimm/2018-February/014046.html
>>
>> ---
>>
>> The vfio interface, like RDMA, wants to setup long term (indefinite)
>> pins of the pages backing an address range so that a guest or userspace
>> driver can perform DMA to the with physical address. Given that this
>> pinning may lead to filesystem operations deadlocking in the
>> filesystem-dax case, the pinning request needs to be rejected.
>>
>> The longer term fix for vfio, RDMA, and any other long term pin user, is
>> to provide a 'pin with lease' mechanism. Similar to the leases that are
>> hold for pNFS RDMA layouts, this userspace lease gives the kernel a way
>> to notify userspace that the block layout of the file is changing and
>> the kernel is revoking access to pinned pages.
>>
>> ---
>>
>> Dan Williams (5):
>>       dax: fix vma_is_fsdax() helper
>>       dax: fix dax_mapping() definition in the FS_DAX=n + DEV_DAX=y case
>>       dax: fix S_DAX definition
>>       dax: short circuit vma_is_fsdax() in the CONFIG_FS_DAX=n case
>>       vfio: disable filesystem-dax page pinning
>>
>>
>>  drivers/vfio/vfio_iommu_type1.c |   18 +++++++++++++++---
>>  include/linux/dax.h             |    9 ++++++---
>>  include/linux/fs.h              |    6 ++++--
>>  3 files changed, 25 insertions(+), 8 deletions(-)
>
> Tested on QEMU with fs-dax and device-dax as vNVDIMM backends
> respectively with vfio passthrough. The fs-dax case fails QEMU as
> expected, and the device-dax case works normally now.
>
> Tested-by: Haozhong Zhang <haozhong.zhang@intel.com>
>

Thank you!
