Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2616C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FEE320880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEE320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeILQG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 12:06:28 -0400
Received: from foss.arm.com ([217.140.101.70]:57596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727673AbeILQG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 12:06:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 256921596;
        Wed, 12 Sep 2018 04:02:26 -0700 (PDT)
Received: from [10.4.12.116] (e107155-lin.emea.arm.com [10.4.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 999383F71F;
        Wed, 12 Sep 2018 04:02:24 -0700 (PDT)
Cc:     Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        t-kristo@ti.com, tony@atomide.com
Subject: Re: [PATCH] dt-bindings: power: Introduce suspend states supported
 properties
To:     Keerthy <j-keerthy@ti.com>, mark.rutland@arm.com,
        robh+dt@kernel.org
References: <1536725372-29174-1-git-send-email-j-keerthy@ti.com>
From:   Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <781b2eb2-1568-b4e5-46f2-c4612862d728@arm.com>
Date:   Wed, 12 Sep 2018 12:02:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536725372-29174-1-git-send-email-j-keerthy@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/18 05:09, Keerthy wrote:
> Introuduce linux generic suspend states supported properties.
> It is convenient for the generic suspend path to have
> the knowledge of the suspend states supported based on the
> device tree properties based on which it can either be suspended
> or safely bailed out of suspend if none of the suspend states
> are supported.
> 

NACK for any bindings that are linux specific. The suspend feature is so
platform dependent that I see no need for generic Linux bindings for the
same.

We have power domains and idle states. If you have platforms that
doesn't support some of the states, just disable them in the DT.

> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  .../devicetree/bindings/power/power-states.txt     | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/power-states.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/power-states.txt b/Documentation/devicetree/bindings/power/power-states.txt
> new file mode 100644
> index 0000000..bb80b36
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/power-states.txt
> @@ -0,0 +1,22 @@
> +* Generic system suspend states support
> +
> +Most platforms support multiple suspend states. Define system
> +suspend states so that one can target appropriate low power
> +states based on the SoC capabilities.
> +
> +linux,suspend-to-memory-supported
> +
> +Upon suspend to memory the system context is saved to primary memory.
> +All the clocks for all the peripherals including CPU are gated.
> +
> +linux,suspend-power-off-supported
> +
> +In this case in additon to the clocks all the voltage resources are
> +turned off except the ones needed to keep the primary memory
> +and a wake up source that can trigger a wakeup event.
> +
> +linux,suspend-to-disk-supported
> +
> +Upon suspend to disk that system context is saved to secondary memory.
> +All the clocks for all the peripherals including CPU are gated. Even
> +the primary memory is turned off.
> 

What makes any of the above linux specific. So once again NACK.


-- 
Regards,
Sudeep
