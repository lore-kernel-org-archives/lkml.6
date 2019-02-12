Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13B7C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFB1222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 20:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iX/VWox6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731004AbfBLU40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 15:56:26 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40956 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727977AbfBLU4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 15:56:25 -0500
Received: by mail-pl1-f196.google.com with SMTP id bj4so35021plb.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 12:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9obCINMWSbQx5Z9XA4aTeD2Li1SJweF1UfOgZps0VW8=;
        b=iX/VWox6n763texG9bk7BIhTEUn7Mz7SzHXowBIQoaQ4kO4jf3KAE1fQcKU0XDJLSp
         t9y+1BbnoL19/5L4HvWfkjhybUxW70ZxYp69QWF+YtXMujgNhHjwE/F90rGxVGw2PrWX
         s2qEc1BYeIZJ/FumqZlD0NXvzFSIHwd/jAHB/HUFT7rRi1wu1bGBRng7LpVN41AFZnDW
         /DXKlYobWVJfzneZeS8FUyizl6VYUCqD9fUquQOgf84mQGaTkQL4ogECEgZxLzzcQcjk
         vFuI7cp1eZPlTZoygpPalZ4C1jgnZFxQfspp8nWCn670+hD2sKpgHya2x7mRRd/KHFo8
         vMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9obCINMWSbQx5Z9XA4aTeD2Li1SJweF1UfOgZps0VW8=;
        b=n5NPRbSLl5d0xtkRbhL/7JmGFIWn+a3HlJYEjrGM1XCWTxFyOEpfnQ4gC2oYfeOGx7
         O/S0GCtyuQUsP7uX8LKuQgT+WvP37jqr+PfUe8QNpswdpbnfxu6ixdzsIp8EzYMbhBEd
         4jp7+aRvKVdfLqZ1NLOf1IOjXsI2cUnW116KOd2uAoX47vFHEeYJ9nnlK1oSMgpjnevZ
         VtNgU3hsGiDwZgLa0NIeEmc92RHIRXspXdAQw6MYhGyPwJFofcIXJjDxD3WBTRA8Atec
         idrfhoPEFsucoKsMjRyXFv7sUNS9/clTGkvv91DafGtI2Cc5i2Lql0YgFikB4Tsgys9m
         eJuw==
X-Gm-Message-State: AHQUAubrpvtSHYwTftvUS5uJHK4m3I4+dx235hljMMPPonObqIYKP+QJ
        w1ZbQXRIfRmnDrZM9z2/vYimig==
X-Google-Smtp-Source: AHgI3Ib3TYUqKxpuO2lOMPo4cYqufg2Aah6gR0aEOs70VYRUIg/XXXbMuBNReqQE0e4/4NlCICy9Zw==
X-Received: by 2002:a17:902:9b87:: with SMTP id y7mr5970199plp.336.1550004985210;
        Tue, 12 Feb 2019 12:56:25 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id i74sm28807661pfi.33.2019.02.12.12.56.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 12:56:24 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gtf6O-0006qD-0Q; Tue, 12 Feb 2019 13:56:24 -0700
Date:   Tue, 12 Feb 2019 13:56:23 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Lijun Ou <oulijun@huawei.com>,
        Wei Hu <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA: fix allocation failure on pointer pd
Message-ID: <20190212205623.GA26269@ziepe.ca>
References: <20190212112233.25667-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212112233.25667-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 11:22:33AM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The null check on an allocation failure on pd is currently checking
> if pd is non-null rather than null. Fix this by adding the missing !
> operator.
> 
> Fixes: 21a428a019c9 ("RDMA: Handle PD allocations by IB/core")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks applied to for-next

Regards,
Jason
