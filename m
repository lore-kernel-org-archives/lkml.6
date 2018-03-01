Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033618AbeCARru (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:47:50 -0500
Received: from mga05.intel.com ([192.55.52.43]:32558 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033504AbeCARrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:47:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,408,1515484800";
   d="scan'208";a="204784021"
Subject: Re: [PATCH] infiniband: remove redundant assignment to pointer 'rdi'
To: Colin King <colin.king@canonical.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180301162354.17420-1-colin.king@canonical.com>
From: Don Hiatt <don.hiatt@intel.com>
Message-ID: <f229e924-8447-5656-12cc-4a7507a6130d@intel.com>
Date: Thu, 1 Mar 2018 09:47:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301162354.17420-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/2018 8:23 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer rdi is being initialized with a value that is never read
> and re-assigned immediately after, hence the initialization is redundant
> and can be removed.
>
> Cleans up clang warning:
> drivers/infiniband/sw/rdmavt/vt.c:94:23: warning: Value stored to 'rdi'
> during its initialization is never read
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/infiniband/sw/rdmavt/vt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rdmavt/vt.c b/drivers/infiniband/sw/rdmavt/vt.c
> index a4553b2b3696..a67b0ddc2230 100644
> --- a/drivers/infiniband/sw/rdmavt/vt.c
> +++ b/drivers/infiniband/sw/rdmavt/vt.c
> @@ -91,7 +91,7 @@ module_exit(rvt_cleanup);
>    */
>   struct rvt_dev_info *rvt_alloc_device(size_t size, int nports)
>   {
> -	struct rvt_dev_info *rdi = ERR_PTR(-ENOMEM);
> +	struct rvt_dev_info *rdi;
>   
>   	rdi = (struct rvt_dev_info *)ib_alloc_device(size);
>   	if (!rdi)
Thanks: Reviewed-by: Don Hiatt <don.hiatt@intel.com>
