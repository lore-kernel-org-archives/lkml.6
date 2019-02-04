Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A969FC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722FB2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="J2Osl4ME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfBDWeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:34:22 -0500
Received: from mail-pf1-f173.google.com ([209.85.210.173]:44285 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfBDWeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:34:22 -0500
Received: by mail-pf1-f173.google.com with SMTP id u6so580041pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 14:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+jMZPbvnKEuG/nLAGNWlhiAeOm1TKx2Hq4rVY0RHeFI=;
        b=J2Osl4MEHLigRvFHxh/B0wF0SrR+kgVwBrJjLkVW5GWWZBaW+NegivD57qgFR+D9G8
         lruOv0F/QVIYOoXVMfKI06L7jaq1eaTwO7LDaquyhvjpN1r6wlKG8wJ2/9GNfsY7WhCh
         0xXIKYZ0l1sUsn39SS8QcSLU04b5gPq4DbmMKoCEmzuF+hxuyghdKnXUDr/70GJrhxGN
         38gBndtpmYGs5TeImi7JKIYTqyhP7KlytiyJi47d802ph6TwOyLUINz1QC9XKlgxqZCq
         W6i5gQ+OM3aCBegBKts+Dgpky1ZWmMzbEEPtkzNqXNNZ5Gd5w3NG5AVua09csJ3RxEp+
         yghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+jMZPbvnKEuG/nLAGNWlhiAeOm1TKx2Hq4rVY0RHeFI=;
        b=kkPuhHOX1+qoj86kzKC8tQJc0UqzOWhFMhgjScc6xF1tQTsKbNxJpaEYxN8ncgRbxw
         nL53nRVZkpW3mDrsfrIwdWroSgCf22+RrxxO6tolmQ0LW1GwgwVZrEIPpbEH7FYfPWUu
         kAs7Nx95ltVwYpvFAg5gj/8EA4vSz1qvNEGlwPRsE+m/JGRbw4ijfJFV5SeloFJgp96V
         qcnuZqCJcSFOecqOXBPPSmBmbpLqLaWYjDEeVKkanlJzjnHrIVvjwsnauduP6z3FHUzq
         Ln32C4ox8hIBpsrE8DTTwyVR/cGycCq6I6EDS40cch04uJfUs05Zj0hX27OoshPTSTuy
         zifA==
X-Gm-Message-State: AHQUAuYF4/scwPzTT0fyLmGyhTn+lIwpzcd0YlSMkD/sNzopgdKTa7Za
        PWUAhfrBeZkfonBDmsoYh0PmpYGJqHo=
X-Google-Smtp-Source: AHgI3IZHQp42fQ3Ib8YEr+f3RTusoW+wQRuqLnxnJAgaPfiTv2a49qRklFWsu6txTWGd+xWmGp1yzA==
X-Received: by 2002:a63:a84a:: with SMTP id i10mr1569484pgp.263.1549319661425;
        Mon, 04 Feb 2019 14:34:21 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id w11sm1463315pgk.16.2019.02.04.14.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 14:34:20 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gqmom-000655-3F; Mon, 04 Feb 2019 15:34:20 -0700
Date:   Mon, 4 Feb 2019 15:34:20 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     oulijun@huawei.com, xavier.huwei@huawei.com, dledford@redhat.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next] RDMA/hns: Make some function static
Message-ID: <20190204223420.GA23292@ziepe.ca>
References: <20190201031104.15064-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201031104.15064-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 11:11:04AM +0800, YueHaibing wrote:
> Fixes the following sparse warnings:
> 
> drivers/infiniband/hw/hns/hns_roce_hw_v2.c:5822:5: warning:
>  symbol 'hns_roce_v2_query_srq' was not declared. Should it be static?
> drivers/infiniband/hw/hns/hns_roce_srq.c:158:6: warning:
>  symbol 'hns_roce_srq_free' was not declared. Should it be static?
> drivers/infiniband/hw/hns/hns_roce_srq.c:81:5: warning:
>  symbol 'hns_roce_srq_alloc' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
>  drivers/infiniband/hw/hns/hns_roce_srq.c   | 9 +++++----
>  2 files changed, 6 insertions(+), 5 deletions(-)

Applied to for-next

Thanks,
Jason
