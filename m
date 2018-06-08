Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 6xpGMZX3GluyUAAAmS7hNA
	; Fri, 08 Jun 2018 21:39:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id ABE6B607E4; Fri,  8 Jun 2018 21:39:33 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jABqcRCF"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CD890601B4;
	Fri,  8 Jun 2018 21:39:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD890601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753216AbeFHVjb (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 17:39:31 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45904 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753126AbeFHVj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 17:39:29 -0400
Received: by mail-pg0-f68.google.com with SMTP id z1-v6so6954385pgv.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 14:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lGwYTJMjY8Gjsfz6JsbcM/PNxWOqwj2si0vSx11O54w=;
        b=jABqcRCF33uxZSK6GKLx3wsOkjjfbUBBwPdpi43Jv/hJJ5awfXVTcEsnuL1W1v9x2T
         HyI2vgzL2PaPMQIutCyNvOtN81flfQA73/DW0in+DuxLn29RfIYqAQC981zSh2bEK/hp
         amj8CICe3d8KRUTAtg39htM2kOZmJhYl08QDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lGwYTJMjY8Gjsfz6JsbcM/PNxWOqwj2si0vSx11O54w=;
        b=spI7rLgelruPx8AlOQazBeFWtezJi+3B1spOqQUpN8BVL0hDxLOz1yDhEhACFoJ+oh
         NXDxlLiojIr3BRg5sDwJBKCyNPBTaOnEzwfgcEYFjBu+MSWBLnIM4u7R6dTvRk6J19EB
         cxikpcda0NCDfXMcX2nRZ5Pha2h7f7GUDIBMGz/yk0uCFAmZm1DfSQ0Zkd3e5ufppnWt
         S5D79vva/TopJxuSzq9C2xy1nrWdRRDJBC81BXYerQ0ipRL+wblJ3X9YeS7elxSR2kQI
         JwRhMLDJBjETGweE1E2N7RgoKlNEvprs5xck95tzw9MXEnj2goj1UrPugEsQS5pAMpS8
         5/0Q==
X-Gm-Message-State: APt69E3+74zdnBsoz57xuZvqTj8l+hahO8J3z83zpo4ofCrEzhad9J2a
        NTM9VYyrYxKnulJyqLg13E/Fww==
X-Google-Smtp-Source: ADUXVKJKpsoJCXmGck/sTLAA09JOeKfmGkqqmGlJ3xCxIBKXNvwZhPYzKFf3ttiBezK6O0QOtaCVLQ==
X-Received: by 2002:a62:9d82:: with SMTP id a2-v6mr7667661pfk.223.1528493968852;
        Fri, 08 Jun 2018 14:39:28 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id a18-v6sm87087804pfn.117.2018.06.08.14.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 14:39:27 -0700 (PDT)
Date: Fri, 8 Jun 2018 15:39:25 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
        frowand.list@gmail.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        arm@kernel.org, linux-kernel@vger.kernel.org, matt.sealey@arm.com,
        john.horley@arm.com, charles.garcia-tobin@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        mike.leach@linaro.org
Subject: Re: [PATCH 09/20] coresight: dts: Define new bindings for direction
 of data flow
Message-ID: <20180608213925.GH30587@xps15>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-10-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528235011-30691-10-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 10:43:20PM +0100, Suzuki K Poulose wrote:
> So far we have relied on an undocumented property "slave-mode",
> to indicate if the given port is input or not. Since we are
> redefining the coresight bindings, define new property for the
> "direction" of data flow for a given connection endpoint in the
> device.
> 
> Each endpoint must define the following property.
> 
>  - "direction" : 0 => Port is input
> 		 1 => Port is output
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../devicetree/bindings/arm/coresight.txt          | 24 ++++++++++++++--------
>  drivers/hwtracing/coresight/of_coresight.c         | 22 ++++++++++++++++----
>  2 files changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index bf75ab3..ff382bc 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -103,9 +103,11 @@ with a specific direction of data flow, each connection must define the
>  following properties to uniquely identify the connection details.
>  
>   * Direction of the data flow w.r.t the component :
> -   Each input port must have the following property defined at the "endpoint"
> +   Each hardware port must have the following property defined at the "endpoint"
>     for the port.
> -	"slave-mode"
> +	"direction" - 32bit integer, whose values are defined as follows :
> +		0 => the endpoint is an Input port
> +		1 => the endpoint is an Output port.
>  
>   * Hardware Port number at the component:
>       - Each "endpoint" must define the hardware port of the local end of the
> @@ -129,7 +131,7 @@ Example:
>  		clock-names = "apb_pclk";
>  		port {
>  			etb_in_port: endpoint@0 {
> -				slave-mode;
> +				direction = <0>;
>  				remote-endpoint = <&replicator_out_port0>;
>  				coresight,hwid = <0>;
>  			};
> @@ -144,7 +146,7 @@ Example:
>  		clock-names = "apb_pclk";
>  		port {
>  			tpiu_in_port: endpoint@0 {
> -				slave-mode;
> +				direction = <0>;
>  				remote-endpoint = <&replicator_out_port1>;
>  				coresight,hwid = <0>;
>  			};
> @@ -166,6 +168,7 @@ Example:
>  			port@0 {
>  				reg = <0>;
>  				replicator_out_port0: endpoint {
> +					direction = <1>;
>  					remote-endpoint = <&etb_in_port>;
>  					coresight,hwid = <0>;
>  				};
> @@ -174,6 +177,7 @@ Example:
>  			port@1 {
>  				reg = <1>;
>  				replicator_out_port1: endpoint {
> +					direction = <1>;
>  					remote-endpoint = <&tpiu_in_port>;
>  					coresight,hwid = <1>;
>  				};
> @@ -183,7 +187,7 @@ Example:
>  			port@2 {
>  				reg = <1>;
>  				replicator_in_port0: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&funnel_out_port0>;
>  					coresight,hwid = <0>;
>  				};
> @@ -205,6 +209,7 @@ Example:
>  			port@0 {
>  				reg = <0>;
>  				funnel_out_port0: endpoint {
> +					direction = <1>;
>  					remote-endpoint =
>  							<&replicator_in_port0>;
>  					coresight,hwid = <0>;
> @@ -215,7 +220,7 @@ Example:
>  			port@1 {
>  				reg = <1>;
>  				funnel_in_port0: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&ptm0_out_port>;
>  					coresight,hwid = <0>;
>  				};
> @@ -224,7 +229,7 @@ Example:
>  			port@2 {
>  				reg = <2>;
>  				funnel_in_port1: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&ptm1_out_port>;
>  					coresight,hwid = <1>;
>  				};
> @@ -233,7 +238,7 @@ Example:
>  			port@3 {
>  				reg = <3>;
>  				funnel_in_port2: endpoint {
> -					slave-mode;
> +					direction = <0>;
>  					remote-endpoint = <&etm0_out_port>;
>  					coresight,hwid = <2>;
>  				};
> @@ -252,6 +257,7 @@ Example:
>  		clock-names = "apb_pclk";
>  		port {
>  			ptm0_out_port: endpoint {
> +				direction = <1>;
>  				remote-endpoint = <&funnel_in_port0>;
>  				coresight,hwid = <0>;
>  			};
> @@ -267,6 +273,7 @@ Example:
>  		clock-names = "apb_pclk";
>  		port {
>  			ptm1_out_port: endpoint {
> +				direction = <1>;
>  				remote-endpoint = <&funnel_in_port1>;
>  				coresight,hwid = <0>;
>  			};
> @@ -284,6 +291,7 @@ Example:
>  		clock-names = "apb_pclk";
>  		port {
>  			stm_out_port: endpoint {
> +				direction = <1>;
>  				remote-endpoint = <&main_funnel_in_port2>;
>  				coresight,hwid = <0>;
>  			};
> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> index d23d7dd..0d6e6a9 100644
> --- a/drivers/hwtracing/coresight/of_coresight.c
> +++ b/drivers/hwtracing/coresight/of_coresight.c
> @@ -45,7 +45,20 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
>  			       endpoint, of_dev_node_match);
>  }
>  
> -static void of_coresight_get_ports(const struct device_node *node,
> +static bool of_coresight_endpoint_is_input(struct device *dev,
> +					   struct device_node *ep_node)
> +{
> +	u32 dir;
> +
> +	if (!of_property_read_u32(ep_node, "direction", &dir))
> +		return dir == 0;
> +
> +	dev_warn_once(dev, "Missing mandatory \"direction\" property!\n");
> +	return of_property_read_bool(ep_node, "slave-mode");
> +}
> +
> +static void of_coresight_get_ports(struct device *dev,
> +				   const struct device_node *node,
>  				   int *nr_inport, int *nr_outport)
>  {
>  	struct device_node *ep = NULL;
> @@ -56,7 +69,7 @@ static void of_coresight_get_ports(const struct device_node *node,
>  		if (!ep)
>  			break;
>  
> -		if (of_property_read_bool(ep, "slave-mode"))
> +		if (of_coresight_endpoint_is_input(dev, ep))
>  			in++;
>  		else
>  			out++;
> @@ -149,7 +162,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
>  		 * No need to deal with input ports, processing for as
>  		 * processing for output ports will deal with them.
>  		 */
> -		if (of_find_property(ep, "slave-mode", NULL))
> +		if (of_coresight_endpoint_is_input(dev, ep))
>  			break;
>  
>  		/* Parse the local port details */
> @@ -212,7 +225,8 @@ of_get_coresight_platform_data(struct device *dev,
>  	pdata->cpu = of_coresight_get_cpu(node);
>  
>  	/* Get the number of input and output port for this component */
> -	of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
> +	of_coresight_get_ports(dev, node,
> +			       &pdata->nr_inport, &pdata->nr_outport);
>  
>  	/* If there are not output connections, we are done */
>  	if (!pdata->nr_outport)

For both the binding and the code:
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.7.4
> 
