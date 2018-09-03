Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F96BC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC67E20867
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 19:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="heqYNVY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC67E20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbeICXmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 19:42:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46199 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbeICXme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 19:42:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so519207pfn.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 12:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PL1FJmN3oihC7AnOx4Qy7gkw9MHVnnMB1Ztw8mhAH/g=;
        b=heqYNVY0p8VBWrYOLvaulzDCw6nA1LI+sH6wglKGrQn0joOG8U9WRrbJ2yBbai0jRT
         X9Lrs+g8zfi9E00KDBFcsQ3uPTYQKUo7CCtgrx5Ko1oFZQOgf5GafAeBIHpB90BtY+Uw
         g/8u+PVV5a6/2V5AwtCGZYv3yQG0zl07f7noM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PL1FJmN3oihC7AnOx4Qy7gkw9MHVnnMB1Ztw8mhAH/g=;
        b=O5BQlvp/q/YALJAgzs3qeekp5uXZrswDlOQViK7lOKxXHaWErGSHOXWpJN5mV7PFZY
         JyYkyCrS48s67M9ruUzMgxhcUjc2jwvplW6RLUqKqdvHyazpVCyMHJYuvh6heK+EAOZp
         VdRba8j9jw4HXcIyBb0gMZNAgqbNwz6Hu4iYTzbIjdnlZmBTMGrysaqiUtlulF7s7RyK
         1ThTMULcm4wk3YS3NOFV5teyqJPkHJgSj5b/TK6e3s+GpZxZ2wLmi7KaKJRrpbT+2k3A
         T+ew4wuULmI3e6KhFzn92Lxz/ct1nKfUo8I0J6PSAvaGsBYvGGREim+i1oo8gs2HghbQ
         YKbA==
X-Gm-Message-State: APzg51CKrjtKCN3HJvgKmk0m50s0WUACp3IuOoGD/2Dn6ue2Cvy9rI6c
        aPuITv/gFqDS+4o0WGE7wMj7SQ==
X-Google-Smtp-Source: ANB0VdY0W2+a6t5b85VB3t/7T8kKjVo0JKxdwkhvKRnf/ZODUWx38w8/aGcN3KWyEfIHUvtBdvVqvA==
X-Received: by 2002:a62:591a:: with SMTP id n26-v6mr31104511pfb.94.1536002459589;
        Mon, 03 Sep 2018 12:20:59 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id y4-v6sm24849166pfm.137.2018.09.03.12.20.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 12:20:59 -0700 (PDT)
Date:   Mon, 3 Sep 2018 12:24:53 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 8/9] soc: qcom: apr: Avoid string overflow
Message-ID: <20180903192453.GD3456@tuxbook-pro>
References: <20180829075724.9095-1-niklas.cassel@linaro.org>
 <20180829075724.9095-9-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829075724.9095-9-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29 Aug 00:57 PDT 2018, Niklas Cassel wrote:

> 'adev->name' is used as a NUL-terminated string, but using strncpy() with the
> length equal to the buffer size may result in lack of the termination:
> 
> In function 'apr_add_device',
>     inlined from 'of_register_apr_devices' at drivers//soc/qcom/apr.c:264:7,
>     inlined from 'apr_probe' at drivers//soc/qcom/apr.c:290:2:
> drivers//soc/qcom/apr.c:222:3: warning: 'strncpy' specified bound 32 equals destination size [-Wstringop-truncation]
>    strncpy(adev->name, np->name, APR_NAME_SIZE);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This changes it to use the safer strscpy() instead.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/soc/qcom/apr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
> index 57af8a537332..ee9197f5aae9 100644
> --- a/drivers/soc/qcom/apr.c
> +++ b/drivers/soc/qcom/apr.c
> @@ -219,9 +219,9 @@ static int apr_add_device(struct device *dev, struct device_node *np,
>  	adev->domain_id = id->domain_id;
>  	adev->version = id->svc_version;
>  	if (np)
> -		strncpy(adev->name, np->name, APR_NAME_SIZE);
> +		strscpy(adev->name, np->name, APR_NAME_SIZE);
>  	else
> -		strncpy(adev->name, id->name, APR_NAME_SIZE);
> +		strscpy(adev->name, id->name, APR_NAME_SIZE);
>  
>  	dev_set_name(&adev->dev, "aprsvc:%s:%x:%x", adev->name,
>  		     id->domain_id, id->svc_id);
> -- 
> 2.17.1
> 
