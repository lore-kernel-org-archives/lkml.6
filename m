Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1BD3FC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C468E208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 14:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C468E208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935737AbeFMOTA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 10:19:00 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36472 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935656AbeFMOS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 10:18:59 -0400
Received: by mail-oi0-f67.google.com with SMTP id 14-v6so2478410oie.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 07:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3TrEa03hsp4Oza3Jmc9LT0+PUB1q2isznMrPvgM3URs=;
        b=G94CYlwfj8Yg4BXidbxH0JmgteF4k1AF+I2rZRJCBO4x9owc9Ws0+8aWca1Bxqi486
         OwJdlrlXyvT/HKkZXvD6rp+Rfx71mVcvVQ+8zXaggcyAaO9SqWmvpdLbwUFScQC/txK8
         igXDqd9OEIpl0kG9AiKHCtSsevciAzfKGcIfLhlQ71zTyze3iEWsEqtY7k+DW7mdGtz8
         xbvP1dKaBzQt/wnN47DqQ5MquRDEKc416+oX83JT1UQJWb8g1F4e88clm2HHIESfoqIC
         uGKYlgHIwx0/uCkd9BXhM4770Y0W+u7cg/KjDcSAl3aPzFgVaz6V1fn8fVvGHsqyE91m
         ABCg==
X-Gm-Message-State: APt69E2Myh78oVe/c24KLcu6DO9suuu/n3OhjDEiA3pIefclmwlbLqPf
        jqDEQrVc9vUs2OyIk7BftYHJkg==
X-Google-Smtp-Source: ADUXVKJfPkOZ5zlWy8K7zJ9dUNbRtIVm6TDjwtigphsDdKJ+w2OlcMAzdri1C3uWeS3h7RK5TmE0Pw==
X-Received: by 2002:aca:c102:: with SMTP id r2-v6mr4298562oif.14.1528899538563;
        Wed, 13 Jun 2018 07:18:58 -0700 (PDT)
Received: from localhost ([130.164.62.61])
        by smtp.gmail.com with ESMTPSA id t4-v6sm1557720otf.8.2018.06.13.07.18.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 07:18:57 -0700 (PDT)
Date:   Wed, 13 Jun 2018 07:18:56 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luwei.kang@intel.com, yi.z.zhang@intel.com
Subject: Re: [PATCH v6 22/29] fpga: dfl: fme-region: add support for compat_id
Message-ID: <20180613141856.GD3866@archbook>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
 <1528798243-2029-23-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528798243-2029-23-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 06:10:36PM +0800, Wu Hao wrote:
> This patch adds compat_id support, it reuses fme manager's
> compat id, as the per region compat id is actually from the
> fme manager's register.
> 
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v5: reuse fme manager's compat_id as per region compat_id
> v6: rebase, fix copyright time and add Acked-by from Alan.
> ---
>  drivers/fpga/dfl-fme-region.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/dfl-fme-region.c b/drivers/fpga/dfl-fme-region.c
> index a6e0bde..0b7e19c 100644
> --- a/drivers/fpga/dfl-fme-region.c
> +++ b/drivers/fpga/dfl-fme-region.c
> @@ -45,6 +45,7 @@ static int fme_region_probe(struct platform_device *pdev)
>  	}
>  
>  	region->priv = pdata;
> +	region->compat_id = mgr->compat_id;
>  	platform_set_drvdata(pdev, region);
>  
>  	ret = fpga_region_register(region);
> -- 
> 1.8.3.1
> 
