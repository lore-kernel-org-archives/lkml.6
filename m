Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030274AbeCALfE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:35:04 -0500
Received: from foss.arm.com ([217.140.101.70]:36568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030228AbeCALfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:35:02 -0500
Date: Thu, 1 Mar 2018 11:34:57 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Derek Basehore <dbasehore@chromium.org>
Cc: linux-kernel@vger.kernel.org, Soby.Mathew@arm.com,
        sudeep.holla@arm.com, devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        tglx@linutronix.de, briannorris@chromium.org, marc.zyngier@arm.com
Subject: Re: [PATCH v7 2/3] DT/arm,gic-v3-its: add reset-on-suspend property
Message-ID: <20180301113457.jg256bsepf7ggx6v@lakrids.cambridge.arm.com>
References: <20180301054820.42847-1-dbasehore@chromium.org>
 <20180301054820.42847-3-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301054820.42847-3-dbasehore@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 09:48:19PM -0800, Derek Basehore wrote:
> This adds documentation for the new reset-on-suspend property. This
> property enables saving and restoring the ITS for when it loses state
> in system suspend.
> 
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  .../devicetree/bindings/interrupt-controller/arm,gic-v3.txt  | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
> index 0a57f2f4167d..dfd1b9b838cd 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
> @@ -78,6 +78,11 @@ These nodes must have the following properties:
>  Optional:
>  - socionext,synquacer-pre-its: (u32, u32) tuple describing the untranslated
>    address and size of the pre-ITS window.
> +- reset-on-suspend: Boolean property. Indicates that the ITS loses power
> +  on suspend to memory (via PSCI_SYSTEM_SUSPEND). Registers and data within
> +  the ITS will be the same as before probe (PSCI FW does not restore state).

What does 'before probe' mean? Perhaps 'at reset'?

Is the state well-defined, or might there be some bits that differ from
boot-to-boot?

Otherwise, this generally looks ok.

> +  Any state stored in external memory is maintained (such as collection
> +  tables stored in external memory).

This a property of PSCI_SYSTEM_SUSPEND not corrupting memory state, so
this need not be stated here. This can go.

Thanks,
Mark.
