Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753558AbeDTFnE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 01:43:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:38597 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751478AbeDTFnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 01:43:03 -0400
Subject: Re: [PATCH] nvme: fc: provide a descriptive error
To: Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>
Cc: James Smart <james.smart@broadcom.com>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <20180419174342.27307-1-jthumshirn@suse.de>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <500112aa-ea97-2428-ac39-854329a52e93@suse.de>
Date: Fri, 20 Apr 2018 07:43:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419174342.27307-1-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/2018 07:43 PM, Johannes Thumshirn wrote:
> Provide a descriptive error in case an lport to rport association
> isn't found when creating the FC-NVME controller.
> 
> Currently it's very hard to debug the reason for a failed connect
> attempt without a look at the source.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> 
> ---
> This actually happened to Hannes and me because of a typo in a
> customer demo today, so yes things like this happen until we have a
> proper way to do auto-connect.
> ---
>  drivers/nvme/host/fc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 6cb26bcf6ec0..8b66879b4ebf 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -3284,6 +3284,8 @@ nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options *opts)
>  	}
>  	spin_unlock_irqrestore(&nvme_fc_lock, flags);
>  
> +	pr_warn("%s: %s - %s combination not found\n",
> +		__func__, opts->traddr, opts->host_traddr);
>  	return ERR_PTR(-ENOENT);
>  }
>  
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
