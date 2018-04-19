Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753524AbeDSVUr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 17:20:47 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:45392 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeDSVUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 17:20:46 -0400
X-Google-Smtp-Source: AB8JxZrG6wDTaRZqyMyUqUanbCakpFMFSuuY6AB2q3k98FGIqV+Mhr1zH1qiDYyVCjqQIddees/1MA==
Subject: Re: [PATCH] nvme: fc: provide a descriptive error
To: Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>
Cc: Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>
References: <20180419174342.27307-1-jthumshirn@suse.de>
From: James Smart <james.smart@broadcom.com>
Message-ID: <6341b630-ce66-90b5-bd80-cc2dcd2cfb71@broadcom.com>
Date: Thu, 19 Apr 2018 14:20:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180419174342.27307-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/2018 10:43 AM, Johannes Thumshirn wrote:
> Provide a descriptive error in case an lport to rport association
> isn't found when creating the FC-NVME controller.
>
> Currently it's very hard to debug the reason for a failed connect
> attempt without a look at the source.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>
> ---
> This actually happened to Hannes and me becuase of a typo in a
> customer demo today, so yes things like this happen unitl we have a
> proper way to do auto-connect.
> ---
>   drivers/nvme/host/fc.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 6cb26bcf6ec0..8b66879b4ebf 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3284,6 +3284,8 @@ nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts)
>   	}
>   	spin_unlock_irqrestore(&nvme_fc_lock, flags);
>   
> +	pr_warn("%s: %s - %s combination not found\n",
> +		__func__, opts->traddr, opts->host_traddr);
>   	return ERR_PTR(-ENOENT);
>   }
>   

Signed-off-by:  James Smart  <james.smart@broadcom.com>
