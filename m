Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F1AE7C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60442086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fnfIuMI1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60442086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934602AbeFLUdj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:33:39 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:38113 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934158AbeFLUd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:33:28 -0400
Received: by mail-wr0-f196.google.com with SMTP id e18-v6so357932wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fTH5TmpICCtRAO3ouW9fe01p/8LGmUEmlSVuNISOW8w=;
        b=fnfIuMI1C0ihlCMCCCRMpjkv5W5IGaeOfHsPQyuAKXVyA9ewNgOsFp2rPrnt6mN0PA
         XhY+mtM6x97By0vYno1MZ+gSOb1WQBzPPtpVzGk3tDficufTfC8JK9W927VpL96ZgI9n
         Ntv5jMQH7zz3kmsNIeCYZ9EAKuVSlZtnseNzTBDos6dn6wewmycTy5z0RiQCYBFL1Del
         fzYFyEN5YIbQknvYGQfeGMb41y5tFweZzW8cv0rI/SoPxW2CYsDdIy0OPt6ZhkqmrZvw
         XoFWtGdhQFHm68M8eayAfobAsXZJ0kGf9yaknTpz+kYWg7mC0TZjuWr/0ZWSBFzzVeoS
         hgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fTH5TmpICCtRAO3ouW9fe01p/8LGmUEmlSVuNISOW8w=;
        b=mIz6Nr/iQGNoaIiCKcU0xnW3pLNWTQp+RBQXuhdWcFmTNEj3uskmEHVJhpU6M3Saqc
         BOOKrxS3/jKMHUmKQ+R9kgR1uqEiD4l8JJuUE60pU06sNh4XKP2E0VdcnlJYuHJ962cn
         Rb6r+RYNqAfWbIJu5AbxNTuKgkWk9Y6N2lOgpGGp3O8it+oB0rtedV8zgawwHNbgoBKP
         YJyac3SWh1Imi2PzHaWO2J6G2taeI7PkSo0W+zmJWI+ahBwX9av9OOemxsL+EGpz20X4
         RA+9AYJTgnjzHbEb/Y9x7FXNQ+2n33EhNc+ld/QwYjUzGYSX9h09FChmObuq5/yh9Rcx
         4+bw==
X-Gm-Message-State: APt69E0B91IDimVFnbI7tNO90hqn7Lcz7DWFUiXsnVptJ+IclPAH8bNA
        nCCUdH1/ocUqjMZ7zZ2OYBgAfw==
X-Google-Smtp-Source: ADUXVKL0DSSRI3OXPn7Vi0D57WvsjPM+UrEl4gD3LV8PVtDLBuObd/xISF8eBpCn1+ggECFiYOvDpQ==
X-Received: by 2002:adf:ad4c:: with SMTP id p70-v6mr1700750wrc.44.1528835607254;
        Tue, 12 Jun 2018 13:33:27 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id v13-v6sm838020wrq.43.2018.06.12.13.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 13:33:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fSpyk-00077r-AU; Tue, 12 Jun 2018 14:33:22 -0600
Date:   Tue, 12 Jun 2018 14:33:22 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] IB/mad: Use IDR for agent IDs
Message-ID: <20180612203322.GG6314@ziepe.ca>
References: <20180608174218.32455-1-willy@infradead.org>
 <20180608174218.32455-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608174218.32455-3-willy@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 10:42:18AM -0700, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Allocate agent IDs from a global IDR instead of an atomic variable.
> This eliminates the possibility of reusing an ID which is already in
> use after 4 billion registrations, and we can also limit the assigned
> ID to be less than 2^24, which fixes a bug in the mlx4 device.
> 
> We look up the agent under protection of the RCU lock, which means we
> have to free the agent using kfree_rcu, and only increment the reference
> counter if it is not 0.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
>  drivers/infiniband/core/mad.c      | 78 ++++++++++++++++++------------
>  drivers/infiniband/core/mad_priv.h |  7 +--
>  include/linux/idr.h                |  9 ++++
>  3 files changed, 59 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
> index 68f4dda916c8..62384a3dd3ec 100644
> +++ b/drivers/infiniband/core/mad.c
> @@ -38,6 +38,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/dma-mapping.h>
> +#include <linux/idr.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/security.h>
> @@ -58,8 +59,8 @@ MODULE_PARM_DESC(send_queue_size, "Size of send queue in number of work requests
>  module_param_named(recv_queue_size, mad_recvq_size, int, 0444);
>  MODULE_PARM_DESC(recv_queue_size, "Size of receive queue in number of work requests");
>  
> +static DEFINE_IDR(ib_mad_clients);
>  static struct list_head ib_mad_port_list;
> -static atomic_t ib_mad_client_id = ATOMIC_INIT(0);
>  
>  /* Port list lock */
>  static DEFINE_SPINLOCK(ib_mad_port_list_lock);
> @@ -377,13 +378,24 @@ struct ib_mad_agent *ib_register_mad_agent(struct ib_device *device,
>  		goto error4;
>  	}
>  
> -	spin_lock_irq(&port_priv->reg_lock);
> -	mad_agent_priv->agent.hi_tid = atomic_inc_return(&ib_mad_client_id);
> +	idr_preload(GFP_KERNEL);
> +	idr_lock(&ib_mad_clients);
> +	ret2 = idr_alloc_cyclic(&ib_mad_clients, mad_agent_priv, 0,
> +			(1 << 24), GFP_ATOMIC);

I like this series, my only concern is this magic number here, at the
very least it deserves a big comment explaining why it
exists..

Let me see if I can get someone to give it some test time, I assume
you haven't been able to test it it?

> diff --git a/include/linux/idr.h b/include/linux/idr.h
> index e856f4e0ab35..bef0df8600e2 100644
> +++ b/include/linux/idr.h
> @@ -81,6 +81,15 @@ static inline void idr_set_cursor(struct idr *idr, unsigned int val)
>  	WRITE_ONCE(idr->idr_next, val);
>  }
>  
> +#define idr_lock(idr)		xa_lock(&(idr)->idr_rt)
> +#define idr_unlock(idr)		xa_unlock(&(idr)->idr_rt)
> +#define idr_lock_irq(idr)	xa_lock_irq(&(idr)->idr_rt)
> +#define idr_unlock_irq(idr)	xa_unlock_irq(&(idr)->idr_rt)
> +#define idr_lock_irqsave(idr, flags) \
> +				xa_lock_irqsave(&(idr)->idr_rt, flags)
> +#define idr_unlock_irqrestore(idr, flags) \
> +				xa_unlock_irqrestore(&(idr)->idr_rt, flags)
> +

And you are Ok to take these through the rdma tree?

Thanks,
Jason
