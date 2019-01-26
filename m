Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A39C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED1AF2184C
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 19:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulPgiD8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfAZTLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 14:11:19 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39115 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfAZTLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 14:11:19 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so9956062edt.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 11:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lJJMAtUkS11z2VxFANMb2emLxV7qrgoiIpjlBEdkCWA=;
        b=ulPgiD8Xoe9Z6hdbUCRnkjuxqS9Eb8Mh0qRhL8ecuHUD7ymMui/dpBU0P4byzCjDcu
         FgVee+gQoDHbTiLvlhM86Wl9Qrc5Sx4kfCAgP8KlqQ+Xll27zcXQtz6MPA6c/c4TcBjI
         KOLEacA/f0GWGdZ8MDth6hqNjaUBTEaIGMOFb77DNP3O9Dpuv09lhqtXx1fBbVl273ic
         5Tp4wVqSkCklmIn1Q7+2YXzhORr+cDHH3Oa69XQ7W/RjsMWNPrpFc2cPmAOYLIS7eMl9
         ofR1qkOK7i9ydKuRDpSh3coNlbohUwygDZPjpb/6Pca4t/PXIynisYZY+kNRIATqrVnC
         OuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lJJMAtUkS11z2VxFANMb2emLxV7qrgoiIpjlBEdkCWA=;
        b=lnVdUSroqhGTOmdWi06Ct2AZdQ2ow5wYl0pKBv5KaFh8Gnwa0NNlVovP6uGAVnHUVX
         E7SgZp8XjAp3TH4tJ8u98WNMHzW5R6LMhuxXBct0UAb3iSJGBwk+/CTPo+JHaiceo/MA
         e93I01+BDaq3+NCfIEdItmBh4UsBjnZxEH5yG5REqniylH4gusMhtl1IcABDiKYj/XSz
         wmtIF5A0K0ZQN5GAshxB8mlS/aox2FFa9SFHm/fP5Hk2yHFP/qx9hg9AmM3XrxXChjgT
         Ej/rIoSxWcg6zWgkfgVKRH/a3rBTQ5NYA7umg60ASO+v21dekp1sEriB1akT1Vk4gryh
         XEoA==
X-Gm-Message-State: AJcUukfrGVCaLIZegsyc/Jep40cP6dw7Qa/4qYpFnubicAI0eXLVDZat
        aWx3wez14DgpeWOvs22DhIc=
X-Google-Smtp-Source: ALg8bN7OGmwP1lUNIKTa8DaXP1+fkm4bbntUHW83mLqyc8495FoZ3xZc7HemBynZN6YMPKBajhjCsA==
X-Received: by 2002:a50:84a9:: with SMTP id 38mr15264799edq.185.1548529877322;
        Sat, 26 Jan 2019 11:11:17 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id g40sm12430525edg.39.2019.01.26.11.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 11:11:16 -0800 (PST)
Date:   Sat, 26 Jan 2019 12:11:15 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: ti: knav_dma: Use proper enum in pktdma_init_chan
Message-ID: <20190126191115.GA25003@archlinux-ryzen>
References: <20181211004114.28029-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211004114.28029-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 05:41:14PM -0700, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another:
> 
> drivers/soc/ti/knav_dma.c:601:20: warning: implicit conversion from
> enumeration type 'enum dma_data_direction' to different enumeration type
> 'enum dma_transfer_direction' [-Wenum-conversion]
>         chan->direction = DMA_NONE;
>                         ~ ^~~~~~~~
> 1 warning generated.
> 
> While DMA_NONE and DMA_TRANS_NONE have different values, there is no
> functional change because direction is never checked against DMA_NONE,
> only against DMA_MEM_TO_DEV and DMA_DEV_TO_MEM.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/soc/ti/knav_dma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
> index e05ab16d9a9e..6285cd8efb21 100644
> --- a/drivers/soc/ti/knav_dma.c
> +++ b/drivers/soc/ti/knav_dma.c
> @@ -598,7 +598,7 @@ static int pktdma_init_chan(struct knav_dma_device *dma,
>  
>  	INIT_LIST_HEAD(&chan->list);
>  	chan->dma	= dma;
> -	chan->direction	= DMA_NONE;
> +	chan->direction	= DMA_TRANS_NONE;
>  	atomic_set(&chan->ref_count, 0);
>  	spin_lock_init(&chan->lock);
>  
> -- 
> 2.20.0
> 

Ping?
