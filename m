Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECC906070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933639AbeFFRSS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:18:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:43486 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932977AbeFFRSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:18:17 -0400
Date: Wed, 6 Jun 2018 18:18:12 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Sudeep.Holla@arm.com, ard.biesheuvel@linaro.org,
        Will.Deacon@arm.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geert@linux-m68k.org,
        Robin.Murphy@arm.com, Morten.Rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: topology: Avoid checking numa mask for
 scheduler MC selection
Message-ID: <20180606171811.lro2u3g6rawxvskm@armageddon.cambridge.arm.com>
References: <20180606163846.495725-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180606163846.495725-1-jeremy.linton@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 11:38:46AM -0500, Jeremy Linton wrote:
> The numa mask subset check can often lead to system hang or crash during
> CPU hotplug and system suspend operation if NUMA is disabled. This is
> mostly observed on HMP systems where the CPU compute capacities are
> different and ends up in different scheduler domains. Since
> cpumask_of_node is returned instead core_sibling, the scheduler is
> confused with incorrect cpumasks(e.g. one CPU in two different sched
> domains at the same time) on CPU hotplug.
> 
> Lets disable the NUMA siblings checks for the time being, as NUMA in
> socket machines have LLC's that will assure that the scheduler topology
> isn't "borken".
> 
> The NUMA check exists to assure that if a LLC within a socket crosses
> NUMA nodes/chiplets the scheduler domains remain consistent. This code will
> likely have to be re-enabled in the near future once the NUMA mask story
> is sorted.  At the moment its not necessary because the NUMA in socket
> machines LLC's are contained within the NUMA domains.
> 
> Further, as a defensive mechanism during hot-plug, lets assure that the
> LLC siblings are also masked.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Thanks for this. I queued it for this merging window.

-- 
Catalin
