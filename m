Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753744AbeBGJWG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:22:06 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47408 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753700AbeBGJWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:22:02 -0500
Subject: Re: [PATCH v5 3/4] DT/arm,gic-v3-its: add reset-on-suspend property
To: Derek Basehore <dbasehore@chromium.org>, linux-kernel@vger.kernel.org
Cc: Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, tglx@linutronix.de,
        briannorris@chromium.org
References: <20180207014117.62611-1-dbasehore@chromium.org>
 <20180207014117.62611-4-dbasehore@chromium.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <b4c7bc62-6861-3851-513e-be8d7a440c91@arm.com>
Date: Wed, 7 Feb 2018 09:21:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207014117.62611-4-dbasehore@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/18 01:41, Derek Basehore wrote:
> This adds documentation for the new reset-on-suspend property. This
> property enables saving and restoring the ITS for when it loses state
> in system suspend.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
> index 0a57f2f4167d..a470147d4f14 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
> @@ -78,6 +78,9 @@ These nodes must have the following properties:
>  Optional:
>  - socionext,synquacer-pre-its: (u32, u32) tuple describing the untranslated
>    address and size of the pre-ITS window.
> +- reset-on-suspend: Boolean property. Indicates that the ITS state is
> +  reset on suspend. The state is then saved on suspend and restored on
> +  resume.

By whom? It is important to be clear about the respective
responsibilities, as this forms a binding contract between firmware and OS.

Mark: Can you have a look at how to formulate this? I'm not sure we have
other instances of a non-architected behaviour involving FW
participation, aside from PSCI.

>  
>  The main GIC node must contain the appropriate #address-cells,
>  #size-cells and ranges properties for the reg property of all ITS
> 

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
