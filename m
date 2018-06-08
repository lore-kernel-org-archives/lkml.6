Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id dbkGDjvfGlunBQAAmS7hNA
	; Fri, 08 Jun 2018 19:55:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 17C85607DC; Fri,  8 Jun 2018 19:55:39 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mvr6FFHy"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4F1C5605A5;
	Fri,  8 Jun 2018 19:55:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F1C5605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752739AbeFHTzg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 15:55:36 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35421 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752356AbeFHTze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 15:55:34 -0400
Received: by mail-pg0-f68.google.com with SMTP id 15-v6so6859626pge.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 12:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e6gPUFJ1Cf4F/qHwJrmRQxQ9ZU67Np7NUc6aII+l2rw=;
        b=Mvr6FFHyJUmkF1Q6vrDtvGbinnm/lOhhbgvX6KxrkN2jn4fPHNTTpzwa5WY9UeBUiJ
         GySiow0/Lcdb7v7v/DcGhvoA4GpZHR6du1H4hDGtr4/l2bh6qU1+l712XSxpRu20BxGz
         OjTIhEfZqgi3UVcmrAwQ1JfSq0UrotHULUlC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e6gPUFJ1Cf4F/qHwJrmRQxQ9ZU67Np7NUc6aII+l2rw=;
        b=Q9qLR2Ka2RcbOMwoLIXp13xkoUpF9zRfBjEd0lqrmvIlK+2EyDpGh72kZIe7Cy8Q7J
         iNzsbB3p9Z3tiowCv9NzG5irk1VIk8HF1TR2cbQqqjAdcsDwcdE7drXTsDFkBIT4p7dP
         aou69j15EFOk0+2PZCV91XBqtZfzcJTKsdwiOoQOHbPs5RpCrUYxIADyPCkuO3Bj5SB+
         cp1GG9Kscn7XfEQ5tQ89Ovz+oBZfSY48vAQ9/CXxH7HaHtGnKy/i0lbSfIRFERs42gE7
         ulpBjRhbm0x1LZVQIargIkO1FXM0kr5xAmF+vuyTREjRauFmC9qgcNWhichIc1GAYrSB
         T4TA==
X-Gm-Message-State: APt69E3eg2BQSjLYzjBZHdLixuoDB/ywMb2FBXVqv0tOLe5tA1km6Fnc
        EWBlKix5e6Dr9MPO9x9YIeTncA==
X-Google-Smtp-Source: ADUXVKLf2Luss0Zw+XHMbhOJDC5Iy2girczOiN079+pdIh9EAqAqQNRLubnwnJz4sNQDF5yVu4ZtMQ==
X-Received: by 2002:a63:780b:: with SMTP id t11-v6mr6357582pgc.91.1528487734040;
        Fri, 08 Jun 2018 12:55:34 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e24-v6sm5284483pfi.70.2018.06.08.12.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 12:55:32 -0700 (PDT)
Date: Fri, 8 Jun 2018 13:55:30 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
        frowand.list@gmail.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        arm@kernel.org, linux-kernel@vger.kernel.org, matt.sealey@arm.com,
        john.horley@arm.com, charles.garcia-tobin@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        mike.leach@linaro.org
Subject: Re: [PATCH 02/20] coresight: of: Fix refcounting for graph nodes
Message-ID: <20180608195530.GB30587@xps15>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-3-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528235011-30691-3-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 10:43:13PM +0100, Suzuki K Poulose wrote:
> The coresight driver doesn't drop the references on the
> remote endpoint/port nodes. Add the missing of_node_put()
> calls. To make it easier to handle different corner cases
> cleanly, move the parsing of an endpoint to separate
> function.

Please split this as those are two different things.

> 
> Reported-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/of_coresight.c | 139 +++++++++++++++++------------
>  1 file changed, 84 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> index a33a92e..8a23c63 100644
> --- a/drivers/hwtracing/coresight/of_coresight.c
> +++ b/drivers/hwtracing/coresight/of_coresight.c
> @@ -111,17 +111,80 @@ int of_coresight_get_cpu(const struct device_node *node)
>  }
>  EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
>  
> +/*
> + * of_coresight_parse_endpoint : Parse the given output endpoint @ep
> + * and fill the connection information in @pdata[*@i].
> + *
> + * Parses the local port, remote device name and the remote port. Also
> + * updates *@i to point to the next index, when an entry is added.
> + *
> + * Returns :
> + *	 0	- If the parsing completed without any fatal errors.
> + *	-Errno	- Fatal error, abort the scanning.
> + */
> +static int of_coresight_parse_endpoint(struct device_node *ep,
> +				       struct coresight_platform_data *pdata,
> +				       int *i)
> +{
> +	int ret = 0;
> +	struct of_endpoint endpoint, rendpoint;
> +	struct device_node *rparent = NULL;
> +	struct device_node *rport = NULL;
> +	struct device *rdev = NULL;
> +
> +	do {
> +		/*
> +		 * No need to deal with input ports, processing for as
> +		 * processing for output ports will deal with them.
> +		 */
> +		if (of_find_property(ep, "slave-mode", NULL))
> +			break;
> +
> +		/* Parse the local port details */
> +		if (of_graph_parse_endpoint(ep, &endpoint))
> +			break;
> +		/*
> +		 * Get a handle on the remote port and parent
> +		 * attached to it.
> +		 */
> +		rparent = of_graph_get_remote_port_parent(ep);
> +		if (!rparent)
> +			break;
> +		rport = of_graph_get_remote_port(ep);
> +		if (!rport)
> +			break;
> +		if (of_graph_parse_endpoint(rport, &rendpoint))
> +			break;
> +
> +		/* If the remote device is not available, defer probing */
> +		rdev = of_coresight_get_endpoint_device(rparent);
> +		if (!rdev) {
> +			ret = -EPROBE_DEFER;
> +			break;
> +		}
> +
> +		pdata->outports[*i] = endpoint.port;
> +		pdata->child_names[*i] = dev_name(rdev);
> +		pdata->child_ports[*i] = rendpoint.id;
> +		/* Move the index */
> +		(*i)++;
> +	} while (0);

That's a clever way of coding a classic 'goto' block.

> +
> +	if (rparent)
> +		of_node_put(rparent);
> +	if (rport)
> +		of_node_put(rport);

Perfect - thank you for that.

> +
> +	return ret;
> +}
> +
>  struct coresight_platform_data *
>  of_get_coresight_platform_data(struct device *dev,
>  			       const struct device_node *node)
>  {
>  	int i = 0, ret = 0;
>  	struct coresight_platform_data *pdata;
> -	struct of_endpoint endpoint, rendpoint;
> -	struct device *rdev;
>  	struct device_node *ep = NULL;
> -	struct device_node *rparent = NULL;
> -	struct device_node *rport = NULL;
>  
>  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata)
> @@ -129,63 +192,29 @@ of_get_coresight_platform_data(struct device *dev,
>  
>  	/* Use device name as sysfs handle */
>  	pdata->name = dev_name(dev);
> +	pdata->cpu = of_coresight_get_cpu(node);
>  
>  	/* Get the number of input and output port for this component */
>  	of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
>  
> -	if (pdata->nr_outport) {
> -		ret = of_coresight_alloc_memory(dev, pdata);
> +	/* If there are not output connections, we are done */

/not/no

> +	if (!pdata->nr_outport)
> +		return pdata;
> +
> +	ret = of_coresight_alloc_memory(dev, pdata);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	/* Iterate through each port to discover topology */
> +	do {
> +		/* Get a handle on a port */
> +		ep = of_graph_get_next_endpoint(node, ep);
> +		if (!ep)
> +			break;
> +		ret = of_coresight_parse_endpoint(ep, pdata, &i);
>  		if (ret)
>  			return ERR_PTR(ret);
> -
> -		/* Iterate through each port to discover topology */
> -		do {
> -			/* Get a handle on a port */
> -			ep = of_graph_get_next_endpoint(node, ep);
> -			if (!ep)
> -				break;
> -
> -			/*
> -			 * No need to deal with input ports, processing for as
> -			 * processing for output ports will deal with them.
> -			 */
> -			if (of_find_property(ep, "slave-mode", NULL))
> -				continue;
> -
> -			/* Get a handle on the local endpoint */
> -			ret = of_graph_parse_endpoint(ep, &endpoint);
> -
> -			if (ret)
> -				continue;
> -
> -			/* The local out port number */
> -			pdata->outports[i] = endpoint.port;
> -
> -			/*
> -			 * Get a handle on the remote port and parent
> -			 * attached to it.
> -			 */
> -			rparent = of_graph_get_remote_port_parent(ep);
> -			rport = of_graph_get_remote_port(ep);
> -
> -			if (!rparent || !rport)
> -				continue;
> -
> -			if (of_graph_parse_endpoint(rport, &rendpoint))
> -				continue;
> -
> -			rdev = of_coresight_get_endpoint_device(rparent);
> -			if (!rdev)
> -				return ERR_PTR(-EPROBE_DEFER);
> -
> -			pdata->child_names[i] = dev_name(rdev);
> -			pdata->child_ports[i] = rendpoint.id;
> -
> -			i++;
> -		} while (ep);
> -	}
> -
> -	pdata->cpu = of_coresight_get_cpu(node);
> +	} while (ep);
>  
>  	return pdata;
>  }
> -- 
> 2.7.4
> 
