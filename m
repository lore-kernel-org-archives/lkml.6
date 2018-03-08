Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755225AbeCHH5l (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 02:57:41 -0500
Received: from verein.lst.de ([213.95.11.211]:33911 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751865AbeCHH5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 02:57:38 -0500
Date: Thu, 8 Mar 2018 08:57:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/5] nvme: do atomically bit operations on
        nvme_request.flags
Message-ID: <20180308075736.GB16084@lst.de>
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com> <1520489971-31174-2-git-send-email-jianchao.w.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520489971-31174-2-git-send-email-jianchao.w.wang@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 02:19:27PM +0800, Jianchao Wang wrote:
> Do atomically bit operations on nvme_request.flags instead of
> regular read/write, then we could add other flags and set/clear
> them safely.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>

Looks good, assuming an actual need for this shows up in the next
patches :)

Reviewed-by: Christoph Hellwig <hch@lst.de>

> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index e80fd74..02097e8 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -93,8 +93,8 @@ struct nvme_request {
>  	struct nvme_command	*cmd;
>  	union nvme_result	result;
>  	u8			retries;
> -	u8			flags;
>  	u16			status;
> +	unsigned long flags;

Please align the field name like the others, though.
