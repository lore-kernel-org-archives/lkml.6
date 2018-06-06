Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CCACC606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752407AbeFFOow (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:44:52 -0400
Received: from foss.arm.com ([217.140.101.70]:41242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752363AbeFFOos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:44:48 -0400
Date: Wed, 6 Jun 2018 15:44:44 +0100
From: Morten Rasmussen <morten.rasmussen@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Sudeep.Holla@arm.com, Will.Deacon@arm.com, Catalin.Marinas@arm.com,
        Robin.Murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        linux-acpi@vger.kernel.org, ard.biesheuvel@linaro.org
Subject: Re: [PATCH] arm64: topology: Avoid checking numa mask for scheduler
 MC selection
Message-ID: <20180606144444.GB8461@e105550-lin.cambridge.arm.com>
References: <20180605190837.493505-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605190837.493505-1-jeremy.linton@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 02:08:37PM -0500, Jeremy Linton wrote:
> The numa mask subset check has problems if !CONFIG_NUMA, over hotplug
> operations or during early boot. Lets disable the NUMA siblings checks
> for the time being, as NUMA in socket machines have LLC's that will
> assure that the scheduler topology isn't "borken".

Could we add an explanation why the numa node mask check is needed in
the first place?

IIUC, we have the check in case the LLC is shared across numa nodes as
this would cause core_siblings > cpumask_of_node() which breaks the
scheduler topology.

While sharing LLC across numa nodes seems quite unusual, I think it is
allowed by ACPI. Those systems might already be broken before, so might
not change anything. It is just worth noting why the check should be
added back later.

Morten
