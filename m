Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B77BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0F1C20896
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 18:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QwvF6JbI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F1C20896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbeHTWJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:09:26 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36006 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeHTWJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:09:26 -0400
Received: by mail-oi0-f66.google.com with SMTP id n21-v6so27677274oig.3;
        Mon, 20 Aug 2018 11:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yjHFWSUiSb/uLFo2wsc8ENflHwLBaM9ufjNdEItan/o=;
        b=QwvF6JbIoyzllD/5RlevDzv3LJoYjili8aqJ5wT1CQbqy+K2INFlnukRh29j8jHUlc
         dltGtpg7rfkVuqc+v06ziEJ7odBNau7Nv23eG+f0g/WAn+DKY2si3aeLxFzd+mD/+TVI
         EQNBQFv0g+kgsux8IRHWQD44AD9eThCi+RRBoUjDKlfYIq3wE3Kq4A4qUYVx5qTTU6s0
         lR9ZGgmqlpZbRfTbpIwJ4Y4nIiXpm0EftenJ8U3oYC6aYIxtX9f/5VoSUKViYxHESePy
         4kkZB2YzqYyy9Ui40BF6Xepx8IQElWzCizx7FWsy88aVLC5RuthWxhM1Nft+ossTUcIH
         nRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yjHFWSUiSb/uLFo2wsc8ENflHwLBaM9ufjNdEItan/o=;
        b=lWp+7akJeMw7Eolti5w+I07tCQbCcdvnNpvvjEu0x/Ruy6RioJe7AfDfJ9jR6GTBSN
         VNyNuKaZYkhWdke9VhTkX2BOCPc6BAolo1HSJ6bgS7dOqnOqRYPXQItbeGXwX5PB/NBd
         pmzuTVrECb7r1of+YWes7jqM/QbrXN1E15cQsltEmPqxswt/MwuReTN+s1b53fiPAHLo
         H8lvh6t7j4XkQMsjtl4X2NvBtreeqjfTQo9sXCLGshELvIXunMj5/wgx2nhMqR++wxyC
         xrY6HPECvq4oixPd4SzA25mOLGvz+hZ3AjP5bd03Jz/xkUMgdsEXStonvd2wm92WNyAn
         94wQ==
X-Gm-Message-State: AOUpUlGPWzauQXIfReZ3qugyOnT9/L25d7tLVziIONyRqqsh5a6pq9n/
        6+UK86Q6H6fwekt0cGvuKWA=
X-Google-Smtp-Source: AA+uWPzXPMhXI1vtf5lLWoHNluFgA9d7IjRuyz9w4RbubnTB8gGSRNQYGqJZoQwQ+y+zXUIG65VmKg==
X-Received: by 2002:aca:e6cd:: with SMTP id d196-v6mr14302127oih.94.1534791158159;
        Mon, 20 Aug 2018 11:52:38 -0700 (PDT)
Received: from localhost.localdomain ([12.251.228.178])
        by smtp.gmail.com with ESMTPSA id o206-v6sm8501808oif.7.2018.08.20.11.52.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 11:52:37 -0700 (PDT)
Date:   Mon, 20 Aug 2018 11:52:34 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: armada: fix incorrect check for drvdata
 allocation failure
Message-ID: <20180820185232.GA16026@localhost.localdomain>
References: <20180730122716.6267-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730122716.6267-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello Colin,

On Mon, Jul 30, 2018 at 01:27:16PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently the drvdata allocation failure is being incorrectly checked by
> checking priv and not drvdata.  Fix this and also free priv to fix a
> memory leak.
> 
> Detected by Coverity Scan, CID#1472102 ("Logically dead code")
> 
> Fixes: c9899c183921 ("thermal: armada: use the resource managed registration helper alternative")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/thermal/armada_thermal.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index 4164a5a4e480..b164fd9f21ac 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -611,8 +611,10 @@ static int armada_thermal_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
> -	if (!priv)
> +	if (!drvdata) {

Thanks for the fix but, I already collected this patch:

84b64de597bc ("thermal: armada: fix copy-paste error in armada_thermal_probe()")

which fixes the same issue you are addressing here.

> +		devm_kfree(&pdev->dev, priv);

As already mentioned by Daniel, the above is not necessary, as it is a
devm_* helper.

BR,
>  		return -ENOMEM;
> +	}
>  
>  	priv->dev = &pdev->dev;
>  	priv->data = (struct armada_thermal_data *)match->data;
> -- 
> 2.17.1
> 
