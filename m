Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2CD4AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1AB3208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dev-mellanox-co-il.20150623.gappssmtp.com header.i=@dev-mellanox-co-il.20150623.gappssmtp.com header.b="ggNxetW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AB3208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dev.mellanox.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934806AbeFMH4M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:56:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39985 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934124AbeFMH4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:56:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id n5-v6so3409202wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 00:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=mjqMnpp8C+NofwBsEYhBZOwwpV12TuvtQOU3p5eeOdI=;
        b=ggNxetW4IukUhcD/Pcl3vwwPhnWBp50jF5+DsjIdrSq4Ek1D4t8m22KmyWwMAuST4W
         EI9+emiP/YoghTd/xvE0M2SeQbH4tkLkx+6GasIT92z6Hz/KyGrsleCLICJISVUqVWne
         yJszJmrFNE4phtqSEF8fv5u0OFwSZ/WrqVVj9SFfnEfuMJv6236TD/9XcymmfCgDgeha
         tagkj7wtYIDw7J5q32o4vek2t7EiLKrMpRzEInOl/qJvod5qZLuVxG847fbSIxwXlM21
         iDfEjIw3P987pxDrqe6qXQ1AM1qIErX0sEnB7AvA+X06w1dukeKe7vHEGAP/UxY2STwk
         +ZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=mjqMnpp8C+NofwBsEYhBZOwwpV12TuvtQOU3p5eeOdI=;
        b=LeX2HDDENb65Wcb/bJ7cu07QI0BwLXY81rO9W0GqYcGrYuO4Q2TAT120Gh4FLemulR
         mQRXAZWcqsZx+aYZ2nVGkrBvEz6VjC51QCii7IPQogC+PaQr6a/GHm+HvqJAn6HGvJGz
         NrqWYEDzm/wkLwlT2DlLu/QUuKhmBbqO8rVcw1nEu7BuKL0Cmia26/odHdzY57LU/SOE
         VcScrb9NWLZWQ9t+CpXbX6gKuzkZ/+1w2wS085xLmeYO+zSqzlRajyaia4Gy2JrqfHSa
         p6DzX4N3PGhdmatBHtxfBsdJ+VOLGkvOKdK8cNxcgt6imLrWK9lr/XSe+M2k2Su70wo8
         Xo+g==
X-Gm-Message-State: APt69E0vWlHXA7s4jNzzlxtl/BZO6e5YmRlXb73BgNWDROxurEZnCu2w
        D242jfDF2Ctvh4Q+a9ffw+ufeQ==
X-Google-Smtp-Source: ADUXVKLK02Sh6VIAp/3XX2QpDw+GyaaUTx551y3vn0+lFkl4yHXaZn4LJsSWjipvFe0JHNCoq5Cw8w==
X-Received: by 2002:a1c:3448:: with SMTP id b69-v6mr3014376wma.0.1528876568931;
        Wed, 13 Jun 2018 00:56:08 -0700 (PDT)
Received: from localhost ([31.210.187.208])
        by smtp.gmail.com with ESMTPSA id u13-v6sm2349718wrr.70.2018.06.13.00.56.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 00:56:08 -0700 (PDT)
Date:   Wed, 13 Jun 2018 10:56:05 +0300
From:   jackm <jackm@dev.mellanox.co.il>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org,
        =?ISO-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org, majd@mellanox.com
Subject: Re: [PATCH 2/2] IB/mad: Use IDR for agent IDs
Message-ID: <20180613105605.00003c33@dev.mellanox.co.il>
In-Reply-To: <20180608174218.32455-3-willy@infradead.org>
References: <20180608174218.32455-1-willy@infradead.org>
        <20180608174218.32455-3-willy@infradead.org>
Organization: Mellanox
X-Mailer: Claws Mail 3.15.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Jun 2018 10:42:18 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Allocate agent IDs from a global IDR instead of an atomic variable.
> This eliminates the possibility of reusing an ID which is already in
> use after 4 billion registrations, and we can also limit the assigned
> ID to be less than 2^24, which fixes a bug in the mlx4 device.
> 
> We look up the agent under protection of the RCU lock, which means we
> have to free the agent using kfree_rcu, and only increment the
> reference counter if it is not 0.
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
>  drivers/infiniband/core/mad.c      | 78
> ++++++++++++++++++------------ drivers/infiniband/core/mad_priv.h |
> 7 +-- include/linux/idr.h                |  9 ++++
>  3 files changed, 59 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/infiniband/core/mad.c
> b/drivers/infiniband/core/mad.c index 68f4dda916c8..62384a3dd3ec
> 100644 --- a/drivers/infiniband/core/mad.c
> +++ b/drivers/infiniband/core/mad.c
> @@ -38,6 +38,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/dma-mapping.h>
> +#include <linux/idr.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/security.h>
> @@ -58,8 +59,8 @@ MODULE_PARM_DESC(send_queue_size, "Size of send
> queue in number of work requests module_param_named(recv_queue_size,
> mad_recvq_size, int, 0444); MODULE_PARM_DESC(recv_queue_size, "Size
> of receive queue in number of work requests"); 
> +static DEFINE_IDR(ib_mad_clients);
>  static struct list_head ib_mad_port_list;
> -static atomic_t ib_mad_client_id = ATOMIC_INIT(0);
>  
>  /* Port list lock */
>  static DEFINE_SPINLOCK(ib_mad_port_list_lock);
> @@ -377,13 +378,24 @@ struct ib_mad_agent
> *ib_register_mad_agent(struct ib_device *device, goto error4;
>  	}
>  
> -	spin_lock_irq(&port_priv->reg_lock);
> -	mad_agent_priv->agent.hi_tid =
> atomic_inc_return(&ib_mad_client_id);
> +	idr_preload(GFP_KERNEL);
> +	idr_lock(&ib_mad_clients);
> +	ret2 = idr_alloc_cyclic(&ib_mad_clients, mad_agent_priv, 0,
> +			(1 << 24), GFP_ATOMIC);
> +	idr_unlock(&ib_mad_clients);
> +	idr_preload_end();
> +
> +	if (ret2 < 0) {
> +		ret = ERR_PTR(ret2);
> +		goto error5;
> +	}
> +	mad_agent_priv->agent.hi_tid = ret2;
>  
>  	/*
>  	 * Make sure MAD registration (if supplied)
>  	 * is non overlapping with any existing ones
>  	 */
> +	spin_lock_irq(&port_priv->reg_lock);
>  	if (mad_reg_req) {
>  		mgmt_class =
> convert_mgmt_class(mad_reg_req->mgmt_class); if
> (!is_vendor_class(mgmt_class)) { @@ -394,7 +406,7 @@ struct
> ib_mad_agent *ib_register_mad_agent(struct ib_device *device, if
> (method) { if (method_in_use(&method,
>  							   mad_reg_req))
> -						goto error5;
> +						goto error6;
>  				}
>  			}
>  			ret2 = add_nonoui_reg_req(mad_reg_req,
> mad_agent_priv, @@ -410,24 +422,25 @@ struct ib_mad_agent
> *ib_register_mad_agent(struct ib_device *device, if
> (is_vendor_method_in_use( vendor_class,
>  							mad_reg_req))
> -						goto error5;
> +						goto error6;
>  				}
>  			}
>  			ret2 = add_oui_reg_req(mad_reg_req,
> mad_agent_priv); }
>  		if (ret2) {
>  			ret = ERR_PTR(ret2);
> -			goto error5;
> +			goto error6;
>  		}
>  	}
> -
> -	/* Add mad agent into port's agent list */
> -	list_add_tail(&mad_agent_priv->agent_list,
> &port_priv->agent_list); spin_unlock_irq(&port_priv->reg_lock);
>  
>  	return &mad_agent_priv->agent;
> -error5:
> +error6:
>  	spin_unlock_irq(&port_priv->reg_lock);
> +	idr_lock(&ib_mad_clients);
> +	idr_remove(&ib_mad_clients, mad_agent_priv->agent.hi_tid);
> +	idr_unlock(&ib_mad_clients);
> +error5:
>  	ib_mad_agent_security_cleanup(&mad_agent_priv->agent);
>  error4:
>  	kfree(reg_req);
> @@ -589,8 +602,10 @@ static void unregister_mad_agent(struct
> ib_mad_agent_private *mad_agent_priv) 
>  	spin_lock_irq(&port_priv->reg_lock);
>  	remove_mad_reg_req(mad_agent_priv);
> -	list_del(&mad_agent_priv->agent_list);
>  	spin_unlock_irq(&port_priv->reg_lock);
> +	idr_lock(&ib_mad_clients);
> +	idr_remove(&ib_mad_clients, mad_agent_priv->agent.hi_tid);
> +	idr_unlock(&ib_mad_clients);
>  
>  	flush_workqueue(port_priv->wq);
>  	ib_cancel_rmpp_recvs(mad_agent_priv);
> @@ -601,7 +616,7 @@ static void unregister_mad_agent(struct
> ib_mad_agent_private *mad_agent_priv)
> ib_mad_agent_security_cleanup(&mad_agent_priv->agent); 
>  	kfree(mad_agent_priv->reg_req);
> -	kfree(mad_agent_priv);
> +	kfree_rcu(mad_agent_priv, rcu);
>  }
>  
>  static void unregister_mad_snoop(struct ib_mad_snoop_private
> *mad_snoop_priv) @@ -1722,22 +1737,19 @@ find_mad_agent(struct
> ib_mad_port_private *port_priv, struct ib_mad_agent_private
> *mad_agent = NULL; unsigned long flags;
>  
> -	spin_lock_irqsave(&port_priv->reg_lock, flags);
>  	if (ib_response_mad(mad_hdr)) {
>  		u32 hi_tid;
> -		struct ib_mad_agent_private *entry;
>  
>  		/*
>  		 * Routing is based on high 32 bits of transaction ID
>  		 * of MAD.
>  		 */
>  		hi_tid = be64_to_cpu(mad_hdr->tid) >> 32;
> -		list_for_each_entry(entry, &port_priv->agent_list,
> agent_list) {
> -			if (entry->agent.hi_tid == hi_tid) {
> -				mad_agent = entry;
> -				break;
> -			}
> -		}
> +		rcu_read_lock();
> +		mad_agent = idr_find(&ib_mad_clients, hi_tid);
> +		if (mad_agent
> && !atomic_inc_not_zero(&mad_agent->refcount))
> +			mad_agent = NULL;
> +		rcu_read_unlock();
>  	} else {
>  		struct ib_mad_mgmt_class_table *class;
>  		struct ib_mad_mgmt_method_table *method;
> @@ -1746,6 +1758,7 @@ find_mad_agent(struct ib_mad_port_private
> *port_priv, const struct ib_vendor_mad *vendor_mad;
>  		int index;
>  
> +		spin_lock_irqsave(&port_priv->reg_lock, flags);
>  		/*
>  		 * Routing is based on version, class, and method
>  		 * For "newer" vendor MADs, also based on OUI
> @@ -1785,20 +1798,19 @@ find_mad_agent(struct ib_mad_port_private
> *port_priv, ~IB_MGMT_METHOD_RESP];
>  			}
>  		}
> +		if (mad_agent)
> +			atomic_inc(&mad_agent->refcount);
> +out:
> +		spin_unlock_irqrestore(&port_priv->reg_lock, flags);
>  	}
>  
> -	if (mad_agent) {
> -		if (mad_agent->agent.recv_handler)
> -			atomic_inc(&mad_agent->refcount);
> -		else {
> -			dev_notice(&port_priv->device->dev,
> -				   "No receive handler for client %p
> on port %d\n",
> -				   &mad_agent->agent,
> port_priv->port_num);
> -			mad_agent = NULL;
> -		}
> +	if (mad_agent && !mad_agent->agent.recv_handler) {
> +		dev_notice(&port_priv->device->dev,
> +			   "No receive handler for client %p on port
> %d\n",
> +			   &mad_agent->agent, port_priv->port_num);
> +		deref_mad_agent(mad_agent);
> +		mad_agent = NULL;
>  	}
> -out:
> -	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
>  
>  	return mad_agent;
>  }
> @@ -3161,7 +3173,6 @@ static int ib_mad_port_open(struct ib_device
> *device, port_priv->device = device;
>  	port_priv->port_num = port_num;
>  	spin_lock_init(&port_priv->reg_lock);
> -	INIT_LIST_HEAD(&port_priv->agent_list);
>  	init_mad_qp(port_priv, &port_priv->qp_info[0]);
>  	init_mad_qp(port_priv, &port_priv->qp_info[1]);
>  
> @@ -3340,6 +3351,9 @@ int ib_mad_init(void)
>  
>  	INIT_LIST_HEAD(&ib_mad_port_list);
>  
> +	/* Client ID 0 is used for snoop-only clients */
> +	idr_alloc(&ib_mad_clients, NULL, 0, 0, GFP_KERNEL);
> +
>  	if (ib_register_client(&mad_client)) {
>  		pr_err("Couldn't register ib_mad client\n");
>  		return -EINVAL;
> diff --git a/drivers/infiniband/core/mad_priv.h
> b/drivers/infiniband/core/mad_priv.h index 28669f6419e1..d84ae1671898
> 100644 --- a/drivers/infiniband/core/mad_priv.h
> +++ b/drivers/infiniband/core/mad_priv.h
> @@ -89,7 +89,6 @@ struct ib_rmpp_segment {
>  };
>  
>  struct ib_mad_agent_private {
> -	struct list_head agent_list;
>  	struct ib_mad_agent agent;
>  	struct ib_mad_reg_req *reg_req;
>  	struct ib_mad_qp_info *qp_info;
> @@ -105,7 +104,10 @@ struct ib_mad_agent_private {
>  	struct list_head rmpp_list;
>  
>  	atomic_t refcount;
> -	struct completion comp;
> +	union {
> +		struct completion comp;
> +		struct rcu_head rcu;
> +	};
>  };
>  
>  struct ib_mad_snoop_private {
> @@ -203,7 +205,6 @@ struct ib_mad_port_private {
>  
>  	spinlock_t reg_lock;
>  	struct ib_mad_mgmt_version_table version[MAX_MGMT_VERSION];
> -	struct list_head agent_list;
>  	struct workqueue_struct *wq;
>  	struct ib_mad_qp_info qp_info[IB_MAD_QPS_CORE];
>  };
> diff --git a/include/linux/idr.h b/include/linux/idr.h
> index e856f4e0ab35..bef0df8600e2 100644
> --- a/include/linux/idr.h
> +++ b/include/linux/idr.h
> @@ -81,6 +81,15 @@ static inline void idr_set_cursor(struct idr *idr,
> unsigned int val) WRITE_ONCE(idr->idr_next, val);
>  }
>  
> +#define idr_lock(idr)		xa_lock(&(idr)->idr_rt)
> +#define idr_unlock(idr)		xa_unlock(&(idr)->idr_rt)
> +#define idr_lock_irq(idr)	xa_lock_irq(&(idr)->idr_rt)
> +#define idr_unlock_irq(idr)	xa_unlock_irq(&(idr)->idr_rt)
> +#define idr_lock_irqsave(idr, flags) \
> +				xa_lock_irqsave(&(idr)->idr_rt,
> flags) +#define idr_unlock_irqrestore(idr, flags) \
> +				xa_unlock_irqrestore(&(idr)->idr_rt,
> flags) +
>  /**
>   * DOC: idr sync
>   * idr synchronization (stolen from radix-tree.h)

Acked-by: Jack Morgenstein <jackm@dev.mellanox.co.il>

Thanks for handling this, Matthew!
Excellent job.

I tested this out both with and without sriov.
For testing, reduced the max id value in the idr_alloc_cyclic call to
1<<5 so as to test wraparound behavior.
I had an infinite "saquery" loop in one console window.  In another, I
did modprobe -r/modprobe mlx4_ib, and also openibd stop/start
occasionally.
For good measure, I had IPoIB ping -f on the ib0 interface running
continuously.

The patch worked perfectly.
I even managed to catch the idr_find returning NULL in find_mad_agent
once, but did not get the idr_find succeeding but the agent refcount
being zero. (Not a big deal -- this would be ferociously hard to catch,
but your logic here is correct).

No oopses, no unexpected behavior. Wraparound worked perfectly.

P.S., it might be a good idea to put the idr.h changes into a separate
commit, since these changes are for the idr library.

 -Jack
