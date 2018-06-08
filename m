Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ahHwIX4MG1vpYQAAmS7hNA
	; Fri, 08 Jun 2018 23:08:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 69FEA6089E; Fri,  8 Jun 2018 23:08:46 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="m5dftXMW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CB72660275;
	Fri,  8 Jun 2018 23:08:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CB72660275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeFHXIn (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 19:08:43 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40959 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753140AbeFHXIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 19:08:41 -0400
Received: by mail-wr0-f195.google.com with SMTP id l41-v6so14809428wre.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 16:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SajILgSWWAJtxWYMhY4L+l225DXzGTWCRJEV7wa1HxM=;
        b=m5dftXMWOzO64ruQQcnSIRaHhpF4Eg8/k/8YpVITReRyIBbIY8Mf8iChJPpCNOnlb6
         vqIu+ZBt0ozR3kLeybyHPDVmyNyMcN1yL9pKkNvwvGXVg5B/Y9cuYhWgJO+GBlpYcNIU
         VWmLNO9y/iBwn1rylGY2Ip7e/FbmQziiZuNn8NxNzK/GGmfsDup05+Ty8iZabMXWZpcJ
         d8KRmFteD77MGAZJeqcZROSnjYhO584U7VMF1r+vL7Yrm+zlU4d5YgdjKCID904bYvq3
         /O5FlFOJz0Vp+4JLu1byxW66koo7sgJrI661B/OHw4UT3r861k0anxt39sIxnPl29itt
         vC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SajILgSWWAJtxWYMhY4L+l225DXzGTWCRJEV7wa1HxM=;
        b=Lmte+aIKFvlGfcSG7/UY6NNWdfo2/G3g4O8saZqcS9GG+59zr3AOK7Ddh5aL32DHwA
         nm+Mz1sdUZfewShlNX7ufgmmGEGyGE4RRHwjLhtCejCa86Gc+GwT76EJnD3GpPkCn3yD
         TUpgPzbB4QkIPJpv9lmkCGGyD4nUYuzkBWAX5kFNNDvqcBilpf7dV0VkvkTbUarKLd6Y
         J8BAX3V2SYKMXznzb/esPxcreEBgxvxqLBO7n0HL0NmdSskgQaDOfo/5QgzTQRyikGC+
         eORx/znzdgc2/F1SSJHu0rrM7hUVpWI7SvhrUnYfpk5kGVnb//JRTioCSqgHIOkKrmMJ
         MsbQ==
X-Gm-Message-State: APt69E0Eyr+Kt6c83QD/Q5Jl0L2BAVyaDrVIizsh8jgEuP1CsW5DyvD8
        aqIPqkABHYBDlT/CB+KuBKQTxw==
X-Google-Smtp-Source: ADUXVKJ9Ej/iXR2JpArKgsaRFIUgLrZS+9HQnmexrIxQ4l96NYpaUSJ20QOuAug9XJQdoZF0Sf/OzA==
X-Received: by 2002:adf:bb10:: with SMTP id r16-v6mr6183988wrg.244.1528499319967;
        Fri, 08 Jun 2018 16:08:39 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id t1-v6sm2275310wmt.40.2018.06.08.16.08.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 16:08:39 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fRQUl-0006M3-Gz; Fri, 08 Jun 2018 17:08:35 -0600
Date: Fri, 8 Jun 2018 17:08:35 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Raed Salem <raeds@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/mlx5: Fix memory leak in mlx5_ib_create_flow
Message-ID: <20180608230835.GA24392@ziepe.ca>
References: <20180607191915.GA9092@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607191915.GA9092@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 02:19:15PM -0500, Gustavo A. R. Silva wrote:
> In case memory resources for *ucmd* were allocated, release them
> before return.
> 
> Addresses-Coverity-ID: 1469857 ("Resource leak")
> Fixes: 3b3233fbf02e ("IB/mlx5: Add flow counters binding support")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>  drivers/infiniband/hw/mlx5/main.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index e52dd21..0472e6c 100644
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -3546,29 +3546,35 @@ static struct ib_flow *mlx5_ib_create_flow(struct ib_qp *qp,
>  			return ERR_PTR(-ENOMEM);
>  
>  		err = ib_copy_from_udata(ucmd, udata, required_ucmd_sz);
> -		if (err) {
> -			kfree(ucmd);
> -			return ERR_PTR(err);
> -		}
> +		if (err)
> +			goto free_ucmd;
>  	}
>  
> -	if (flow_attr->priority > MLX5_IB_FLOW_LAST_PRIO)
> -		return ERR_PTR(-ENOMEM);
> +	if (flow_attr->priority > MLX5_IB_FLOW_LAST_PRIO) {
> +		err = -ENOMEM;
> +		goto free_ucmd;
> +	}
>  
>  	if (domain != IB_FLOW_DOMAIN_USER ||
>  	    flow_attr->port > dev->num_ports ||
>  	    (flow_attr->flags & ~(IB_FLOW_ATTR_FLAGS_DONT_TRAP |
> -				  IB_FLOW_ATTR_FLAGS_EGRESS)))
> -		return ERR_PTR(-EINVAL);
> +				  IB_FLOW_ATTR_FLAGS_EGRESS))) {
> +		err = -EINVAL;
> +		goto free_ucmd;
> +	}
>  
>  	if (is_egress &&
>  	    (flow_attr->type == IB_FLOW_ATTR_ALL_DEFAULT ||
> -	     flow_attr->type == IB_FLOW_ATTR_MC_DEFAULT))
> -		return ERR_PTR(-EINVAL);
> +	     flow_attr->type == IB_FLOW_ATTR_MC_DEFAULT)) {
> +		err = -EINVAL;
> +		goto free_ucmd;
> +	}
>  
>  	dst = kzalloc(sizeof(*dst), GFP_KERNEL);
> -	if (!dst)
> -		return ERR_PTR(-ENOMEM);
> +	if (!dst) {
> +		err = -ENOMEM;
> +		goto free_ucmd;
> +	}
>  
>  	mutex_lock(&dev->flow_db->lock);
>  
> @@ -3640,6 +3646,9 @@ static struct ib_flow *mlx5_ib_create_flow(struct ib_qp *qp,
>  	kfree(ucmd);
>  	kfree(handler);
>  	return ERR_PTR(err);
> +free_ucmd:
> +	kfree(ucmd);
> +	return ERR_PTR(err);
>  }

This hunk is a bit wonky, can we do this instead? handle never needs
to be freed.

destroy_ft:
	put_flow_table(dev, ft_prio, false);
	if (ft_prio_tx)
		put_flow_table(dev, ft_prio_tx, false);
unlock:
	mutex_unlock(&dev->flow_db->lock);
	kfree(dst);
free_ucmd:
	kfree(ucmd);
	return ERR_PTR(err);
}


Jason
