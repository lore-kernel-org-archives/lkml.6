Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752280AbeEQOLJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 10:11:09 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:43051 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752002AbeEQOLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 10:11:07 -0400
X-Google-Smtp-Source: AB8JxZqPz1UmfkAbTRXTwhEBd+qDtM0nMQ2dI5UswnemYAoZRr31Bq9IRDx7VaW6HWrpx/M5ugeu3g==
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Thu, 17 May 2018 10:11:02 -0400 (EDT)
X-X-Sender: vince@macbook-air
To: Eric Anholt <eric@anholt.net>
cc: Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
In-Reply-To: <20180517131727.29263-1-eric@anholt.net>
Message-ID: <alpine.DEB.2.21.1805171007260.7820@macbook-air>
References: <20180517131727.29263-1-eric@anholt.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2018, Eric Anholt wrote:

> diff --git a/arch/arm/boot/dts/bcm2837.dtsi b/arch/arm/boot/dts/bcm2837.dtsi
> index 7704bb029605..1f5e5c782835 100644
> --- a/arch/arm/boot/dts/bcm2837.dtsi
> +++ b/arch/arm/boot/dts/bcm2837.dtsi
> @@ -17,6 +17,12 @@
>  		};
>  	};
>  
> +	arm-pmu {
> +		compatible = "arm,cortex-a53-pmu", "arm,cortex-a7-pmu";
> +		interrupt-parent = <&local_intc>;
> +		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +

why this and not

arm-pmu {
	compatible = "arm,armv8-pmuv3";
	interrupt-parent = <&local_intc>;
	interrupts = <9>;
};

which works, though when I didn't get very far when I submitted the patch 
to add this last August.

Vince
