Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC2AECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCE22080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="vKOat87I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABCE22080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbeKAFeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 01:34:24 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:36998 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeKAFeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 01:34:24 -0400
Received: by mail-yb1-f193.google.com with SMTP id d18-v6so7225212yba.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 13:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jM0WAQyd1oh1Nro7xMTb0EJZkR7YiMUcY+piOd6TCoQ=;
        b=vKOat87IRGcsal/QvGVWPrxYAqc+/67vwTNEhvnNpytu5peFJuJm3/3wPDWpp1ujV/
         zQm+kf+Rkhza+Jc3zdjWC7nB9jIGjALlLL50hjUgZcTvdwhh/yW1fkKwC5+GLX5qyYTb
         QJOd49LZoxjZ1TrQuD3WvPZ1EzL4GQraqAN/WCVUrOPFsdIyhTXM7t3ljqF2LpLjhga+
         b3jULpbnEU1R9PTryTizM5sd7Ttmd0M8QP7Ay2IVvtjnYCsZOnVH9pTkxw2teVdJMrx7
         yuom1A3yBhEFirxGgio01pYiVPF19i4C/vblHkC0FgufFlG8kfFmaSyoY5nLbDX9w1R+
         6SQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jM0WAQyd1oh1Nro7xMTb0EJZkR7YiMUcY+piOd6TCoQ=;
        b=YFSjT6j6gxHW6D8ldKhwOT2tJ9GoKy9Y2yaREk+84jc+xGAKFcGWq9Cv1qGxBi0QP6
         E+BHDBiTXjhkWINTIkBpun2YmiYFJfC8UwwSdI2ls8KIer0v6xtZDvHzu3prdvp7a8Tm
         /KpmmlWRx5Q21/dDLmL9GWnrwErX2l6GPFw2q6AVy3H4wZmPKZAE/1ZKepSNwyjJYCM7
         0V2eAA300Hp9TjwxrQu6rKDLK5YLUJ6QGqUy4TvREuC2VTlST4lwvrViOpp7r1lLsfC5
         Bb9gdQzuGsFubECF9HfjPXscs0S4T0UMEO+Uz/uTrtaucClaCLwRtQ7LMAbwON9x91AQ
         UcGw==
X-Gm-Message-State: AGRZ1gJT06UKN2WBcLQdc9Y36t4kYbGu0BEseklvK91mvO2kJ5KYU/Dl
        FgX0Xl3psSWu1kgfvg2Dcq6RwA==
X-Google-Smtp-Source: AJdET5cCTmeI1BJIlJEEeeSGqM1KRL8PX1i2n8VnO6Cud0jgb0OhDxys21Ccs/AWjp+mvxNC8jEfxQ==
X-Received: by 2002:a25:e0c6:: with SMTP id x189-v6mr4694854ybg.520.1541018084604;
        Wed, 31 Oct 2018 13:34:44 -0700 (PDT)
Received: from kudzu.us (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id k82-v6sm1301826ywb.65.2018.10.31.13.34.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 13:34:44 -0700 (PDT)
Date:   Wed, 31 Oct 2018 16:34:42 -0400
From:   Jon Mason <jdmason@kudzu.us>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NTB: ntb_hw_idt: replace IS_ERR_OR_NULL with regular
 NULL checks
Message-ID: <20181031203441.GB22474@kudzu.us>
References: <20180827221306.GA8936@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827221306.GA8936@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 05:13:06PM -0500, Gustavo A. R. Silva wrote:
> Both devm_kcalloc() and devm_kzalloc() return NULL on error. They
> never return error pointers.
> 
> The use of IS_ERR_OR_NULL is currently applied to the wrong
> context.
> 
> Fix this by replacing IS_ERR_OR_NULL with regular NULL checks.
> 
> Fixes: bf2a952d31d2 ("NTB: Add IDT 89HPESxNTx PCIe-switches support")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied to my ntb branch

Thanks,
Jon

> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index dbe72f1..a67ef23 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -1105,9 +1105,9 @@ static struct idt_mw_cfg *idt_scan_mws(struct idt_ntb_dev *ndev, int port,
>  	}
>  
>  	/* Allocate memory for memory window descriptors */
> -	ret_mws = devm_kcalloc(&ndev->ntb.pdev->dev, *mw_cnt,
> -				sizeof(*ret_mws), GFP_KERNEL);
> -	if (IS_ERR_OR_NULL(ret_mws))
> +	ret_mws = devm_kcalloc(&ndev->ntb.pdev->dev, *mw_cnt, sizeof(*ret_mws),
> +			       GFP_KERNEL);
> +	if (!ret_mws)
>  		return ERR_PTR(-ENOMEM);
>  
>  	/* Copy the info of detected memory windows */
> @@ -2390,7 +2390,7 @@ static struct idt_ntb_dev *idt_create_dev(struct pci_dev *pdev,
>  
>  	/* Allocate memory for the IDT PCIe-device descriptor */
>  	ndev = devm_kzalloc(&pdev->dev, sizeof(*ndev), GFP_KERNEL);
> -	if (IS_ERR_OR_NULL(ndev)) {
> +	if (!ndev) {
>  		dev_err(&pdev->dev, "Memory allocation failed for descriptor");
>  		return ERR_PTR(-ENOMEM);
>  	}
> -- 
> 2.7.4
> 
