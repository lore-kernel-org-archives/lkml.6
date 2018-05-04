Return-Path: <wangxiongfeng2@huawei.com>
X-Google-Smtp-Source: AB8JxZrIU0XGGaZMxPmEsLO2MIlQnx0RssvIMw95Vm2VUJls1su9yCDVxweN5dKKMD8ss5aFlQul
ARC-Seal: i=1; a=rsa-sha256; t=1525433755; cv=none;
        d=google.com; s=arc-20160816;
        b=Q3iR+/WRwx2MLyZQtfA/A0pFqCKwFIa85rgN4G+VN6HFNdnPnyT4KYw1Av/u+gdBFR
         pmObJur+1BFdBX5XTUqZpfzQReP9Y1mpzOP1brEAQJ7P9/5ytefEDo3crfBDTIxrXNhK
         tQvAXl0ZL/jNJtCrY9etSVitoEc8G4PQ0Cdyxeb1LnzFju+hc4RycyiAqWyRLyt+s1VS
         4P4YKjFrnfUX8Q+Oy1B76cjlHwtAUdOpkJOjapfWrk4kCGDd1hw2iHGoFCIcxqrlT1Je
         rfDzsIQiNXzH/QpiMhIxbqPv6XEHkdzp7Tnxy1AGOIfBEQ/Fb1CVly+o8rwXuzNPkgn1
         nx7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=+dQl4xKPBDfpd8wbfIuPL1QZWr9sZDRWm/AAcxFdA1Q=;
        b=cVqIeGaXSlmRiiIhhF6TTBNdaTTWipovteThiwJmdatHfpbm0+8kri/WoaUFadxBW3
         5n1XHAnyfjT8r0IjSb+CZmZ/ElmTux60BhNG0EPGVzEPHXItZPKxBtlLCe3tzn7EYchL
         duVfUkKKdwY+Ue9VFo1tzz2JGAm18zbzaQuLD1tckSzrjavHRkbUhYeL1AwH6vVI5K+X
         lmTZN35rCEY1WBCsn9IJKPJGKQ/tONpcGwRuHLgQZJ+h3Ncu7UlzBy5K8uXQFYGSEcGb
         TWBcmzj1Yk4W2FbLzFiZCXSwBvblDQY5rZeDfINpw1o4IrYZRg0qkTuE23Gz7jlXq7Hx
         QjpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of wangxiongfeng2@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=wangxiongfeng2@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of wangxiongfeng2@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=wangxiongfeng2@huawei.com
Subject: Re: [PATCH v8 00/13] Support PPTT for ARM64
To: Jeremy Linton <jeremy.linton@arm.com>, <linux-acpi@vger.kernel.org>
CC: <Sudeep.Holla@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<Lorenzo.Pieralisi@arm.com>, <hanjun.guo@linaro.org>, <rjw@rjwysocki.net>,
	<Will.Deacon@arm.com>, <Catalin.Marinas@arm.com>,
	<gregkh@linuxfoundation.org>, <Mark.Rutland@arm.com>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<vkilari@codeaurora.org>, <ahs3@redhat.com>, <Dietmar.Eggemann@arm.com>,
	<Morten.Rasmussen@arm.com>, <palmer@sifive.com>, <lenb@kernel.org>,
	<john.garry@huawei.com>, <austinwc@codeaurora.org>,
	<tnowicki@caviumnetworks.com>, <jhugo@qti.qualcomm.com>,
	<timur@qti.qualcomm.com>, <ard.biesheuvel@linaro.org>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <35ce144b-4386-7bd8-f401-8643400fb7a1@huawei.com>
Date: Fri, 4 May 2018 19:34:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.52.56]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766310843839266?=
X-GMAIL-MSGID: =?utf-8?q?1599533225705373146?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

Tested on D05 board. 'lscpu' prints the following info:
localhost:~ # lscpu
Architecture:          aarch64
Byte Order:            Little Endian
CPU(s):                64
On-line CPU(s) list:   0-63
Thread(s) per core:    1
Core(s) per socket:    32
Socket(s):             2
NUMA node(s):          4
L1d cache:             32K
L1i cache:             48K
L2 cache:              1024K
L3 cache:              16384K
NUMA node0 CPU(s):     0-15
NUMA node1 CPU(s):     16-31
NUMA node2 CPU(s):     32-47
NUMA node3 CPU(s):     48-63

'sched_domain' is as follows
localhost:~ # cat /proc/schedstat
version 15
timestamp 4294936236
cpu0 0 0 0 0 0 0 2471285600 2634828800 4813
domain0 00000000,0000ffff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
domain1 00000000,ffffffff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
domain2 ffffffff,ffffffff 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0


On 2018/4/26 7:31, Jeremy Linton wrote:
> ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
> used to describe the processor and cache topology. Ideally it is
> used to extend/override information provided by the hardware, but
> right now ARM64 is entirely dependent on firmware provided tables.
> 
> This patch parses the table for the cache topology and CPU topology.
> When we enable ACPI/PPTT for arm64 we map the package_id to the
> PPTT node flagged as the physical package by the firmware.
> This results in topologies that match what the remainder of the
> system expects. Finally, we update the scheduler MC domain so that
> it generally reflects the LLC unless the LLC is too large for the
> NUMA domain (or package).
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
> 
> v7->v8:
> Modify the logic used to select the MC domain (the change
>   shouldn't modify the sched domains on any existing machines
>   compared to v7, only how they are built)
> Reduce the severity of some parsing messages.
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
>  drivers/acpi/pptt.c               | 678 ++++++++++++++++++++++++++++++++++++++
>  drivers/acpi/tables.c             |   2 +-
>  drivers/base/cacheinfo.c          | 157 ++++-----
>  include/linux/acpi.h              |   4 +
>  include/linux/cacheinfo.h         |  18 +-
>  13 files changed, 886 insertions(+), 107 deletions(-)
>  create mode 100644 drivers/acpi/pptt.c
> 
