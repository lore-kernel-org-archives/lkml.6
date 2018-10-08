Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A55C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB252089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB252089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeJHXFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:05:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:53544 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbeJHXFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:05:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2018 08:53:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,357,1534834800"; 
   d="scan'208";a="95662383"
Received: from ddalessa-mobl2.amr.corp.intel.com (HELO [10.254.206.32]) ([10.254.206.32])
  by fmsmga004.fm.intel.com with ESMTP; 08 Oct 2018 08:50:52 -0700
Subject: Re: [PATCH v3 0/3] get_user_pages*() and RDMA: first steps
To:     john.hubbard@gmail.com, Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jerome Glisse <jglisse@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ralph Campbell <rcampbell@nvidia.com>
References: <20181006024949.20691-1-jhubbard@nvidia.com>
From:   Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <8973680e-4391-48cf-e979-1e9a10be0968@intel.com>
Date:   Mon, 8 Oct 2018 11:50:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181006024949.20691-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/2018 10:49 PM, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> Changes since v2:
> 
> -- Absorbed more dirty page handling logic into the put_user_page*(), and
>     handled some page releasing loops in infiniband more thoroughly, as per
>     Jason Gunthorpe's feedback.
> 
> -- Fixed a bug in the put_user_pages*() routines' loops (thanks to
>     Ralph Campbell for spotting it).
> 
> Changes since v1:
> 
> -- Renamed release_user_pages*() to put_user_pages*(), from Jan's feedback.
> 
> -- Removed the goldfish.c changes, and instead, only included a single
>     user (infiniband) of the new functions. That is because goldfish.c no
>     longer has a name collision (it has a release_user_pages() routine), and
>     also because infiniband exercises both the put_user_page() and
>     put_user_pages*() paths.
> 
> -- Updated links to discussions and plans, so as to be sure to include
>     bounce buffers, thanks to Jerome's feedback.
> 
> Also:
> 
> -- Dennis, thanks for your earlier review, and I have not yet added your
>     Reviewed-by tag, because this revision changes the things that you had
>     previously reviewed, thus potentially requiring another look.

This spin looks fine to me.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
