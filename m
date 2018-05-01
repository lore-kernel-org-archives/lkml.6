Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755171AbeEANNE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 09:13:04 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33809 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeEANNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 09:13:02 -0400
X-Google-Smtp-Source: AB8JxZrENYGULTKEZi6fGrEGD8swgTmW7X9SeKnIrG3teGxQmbJh1Qt9qXrpttmgj3ho1lW0HNoN9w==
Date: Tue, 1 May 2018 08:13:00 -0500
From: Rob Herring <robh@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        robert.walker@arm.com, mark.rutland@arm.com, will.deacon@arm.com,
        robin.murphy@arm.com, sudeep.holla@arm.com, frowand.list@gmail.com,
        john.horley@arm.com, Mathieu Poirier <matheiu.poirier@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 10/27] dts: bindings: Restrict coresight tmc-etr
 scatter-gather mode
Message-ID: <20180501131300.GA31425@rob-hp-laptop>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
 <1525165857-11096-11-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525165857-11096-11-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 01, 2018 at 10:10:40AM +0100, Suzuki K Poulose wrote:
> We are about to add the support for ETR builtin scatter-gather mode
> for dealing with large amount of trace buffers. However, on some of
> the platforms, using the ETR SG mode can lock up the system due to
> the way the ETR is connected to the memory subsystem.
> 
> In SG mode, the ETR performs READ from the scatter-gather table to
> fetch the next page and regular WRITE of trace data. If the READ
> operation doesn't complete(due to the memory subsystem issues,
> which we have seen on a couple of platforms) the trace WRITE
> cannot proceed leading to issues. So, we by default do not
> use the SG mode, unless it is known to be safe on the platform.
> We define a DT property for the TMC node to specify whether we
> have a proper SG mode.
> 
> Cc: Mathieu Poirier <matheiu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: John Horley <john.horley@arm.com>
> Cc: Robert Walker <robert.walker@arm.com>
> Cc: devicetree@vger.kernel.org
> Cc: frowand.list@gmail.com
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/coresight.txt | 3 +++
>  drivers/hwtracing/coresight/coresight-tmc.c         | 8 +++++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index cdd84d0..7c0c8f0 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -88,6 +88,9 @@ its hardware characteristcs.
>  	* arm,buffer-size: size of contiguous buffer space for TMC ETR
>  	 (embedded trace router)
>  
> +	* scatter-gather: boolean. Indicates that the TMC-ETR can safely
> +	  use the SG mode on this system.
> +

Needs a vendor prefix.

>  * Optional property for CATU :
>  	* interrupts : Exactly one SPI may be listed for reporting the address
>  	  error
