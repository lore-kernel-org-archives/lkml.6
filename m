Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03475C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB8E20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 21:35:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB8E20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbeGYWtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 18:49:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:43391 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730370AbeGYWtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 18:49:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 14:35:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,402,1526367600"; 
   d="scan'208";a="243319781"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.93])
  by orsmga005.jf.intel.com with ESMTP; 25 Jul 2018 14:35:33 -0700
Subject: Re: [PATCH v2 0/6] kaddr and pfn can be NULL to ->direct_access()
To:     Huaisheng Ye <yehs2007@zoho.com>, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com
Cc:     ross.zwisler@linux.intel.com, willy@infradead.org,
        vishal.l.verma@intel.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, viro@zeniv.linux.org.uk,
        martin.petersen@oracle.com, axboe@kernel.dk,
        gregkh@linuxfoundation.org, bart.vanassche@wdc.com, jack@suse.cz,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, chengnt@lenovo.com, colyli@suse.de,
        Huaisheng Ye <yehs1@lenovo.com>
References: <20180725162849.8320-1-yehs2007@zoho.com>
From:   Dave Jiang <dave.jiang@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.jiang@intel.com; prefer-encrypt=mutual; keydata=
 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
 o6nmKbYpUAltQObU2w==
Message-ID: <3689520a-4a49-4e1f-6ee9-2ff4a9796b9f@intel.com>
Date:   Wed, 25 Jul 2018 14:35:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180725162849.8320-1-yehs2007@zoho.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pretty straight forward series. Huaisheng, I can apply the whole series
to libnvdimm if we can get ack's from maintainer of dcssblk and
dm-writecache for the respective bits.

On 07/25/2018 09:28 AM, Huaisheng Ye wrote:
> From: Huaisheng Ye <yehs1@lenovo.com>
> 
> Changes since v1 [1]:
> * Involve the previous patches for pfn can be NULL.
> * Reword the patch descriptions according to Christian's comment.
> * According to Ross's suggestion, replace local pointer dummy_addr
>   with NULL within md/dm-writecache for direct_access.
> 
> [1]: https://lkml.org/lkml/2018/7/24/199
> 
> Some functions within fs/dax, dax/super and md/dm-writecache don't
> need to get local pointer kaddr or variable pfn from direct_access.
> Assigning NULL to kaddr or pfn to ->direct_access() is more
> straightforward and simple than offering a useless local pointer or
> variable.
> 
> So all ->direct_access() need to check the validity of pointer kaddr
> and pfn for NULL assignment. If either of them is equal to NULL, that
> is to say callers may have no need for kaddr or pfn, so this series of
> patch are prepared for allowing them to pass in NULL instead of having
> to pass in a local pointer or variable that they then just throw away.
> 
> Huaisheng Ye (6):
>   libnvdimm, pmem: kaddr and pfn can be NULL to ->direct_access()
>   s390, dcssblk: kaddr and pfn can be NULL to ->direct_access()
>   tools/testing/nvdimm: kaddr and pfn can be NULL to ->direct_access()
>   dax/super: Do not request a pointer kaddr when not required
>   md/dm-writecache: Don't request pointer dummy_addr when not required
>   filesystem-dax: Do not request kaddr and pfn when not required
> 
>  drivers/dax/super.c             |  3 +--
>  drivers/md/dm-writecache.c      |  3 +--
>  drivers/nvdimm/pmem.c           |  7 +++++--
>  drivers/s390/block/dcssblk.c    |  8 +++++---
>  fs/dax.c                        | 13 ++++---------
>  tools/testing/nvdimm/pmem-dax.c | 12 ++++++++----
>  6 files changed, 24 insertions(+), 22 deletions(-)
> 
