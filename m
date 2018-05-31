Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754213AbeEaJbe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:31:34 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50471 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754092AbeEaJbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:31:32 -0400
X-Google-Smtp-Source: ADUXVKIQdcVYaiCe0xwH91HMipX0qrkdZqwKWdeaSg/obUiC80Z0F2yFRB/u/V2Lhd69MrjFIbV9pw==
Subject: Re: [PATCH 4/5] nvmet: use atomic allocations when allocating fc
 requests
To: Johannes Thumshirn <jthumshirn@suse.de>,
        Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>,
        Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
References: <20180515074043.22843-1-jthumshirn@suse.de>
 <20180515074043.22843-5-jthumshirn@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3c91cf45-aa85-e1a5-6d25-5654131626dd@grimberg.me>
Date: Thu, 31 May 2018 12:31:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515074043.22843-5-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 34712def81b1..d2209c60f95f 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -509,7 +509,7 @@ fcloop_fcp_req(struct nvme_fc_local_port *localport,
>   	if (!rport->targetport)
>   		return -ECONNREFUSED;
>   
> -	tfcp_req = kzalloc(sizeof(*tfcp_req), GFP_KERNEL);
> +	tfcp_req = kzalloc(sizeof(*tfcp_req), GFP_ATOMIC);

Question, why isn't tfcp_req embedded in fcpreq? don't they have
the same lifetime?

>   	if (!tfcp_req)
>   		return -ENOMEM;
>   
> 
