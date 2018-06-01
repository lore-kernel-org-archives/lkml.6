Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752950AbeFAQOs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:14:48 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40550 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752731AbeFAQOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:14:45 -0400
X-Google-Smtp-Source: ADUXVKLpHs66IhjaGF0oOafTizKyHiwftUoLCFuypKZu8K0gZX3tMeLDGZ8NVZUQ6QjgttXRUwiz5w==
Date: Fri, 1 Jun 2018 10:14:41 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com,
        robh@kernel.org, mark.rutland@arm.com, frowand.list@gmail.com,
        matt.sealey@arm.com, charles.garcia-tobin@arm.com, john.horley@arm.com,
        mike.leach@linaro.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 1/8] dts: binding: coresight: Document graph bindings
Message-ID: <20180601161441.GA9838@xps15>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-2-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527858967-16047-2-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 02:16:00PM +0100, Suzuki K Poulose wrote:
> Before we updat the bindings, document the current graph bindings

s/updat/update

> and usage of additional properties.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../devicetree/bindings/arm/coresight.txt          | 28 ++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index 15ac8e8..bd36e40 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -52,9 +52,7 @@ its hardware characteristcs.
>  	  clocks the core of that coresight component. The latter clock
>  	  is optional.
>  
> -	* port or ports: The representation of the component's port
> -	  layout using the generic DT graph presentation found in
> -	  "bindings/graph.txt".
> +	* port or ports: see "Graph bindings for Coresight" below
>  
>  * Additional required properties for System Trace Macrocells (STM):
>  	* reg: along with the physical base address and length of the register
> @@ -71,7 +69,7 @@ its hardware characteristcs.
>  	  AMBA markee):
>  		- "arm,coresight-replicator"
>  
> -	* port or ports: same as above.
> +	* port or ports: see "Graph bindings for Coresight" below.
>  
>  * Optional properties for ETM/PTMs:
>  
> @@ -86,6 +84,28 @@ its hardware characteristcs.
>  	* arm,buffer-size: size of contiguous buffer space for TMC ETR
>  	 (embedded trace router)
>  
> +Graph bindings for Coresight
> +-------------------------------
> +
> +Coresight components are interconnected to create a data path for the flow of
> +trace data generated from the "sources" to their collection points "sink". Each

Over 80 characters.

> +coresight component must describe the "input" and "output" connections.
> +The connections must be described via generic DT graph bindings as described
> +by the "bindings/graph.txt", where each "port" along with an "endpoint" component

Same here.

> +represents a hardware port and the connection.
> +
> +Since it is possible to have multiple connections for any coresight component with

And here.

> +a specific direction of data flow, each connection must define the following
> +properties to uniquely identify the connection details.
> +
> + * Direction of the data flow w.r.t the component :
> +   Each input port must have the following property defined at the "endpoint"
> +   for the port.
> +	"slave-mode"
> +
> + * Hardware Port number at the component:
> +     -  The hardware port number is assumed to be the address of the "port" component.

And here.

Moveover this patches doesn't apply to my next tree. 

> +
>  
>  Example:
>  
> -- 
> 2.7.4
> 
