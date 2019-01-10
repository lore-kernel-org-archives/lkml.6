Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFE6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8F7208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gYnGeZpr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfAJRgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:36:31 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:44435 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbfAJRgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:36:31 -0500
Received: by mail-yb1-f194.google.com with SMTP id e1so4735581ybn.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6o4xi9I0GHXms4CBEYxts0ZMmV9p7dXam+GidfvFBRQ=;
        b=gYnGeZprpmuS9qYkJavFExayZY6EJjVsUF/a6KGGA1wWKc7RXtVU5WScYCM34Gvkde
         xwH72WPI6dmlk6jLdV46sgQ5d9iyHLoPi1C9wiYbfMrOqM7JGBBvze2Elqix5fj+eww2
         QNR8YDP7tdp0KCqVjlB4frCZpEjKmGNpRWtgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6o4xi9I0GHXms4CBEYxts0ZMmV9p7dXam+GidfvFBRQ=;
        b=Dxny/rjNR6HCi/iZyUB2NOGALoKLJL8qFczE1JLWiXvARNOyQ0gf/8nGnE/31A2Ep+
         C6ROsvp0B7xLHC38voDLViAoCRcqIr7mZxFtWqIHtmyrrpDWYygNcOJgx18IOU1h9KUL
         kYh67y4xfooMWHvB0qgHsA1zl6BVvG9wWnEBZ+7F2VUiZto8UlcG/4eoOEp71ZsL6c0a
         GkZePnD4IpH6kXOp70q4f/J+y4q6Q3Pdh2ruWHdzvxsYwE74caYC5JFb2OBnO+lHjbM5
         5fQuFElbqyd3eLH9NdRDOyC7n4TsXbF1UKWpDfDIG+y6IUk5fTWdd50grI6269jXpDIf
         1tSg==
X-Gm-Message-State: AJcUukcyzUiYLxN1focCKVtDWyVnYaPItBqBcOEz/tIkI55FLEyRLCLz
        /tZ651HQHp5WuaC9yO3DmndpCA==
X-Google-Smtp-Source: ALg8bN6tC2jiIOi8kv27nGxRQZKncLmNzWB+cUFsTiYhF9uqDP2rFPvqLhCIgkEx3CJPWFsr3HZBlA==
X-Received: by 2002:a25:3950:: with SMTP id g77mr10309373yba.448.1547141789545;
        Thu, 10 Jan 2019 09:36:29 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x132sm35386699ywx.27.2019.01.10.09.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 09:36:28 -0800 (PST)
Subject: Re: [PATCH] dmaengine: bcm-sba-raid: Handle mbox_request_channel
 failure
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
References: <1547100464-7020-1-git-send-email-rayagonda.kokatanur@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <3d5497d8-7275-1461-8b59-b3695838be45@broadcom.com>
Date:   Thu, 10 Jan 2019 09:36:26 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547100464-7020-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/2019 10:07 PM, Rayagonda Kokatanur wrote:
> Fix kernel NULL pointer dereference error when mbox_request_channel()
> fails to allocate channel.
> 
> Fixes: 4e9f8187aecb ("dmaengine: bcm-sba-raid: Use only single mailbox channel")
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>  drivers/dma/bcm-sba-raid.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
> index 72878ac5c78d..77ae74663a45 100644
> --- a/drivers/dma/bcm-sba-raid.c
> +++ b/drivers/dma/bcm-sba-raid.c
> @@ -1690,7 +1690,7 @@ static int sba_probe(struct platform_device *pdev)
>  	sba->mchan = mbox_request_channel(&sba->client, 0);
>  	if (IS_ERR(sba->mchan)) {
>  		ret = PTR_ERR(sba->mchan);
> -		goto fail_free_mchan;
> +		goto fail_exit;
>  	}
>  
>  	/* Find-out underlying mailbox device */
> @@ -1747,6 +1747,7 @@ static int sba_probe(struct platform_device *pdev)
>  	sba_freeup_channel_resources(sba);
>  fail_free_mchan:
>  	mbox_free_channel(sba->mchan);
> +fail_exit:
>  	return ret;
>  }
>  
> 

Looks good to me.

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
