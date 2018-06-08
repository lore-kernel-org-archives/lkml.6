Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xR/0FpLkGlvRRgAAmS7hNA
	; Fri, 08 Jun 2018 20:18:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EE6E3607E4; Fri,  8 Jun 2018 20:18:37 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X9U4EZEn"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 32475607A4;
	Fri,  8 Jun 2018 20:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32475607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeFHUSf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 16:18:35 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40258 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752730AbeFHUSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 16:18:33 -0400
Received: by mail-pf0-f194.google.com with SMTP id z24-v6so7167036pfe.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lJdXY4DKaBXBRhX78sWTOtsjl7CuwfJYUgYovSlUirI=;
        b=X9U4EZEnRyq9NelAEaacjrQqJxe3TdnDl+k3embrHbDuoEVrYsMmEyebi+MWrXg/3T
         JjDeJk7duKgEEyhDns8VqaPLkLY8/QqQBONNcWpeUnyAi3ZWY1NDFepROojB8/SJppQ9
         CiW/yHdYWU5vQSQr/kQtAMVN7yqPaD/iQcr4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lJdXY4DKaBXBRhX78sWTOtsjl7CuwfJYUgYovSlUirI=;
        b=G2rK37IOBhcI58vclmVvGOK1j8Uba2no7Y2ZS7mqWNm4SMKavwOS8sJXiSolzrwa9R
         rEK0f4TFEN09ZIOG3Ic3xhHcZFdopTooXKkVQFJqFzfOFh0AsElA7FMm7d1a9V7Sn+uW
         YYzeumsLeCStdsaW9HcOqmknwXvka8iNiSe4vPxp0DBDwOMj0FAhVvb5lNc0+f81cYjU
         A7z56tRhLRDCHapycoXXj4PHEd1L5TAfUU6RpHEoZczPuHyAcuy7V23KZ3K00KBpHxCS
         9nFGaMMvMg8ab+r97CK6TUKVx2JoDbSc/io3l27ddTh9GFGLjjNw5kiZx10HeFn+znTw
         jvMA==
X-Gm-Message-State: APt69E0KPmOS3nL2qSAvIgxS6p7UWz1jRKLTD/4plNU5qEvGUhobXHYf
        mc2bNVxja3P597sW+AWIWYsc7Q==
X-Google-Smtp-Source: ADUXVKJMdDM08ULhk/HCdrBI7/B3h1NnFkG7ktP52JJfiYEKQmjnlkDWGa59jTZej8ku4/qQQ4N8mw==
X-Received: by 2002:a63:7341:: with SMTP id d1-v6mr6366496pgn.404.1528489112599;
        Fri, 08 Jun 2018 13:18:32 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m83-v6sm51022666pfi.188.2018.06.08.13.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 13:18:31 -0700 (PDT)
Date: Fri, 8 Jun 2018 14:18:29 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
        frowand.list@gmail.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        arm@kernel.org, linux-kernel@vger.kernel.org, matt.sealey@arm.com,
        john.horley@arm.com, charles.garcia-tobin@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        mike.leach@linaro.org
Subject: Re: [PATCH 05/20] coresight: platform: Cleanup coresight connection
 handling
Message-ID: <20180608201829.GD30587@xps15>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-6-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528235011-30691-6-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 10:43:16PM +0100, Suzuki K Poulose wrote:
> The platform code parses the component connections and populates
> a platform-description of the output connections in arrays of fields
> (which is never freed). This is later copied in the coresight_register
> to a newly allocated area, represented by coresight_connection(s).
> 
> This patch cleans up the code dealing with connections by making
> use of the "coresight_connection" structure right at the platform
> code and lets the generic driver simply re-use information provided
> by the platform.
> 
> Thus making it reader friendly as well as avoiding the wastage of
> unused memory.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight.c    | 21 +-----------
>  drivers/hwtracing/coresight/of_coresight.c | 51 ++++++++++++------------------
>  include/linux/coresight.h                  |  9 ++----
>  3 files changed, 23 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
> index 2893cfe..69e9136 100644
> --- a/drivers/hwtracing/coresight/coresight.c
> +++ b/drivers/hwtracing/coresight/coresight.c
> @@ -953,13 +953,11 @@ postcore_initcall(coresight_init);
>  
>  struct coresight_device *coresight_register(struct coresight_desc *desc)
>  {
> -	int i;
>  	int ret;
>  	int link_subtype;
>  	int nr_refcnts = 1;
>  	atomic_t *refcnts = NULL;
>  	struct coresight_device *csdev;
> -	struct coresight_connection *conns = NULL;
>  
>  	csdev = kzalloc(sizeof(*csdev), GFP_KERNEL);
>  	if (!csdev) {
> @@ -988,22 +986,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>  	csdev->nr_inport = desc->pdata->nr_inport;
>  	csdev->nr_outport = desc->pdata->nr_outport;
>  
> -	/* Initialise connections if there is at least one outport */
> -	if (csdev->nr_outport) {
> -		conns = kcalloc(csdev->nr_outport, sizeof(*conns), GFP_KERNEL);
> -		if (!conns) {
> -			ret = -ENOMEM;
> -			goto err_kzalloc_conns;
> -		}
> -
> -		for (i = 0; i < csdev->nr_outport; i++) {
> -			conns[i].outport = desc->pdata->outports[i];
> -			conns[i].child_name = desc->pdata->child_names[i];
> -			conns[i].child_port = desc->pdata->child_ports[i];
> -		}
> -	}
> -
> -	csdev->conns = conns;
> +	csdev->conns = desc->pdata->conns;
>  
>  	csdev->type = desc->type;
>  	csdev->subtype = desc->subtype;
> @@ -1032,8 +1015,6 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>  
>  	return csdev;
>  
> -err_kzalloc_conns:
> -	kfree(refcnts);
>  err_kzalloc_refcnts:
>  	kfree(csdev);
>  err_kzalloc_csdev:
> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> index ada4f07..d01a9ce 100644
> --- a/drivers/hwtracing/coresight/of_coresight.c
> +++ b/drivers/hwtracing/coresight/of_coresight.c
> @@ -70,26 +70,13 @@ static void of_coresight_get_ports(const struct device_node *node,
>  static int of_coresight_alloc_memory(struct device *dev,
>  			struct coresight_platform_data *pdata)
>  {
> -	/* List of output port on this component */
> -	pdata->outports = devm_kzalloc(dev, pdata->nr_outport *
> -				       sizeof(*pdata->outports),
> -				       GFP_KERNEL);
> -	if (!pdata->outports)
> -		return -ENOMEM;
> -
> -	/* Children connected to this component via @outports */
> -	pdata->child_names = devm_kzalloc(dev, pdata->nr_outport *
> -					  sizeof(*pdata->child_names),
> -					  GFP_KERNEL);
> -	if (!pdata->child_names)
> -		return -ENOMEM;
> -
> -	/* Port number on the child this component is connected to */
> -	pdata->child_ports = devm_kzalloc(dev, pdata->nr_outport *
> -					  sizeof(*pdata->child_ports),
> -					  GFP_KERNEL);
> -	if (!pdata->child_ports)
> -		return -ENOMEM;
> +	if (pdata->nr_outport) {
> +		pdata->conns = devm_kzalloc(dev, pdata->nr_outport *
> +					    sizeof(*pdata->conns),
> +					    GFP_KERNEL);
> +		if (!pdata->conns)
> +			return -ENOMEM;
> +	}
>  
>  	return 0;
>  }
> @@ -113,24 +100,24 @@ EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
>  
>  /*
>   * of_coresight_parse_endpoint : Parse the given output endpoint @ep
> - * and fill the connection information in @pdata[*@i].
> + * and fill the connection information in *@pconn.
>   *
>   * Parses the local port, remote device name and the remote port. Also
> - * updates *@i to point to the next index, when an entry is added.
> + * updates *@pconn to point to the next record, when an entry is added.
>   *
>   * Returns :
>   *	 0	- If the parsing completed without any fatal errors.
>   *	-Errno	- Fatal error, abort the scanning.
>   */
>  static int of_coresight_parse_endpoint(struct device_node *ep,
> -				       struct coresight_platform_data *pdata,
> -				       int *i)
> +				       struct coresight_connection **pconn)
>  {
>  	int ret = 0;
>  	struct of_endpoint endpoint, rendpoint;
>  	struct device_node *rparent = NULL;
>  	struct device_node *rep = NULL;
>  	struct device *rdev = NULL;
> +	struct coresight_connection *conn = *pconn;
>  
>  	do {
>  		/*
> @@ -163,11 +150,11 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
>  			break;
>  		}
>  
> -		pdata->outports[*i] = endpoint.port;
> -		pdata->child_names[*i] = dev_name(rdev);
> -		pdata->child_ports[*i] = rendpoint.port;
> -		/* Move the index */
> -		(*i)++;
> +		conn->outport = endpoint.port;
> +		conn->child_name = dev_name(rdev);
> +		conn->child_port = rendpoint.port;
> +		/* Move the connection record */
> +		(*pconn)++;
>  	} while (0);
>  
>  	if (rparent)
> @@ -182,8 +169,9 @@ struct coresight_platform_data *
>  of_get_coresight_platform_data(struct device *dev,
>  			       const struct device_node *node)
>  {
> -	int i = 0, ret = 0;
> +	int ret = 0;
>  	struct coresight_platform_data *pdata;
> +	struct coresight_connection *conn;
>  	struct device_node *ep = NULL;
>  
>  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> @@ -205,13 +193,14 @@ of_get_coresight_platform_data(struct device *dev,
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> +	conn = pdata->conns;
>  	/* Iterate through each port to discover topology */
>  	do {
>  		/* Get a handle on a port */
>  		ep = of_graph_get_next_endpoint(node, ep);
>  		if (!ep)
>  			break;
> -		ret = of_coresight_parse_endpoint(ep, pdata, &i);
> +		ret = of_coresight_parse_endpoint(ep, &conn);
>  		if (ret)
>  			return ERR_PTR(ret);
>  	} while (ep);
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index 69a5c9f..2a75a15 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -82,20 +82,15 @@ struct coresight_dev_subtype {
>   * @cpu:	the CPU a source belongs to. Only applicable for ETM/PTMs.
>   * @name:	name of the component as shown under sysfs.
>   * @nr_inport:	number of input ports for this component.
> - * @outports:	list of remote endpoint port number.
> - * @child_names:name of all child components connected to this device.
> - * @child_ports:child component port number the current component is
> -		connected  to.
>   * @nr_outport:	number of output ports for this component.
> + * @conns:	Array of nr_outport connections from this component
>   */
>  struct coresight_platform_data {
>  	int cpu;
>  	const char *name;
>  	int nr_inport;
> -	int *outports;
> -	const char **child_names;
> -	int *child_ports;
>  	int nr_outport;
> +	struct coresight_connection *conns;
>  };

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  
>  /**
> -- 
> 2.7.4
> 
