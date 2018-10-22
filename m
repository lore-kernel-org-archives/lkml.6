Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1713FC004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD1720645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 18:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="D11cge1c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFD1720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728904AbeJWCfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 22:35:01 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:51891 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbeJWCfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 22:35:01 -0400
Received: by mail-it1-f193.google.com with SMTP id 74-v6so12948755itw.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Oct 2018 11:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9GH0SwJOZIzEMndd35Rz+3RrbKS1QOTiYaCrODUg2Hc=;
        b=D11cge1cack2hFD90EPtMvTDVcj4Prp/ers7F/PZ6wBEPt3ulUsGdMRRI4lcPjNLkm
         Vsd3CYNB5yjAdNYXBGAUwHFobthmJXZPQxe6uJr0OboZIQwLGiJ7qHc/XMUidB6bkIyI
         bL5iZhppouwVxrw0qZBTsPkCUuAanDeO0pPJo27E2dtaVzIvb2inhLeJoa59YDkufhLW
         AWWWWDNSN+tXoJf8iq46Bp+QBV5yXG7Ts0copHEdF9EFW7cKBCTjofk4VMrG5+n6Xn+u
         st+f8Gea2s+W7IvR5eT2Uq9DbIiupQsMXo3XXy5kh3CGPZlhU8UKMVPVM3wTHSEaqmlh
         VUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9GH0SwJOZIzEMndd35Rz+3RrbKS1QOTiYaCrODUg2Hc=;
        b=TkaxLBtOIWHX6PR/v92geiDvpo/HJwl06coILA99uFhTQtDqpcciMUJ2VI8x2rsFNl
         dld+iU2AuE89o79hT8BQCPwWtvKbqCF6N+U8lm5CjlZzTIqgHT/N7IvubZA0/RwQEl8v
         wHdTEXx53FTvHCU7W7jT0TZPfg1+ilKss+4ltMUjQd7jRsFXeyzvekirCBcmyYMHGws0
         hCr4Wzn++l99DVY2BSL6y8U2iVCilx2Y7KvBfNwYcIihEC7jWEaN1ZQ5ear+uxXb1xlb
         4EyuD8n9ncXBewxECDj+22E0BuAmTOwW75Y8grduYobp8jB6JZv9wTF9ywdUyn5xEboS
         WGEw==
X-Gm-Message-State: ABuFfohubRdV9h0EovDTOL1wpezJtmLVTFtme5C9VYEcjYRBw5BsaJT5
        JbKEE/O2DSRfreyYjofrRFTtCw==
X-Google-Smtp-Source: ACcGV61Phgl97T2NnKqV60vsYDanp5+BppM1jyfiXhcv3YGVI5FpViyLKz5V0jJFcFyfu4VS4qL1YA==
X-Received: by 2002:a24:a508:: with SMTP id k8-v6mr10622669itf.127.1540232125720;
        Mon, 22 Oct 2018 11:15:25 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id z191-v6sm5435190itb.31.2018.10.22.11.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Oct 2018 11:15:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gEejb-00020m-E7; Mon, 22 Oct 2018 12:15:23 -0600
Date:   Mon, 22 Oct 2018 12:15:23 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Use 64-bit arithmetic instead of 32-bit
Message-ID: <20181022181523.GB30059@ziepe.ca>
References: <20181018080258.GA1720@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018080258.GA1720@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 10:02:58AM +0200, Gustavo A. R. Silva wrote:
> Cast *max_num_sg* to u64 in order to give the compiler complete
> information about the proper arithmetic to use.
> 
> Notice that such variable is used in a context that expects an
> expression of type u64 (64 bits, unsigned) and the following
> expression is currently being evaluated using 32-bit
> arithmetic:
> 
> length = max_num_sg * page_size;
> 
> Addresses-Coverity-ID: 1474517 ("Unintentional integer overflow")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>  drivers/infiniband/hw/hns/hns_roce_mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_mr.c b/drivers/infiniband/hw/hns/hns_roce_mr.c
> index 521ad2a..d479d5e 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_mr.c
> @@ -1219,7 +1219,7 @@ struct ib_mr *hns_roce_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
>  	int ret;
>  
>  	page_size = 1 << (hr_dev->caps.pbl_buf_pg_sz + PAGE_SHIFT);
> -	length = max_num_sg * page_size;
> +	length = (u64)max_num_sg * page_size;

This should be done with check_mul_overflow() which will also force
the input types to the correct thing.

alloc_mr is callable from userspace so the potential overflow here
should not be ignored.

Jason
