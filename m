Return-Path: <vkilari@codeaurora.org>
X-Google-Smtp-Source: AB8JxZoKiaI0U8Hj97i9/WAH9vlkGCaWWWbszwZWn3vo+WLn7+3YblstyHO2zpq5gYEu/2vfC1WE
ARC-Seal: i=1; a=rsa-sha256; t=1525421436; cv=none;
        d=google.com; s=arc-20160816;
        b=c3e5acTJX6WHeZb49D4CTxLRHwfu4viyOW1CT7VMpkZ/xHMB5S1iPUq05ORO10XbnV
         O1UTPIIUkaxwxmpQv4L2ZgHLVi07kpF0pgpQfFx/MV2mU0lTgI3mso+DZKce7nLkfus/
         deXItkFASLp7WI6hBZoFcOimoRhusnySENSLkhuFpg2FcPyHYeYL3Q06MdiKX0IImbyp
         T1PAbiuQJxgAPrmX8f5YJQLdiwXATr3jhYUIM9GFYhO51EOq2n4OTnss+6jb18zR9Eu1
         hpPa2WLInnXSLw4+OduVRO1cAzm/UoPzrW5MHeo3nZeo02HrL4+Q2jsmWoO6MTRF9kK1
         KwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=b/sGewGz/fVDQCe1y8DsdA2BnSQPdhNahh6Fbm7RiZo=;
        b=PAXeM+zXhkn4ozSNU7ZbZQFinEtu41imjIauThqpJqdxHs1iXajzv8yln1td1sOr9j
         jrcakA+6G/l16qolLpvjQ7w/byvNSNWNgLAWu83lINVikLY4lUDtwiE4AT32R8HGsiCv
         ySZRMCaLS8jx3GwIlU2C/9ky/jEIWy9sM1lflImU+9XGg58wCS9OwYXIerVmny1DP13v
         wLnRNEhdbkitv7Qekq3O9IknR4k49GHwGSS4TQTK9pUP+k1K1sIGiGoq4vrfSThCG4UJ
         EaYteK3FoPx7HCsfMf0vokVi/YWIfT2gFTyQXtASnrPSyWKmgEvr2y2V2WYKGByW4Msi
         5LJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dtLOP/Rc;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=JppwRmv6;
       spf=pass (google.com: domain of vkilari@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vkilari@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dtLOP/Rc;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=JppwRmv6;
       spf=pass (google.com: domain of vkilari@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=vkilari@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0ADA86037B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vkilari@codeaurora.org
From: <vkilari@codeaurora.org>
To: "'Jeremy Linton'" <jeremy.linton@arm.com>,
	<linux-acpi@vger.kernel.org>
Cc: <Sudeep.Holla@arm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<Lorenzo.Pieralisi@arm.com>,
	<hanjun.guo@linaro.org>,
	<rjw@rjwysocki.net>,
	<Will.Deacon@arm.com>,
	<Catalin.Marinas@arm.com>,
	<gregkh@linuxfoundation.org>,
	<Mark.Rutland@arm.com>,
	<linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>,
	<wangxiongfeng2@huawei.com>,
	<ahs3@redhat.com>,
	<Dietmar.Eggemann@arm.com>,
	<Morten.Rasmussen@arm.com>,
	<palmer@sifive.com>,
	<lenb@kernel.org>,
	<john.garry@huawei.com>,
	<austinwc@codeaurora.org>,
	<tnowicki@caviumnetworks.com>,
	<jhugo@qti.qualcomm.com>,
	<timur@qti.qualcomm.com>,
	<ard.biesheuvel@linaro.org>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
Subject: RE: [PATCH v8 00/13] Support PPTT for ARM64
Date: Fri, 4 May 2018 13:40:09 +0530
Message-ID: <050a01d3e37f$57678470$06368d50$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG/BgUedQYFf1CdCs7IojeDOgz6u6RI8nLw
Content-Language: en-us
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766310843839266?=
X-GMAIL-MSGID: =?utf-8?q?1599520308446796108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Jeremy Linton <jeremy.linton@arm.com>
> Sent: Thursday, April 26, 2018 5:01 AM
> To: linux-acpi@vger.kernel.org
> Cc: Sudeep.Holla@arm.com; linux-arm-kernel@lists.infradead.org;
> Lorenzo.Pieralisi@arm.com; hanjun.guo@linaro.org; rjw@rjwysocki.net;
> Will.Deacon@arm.com; Catalin.Marinas@arm.com;
> gregkh@linuxfoundation.org; Mark.Rutland@arm.com; linux-
> kernel@vger.kernel.org; linux-riscv@lists.infradead.org;
> wangxiongfeng2@huawei.com; vkilari@codeaurora.org; ahs3@redhat.com;
> Dietmar.Eggemann@arm.com; Morten.Rasmussen@arm.com;
> palmer@sifive.com; lenb@kernel.org; john.garry@huawei.com;
> austinwc@codeaurora.org; tnowicki@caviumnetworks.com;
> jhugo@qti.qualcomm.com; timur@qti.qualcomm.com;
> ard.biesheuvel@linaro.org; Jeremy Linton <jeremy.linton@arm.com>
> Subject: [PATCH v8 00/13] Support PPTT for ARM64
> 
> ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
used to
> describe the processor and cache topology. Ideally it is used to
extend/override
> information provided by the hardware, but right now ARM64 is entirely
> dependent on firmware provided tables.
> 
> This patch parses the table for the cache topology and CPU topology.
> When we enable ACPI/PPTT for arm64 we map the package_id to the PPTT
> node flagged as the physical package by the firmware.
> This results in topologies that match what the remainder of the system
expects.
> Finally, we update the scheduler MC domain so that it generally reflects
the
> LLC unless the LLC is too large for the NUMA domain (or package).
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
> branch: pptt_v8

Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>

> 
> v7->v8:
> Modify the logic used to select the MC domain (the change
>   shouldn't modify the sched domains on any existing machines
>   compared to v7, only how they are built) Reduce the severity of some
parsing
> messages.
> Fix s390 link problem.
> Further checks to deal with broken PPTT tables.
> Various style tweaks, SPDX license addition, etc.
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
>  arch/arm64/include/asm/topology.h |   6 +-
>  arch/arm64/kernel/cacheinfo.c     |  15 +-
>  arch/arm64/kernel/topology.c      | 103 +++++-
>  arch/riscv/kernel/cacheinfo.c     |   1 -
>  drivers/acpi/Kconfig              |   3 +
>  drivers/acpi/Makefile             |   1 +
>  drivers/acpi/pptt.c               | 678
> ++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/tables.c             |   2 +-
>  drivers/base/cacheinfo.c          | 157 ++++-----
>  include/linux/acpi.h              |   4 +
>  include/linux/cacheinfo.h         |  18 +-
>  13 files changed, 886 insertions(+), 107 deletions(-)  create mode 100644
> drivers/acpi/pptt.c
> 
> --
> 2.13.6
