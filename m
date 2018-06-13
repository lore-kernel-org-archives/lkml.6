Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6944BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C99208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 20:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C99208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935741AbeFMUIN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 16:08:13 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33336 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935333AbeFMUIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 16:08:11 -0400
Received: by mail-ot0-f196.google.com with SMTP id h6-v6so4459164otj.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 13:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yS2pvsEriNiXpKsTUV7eHqo2cX4+StnkRHLgBEpgxMQ=;
        b=U2r95avHSd0eIk2NQz3zLct+HWNeFFE+ejvThWEuz1cCmQIvjCmWC+JoUbqRRCS9+A
         SSJ0Ts55tvpre0BOGLo06qD9Ci+m0UQ0/fUbS5Ze2zeKFja9p2agppBSNML85SN82iS/
         0Mc3RMEacm9KqqHxtPjkSTU8tj4fnX2UsWi0GpvyhuYOpF4UQaXsl9MiqSR4AEdTcfQb
         XH7SiRYbnFUCL+kjWjYVCVy9WCIBrQIphrGCG4dvkr38sauu4WqqVcN6YPpXBtXYDr3z
         i7iuI8MJEd0jCbewDkeeGm9i0dCdn3VFlpJiFuY1uXbdXq9gE3kqn+g0T/yb6zmsBmzP
         Qb3g==
X-Gm-Message-State: APt69E00mjoHOR95wtiLtJG2eMzpgA3NFyRrF7ahNHDR2VahIIbHWVGf
        oChr2d/ctyXwXjd1LGoCccUeog==
X-Google-Smtp-Source: ADUXVKLs06zYTJtg6OtX1oGpqFYU5a7gc2IqYMt8vPG1QujU19i8vC6dhskS1xEnP1n+eaVnefNItw==
X-Received: by 2002:a9d:577d:: with SMTP id x58-v6mr4225443oti.196.1528920490493;
        Wed, 13 Jun 2018 13:08:10 -0700 (PDT)
Received: from localhost ([130.164.62.61])
        by smtp.gmail.com with ESMTPSA id r131-v6sm1433332oih.16.2018.06.13.13.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 13:08:08 -0700 (PDT)
Date:   Wed, 13 Jun 2018 15:08:08 -0500
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luwei.kang@intel.com, yi.z.zhang@intel.com
Subject: Re: [PATCH v6 19/29] fpga: dfl: fme-mgr: add compat_id support
Message-ID: <20180613200808.GA24512@archbook>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
 <1528798243-2029-20-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528798243-2029-20-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 06:10:33PM +0800, Wu Hao wrote:
> This patch adds compat_id support to fme manager driver, it
> reads the ID from the hardware register. And it could be used
> for compatibility check before partial reconfiguration.
> 
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Acked-by: Alan Tull <atull@kernel.org>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v6: add Acked-by from Alan.
> ---
>  drivers/fpga/dfl-fme-mgr.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
> index be0060a..691761f 100644
> --- a/drivers/fpga/dfl-fme-mgr.c
> +++ b/drivers/fpga/dfl-fme-mgr.c
> @@ -272,9 +272,17 @@ static u64 fme_mgr_status(struct fpga_manager *mgr)
>  	.status = fme_mgr_status,
>  };
>  
> +static void fme_mgr_get_compat_id(void __iomem *fme_pr,
> +				  struct fpga_compat_id *id)
> +{
> +	id->id_l = readq(fme_pr + FME_PR_INTFC_ID_L);
> +	id->id_h = readq(fme_pr + FME_PR_INTFC_ID_H);
> +}
> +
>  static int fme_mgr_probe(struct platform_device *pdev)
>  {
>  	struct dfl_fme_mgr_pdata *pdata = dev_get_platdata(&pdev->dev);
> +	struct fpga_compat_id *compat_id;
>  	struct device *dev = &pdev->dev;
>  	struct fme_mgr_priv *priv;
>  	struct fpga_manager *mgr;
> @@ -295,11 +303,18 @@ static int fme_mgr_probe(struct platform_device *pdev)
>  			return PTR_ERR(priv->ioaddr);
>  	}
>  
> +	compat_id = devm_kzalloc(dev, sizeof(*compat_id), GFP_KERNEL);
> +	if (!compat_id)
> +		return -ENOMEM;
> +
> +	fme_mgr_get_compat_id(priv->ioaddr, compat_id);
> +
>  	mgr = fpga_mgr_create(dev, "DFL FME FPGA Manager",
>  			      &fme_mgr_ops, priv);
>  	if (!mgr)
>  		return -ENOMEM;
>  
> +	mgr->compat_id = compat_id;
>  	platform_set_drvdata(pdev, mgr);
>  
>  	ret = fpga_mgr_register(mgr);
> -- 
> 1.8.3.1
> 
Thanks,

Moritz
