Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA15CC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802F12073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V1l2xtaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802F12073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeIFC1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:27:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38496 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727876AbeIFC1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:27:00 -0400
Received: by mail-pl1-f195.google.com with SMTP id u11-v6so3925714plq.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 14:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ocwCp4FTzJDaRvo3IIMSA5yMnq81kmSCGZhFLQ1qCZw=;
        b=V1l2xtaW4ynjmj7WysNZwhxI77CkmBspA11GzK44YS06e6TDUMqcx1Vn4xZDhoO7JZ
         B6E3qj5wTVPPBDTv7bRMp/BgNPZhzvwWiT37qoVwAZVmyNko/9ueuRKxdV91Gy6tcway
         ZUwFPvLEQBWQtZSRDqTns60j4GDiUjgpMygPwMWQLzHH/Eo21T0AgIrDY03sHGQIsm1x
         QREDSxdRjG7ZZxzmclSEzX2UWWJaHbw/tZ975Lpb5SSBUHqCnlbHkMdbEzSaOfPFBzgB
         oDdkWhS1HZO/slhSz0YZRmHCrkq95biL4M3r/IVUdPsuLI19GodZWQje0QL6ulBgZyCb
         bWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ocwCp4FTzJDaRvo3IIMSA5yMnq81kmSCGZhFLQ1qCZw=;
        b=q7N9DANtKtzRrqF4oXV/15P/GMbiP9KjeUYymnNP2uctDg3CcbHtA7980MePUD56Ox
         Lqlgv+igORhURsA72rXjZQBXhzL15VZVjJ25DK5YV0FLGvdyNq7NNEdx0SC97Gvi2v9q
         oaO3YlEsg3g56HpjreBOdZz/sySx2w0zRIEOYsPLm2Unc9FBepY7+fQc4OUGRBe6nP4v
         dDgDTCsIF1WSlMmGm+ngMaZJ5j6Yn5BQXyo+d+gpjg41yFznRiBBpkuzt7z+GWkHO/uj
         RGGDcj/3jP9r7vEaA8PLSBytb37Tfk2EvKsqz/iyCn+MrpfS1dKtpSzuZcND7RN15/h5
         FwQg==
X-Gm-Message-State: APzg51AXMXqBg3JnowIoXWJZXl/Y3H3wJNb4udTXDqM7QQYAF1RYxwzE
        7yJc+/nI+aw9dWnyIUrgwuxmJA==
X-Google-Smtp-Source: ANB0VdYqzxE5XGW7pyrrHaE543+ZfTZsJ+0Nsi6oeEe6WYH4hOxlwvoIlu/7IK4T8Bpu93vWkSlRGQ==
X-Received: by 2002:a17:902:145:: with SMTP id 63-v6mr33137659plb.329.1536184492011;
        Wed, 05 Sep 2018 14:54:52 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id h12-v6sm4685921pfo.135.2018.09.05.14.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 14:54:51 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1fxflC-0007BY-M0; Wed, 05 Sep 2018 15:54:50 -0600
Date:   Wed, 5 Sep 2018 15:54:50 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     oulijun@huawei.com, xavier.huwei@huawei.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: hw: hns: Fix a sleep-in-atomic-context bug
 in hns_roce_set_hem()
Message-ID: <20180905215450.GA27596@ziepe.ca>
References: <20180901113948.28967-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180901113948.28967-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2018 at 07:39:48PM +0800, Jia-Ju Bai wrote:
> The driver may sleep with holding a spinlock.
> 
> The function call paths (from bottom to top) in Linux-4.16 are:
> 
> drivers/infiniband/hw/hns/hns_roce_hem.c, 345: 
> 	msleep in hns_roce_set_hem
> drivers/infiniband/hw/hns/hns_roce_hem.c, 330: 
> 	_raw_spin_lock_irqsave in hns_roce_set_hem
> 
> To fix this bug, msleep() is replaced with mdelay().
> 
> This bug is found by my static analysis tool DSAC.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This was already fixed here:

commit 73b4e1f4c04e76b19fca296d09b97555bfb35202
Author: Lijun Ou <oulijun@huawei.com>
Date:   Wed Jul 25 15:29:38 2018 +0800

    RDMA/hns: Use delay instead of usleep
    
    In order to avoid using usleep function in lock function, we use delay
    function instead of it.  Besides, it also use brackets for standardized
    the computed order.
    
    Signed-off-by: Lijun Ou <oulijun@huawei.com>
    Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
