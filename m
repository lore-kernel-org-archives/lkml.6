Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AA3C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9DE21872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 18:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TrHNTnHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfADSp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 13:45:26 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39183 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfADSpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 13:45:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id r136so18680040pfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 10:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6GF5rAcfMJVLtpvQ7aVtwTUTzKCYj9NcKt5CqRfM1bU=;
        b=TrHNTnHBnCmoDtATHQFoi4iF+FKipdi69j87lYxSzUKQo4H52wa3AdS7mJnWtA0RKR
         VvhaLE+wvHCvmUNVRJdwIeklvbSVr/D1iJH02XZcnT4DeUOpGq11JTiJipLINhp//6Zg
         DMmuvjAIyd93Oo5s3x0VjlB9Ub7Mddd/ifmok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6GF5rAcfMJVLtpvQ7aVtwTUTzKCYj9NcKt5CqRfM1bU=;
        b=CtNLaU30CRCiM2XMRm6qleU3EyUwAEpcyVJQGmo1RalURUjJjRF+yq7+BVum2sDAnp
         Dlv+PR5L1xyiN5swooXyxOIyiOUtK1vdS6EsaUJpmo5MmFrItLXqQ4ckPc6R8EHQMHAr
         l5GpHnPCjuMEdhGKj4Cog474vfNO9HbthG29uqImgyrlrsE1ao3Rm+CXiZvZd/po+79a
         xzd1cu8Q0ghPbkHqSluVxz8twOUg7kZP6l0cOw0fYOe1SJNB7yRRLZJymjm03DSP2on3
         Vu15v1ibtEftnn+p44+DxPqC/9uFeugdOavwGsvBKSKJ6Tyx+MlOJEqICexUIcJPC7t2
         VQtQ==
X-Gm-Message-State: AJcUukfG8fiv6EcRzGw54tFR7ALZXJBzR3iBdIxn1ZRjyP+8YPntlr4/
        NuKTuKLs2/h5uvo2JTQKxHr8Hg==
X-Google-Smtp-Source: ALg8bN4PXKeyIEFfjnEDWD97zpcBrCNDADbtFR1r64GEbMqG+Pz1D/u0vMwZL8qOTC4MZRWO3lJ59A==
X-Received: by 2002:a63:381c:: with SMTP id f28mr21610892pga.330.1546627524787;
        Fri, 04 Jan 2019 10:45:24 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id m67sm115796970pfb.25.2019.01.04.10.45.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 10:45:23 -0800 (PST)
Subject: Re: [PATCH] mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush
 timeout issue
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <1546573819-23530-1-git-send-email-rayagonda.kokatanur@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <f115f375-0314-a493-0c34-49cd704c8d35@broadcom.com>
Date:   Fri, 4 Jan 2019 10:45:21 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1546573819-23530-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/3/2019 7:50 PM, Rayagonda Kokatanur wrote:
> RING_CONTROL reg was not written due to wrong address, hence all
> the subsequent ring flush was timing out.
> 
> Fixes: a371c10ea4b3 ("mailbox: bcm-flexrm-mailbox: Fix FlexRM ring flush sequence")
> 
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> Tested-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>  drivers/mailbox/bcm-flexrm-mailbox.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
> index d7a8ed7..57cd729 100644
> --- a/drivers/mailbox/bcm-flexrm-mailbox.c
> +++ b/drivers/mailbox/bcm-flexrm-mailbox.c
> @@ -1396,9 +1396,9 @@ static void flexrm_shutdown(struct mbox_chan *chan)
>  
>  	/* Clear ring flush state */
>  	timeout = 1000; /* timeout of 1s */
> -	writel_relaxed(0x0, ring + RING_CONTROL);
> +	writel_relaxed(0x0, ring->regs + RING_CONTROL);
>  	do {
> -		if (!(readl_relaxed(ring + RING_FLUSH_DONE) &
> +		if (!(readl_relaxed(ring->regs + RING_FLUSH_DONE) &
>  		      FLUSH_DONE_MASK))
>  			break;
>  		mdelay(1);
> 

Looks good to me. Thanks.

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
