Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Y2mKI9/hGltuMgAAmS7hNA
	; Fri, 08 Jun 2018 20:07:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 54D99605A5; Fri,  8 Jun 2018 20:07:56 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ptt1xLzm"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 540F56074D;
	Fri,  8 Jun 2018 20:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 540F56074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeFHUHy (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:07:54 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37452 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752968AbeFHUFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:05:07 -0400
Received: by mail-pl0-f66.google.com with SMTP id 31-v6so8873825plc.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 13:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+N7TW72v+t/5sD1mAeheF2xfj4Q3xhLy8CyQ/zPhWjE=;
        b=Ptt1xLzmDnqX83AoLI88XYrXyKWoegFBJbihHi7RUDznwqy/JTV6qmMbu5Gdx0DIgX
         mHi/ghC3iPvRK1tLEx9tbxeuXnMn3uWWWkfkogGRXMTf3KjBqfssQlR525VyP9kqXIf8
         cAEChVOUb4xIsYPQtkYmOx+j/wD9SbyFvz7Ns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+N7TW72v+t/5sD1mAeheF2xfj4Q3xhLy8CyQ/zPhWjE=;
        b=eoXcf6O60L5zHNViiQnJ715VT2CSFD6VSc+fp/1myZQUCRlrhVexLVyCt9anvXwf6d
         TuhOprlj8iDTHarZtyjlOjVrZvgAUb50ROjMUvG00KTrQ/jO3wqYppwvv/Jrd/M2mbD3
         gHYLBJZw8qbtlKRSZ7LyFoXS+vXLAHl+M0me2QTwsqnJ9Uo/cfE/sbaBZQCu7BVGmlj1
         vumTBMiaQX8vR1JHhO+HtL8H/FdB9nXk9XQv4ivMx/uVyS4/S7Xq6AwcRCy2n/lY2U7U
         WYv9C4fXQhAvn4y/PIbjxgnLQr2/j/E6FtEJ/P2H1B6tGOcK1PRPSJfzTfUDWa7bOzh1
         xshg==
X-Gm-Message-State: APt69E2NEsXWCERbuSnjJFLsWo/9WR6YWjG+zRYVwgjiW25IvLdkiYqu
        EiCo8IIRnLtFdf3YJMGk6Ym02g==
X-Google-Smtp-Source: ADUXVKIYRWCjBzyp79OTh+i6/VNZoiyeTDltWlQMxrVBH5TAmvuEJ5pXtft9NmAIlr0H3RmwQ41EbQ==
X-Received: by 2002:a17:902:c6b:: with SMTP id 98-v6mr7861000pls.37.1528488307207;
        Fri, 08 Jun 2018 13:05:07 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l26-v6sm32253043pgn.55.2018.06.08.13.05.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 13:05:06 -0700 (PDT)
Date: Fri, 8 Jun 2018 14:05:03 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
        frowand.list@gmail.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        arm@kernel.org, linux-kernel@vger.kernel.org, matt.sealey@arm.com,
        john.horley@arm.com, charles.garcia-tobin@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        mike.leach@linaro.org
Subject: Re: [PATCH 03/20] coresight: Fix remote endpoint parsing
Message-ID: <20180608200503.GC30587@xps15>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-4-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528235011-30691-4-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 10:43:14PM +0100, Suzuki K Poulose wrote:
> When parsing the remote endpoint of an output port, we do :
>      rport = of_graph_get_remote_port(ep);
>      rparent = of_graph_get_remote_port_parent(ep);
> 
> and then parse the "remote_port" as if it was the remote endpoint,
> which is wrong. The code worked fine because we used endpoint number
> as the port number. Let us fix it and optimise a bit as:
> 
>      remote_ep = of_graph_get_remote_endpoint(ep);
>      if (remote_ep)
>         remote_parent = of_graph_get_port_parent(remote_ep);
> 
> and then, parse the remote_ep for the port/endpoint details.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/of_coresight.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> index 8a23c63..ada4f07 100644
> --- a/drivers/hwtracing/coresight/of_coresight.c
> +++ b/drivers/hwtracing/coresight/of_coresight.c
> @@ -129,7 +129,7 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
>  	int ret = 0;
>  	struct of_endpoint endpoint, rendpoint;
>  	struct device_node *rparent = NULL;
> -	struct device_node *rport = NULL;
> +	struct device_node *rep = NULL;
>  	struct device *rdev = NULL;
>  
>  	do {
> @@ -144,16 +144,16 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
>  		if (of_graph_parse_endpoint(ep, &endpoint))
>  			break;
>  		/*
> -		 * Get a handle on the remote port and parent
> -		 * attached to it.
> +		 * Get a handle on the remote endpoint and the device it is
> +		 * attached to.
>  		 */
> -		rparent = of_graph_get_remote_port_parent(ep);
> +		rep = of_graph_get_remote_endpoint(ep);
> +		if (!rep)
> +			break;
> +		rparent = of_graph_get_port_parent(rep);
>  		if (!rparent)
>  			break;
> -		rport = of_graph_get_remote_port(ep);
> -		if (!rport)
> -			break;
> -		if (of_graph_parse_endpoint(rport, &rendpoint))
> +		if (of_graph_parse_endpoint(rep, &rendpoint))
>  			break;
>  
>  		/* If the remote device is not available, defer probing */
> @@ -165,15 +165,15 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
>  
>  		pdata->outports[*i] = endpoint.port;
>  		pdata->child_names[*i] = dev_name(rdev);
> -		pdata->child_ports[*i] = rendpoint.id;
> +		pdata->child_ports[*i] = rendpoint.port;
>  		/* Move the index */
>  		(*i)++;
>  	} while (0);
>  
>  	if (rparent)
>  		of_node_put(rparent);
> -	if (rport)
> -		of_node_put(rport);
> +	if (rep)
> +		of_node_put(rep);
>  
>  	return ret;
>  }

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

(Please add to the next iteration so that I don't have to review again)

> -- 
> 2.7.4
> 
