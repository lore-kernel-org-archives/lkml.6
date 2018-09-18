Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF71ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300B7214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G4Qu44wd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 300B7214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbeIRURk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:17:40 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:54571 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbeIRURj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:17:39 -0400
Received: by mail-it0-f66.google.com with SMTP id f14-v6so3544426ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 07:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ehvIOQwcYh0xz5/c8Mj9f/Ezb2VwaoXPACqtKlUQPF0=;
        b=G4Qu44wdIG7vGHEBOhI82KXEiJjteLFYuKwW82bgohhGDRnbwkBVziB4ExSWallzSq
         cBgkPjnTtlkUC+P7cA1PKaCb432ay5SrQGpzpzURh6mJ242yipIv4e+yH6Qqn0eZu4KR
         tzeHE1OmYv8XDQLXZL7bUqpHLp6KZzxE1D1p7J9mqhmjDWrVabKniH8UU2WSqAVKF5ze
         vtNNjRIXIzwo1oKjF3S1jDW8RlvTBTgSEnyu5ClWNhZXYDNfRyppOcdkmWJMMgNZSGRQ
         SNA2B5wu5bTy4uwTaJmj3Bd89/Asm5e7Me4BhzDtB1GZdGCieNrKuL4s+o2tOTK2Dk31
         NouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ehvIOQwcYh0xz5/c8Mj9f/Ezb2VwaoXPACqtKlUQPF0=;
        b=NPBY9YgMZ6YbABfNJgaBk0egicVkJQ/Fx/wzIYC8IZmEOVVObFqJbEEGmHFh6qs+jr
         a16hQAIqU8ejtOW0evVR+IdmtlPeC894uiR3kij1KNAJ2MA+STO4/Zvi0gQR3cLxe69f
         KbvzKzWl6yIfNVy6rNLsODZz34BRWE0BPr1G/99b7liu5nlIiqMULHGpyAVnegRxlGb/
         auW8plQKCS0IBTA64OwxiPg0C5XVFQZEEs6MEYYkXm6pTmclYB3QBdH//bVKcsJZbuWE
         uflT+CHyjay9o7u4WS03SYDp2MNzlqeRyu7l0CSyn7MpDsQNZxu38enXP8S3+pbecb8k
         uzrQ==
X-Gm-Message-State: APzg51DskYGRcZmSH8K1G+47Wl6p1p4KHQrrZ8CCmxCTczWCSu37dM/+
        waku41GhcTaFWD9oTfg8ZAgS8g==
X-Google-Smtp-Source: ANB0VdY3XaYH4cxuFthbHzPgaMKIJT857IHYYG9ht4PmHz2Bfs96NX0Lc/U4ch4lDoyyG179hO32Ow==
X-Received: by 2002:a24:fe44:: with SMTP id w65-v6mr16103999ith.122.1537281884320;
        Tue, 18 Sep 2018 07:44:44 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id a11-v6sm4501587ita.21.2018.09.18.07.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 07:44:42 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g2HF3-0003Pn-Bi; Tue, 18 Sep 2018 08:44:41 -0600
Date:   Tue, 18 Sep 2018 08:44:41 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        Kamal Heib <kamalheib1@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH 1/4] IB/core: introduce ->release() callback
Message-ID: <20180918144441.GH11367@ziepe.ca>
References: <1537275826-27247-1-git-send-email-jan.dakinevich@virtuozzo.com>
 <1537275826-27247-2-git-send-email-jan.dakinevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537275826-27247-2-git-send-email-jan.dakinevich@virtuozzo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 04:03:43PM +0300, Jan Dakinevich wrote:
> IB infrastructure shares common device instance constructor with
> reference counting, and it uses kzalloc() to allocate memory
> for device specific instance with incapsulated ib_device field as one
> contigous memory block.
> 
> The issue is that the device specific instances tend to be too large
> and require high page order memory allocation. Unfortunately, kzalloc()
> in ib_alloc_device() can not be replaced with kvzalloc() since it would
> require a lot of review in all IB driver to prove correctness of the
> replacement.
> 
> The driver can allocate some heavy partes of their instance for itself
> and keep pointers for them in own instance. For this it is important
> that the alocated parts have the same life time as ib_device, thus
> their deallocation should be based on the same reference counting.
> 
> Let suppose:
> 
> struct foo_ib_device {
> 	struct ib_device device;
> 
> 	void *part;
> 
> 	...
> };
> 
> To properly free memory from .foo_ib_part the driver should provide
> function for ->release() callback:
> 
> void foo_ib_release(struct ib_device *device)
> {
> 	struct foo_ib_device *foo = container_of(device,  struct foo_ib_device,
> 						 device);
> 
> 	kvfree(foo->part);
> }
> 
> ...and initialiaze this callback immediately after foo_ib_device
> instance allocation.
> 
> 	struct foo_ib_device *foo;
> 
> 	foo = ib_alloc_device(sizeof(struct foo_ib_device));
> 
> 	foo->device.release = foo_ib_release;
> 
> 	/* allocate parts */
> 	foo->part = kvmalloc(65536, GFP_KERNEL);
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@virtuozzo.com>
>  drivers/infiniband/core/device.c | 2 ++
>  include/rdma/ib_verbs.h          | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> index db3b627..a8c8b0d 100644
> +++ b/drivers/infiniband/core/device.c
> @@ -215,6 +215,8 @@ static void ib_device_release(struct device *device)
>  		ib_cache_release_one(dev);
>  		kfree(dev->port_immutable);
>  	}
> +	if (dev->release)
> +		dev->release(dev);
>  	kfree(dev);
>  }

Nope, the driver module could be unloaded at this point.

The driver should free memory after its call to ib_unregister_device
returns.

Jason
