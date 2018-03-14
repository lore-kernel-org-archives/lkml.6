Return-Path: <vkilari@codeaurora.org>
X-Google-Smtp-Source: AG47ELuPX38FQ67tayRl+nQTBZ1PrQIuEDX8o+T26atiVW8z3Pee46KDjEKjDh7vCWaGNn65P+l6
ARC-Seal: i=1; a=rsa-sha256; t=1521021482; cv=none;
        d=google.com; s=arc-20160816;
        b=w7Dl1NMzH7DnKsscrFIRg3Y/PSOFbZElaW473Ub5qdBt7u/ic/YXLKYQ5FcegOSzrq
         7/DVdcL9ilqkRN6Noc/a8EnWoHuF52Bh/2I6hukLjxzDoXWMStB35g8QewPmW1LSdeOL
         9X7oDuce3V+xgQzBUY2CUnuOZ9dWi0TAGOcNCyzdPua/6842CQImbVofpnRadbstWfwA
         RXX7RV6dzzgL6fVstSMt6ghlVaEGof5ALU8PEcr+WaQG40k1H+7/Xi34wAISoOkloJ2t
         l0RLqmQ/0aDg5SUF+OqV0Oka/SlPogv6SnCB102rCuDKTe+BWxVUerdmahMuNDVJCXie
         vZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=dvW4aAV+jA+/mmY4IBmjiHcMBl0qbhRYUIx3S8jJ3MU=;
        b=wVAFnDTokARCtDDDJ+vlOtT55NFYfPS0zNpdtOWKfqs86+CrXGWWC8ZX/mfrZajJ0r
         Uu0+VdoZ82Pe8ggzrc2C8wd9r30Q3beYnUMwUt1LXHNdAb/2rVWM0N74g2B2SYZe0LUA
         PdV36y1wxOrWjRTrktrzkE8bonHf/PmU5JhaIfGPZp30Pd8Bh1LSviCDmFq5QnmFhY5s
         fNwZ9/QZXXm6ACk6A4QsyoKN3cykbNGX+FYqap6EAVoMEUDW4XxZT2jxR3kVVtMnzBfi
         LpprMWAlUDi5SieRsPmL+srvkSceLvpAyXj/r76VgPogmZG0F3ponAWF8jOvaDORMOiL
         OzxQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ilrc6V87;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=mot+deTC;
       spf=pass (google.com: domain of vkilari@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vkilari@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=Ilrc6V87;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=mot+deTC;
       spf=pass (google.com: domain of vkilari@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vkilari@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A23B960390
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vkilari@codeaurora.org
From: <vkilari@codeaurora.org>
To: "'Jeremy Linton'" <jeremy.linton@arm.com>,
	<linux-acpi@vger.kernel.org>
Cc: <linux-arm-kernel@lists.infradead.org>,
	<sudeep.holla@arm.com>,
	<lorenzo.pieralisi@arm.com>,
	<hanjun.guo@linaro.org>,
	<rjw@rjwysocki.net>,
	<will.deacon@arm.com>,
	<catalin.marinas@arm.com>,
	<gregkh@linuxfoundation.org>,
	<mark.rutland@arm.com>,
	<linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>,
	<wangxiongfeng2@huawei.com>,
	<ahs3@redhat.com>,
	<dietmar.eggemann@arm.com>,
	<morten.rasmussen@arm.com>,
	<palmer@sifive.com>,
	<lenb@kernel.org>,
	<john.garry@huawei.com>,
	<austinwc@codeaurora.org>,
	<tnowicki@caviumnetworks.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
In-Reply-To: <20180228220619.6992-1-jeremy.linton@arm.com>
Subject: RE: [PATCH v7 00/13] Support PPTT for ARM64
Date: Wed, 14 Mar 2018 15:27:35 +0530
Message-ID: <004d01d3bb7a$e5ec7700$b1c56500$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-us
Thread-Index: AQHbEhixWGAvCrV1zGAGjpstLKa1iKPA0SDA
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684134324692162?=
X-GMAIL-MSGID: =?utf-8?q?1594906622037266448?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jeremy,

> -----Original Message-----
> From: Jeremy Linton <jeremy.linton@arm.com>
> Sent: Thursday, March 1, 2018 3:36 AM
> To: linux-acpi@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; sudeep.holla@arm.com;
> lorenzo.pieralisi@arm.com; hanjun.guo@linaro.org; rjw@rjwysocki.net;
> will.deacon@arm.com; catalin.marinas@arm.com;
> gregkh@linuxfoundation.org; mark.rutland@arm.com; linux-
> kernel@vger.kernel.org; linux-riscv@lists.infradead.org;
> wangxiongfeng2@huawei.com; vkilari@codeaurora.org; ahs3@redhat.com;
> dietmar.eggemann@arm.com; morten.rasmussen@arm.com;
> palmer@sifive.com; lenb@kernel.org; john.garry@huawei.com;
> austinwc@codeaurora.org; tnowicki@caviumnetworks.com; Jeremy Linton
> <jeremy.linton@arm.com>
> Subject: [PATCH v7 00/13] Support PPTT for ARM64
> 
> ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
used to
> describe the processor and cache topology. Ideally it is used to
extend/override
> information provided by the hardware, but right now ARM64 is entirely
> dependent on firmware provided tables.
> 
> This patch parses the table for the cache topology and CPU topology.
> When we enable ACPI/PPTT for arm64 we map the physical_id to the PPTT
> node flagged as the physical package by the firmware.
> This results in topologies that match what the remainder of the system
expects.
> To avoid inverted scheduler domains we then set the MC domain equal to the
> largest cache within the socket below the NUMA domain.
> 
> For example on juno:
> [root@mammon-juno-rh topology]# lstopo-no-graphics
>   Package L#0
>     L2 L#0 (1024KB)
>       L1d L#0 (32KB) + L1i L#0 (32KB) + Core L#0 + PU L#0 (P#0)
>       L1d L#1 (32KB) + L1i L#1 (32KB) + Core L#1 + PU L#1 (P#1)
>       L1d L#2 (32KB) + L1i L#2 (32KB) + Core L#2 + PU L#2 (P#2)
>       L1d L#3 (32KB) + L1i L#3 (32KB) + Core L#3 + PU L#3 (P#3)
>     L2 L#1 (2048KB)
>       L1d L#4 (32KB) + L1i L#4 (48KB) + Core L#4 + PU L#4 (P#4)
>       L1d L#5 (32KB) + L1i L#5 (48KB) + Core L#5 + PU L#5 (P#5)
>   HostBridge L#0
>     PCIBridge
>       PCIBridge
>         PCIBridge
>           PCI 1095:3132
>             Block(Disk) L#0 "sda"
>         PCIBridge
>           PCI 1002:68f9
>             GPU L#1 "renderD128"
>             GPU L#2 "card0"
>             GPU L#3 "controlD64"
>         PCIBridge
>           PCI 11ab:4380
>             Net L#4 "enp8s0"
> 
> Git tree at:
> http://linux-arm.org/git?p=linux-jlinton.git
> branch: pptt_v7

Tested this series and looks good

Tested by: Vijaya Kumar K <vkilari@codeaurora.org>
> 
> v6->v7:
> Add additional patch to use the last cache level within the NUMA
>   or socket as the MC domain. This assures the MC domain is
>   equal or smaller than the DIE.
> 
> Various formatting/etc review comments.
> 
> Rebase to 4.16rc2
> 
> v5->v6:
> Add additional patches which re-factor how the initial DT code sets
>   up the cacheinfo structure so that its not as dependent on the
>   of_node stored in that tree. Once that is done we rename it
>   for use with the ACPI code.
> 
> Additionally there were a fair number of minor name/location/etc
>   tweaks scattered about made in response to review comments.
> 
> v4->v5:
> Update the cache type from NOCACHE to UNIFIED when all the cache
>   attributes we update are valid. This fixes a problem where caches
>   which are entirely created by the PPTT don't show up in lstopo.
> 
> Give the PPTT its own firmware_node in the cache structure instead of
>   sharing it with the of_node.
> 
> Move some pieces around between patches.
> 
> (see previous cover letters for futher changes)
> 
> Jeremy Linton (13):
>   drivers: base: cacheinfo: move cache_setup_of_node()
>   drivers: base: cacheinfo: setup DT cache properties early
>   cacheinfo: rename of_node to fw_token
>   arm64/acpi: Create arch specific cpu to acpi id helper
>   ACPI/PPTT: Add Processor Properties Topology Table parsing
>   ACPI: Enable PPTT support on ARM64
>   drivers: base cacheinfo: Add support for ACPI based firmware tables
>   arm64: Add support for ACPI based firmware tables
>   ACPI/PPTT: Add topology parsing code
>   arm64: topology: rename cluster_id
>   arm64: topology: enable ACPI/PPTT based CPU topology
>   ACPI: Add PPTT to injectable table list
>   arm64: topology: divorce MC scheduling domain from core_siblings
> 
>  arch/arm64/Kconfig                |   1 +
>  arch/arm64/include/asm/acpi.h     |   4 +
>  arch/arm64/include/asm/topology.h |   9 +-
>  arch/arm64/kernel/cacheinfo.c     |  15 +-
>  arch/arm64/kernel/topology.c      | 132 +++++++-
>  arch/riscv/kernel/cacheinfo.c     |   1 -
>  drivers/acpi/Kconfig              |   3 +
>  drivers/acpi/Makefile             |   1 +
>  drivers/acpi/pptt.c               | 642
> ++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/tables.c             |   2 +-
>  drivers/base/cacheinfo.c          | 157 +++++-----
>  include/linux/acpi.h              |   4 +
>  include/linux/cacheinfo.h         |  17 +-
>  13 files changed, 882 insertions(+), 106 deletions(-)  create mode 100644
> drivers/acpi/pptt.c
> 
> --
> 2.13.6
