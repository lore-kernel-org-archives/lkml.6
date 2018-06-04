Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752288AbeFDPMc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:12:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44748 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752017AbeFDPMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:12:30 -0400
Date: Mon, 4 Jun 2018 16:12:24 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: Mark.Rutland@arm.com, austinwc@codeaurora.org,
        tnowicki@caviumnetworks.com, palmer@sifive.com, Will.Deacon@arm.com,
        linux-riscv@lists.infradead.org, wangxiongfeng2@huawei.com,
        vkilari@codeaurora.org, Lorenzo.Pieralisi@arm.com,
        jhugo@codeaurora.org, Morten.Rasmussen@arm.com,
        linux-acpi@vger.kernel.org, lenb@kernel.org, john.garry@huawei.com,
        ahs3@redhat.com, linux-arm-kernel@lists.infradead.org,
        ard.biesheuvel@linaro.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, linux-kernel@vger.kernel.org, hanjun.guo@linaro.org,
        Sudeep.Holla@arm.com, Dietmar.Eggemann@arm.com
Subject: Re: [PATCH v9 00/12] Support PPTT for ARM64
Message-ID: <20180604151223.tmwllb72lqopff2y@armageddon.cambridge.arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180517170523.h7tuvbzdfluuidcz@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517170523.h7tuvbzdfluuidcz@armageddon.cambridge.arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 06:05:24PM +0100, Catalin Marinas wrote:
> On Fri, May 11, 2018 at 06:57:55PM -0500, Jeremy Linton wrote:
> > Jeremy Linton (12):
> >   drivers: base: cacheinfo: move cache_setup_of_node()
> >   drivers: base: cacheinfo: setup DT cache properties early
> >   cacheinfo: rename of_node to fw_token
> >   arm64/acpi: Create arch specific cpu to acpi id helper
> >   ACPI/PPTT: Add Processor Properties Topology Table parsing
> >   ACPI: Enable PPTT support on ARM64
> >   drivers: base cacheinfo: Add support for ACPI based firmware tables
> >   arm64: Add support for ACPI based firmware tables
> >   arm64: topology: rename cluster_id
> >   arm64: topology: enable ACPI/PPTT based CPU topology
> >   ACPI: Add PPTT to injectable table list
> >   arm64: topology: divorce MC scheduling domain from core_siblings
> 
> Queued for 4.18 (without Sudeep's latest property_read_u64 cacheinfo
> patch - http://lkml.kernel.org/r/20180517154701.GA20281@e107155-lin; I
> can add it separately).

I'm going to revert patch 12 in this series (arm64: topology: divorce MC
scheduling domain from core_siblings) until the problem is understood
and a fix proposed and tested. It's likely that the PPTT for arm64 will
only be fully enabled in 4.19.

-- 
Catalin
