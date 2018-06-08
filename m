Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id mmfoEY/zGltJQgAAmS7hNA
	; Fri, 08 Jun 2018 21:22:23 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 277CE6089E; Fri,  8 Jun 2018 21:22:23 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YP6OvLDK"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 57C5C602FC;
	Fri,  8 Jun 2018 21:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57C5C602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753127AbeFHVWR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 17:22:17 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44969 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752810AbeFHVWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 17:22:16 -0400
Received: by mail-pl0-f68.google.com with SMTP id z9-v6so8963659plk.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 14:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ik5vzmKJ/eFS4ZdHPKyWRWSIHl6DzBuS1zzNF1SY1Mc=;
        b=YP6OvLDK0kxjKqctyP7EkuNa0xljx/PcfHwtqK4zt4eVseXxY0MvCF1wulhicW2ygy
         D8jGLhxz8pPCBfEurQc4/YxpUBySxiTlULCBjfjrX8lBZINtfEso9FDY2uq9IsqjeEwl
         jjZ0cIzjMjIt8Al7pKr9fEE3LgBYo/NeQOY6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ik5vzmKJ/eFS4ZdHPKyWRWSIHl6DzBuS1zzNF1SY1Mc=;
        b=LuU7Gnk3OC2ETqTVl5Y8gcwj2A43muHJIoGP5NziFwVNqxZwHxZh39zqKpk/e7rDpg
         0nMS/QSSkiFwxOXGPNJoU/+mXGUI5+XMt9VYPhsMHVPae7pMyaWpt1h76RhNLo5bmWPB
         G7MiDwGZmwcC3+9AARlrhli4mxJKDdEqrhJS+GRHYCTWR/zAX5skgmg2UstdRJbXTjpO
         wEBuorUt1pXZrJjzdkOW65h8xl6KMv6wIo1BjF3IRd0cp+HIT5cVyRsg5MnbNCeIPvn2
         QgROxco3S2eoeip+gi2lfUaYlxT++FQqcHvrHRkMtMzisri109tcLopSN5lE3jpNF0Z2
         ERbA==
X-Gm-Message-State: APt69E0HptqDljD7e/c3DBkedMd7xc9QgP3N32ur1LaiuzoLc3U2V9Mz
        rzIfhubpGc7E5/0GvdhAaEUFpQ==
X-Google-Smtp-Source: ADUXVKJJZCad+qQGI4DRTi9j48p9UdHFJ/rCCEh2bY+03VuhcE8aNvejXeyqEXmNADvBMUIhOgmFww==
X-Received: by 2002:a17:902:64cf:: with SMTP id y15-v6mr8328653pli.53.1528492935462;
        Fri, 08 Jun 2018 14:22:15 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id l8-v6sm37869218pfb.102.2018.06.08.14.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 14:22:14 -0700 (PDT)
Date: Fri, 8 Jun 2018 15:22:11 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, robh@kernel.org,
        frowand.list@gmail.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        arm@kernel.org, linux-kernel@vger.kernel.org, matt.sealey@arm.com,
        john.horley@arm.com, charles.garcia-tobin@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        mike.leach@linaro.org
Subject: Re: [PATCH 08/20] coresight: dts: Cleanup device tree graph bindings
Message-ID: <20180608212211.GG30587@xps15>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
 <1528235011-30691-9-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528235011-30691-9-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 10:43:19PM +0100, Suzuki K Poulose wrote:
> The coresight drivers relied on default bindings for graph
> in DT, while reusing the "reg" field of the "ports" to indicate
> the actual hardware port number for the connections. However,
> with the rules getting stricter w.r.t to the address mismatch
> with the label, it is no longer possible to use the port address
> field for the hardware port number. Hence, we add an explicit
> property to denote the hardware port number, "coresight,hwid"
> which must be specified for each "endpoint".
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../devicetree/bindings/arm/coresight.txt          | 29 ++++++++++---
>  drivers/hwtracing/coresight/of_coresight.c         | 49 +++++++++++++++++-----
>  2 files changed, 62 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index ed6b555..bf75ab3 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -108,8 +108,13 @@ following properties to uniquely identify the connection details.
>  	"slave-mode"
>  
>   * Hardware Port number at the component:
> -     -  The hardware port number is assumed to be the address of the "port"
> -         component.
> +     - Each "endpoint" must define the hardware port of the local end of the
> +       connection using the following property :
> +
> +	"coresight,hwid" - 32bit integer, local hardware port.
> +
> +     - [ ** Obsolete ** ] The hardware port number is assumed to be the address
> +       of the "port" component.
>  
>  
>  
> @@ -126,6 +131,7 @@ Example:
>  			etb_in_port: endpoint@0 {
>  				slave-mode;
>  				remote-endpoint = <&replicator_out_port0>;
> +				coresight,hwid = <0>;
>  			};
>  		};
>  	};
> @@ -140,6 +146,7 @@ Example:
>  			tpiu_in_port: endpoint@0 {
>  				slave-mode;
>  				remote-endpoint = <&replicator_out_port1>;
> +				coresight,hwid = <0>;
>  			};
>  		};
>  	};
> @@ -160,6 +167,7 @@ Example:
>  				reg = <0>;
>  				replicator_out_port0: endpoint {
>  					remote-endpoint = <&etb_in_port>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  
> @@ -167,15 +175,17 @@ Example:
>  				reg = <1>;
>  				replicator_out_port1: endpoint {
>  					remote-endpoint = <&tpiu_in_port>;
> +					coresight,hwid = <1>;
>  				};
>  			};
>  
>  			/* replicator input port */
>  			port@2 {
> -				reg = <0>;
> +				reg = <1>;
>  				replicator_in_port0: endpoint {
>  					slave-mode;
>  					remote-endpoint = <&funnel_out_port0>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  		};
> @@ -197,31 +207,35 @@ Example:
>  				funnel_out_port0: endpoint {
>  					remote-endpoint =
>  							<&replicator_in_port0>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  
>  			/* funnel input ports */
>  			port@1 {
> -				reg = <0>;
> +				reg = <1>;
>  				funnel_in_port0: endpoint {
>  					slave-mode;
>  					remote-endpoint = <&ptm0_out_port>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  
>  			port@2 {
> -				reg = <1>;
> +				reg = <2>;
>  				funnel_in_port1: endpoint {
>  					slave-mode;
>  					remote-endpoint = <&ptm1_out_port>;
> +					coresight,hwid = <1>;
>  				};
>  			};
>  
>  			port@3 {
> -				reg = <2>;
> +				reg = <3>;
>  				funnel_in_port2: endpoint {
>  					slave-mode;
>  					remote-endpoint = <&etm0_out_port>;
> +					coresight,hwid = <2>;
>  				};
>  			};
>  
> @@ -239,6 +253,7 @@ Example:
>  		port {
>  			ptm0_out_port: endpoint {
>  				remote-endpoint = <&funnel_in_port0>;
> +				coresight,hwid = <0>;
>  			};
>  		};
>  	};
> @@ -253,6 +268,7 @@ Example:
>  		port {
>  			ptm1_out_port: endpoint {
>  				remote-endpoint = <&funnel_in_port1>;
> +				coresight,hwid = <0>;
>  			};
>  		};
>  	};
> @@ -269,6 +285,7 @@ Example:
>  		port {
>  			stm_out_port: endpoint {
>  				remote-endpoint = <&main_funnel_in_port2>;
> +				coresight,hwid = <0>;
>  			};
>  		};
>  	};

For the binding part:
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> index d01a9ce..d23d7dd 100644
> --- a/drivers/hwtracing/coresight/of_coresight.c
> +++ b/drivers/hwtracing/coresight/of_coresight.c
> @@ -99,6 +99,31 @@ int of_coresight_get_cpu(const struct device_node *node)
>  EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
>  
>  /*
> + * of_coresight_endpoint_get_port_id : Get the hardware port number for the
> + * given endpoint device node. Prefer the explicit "coresight,hwid" property
> + * over the endpoint register id (obsolete bindings).
> + */
> +static int of_coresight_endpoint_get_port_id(struct device *dev,
> +					     struct device_node *ep_node)
> +{
> +	struct of_endpoint ep;
> +	int rc, port_id;
> +
> +
> +	if (!of_property_read_u32(ep_node, "coresight,hwid", &port_id))
> +		return port_id;
> +
> +	rc = of_graph_parse_endpoint(ep_node, &ep);
> +	if (rc)
> +		return rc;
> +	dev_warn_once(dev,
> +		      "ep%d: Mandatory \"coresight,hwid\" property missing.\n",
> +		      ep.port);
> +	dev_warn_once(dev, "DT uses obsolete coresight bindings\n");
> +	return ep.port;
> +}
> +
> +/*
>   * of_coresight_parse_endpoint : Parse the given output endpoint @ep
>   * and fill the connection information in *@pconn.
>   *
> @@ -109,11 +134,11 @@ EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
>   *	 0	- If the parsing completed without any fatal errors.
>   *	-Errno	- Fatal error, abort the scanning.
>   */
> -static int of_coresight_parse_endpoint(struct device_node *ep,
> +static int of_coresight_parse_endpoint(struct device *dev,
> +				       struct device_node *ep,
>  				       struct coresight_connection **pconn)
>  {
> -	int ret = 0;
> -	struct of_endpoint endpoint, rendpoint;
> +	int ret = 0, local_port, child_port;
>  	struct device_node *rparent = NULL;
>  	struct device_node *rep = NULL;
>  	struct device *rdev = NULL;
> @@ -128,7 +153,8 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
>  			break;
>  
>  		/* Parse the local port details */
> -		if (of_graph_parse_endpoint(ep, &endpoint))
> +		local_port = of_coresight_endpoint_get_port_id(dev, ep);
> +		if (local_port < 0)
>  			break;
>  		/*
>  		 * Get a handle on the remote endpoint and the device it is
> @@ -140,9 +166,6 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
>  		rparent = of_graph_get_port_parent(rep);
>  		if (!rparent)
>  			break;
> -		if (of_graph_parse_endpoint(rep, &rendpoint))
> -			break;
> -
>  		/* If the remote device is not available, defer probing */
>  		rdev = of_coresight_get_endpoint_device(rparent);
>  		if (!rdev) {
> @@ -150,9 +173,15 @@ static int of_coresight_parse_endpoint(struct device_node *ep,
>  			break;
>  		}
>  
> -		conn->outport = endpoint.port;
> +		child_port = of_coresight_endpoint_get_port_id(rdev, rep);
> +		if (child_port < 0) {
> +			ret = 0;

Why returning '0' on an error condition?  Same for 'local_port' above.

> +			break;
> +		}
> +
> +		conn->outport = local_port;
>  		conn->child_name = dev_name(rdev);
> -		conn->child_port = rendpoint.port;
> +		conn->child_port = child_port;
>  		/* Move the connection record */
>  		(*pconn)++;
>  	} while (0);
> @@ -200,7 +229,7 @@ of_get_coresight_platform_data(struct device *dev,
>  		ep = of_graph_get_next_endpoint(node, ep);
>  		if (!ep)
>  			break;
> -		ret = of_coresight_parse_endpoint(ep, &conn);
> +		ret = of_coresight_parse_endpoint(dev, ep, &conn);
>  		if (ret)
>  			return ERR_PTR(ret);
>  	} while (ep);
> -- 
> 2.7.4
> 
