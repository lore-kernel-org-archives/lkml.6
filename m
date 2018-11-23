Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF4DC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA7820861
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 20:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="b5UA2iRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DA7820861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbeKXHdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 02:33:12 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36073 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbeKXHdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 02:33:12 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so3479501pgm.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Nov 2018 12:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CGw3X7vyU/LGwMbOd4g+kxqUxg6cAN9ipMNuU+g3BZE=;
        b=b5UA2iRSLIU7p3747AKeAQ6riN7YdVmFAfQ71FF+Z5HVKz+LGqB6+1DhsgGUvO3hgo
         lD9tAjYeTpTYcAcs57YjuwXqYSqm3mesR3GbIgPtBXMop1ou4BOckrvm8293zHqg49PN
         XHW2FpDrgWcv4uklDk7LMVsz4IVoRB9Gx2hb+glIx44ZOdFmBUzfze5MdIOpyZ8sCHeE
         GYAQb7BfIXHAnJ5jNu/OXYYxJWGW5mrGL53kM4haLGKnAfjMbOP0wWr7Qcb3V4Hxh/qH
         EVHyRDtbeMLbGTgO7nfoy8BOP15P/88ejgNUp2LMPY566yjWsHNdJcdl4pDyinEKm6i1
         qmZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CGw3X7vyU/LGwMbOd4g+kxqUxg6cAN9ipMNuU+g3BZE=;
        b=iN0IPtvJ/Ns/enztZEJnWFESgagjKrObWw2dLRl3fS27p4b0TB0+wIEUVgcCj4hGyP
         P+9BXEehabVSZqu5AIHV9dpV8ub6dT4H3WqUQ/pKnugklPToeSJ8ohwpBtBJJ6nH3kAG
         92iAD5Kduo8fIXMKSuLznYomRnRXeC9xklD4w9UxCfE/y8+vGGu0z8ggK+4XS5jUtnqO
         4aUesLvKA8rvovyC351TR0cWUA/WbA2zKu01RcEzzPoqPbjyFk+FnI89FruBdTWUK6Kh
         gavnFfIM4C/G6GpFbDtI8R98focFBx/krGVmOGBl5W4fdxsRbT0BGXkCmqagynGGUKa9
         A99g==
X-Gm-Message-State: AA+aEWZMWmhtg9iVmSZOJ3Eo+ARix8B+/2LzxcNKNvmfBg3vgaBOmDZi
        vgHOtWoJY5QZpQW/qgMOgjpZYQ==
X-Google-Smtp-Source: AFSGD/WtUJlKZ8O8OPj/TRBbHTMUUBBxsaHw0YeHWBFlM1aiT6sdvaUCTUjgYikeQRNFKZUdf8wjjw==
X-Received: by 2002:a63:db02:: with SMTP id e2mr15618385pgg.419.1543005599696;
        Fri, 23 Nov 2018 12:39:59 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id j185sm29825625pge.72.2018.11.23.12.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Nov 2018 12:39:58 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gQIF4-0004Px-2c; Fri, 23 Nov 2018 13:39:58 -0700
Date:   Fri, 23 Nov 2018 13:39:58 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Wei Hu (Xavier)" <xavier.huwei@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        lijun_nudt@163.com, oulijun@huawei.com, charles.chenxin@huawei.com,
        liuyixian@huawei.com, zhangxiping3@huawei.com, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org, xavier_huwei@163.com
Subject: Re: [PATCH rdma-next 3/3] RDMA/hns: Modify hns RoCE device's name
Message-ID: <20181123203958.GJ3395@ziepe.ca>
References: <1542986065-44265-1-git-send-email-xavier.huwei@huawei.com>
 <1542986065-44265-4-git-send-email-xavier.huwei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542986065-44265-4-git-send-email-xavier.huwei@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 11:14:25PM +0800, Wei Hu (Xavier) wrote:
> This patch modifies the name of hns RoCE device's name in order
> to ensure that the name is consistent before and after reset.
> 
> Signed-off-by: Wei Hu (Xavier) <xavier.huwei@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_device.h | 1 +
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 3 +++
>  drivers/infiniband/hw/hns/hns_roce_main.c   | 4 +++-
>  3 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
> index 259977b..a8cfe76 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
> @@ -954,6 +954,7 @@ struct hns_roce_dev {
>  	struct pci_dev		*pci_dev;
>  	struct device		*dev;
>  	struct hns_roce_uar     priv_uar;
> +	char			name[IB_DEVICE_NAME_MAX];
>  	const char		*irq_names[HNS_ROCE_MAX_IRQ_NUM];
>  	spinlock_t		sm_lock;
>  	spinlock_t		bt_cmd_lock;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 1d639a0..678c7ec 100644
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -6110,6 +6110,9 @@ static int hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
>  		hr_dev->irq[i] = pci_irq_vector(handle->pdev,
>  						i + handle->rinfo.base_vector);
>  
> +	snprintf(hr_dev->name, IB_DEVICE_NAME_MAX, "hns%s",
> +		 handle->rinfo.netdev->name);

Why is this making up its own driver name? How is this avoiding
colliding with an existing name?

This is very dangerous since we now have device renaming, the driver
could fail to load with no recovery.

Jason
