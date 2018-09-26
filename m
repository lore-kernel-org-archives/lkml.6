Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53404C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC392147D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BUYEiDXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBC392147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeI0CFp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 22:05:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38672 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeI0CFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 22:05:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so110328pfh.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=trUG+O8N/sUb+sZXG7HfnQcnFTPiLSru7dysOvSYHC8=;
        b=BUYEiDXIJpsCy/8Zw3RD1TxgA5bi6lutW4c9kwgTBpXKXTmPIrdmKG6HTv+ntE19yz
         KZFiBfiGqlXvlrLMUcEDd5LGsgFTOzZDdOAm3HoAmVSxMgmVKKLiErSDWO+vidNX5cGH
         4Bl4KU2umDcOqPODgM1zfDy4H/x+uA+r1+pCxIB2qvZhsdzeSEbo2Z/mUKcwDxy+lRih
         c8LRt1llHwJ+5udhmbdxaEzSPXfOollWWXxd6ESSP7cTt2a9SYnV11jiCgfmodMJ/D+g
         Z/YDKLZRCYrvmc+ZRCLq+mxbbq6+p9IOEU5qoau3ef5tTqIH/EaT+uh94XxSfoEB0ExD
         pdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=trUG+O8N/sUb+sZXG7HfnQcnFTPiLSru7dysOvSYHC8=;
        b=bXT4Sgi27mriGva6M1mTgZVHxg+3yVpHN2mSQEB9/WHcRBOoYPcMbLhB0rL49qybtz
         VwaMQ3nfw5DgwKjJMZVxQa6gwguRL6hq/tiWZdCPeM1hxHcM9Q4UUPLR5Uy78xZ/cDFc
         vCMiB2jQMdMsk/Z4hiZfXL3ujh+vjESFWLB70XwSUXmUVBJ5ZZTDbxL3IXHA8kEo+zhj
         9g7nSYxKh1aVQMS/9HcJB+76TQmL6uPe4F0LRvh5VtnVapOdBNWTm7ARGD1JPuM9x6K3
         5+UVZ4H/XevLtiYzHEIHoM/KiZ08/LMMtXJJOJ5civ2nyfra4gj6ldHZy+6r/ykv0FgQ
         QApg==
X-Gm-Message-State: ABuFfohRBjhZW4oyylHZAKInOfuPQVbY/pKUJbfWEW03YJ5Ugp8tZXJz
        +LqPUWOJZWONKbKmiueXAxw1Qg==
X-Google-Smtp-Source: ACcGV615y9xOlcjyk/wf53cZVZNJogXv3VuAFPwnEM5OmOrJ7RnlOZJBcoDOAAjy+8uJx6LzTnWCEA==
X-Received: by 2002:a63:f941:: with SMTP id q1-v6mr6782093pgk.213.1537991471372;
        Wed, 26 Sep 2018 12:51:11 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id v2-v6sm9465854pgf.58.2018.09.26.12.51.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 12:51:10 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g5Fq2-00075e-2T; Wed, 26 Sep 2018 13:51:10 -0600
Date:   Wed, 26 Sep 2018 13:51:10 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Shaobo Xu <xushaobo2@huawei.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA: fix dependencies for rdma_user_mmap_io
Message-ID: <20180926195110.GA27233@ziepe.ca>
References: <20180926193706.2447532-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926193706.2447532-1-arnd@arndb.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 09:36:52PM +0200, Arnd Bergmann wrote:
> The mlx4 driver produces a link error when it is configured
> as built-in while CONFIG_INFINIBAND_USER_ACCESS is set to =m:
> 
> drivers/infiniband/hw/mlx4/main.o: In function `mlx4_ib_mmap':
> main.c:(.text+0x1af4): undefined reference to `rdma_user_mmap_io'
> 
> The same function is called from mlx5, which already has a
> dependency to ensure we can call it, and from hns, which
> appears to suffer from the same problem.
> 
> This adds the same dependency that mlx5 uses to the other two.
> 
> Fixes: 6745d356ab39 ("RDMA/hns: Use rdma_user_mmap_io")
> Fixes: c282da4109e4 ("RDMA/mlx4: Use rdma_user_mmap_io")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/hw/hns/Kconfig  | 1 +
>  drivers/infiniband/hw/mlx4/Kconfig | 1 +
>  2 files changed, 2 insertions(+)

Woops, thanks Arnd, applied to for-next

Jason
