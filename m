Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5642DC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09D2C208D5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 17:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K6Kou6Z+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D2C208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935439AbeFMRbF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 13:31:05 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45162 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935361AbeFMRbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 13:31:03 -0400
Received: by mail-wr0-f196.google.com with SMTP id o12-v6so3584351wrm.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 10:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3cf0UjHW/aO/yu7azLc1Bt/+6dP8sYkOxxVsr0JZ4pA=;
        b=K6Kou6Z+QwXzftoDDqP1ibsQC5oARgnOgAe2UEDWSYEDiEwN1oaageCpGiVm7TF6NP
         E4IlxVRJ1QIea0ku7ljHjsr7DIqGAd6KsBtXe3oTE/KVKrSSrKJqyQRrw5oaQMCWH8eG
         4d/vSon331TzpdfqsE82FBpG37Z9wNC/+Vx7bclUMz5nCwkftqM8eFdMsvjhWj37chis
         xNkpZAPHrVNeeBnMOfdEMagfUoFxVEtS8qh/DOLlmNs8Jdj6n6xEpa+LQCyoplwLNaKA
         vv7QcFxwOCWIYgCg/GJSEVaRPwtRsaNkEHVsmyW/7Y0e3pJKjV3VPPT8LrPRWl9haCBU
         KAZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3cf0UjHW/aO/yu7azLc1Bt/+6dP8sYkOxxVsr0JZ4pA=;
        b=DLlSQ5XBHMwqV8z6l0Iiq5eF6TEFzlEeq8WuE9cQpVaNf+MEu/ezPBy7tkEBzRWB4h
         RQWCneLhGjjue7sYxx6OsL9+NKmF/MKNKQqVpHtf8WaKdKFU7zk5VUAIz7VnEhkPHP3w
         IjVblHa4ftV9lyOWqMN1qpZbzne1zd4oPMo51Hc841oq9iTXR3cK7dL3xG9zpVGUyORn
         Pvbbxd8PzLgLbB8BqDLj0DBNdUh/8dXaiTvkmfJ7cC/8PEUcG+paPnOJQZYlgU0dDR7T
         xLBc0fSPTKgaZ3htalP3zRzn45GT0h1uTHDOKHHX7uvRbpMq1NiAfhcSmhiAkYx539Dt
         0kSw==
X-Gm-Message-State: APt69E1MMXRCb02yA95QpzffvT4i85+1JID3/CPaXjo6uq9z6reLRL5Z
        UEB6rTWz64eSvw58hLnQEIS6dyX73Ng=
X-Google-Smtp-Source: ADUXVKJhRWzCVqx8wjGbb4UPWpE+UR0MP956mHydTeanoY7GjzMe9EhtBMPUkMK8way2mTI4/Oqp1Q==
X-Received: by 2002:adf:f7cf:: with SMTP id a15-v6mr4867863wrq.108.1528911062233;
        Wed, 13 Jun 2018 10:31:02 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id j13-v6sm3922665wre.38.2018.06.13.10.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 10:31:01 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fT9bl-000796-2S; Wed, 13 Jun 2018 11:30:57 -0600
Date:   Wed, 13 Jun 2018 11:30:57 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org,
        =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] IDR: Expose the XArray lock
Message-ID: <20180613173057.GA27281@ziepe.ca>
References: <20180613123403.25233-1-willy@infradead.org>
 <20180613123403.25233-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180613123403.25233-2-willy@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 05:34:02AM -0700, Matthew Wilcox wrote:
> Allow users of the IDR to use the XArray lock for their own
> synchronisation purposes.  The IDR continues to rely on the caller to
> handle locking, but this lets the caller use the lock embedded in the
> IDR data structure instead of allocating their own lock.
> 
> Signed-off-by: Matthew Wilcox <willy@infradead.org>
>  include/linux/idr.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/linux/idr.h b/include/linux/idr.h
> index e856f4e0ab35..109d7a3c8d56 100644
> +++ b/include/linux/idr.h
> @@ -98,6 +98,17 @@ static inline void idr_set_cursor(struct idr *idr, unsigned int val)
>   * period).
>   */
>  
> +#define idr_lock(idr)		xa_lock(&(idr)->idr_xa)
> +#define idr_unlock(idr)		xa_unlock(&(idr)->idr_xa)
> +#define idr_lock_bh(idr)	xa_lock_bh(&(idr)->idr_xa)
> +#define idr_unlock_bh(idr)	xa_unlock_bh(&(idr)->idr_xa)
> +#define idr_lock_irq(idr)	xa_lock_irq(&(idr)->idr_xa)
> +#define idr_unlock_irq(idr)	xa_unlock_irq(&(idr)->idr_xa)
> +#define idr_lock_irqsave(idr, flags) \
> +				xa_lock_irqsave(&(idr)->idr_xa, flags)
> +#define idr_unlock_irqrestore(idr, flags) \
> +				xa_unlock_irqrestore(&(idr)->idr_xa, flags)
> +
>  void idr_preload(gfp_t gfp_mask);

Hmm, what do I need to apply this?

drivers/infiniband/core/mad.c: In function ‘ib_register_mad_agent’:
drivers/infiniband/core/mad.c:387:34: error: ‘struct idr’ has no member named ‘idr_xa’; did you mean ‘idr_rt’?
  idr_lock(&ib_mad_clients);
                                  ^     
                                  idr_rt

Linus's master (be779f03d563981)  doesn't seem to have idr_xa?

Jason
