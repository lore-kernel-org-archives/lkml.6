Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-585385-1524655833-2-13750967591449347657
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524655831; b=QzGAm+z+z6ENgWOM0wTaVTZyx8Pr6SQDptfrjvb4zd8dyFSv6A
    HqfIKP+oN0yfI0zT0jJTSqhWDv+aJYWnjbpNI3DQo9PqTyUMplQbApiFnjgz7Dol
    yYtnDV4YfJ1NXvDdMwaLSMGMygJM80d74eh4jrnsE2PwQJ7hQvUvrxxVq2vHpEKt
    5I2I8g64NqNZQUuHfv8fiZ2ZRFnUjtCms/1GldPJCGTrQNpVPuxulgAsla1rwZ05
    fVrANdYGEvyBZD7ypPEzroPmlu9voSyLL1HocXjvwEJki9WSUbDKOvs/3ZHjxCap
    6a1PNlId+nsDSOO4Mv+Zfb34JdJ/hVhaJsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1524655831; bh=uDzKOBpcJS3Kc2EQtkZsrYmo56IXEq
    nkXgC3lTTt8eY=; b=XdTf7GUX9wKof6DX7gY6lBvOe3vsRHZ8D2UZGA2+y9zt90
    Jp70LaWdRrw10jrmcah5HVUt0782AjJjNYbS/UvCTrjtdiBwbvP6Dd26C90j5EcE
    YE5RPa2CxLBmQ4bIVDJKA+MaBcUVvvHU1JMXhMnPAHcZzXhe+zD1opbpWO8BLtVI
    dDBg6eTwtmpQ16d0iRTR8sA/V4yS5OmhQyi9QRwE9FQ5ODBt/Le2YWertU3eWwKI
    2+HOroAygns2Fu7d5OJ6iWLpRd9w6fsWSiquJIVKXB4ah9WSwIhx5TTnKUfxDy/c
    5fGlxDK1ETWRaxtKqqIt53gjJBuHYUC6wL47gZ1Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKpzoPGenBcwi3kHY0nt2Bry4QDNxWtxSzwdy3qMAM3F/yICmEPzVXUn4+tkblECYoUU+ky53d0QqlToOti4Aqy4SFtVFuFvWl3fO1uMqOxQKm1bz2ZK
    3eOjtaST48AQ0CWHq81fEEpQREgxsTfgGuwS35soevJ6PBsCwPcnnO+zVfs/Av0epnZQqM76XGRiQqoYnzK/Xyn2xCQ4xqBUgg36fiRalBGUOQpvz4R3Xqku
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=viYhoEuuK30A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=QyXUC8HyAAAA:8
    a=CbDCq_QkAAAA:8 a=20KFwNOVAAAA:8 a=UqCG9HQmAAAA:8 a=LpQP-O61AAAA:8
    a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8 a=MvuuwTCpAAAA:8
    a=SRrdq9N9AAAA:8 a=2KMo9-giAAAA:8 a=hWMQpYRtAAAA:8 a=3-RhneuVAAAA:8
    a=VZJtwKKvAAAA:8 a=voM4FWlXAAAA:8 a=xNf9USuDAAAA:8 a=yPCof4ZbAAAA:8
    a=meVymXHHAAAA:8 a=1RTuLK3dAAAA:8 a=KKAkSRfTAAAA:8 a=tHz9FfFoAAAA:8
    a=gPJu0pBYAAAA:8 a=FOH2dFAWAAAA:8 a=mzo1gerHAAAA:8 a=V4zo2IF0AAAA:8
    a=R_Myd5XaAAAA:8 a=i0EeH86SAAAA:8 a=_Wotqz80AAAA:8 a=1XWaLZrsAAAA:8
    a=9isDrUItAAAA:8 a=gXLdhW2jAAAA:8 a=edGIuiaXAAAA:8 a=3W9sBVhNAAAA:8
    a=gVGD3344AAAA:8 a=s8YR1HE3AAAA:8 a=iox4zFpeAAAA:8 a=hD80L64hAAAA:8
    a=_jlGtV7tAAAA:8 a=RW_g7ExWAAAA:8 a=mK_AVkanAAAA:8 a=tBb2bbeoAAAA:8
    a=zAyngx5bAAAA:8 a=D31QgfloAAAA:8 a=JfrnYn6hAAAA:8 a=uAS_uZ3KAAAA:8
    a=_ua-DJzVAAAA:8 a=50gAi1W1AAAA:8 a=Byx-y9mGAAAA:8 a=t9ty7G3lAAAA:8
    a=8AirrxEcAAAA:8 a=omOdbC7AAAAA:8 a=JE2zQuZmfspogL39oHoA:9
    a=DxFblOPo2WfiVta_:21 a=aSZCetxY-zRaZ0vb:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=1qrBK16LubpBFNPVNq2M:22
    a=pioyyrs4ZptJ924tMmac:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=dVHiktpip_riXrfdqayU:22
    a=UeCTMeHK7YUBiLmz_SX7:22 a=KCsI-UfzjElwHeZNREa_:22 a=VLVLkjT_5ZicWzSuYqSo:22
    a=vzdIw8kzLcqZOxdJCU6L:22 a=IC2XNlieTeVoXbcui8wp:22 a=SEwjQc04WA-l_NiBhQ7s:22
    a=2JgSa4NbpEOStq-L5dxp:22 a=kRpfLKi8w9umh8uBmg1i:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753466AbeDYLaR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 07:30:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51306 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752391AbeDYKiK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:38:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/183] 4.14.37-stable review
Date: Wed, 25 Apr 2018 12:33:40 +0200
Message-Id: <20180425103242.532713678@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.37-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.37-rc1
X-KernelTest-Deadline: 2018-04-27T10:32+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.37 release.
There are 183 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri Apr 27 10:32:04 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.37-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.37-rc1

Benjamin Beichler <benjamin.beichler@uni-rostock.de>
    mac80211_hwsim: fix use-after-free bug in hwsim_exit_net

Sean Christopherson <sean.j.christopherson@intel.com>
    Revert "KVM: X86: Fix SMRAM accessing even if VM is shutdown"

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Fix NULL dereference while accessing XRC_TGT QPs

Jiri Olsa <jolsa@kernel.org>
    perf: Return proper values for user stack errors

Jiri Olsa <jolsa@kernel.org>
    perf: Fix sample_max_stack maximum check

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: limit allocation requests for blob rule heads

Florian Westphal <fw@strlen.de>
    netfilter: compat: reject huge allocation requests

Florian Westphal <fw@strlen.de>
    netfilter: compat: prepare xt_compat_init_offsets to return errors

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: add counters allocation wrapper

Florian Westphal <fw@strlen.de>
    netfilter: x_tables: cap allocations at 512 mbyte

Thomas Gleixner <tglx@linutronix.de>
    alarmtimer: Init nanosleep alarm timer on stack

Max Gurtovoy <maxg@mellanox.com>
    RDMA/core: Reduce poll batch for direct cq polling

Mark Salter <msalter@redhat.com>
    irqchip/gic-v3: Change pr_debug message to pr_devel

Michael Kelley <mhkelley@outlook.com>
    cpumask: Make for_each_cpu_wrap() available on UP as well

Stephen Boyd <sboyd@codeaurora.org>
    irqchip/gic-v3: Ignore disabled ITS nodes

Thomas Richter <tmricht@linux.vnet.ibm.com>
    perf test: Fix test trace+probe_libc_inet_pton.sh for s390x

Nicholas Piggin <npiggin@gmail.com>
    powerpc/powernv: IMC fix out of bounds memory access at shutdown

Will Deacon <will.deacon@arm.com>
    locking/qspinlock: Ensure node->count is updated before initialising node

mike.travis@hpe.com <mike.travis@hpe.com>
    x86/platform/UV: Fix GAM Range Table entries less than 1GB

Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
    powerpc/mm/hash64: Zero PGD pages on allocation

Jia Zhang <zhang.jia@linux.alibaba.com>
    vfs/proc/kcore, x86/mm/kcore: Fix SMAP fault when dumping vsyscall user page

Tony Lindgren <tony@atomide.com>
    PM / wakeirq: Fix unbalanced IRQ enable for wakeirq

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    ACPI / EC: Restore polling during noirq suspend/resume phases

Daniel Borkmann <daniel@iogearbox.net>
    bpf: fix rlimit in reuseport net selftest

Niklas Cassel <niklas.cassel@axis.com>
    net: stmmac: discard disabled flags in interrupt status register

Trond Myklebust <trond.myklebust@primarydata.com>
    SUNRPC: Don't call __UDPX_INC_STATS() from a preemptible context

Paul Mackerras <paulus@ozlabs.org>
    KVM: PPC: Book3S HV: Fix handling of secondary HPTEG in HPT resizing code

Jesper Dangaard Brouer <brouer@redhat.com>
    tools/libbpf: handle issues with bpf ELF objects containing .eh_frames

Mathieu Malaterre <malat@debian.org>
    net: Extra '_get' in declaration of arch_get_platform_mac_address

Chuck Lever <chuck.lever@oracle.com>
    svcrdma: Fix Read chunk round-up

David Howells <dhowells@redhat.com>
    rxrpc: Don't put crypto buffers on the stack

Steven Rostedt (VMware) <rostedt@goodmis.org>
    selftests/ftrace: Add some missing glob checks

Chen Yu <yu.c.chen@intel.com>
    cpufreq: intel_pstate: Enable HWP during system resume on CPU0

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: return attach error when no cache set exist

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: fix for data collapse after re-attaching an attached device

Tang Junhui <tang.junhui@zte.com.cn>
    bcache: fix for allocator and register thread race

Coly Li <colyli@suse.de>
    bcache: properly set task state in bch_writeback_thread()

Arnd Bergmann <arnd@arndb.de>
    cifs: silence compiler warnings showing up with gcc-8.0.0

Ulf Hansson <ulf.hansson@linaro.org>
    PM / domains: Fix up domain-idle-states OF parsing

Alexey Dobriyan <adobriyan@gmail.com>
    proc: fix /proc/*/map_files lookup

Will Deacon <will.deacon@arm.com>
    arm64: spinlock: Fix theoretical trylock() A-B-A with LSE atomics

Guanglei Li <guanglei.li@oracle.com>
    RDS: IB: Fix null pointer issue

John Fastabend <john.fastabend@gmail.com>
    bpf: sockmap, fix leaking maps with attached but not detached progs

Ross Lagerwall <ross.lagerwall@citrix.com>
    xen/grant-table: Use put_page instead of free_page

Ross Lagerwall <ross.lagerwall@citrix.com>
    xen-netfront: Fix race between device setup and open

Jiri Olsa <jolsa@kernel.org>
    perf evsel: Fix period/freq terms setup

Matt Redfearn <matt.redfearn@mips.com>
    MIPS: Generic: Support GIC in EIC mode

Jiri Olsa <jolsa@kernel.org>
    perf record: Fix period option handling

Matt Redfearn <matt.redfearn@mips.com>
    MIPS: TXx9: use IS_BUILTIN() for CONFIG_LEDS_CLASS

James Hogan <jhogan@kernel.org>
    MIPS: generic: Fix machine compatible matching

Yonghong Song <yhs@fb.com>
    bpf: fix selftests/bpf test_kmod.sh failure when CONFIG_BPF_JIT_ALWAYS_ON=y

Hans de Goede <hdegoede@redhat.com>
    ACPI / scan: Use acpi_bus_get_status() to initialize ACPI_TYPE_DEVICE devs

Hans de Goede <hdegoede@redhat.com>
    ACPI / bus: Do not call _STA on battery devices with unmet dependencies

Chen Yu <yu.c.chen@intel.com>
    ACPI: processor_perflib: Do not send _PPC change notification if not ready

Jean Delvare <jdelvare@suse.de>
    firmware: dmi_scan: Fix handling of empty DMI strings

Arnd Bergmann <arnd@arndb.de>
    x86/dumpstack: Avoid uninitlized variable

Arnd Bergmann <arnd@arndb.de>
    x86/power: Fix swsusp_arch_resume prototype

Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
    netfilter: ipv6: nf_defrag: Kill frag queue on RFC2460 failure

Sebastian Ott <sebott@linux.vnet.ibm.com>
    s390/eadm: fix CONFIG_BLOCK include dependency

Karol Herbst <kherbst@redhat.com>
    drm/nouveau/pmu/fuc: don't use movw directly anymore

Don Hiatt <don.hiatt@intel.com>
    IB/core: Map iWarp AH type to undefined in rdma_ah_find_type

Alex Estrin <alex.estrin@intel.com>
    IB/ipoib: Fix for potential no-carrier state

Alex Estrin <alex.estrin@intel.com>
    IB/hfi1: Fix for potential refcount leak in hfi1_open_file()

Michael J. Ruhl <michael.j.ruhl@intel.com>
    IB/hfi1: Re-order IRQ cleanup to address driver cleanup race

Jens Axboe <axboe@kernel.dk>
    blk-mq: fix discard merge with scheduler attached

Ed Swierk <eswierk@skyportsystems.com>
    openvswitch: Remove padding from packet before L3+ conntrack processing

shidao.ytt <shidao.ytt@alibaba-inc.com>
    mm/fadvise: discard partial page if endbyte is also EOF

Mel Gorman <mgorman@techsingularity.net>
    mm: pin address_space before dereferencing it while isolating an LRU page

Yang Shi <yang.s@alibaba-inc.com>
    mm: thp: use down_read_trylock() in khugepaged to avoid long block

Nitin Gupta <nitin.m.gupta@oracle.com>
    sparc64: update pmdp_invalidate() to return old pmd value

Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    asm-generic: provide generic_pmdp_establish()

Yisheng Xie <xieyisheng1@huawei.com>
    mm/mempolicy: add nodes_empty check in SYSC_migrate_pages

Yisheng Xie <xieyisheng1@huawei.com>
    mm/mempolicy: fix the check of nodemask from user

piaojun <piaojun@huawei.com>
    ocfs2: return error when we attempt to access a dirty bh in jbd2

piaojun <piaojun@huawei.com>
    ocfs2/acl: use 'ip_xattr_sem' to protect getting extended attribute

piaojun <piaojun@huawei.com>
    ocfs2: return -EROFS to mount.ocfs2 if inode block is invalid

Jan H. Schönherr <jschoenh@amazon.de>
    fs/dax.c: release PMD lock even when there is no PMD support in DAX

Vitaly Kuznetsov <vkuznets@redhat.com>
    x86/kvm/vmx: do not use vm-exit instruction length for fast MMIO when running nested

KarimAllah Ahmed <karahmed@amazon.de>
    kvm: Map PFN-type memory regions as writable (if possible)

Gustavo A. R. Silva <gustavo@embeddedor.com>
    tcp_nv: fix potential integer overflow in tcpnv_acked

Dmitry Vyukov <dvyukov@google.com>
    netfilter: x_tables: fix pointer leaks to userspace

Vitaly Kuznetsov <vkuznets@redhat.com>
    x86/hyperv: Check for required priviliges in hyperv_init()

Andy Spencer <aspencer@spacex.com>
    gianfar: prevent integer wrapping in the rx handler

Logan Gunthorpe <logang@deltatee.com>
    ntb_transport: Fix bug with max_mw_size parameter

Leon Romanovsky <leonro@mellanox.com>
    RDMA/mlx5: Avoid memory leak in case of XRCD dealloc failure

Michael Bringmann <mwb@linux.vnet.ibm.com>
    powerpc/numa: Ensure nodes initialized for hotplug

Michael Bringmann <mwb@linux.vnet.ibm.com>
    powerpc/numa: Use ibm,max-associativity-domains to discover possible nodes

Mickaël Salaün <mic@digikod.net>
    samples/bpf: Partially fixes the bpf.o build

Jacob Keller <jacob.e.keller@intel.com>
    i40e: fix reported mask for ntuple filters

Jacob Keller <jacob.e.keller@intel.com>
    i40e: program fragmented IPv4 filter input set

Emil Tantilov <emil.s.tantilov@intel.com>
    ixgbe: don't set RXDCTL.RLPML for 82599

Jake Daryll Obina <jake.obina@gmail.com>
    jffs2: Fix use-after-free bug in jffs2_iget()'s error handling path

Jason Gunthorpe <jgg@mellanox.com>
    RDMA/uverbs: Use an unambiguous errno for method not supported

Corentin LABBE <clabbe.montjoie@gmail.com>
    crypto: artpec6 - remove select on non-existing CRYPTO_SHA384

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    device property: Define type of PROPERTY_ENRTY_*() macros

Aaron Sierra <asierra@xes-inc.com>
    tty: serial: exar: Relocate sleep wake-up handling

Vitaly Kuznetsov <vkuznets@redhat.com>
    x86/hyperv: Stop suppressing X86_FEATURE_PCID

Ngai-Mint Kwan <ngai-mint.kwan@intel.com>
    fm10k: fix "failed to kill vid" message for VF

Daniel Hua <daniel.hua@ni.com>
    igb: Clear TXSTMP when ptp_tx_work() is timeout

Corinna Vinschen <vinschen@redhat.com>
    igb: Allow to remove administratively set MAC on VFs

Jeffy Chen <jeffy.chen@rock-chips.com>
    ASoC: rockchip: Use dummy_dai for rt5514 dsp dailink

Eryu Guan <eguan@redhat.com>
    blk-mq-debugfs: don't allow write on attributes with seq_operations set

David Hildenbrand <david@redhat.com>
    KVM: s390: vsie: use READ_ONCE to access some SCB fields

David Herrmann <dh.herrmann@gmail.com>
    platform/x86: thinkpad_acpi: suppress warning about palm detection

Alan Brady <alan.brady@intel.com>
    i40evf: ignore link up if not running

Avinash Dayanand <avinash.dayanand@intel.com>
    i40evf: Don't schedule reset_task when device is being removed

Prashant Bhole <bhole_prashant_q7@lab.ntt.co.jp>
    bpf: test_maps: cleanup sockmaps when test ends

Goldwyn Rodrigues <rgoldwyn@suse.com>
    block: Set BIO_TRACE_COMPLETION on new bio during split

Wei Yongjun <weiyongjun1@huawei.com>
    nfp: fix error return code in nfp_pci_probe()

Dan Carpenter <dan.carpenter@oracle.com>
    HID: roccat: prevent an out of bounds read in kovaplus_profile_activated()

Andi Shyti <andi.shyti@samsung.com>
    Input: stmfts - set IRQ_NOAUTOEN to the irq flag

Arnd Bergmann <arnd@arndb.de>
    scsi: fas216: fix sense buffer initialization

Xose Vazquez Perez <xose.vazquez@gmail.com>
    scsi: devinfo: fix format of the device list

Sheng Yong <shengyong1@huawei.com>
    f2fs: avoid hungtask when GC encrypted block if io_bits is set

Parav Pandit <parav@mellanox.com>
    RDMA/cma: Check existence of netdevice during port validation

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: raid56: fix race between merge_bio and rbio_orig_end_io

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix unexpected EEXIST from btrfs_get_extent

Anand Jain <Anand.Jain@oracle.com>
    btrfs: fail mount when sb flag is not in BTRFS_SUPER_FLAG_SUPP

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix scrub to repair raid6 corruption

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix out of bounds access in btrfs_search_slot

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: set plug for fsync

Wei Yongjun <weiyongjun1@huawei.com>
    ipmi/powernv: Fix error return code in ipmi_powernv_probe()

weiyongjun (A) <weiyongjun1@huawei.com>
    mac80211_hwsim: fix possible memory leak in hwsim_new_radio_nl()

Ulf Magnusson <ulfalizer@gmail.com>
    kconfig: Fix expr_free() E_NOT leak

Ulf Magnusson <ulfalizer@gmail.com>
    kconfig: Fix automatic menu creation mem leak

Ulf Magnusson <ulfalizer@gmail.com>
    kconfig: Don't leak main menus during parsing

Guenter Roeck <linux@roeck-us.net>
    watchdog: sp5100_tco: Fix watchdog disable bit

Niklas Cassel <niklas.cassel@axis.com>
    PCI: Add dummy pci_irqd_intx_xlate() for CONFIG_PCI=n build

James Hogan <jhogan@kernel.org>
    MIPS: Fix clean of vmlinuz.{32,ecoff,bin,srec}

Jan Chochol <jan@chochol.info>
    nfs: Do not convert nfs_idmap_cache_timeout to jiffies

Sagi Grimberg <sagi@grimberg.me>
    IB/cq: Don't force IB_POLL_DIRECT poll context for ib_process_cq_direct

Maxime Chevallier <maxime.chevallier@smile.fr>
    spi: a3700: Clear DATA_OUT when performing a read

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    net: stmmac: dwmac-meson8b: propagate rate changes to the parent clock

Martin Blumenstingl <martin.blumenstingl@googlemail.com>
    net: stmmac: dwmac-meson8b: fix setting the RGMII TX clock on Meson8b

Geert Uytterhoeven <geert@linux-m68k.org>
    ubifs: Fix uninitialized variable in search_dh_cookie()

Ming Lei <ming.lei@redhat.com>
    blk-mq: turn WARN_ON in __blk_mq_run_hw_queue into printk

Ming Lei <ming.lei@redhat.com>
    dm mpath: return DM_MAPIO_REQUEUE on blk-mq rq allocation failure

mulhern <amulhern@redhat.com>
    dm thin: fix documentation relative to low water mark threshold

Peter Xu <peterx@redhat.com>
    iommu/vt-d: Use domain instead of cache fetching

Nicholas Piggin <npiggin@gmail.com>
    powerpc: System reset avoid interleaving oops using die synchronisation

Robin Murphy <robin.murphy@arm.com>
    iommu/exynos: Don't unconditionally steal bus ops

Thomas Richter <tmricht@linux.vnet.ibm.com>
    perf record: Fix failed memory allocation for get_cpuid_str

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tools lib traceevent: Fix get_field_str() for dynamic strings

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf callchain: Fix attr.sample_max_stack setting

Steven Rostedt (VMware) <rostedt@goodmis.org>
    tools lib traceevent: Simplify pointer print logic and fix %pF

Arnaldo Carvalho de Melo <acme@redhat.com>
    perf unwind: Do not look just at the global callchain_param.record_mode

himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix warning in qla2x00_async_iocb_timeout()

Shiraz Saleem <shiraz.saleem@intel.com>
    i40iw: Zero-out consumer key on allocate stag for FMR

Mustafa Ismail <mustafa.ismail@intel.com>
    i40iw: Free IEQ resources

Peter Hutterer <peter.hutterer@who-t.net>
    Input: synaptics - reset the ABS_X/Y fuzz after initializing MT axes

Jesper Dangaard Brouer <brouer@redhat.com>
    libbpf: Makefile set specified permission mode

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: psmouse - fix Synaptics detection when protocol is disabled

Alex Williamson <alex.williamson@redhat.com>
    PCI: Add function 1 DMA alias quirk for Marvell 9128

Masami Hiramatsu <mhiramat@kernel.org>
    selftest: ftrace: Fix to pick text symbols for kprobes

Chuck Lever <chuck.lever@oracle.com>
    xprtrdma: Fix backchannel allocation of extra rpcrdma_reps

Hans de Goede <hdegoede@redhat.com>
    platform/x86: dell-laptop: Filter out spurious keyboard backlight change events

Christian Borntraeger <borntraeger@de.ibm.com>
    KVM: s390: use created_vcpus in more places

Anna-Maria Gleixner <anna-maria@linutronix.de>
    tracing/hrtimer: Fix tracing bugs by taking all clock bases and modes into account

Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
    netfilter: ipv6: nf_defrag: Pass on packets to stack per RFC2460

Paul Mackerras <paulus@ozlabs.org>
    KVM: PPC: Book3S HV: Enable migration of decrementer register

Parav Pandit <parav@mellanox.com>
    RDMA/core: Clarify rdma_ah_find_type

Paolo Bonzini <pbonzini@redhat.com>
    kvm: x86: fix KVM_XEN_HVM_CONFIG ioctl

Dan Carpenter <dan.carpenter@oracle.com>
    ASoC: au1x: Fix timeout tests in au1xac97c_ac97_read()

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Use IS_REACHABLE() for dependency on input

Hans de Goede <hdegoede@redhat.com>
    ACPI / LPSS: Do not instiate platform_dev for devs without MMIO resources

NeilBrown <neilb@suse.com>
    NFSv4: always set NFS_LOCK_LOST when a lock is lost.

Peter Zijlstra <peterz@infradead.org>
    x86/tsc: Allow TSC calibration without PIT

Hector Martin <marcan@marcan.st>
    firewire-ohci: work around oversized DMA reads on JMicron controllers

Michael Neuling <mikey@neuling.org>
    powerpc/eeh: Fix race with driver un/bind

Merlijn Wajer <merlijn@wizzup.org>
    usb: musb: Fix external abort in musb_remove on omap2430

Merlijn Wajer <merlijn@wizzup.org>
    usb: musb: call pm_runtime_{get,put}_sync before reading vbus registers

Andreas Kemnade <andreas@kemnade.info>
    usb: musb: fix enumeration after resume

Imre Deak <imre.deak@intel.com>
    drm/i915/bxt, glk: Increase PCODE timeouts during CDCLK freq changing

Imre Deak <imre.deak@intel.com>
    drm/i915: Fix LSPCON TMDS output buffer enabling from low-power state

Xidong Wang <wangxidong_97@163.com>
    drm/i915: Do no use kfree() to free a kmem_cache_alloc() return value

Gaurav K Singh <gaurav.k.singh@intel.com>
    drm/i915/audio: Fix audio detection issue on GLK

Gerd Hoffmann <kraxel@redhat.com>
    drm/i915/gvt: throw error on unhandled vfio ioctls

Daniel J Blueman <daniel@quora.org>
    drm/vc4: Fix memory leak during BO teardown

Xiaoming Gao <gxm.linux.kernel@gmail.com>
    x86/tsc: Prevent 32bit truncation in calc_hpet_ref()

Anson Huang <Anson.Huang@nxp.com>
    clocksource/imx-tpm: Correct -ETIME return condition check

Dou Liyang <douly.fnst@cn.fujitsu.com>
    x86/acpi: Prevent X2APIC id 0xffffffff from being accounted

David Sterba <dsterba@suse.com>
    btrfs: fix unaligned access in readdir

Steve French <smfrench@gmail.com>
    cifs: do not allow creating sockets except with SMB1 posix exensions


-------------

Diffstat:

 Documentation/device-mapper/thin-provisioning.txt  |    8 +-
 Documentation/virtual/kvm/api.txt                  |    1 +
 Makefile                                           |    4 +-
 arch/arm64/include/asm/spinlock.h                  |    4 +-
 arch/mips/boot/compressed/Makefile                 |    6 +-
 arch/mips/generic/irq.c                            |   18 +-
 arch/mips/include/asm/machine.h                    |    2 +-
 arch/mips/txx9/rbtx4939/setup.c                    |    4 +-
 arch/powerpc/include/asm/book3s/64/pgalloc.h       |   10 +-
 arch/powerpc/include/uapi/asm/kvm.h                |    2 +
 arch/powerpc/kernel/eeh_driver.c                   |   65 +-
 arch/powerpc/kernel/traps.c                        |    2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |    8 +-
 arch/powerpc/kvm/book3s_hv.c                       |    8 +
 arch/powerpc/kvm/powerpc.c                         |    2 +-
 arch/powerpc/mm/numa.c                             |   78 +-
 arch/powerpc/platforms/powernv/opal-imc.c          |    6 +-
 arch/s390/include/asm/eadm.h                       |    2 +-
 arch/s390/kvm/kvm-s390.c                           |    4 +-
 arch/s390/kvm/vsie.c                               |   50 +-
 arch/sparc/include/asm/pgtable_64.h                |    2 +-
 arch/sparc/mm/tlb.c                                |   23 +-
 arch/x86/hyperv/hv_init.c                          |    9 +-
 arch/x86/hyperv/mmu.c                              |   12 +-
 arch/x86/include/asm/i8259.h                       |    5 +
 arch/x86/kernel/acpi/boot.c                        |    4 +
 arch/x86/kernel/apic/x2apic_uv_x.c                 |   15 +-
 arch/x86/kernel/dumpstack.c                        |    2 +-
 arch/x86/kernel/tsc.c                              |   20 +-
 arch/x86/kvm/mmu.c                                 |    2 +-
 arch/x86/kvm/vmx.c                                 |   16 +-
 arch/x86/kvm/x86.c                                 |   10 +-
 arch/x86/mm/init_64.c                              |    3 +-
 arch/x86/power/hibernate_32.c                      |    2 +-
 arch/x86/power/hibernate_64.c                      |    2 +-
 block/bio.c                                        |    2 +-
 block/blk-core.c                                   |    2 +
 block/blk-merge.c                                  |   29 +-
 block/blk-mq-debugfs.c                             |    6 +-
 block/blk-mq.c                                     |   22 +-
 drivers/acpi/acpi_lpss.c                           |    2 +
 drivers/acpi/bus.c                                 |    6 +
 drivers/acpi/ec.c                                  |    6 +
 drivers/acpi/processor_perflib.c                   |    2 +-
 drivers/acpi/scan.c                                |   20 +-
 drivers/base/power/domain.c                        |   76 +-
 drivers/base/power/wakeirq.c                       |    6 +-
 drivers/char/ipmi/ipmi_powernv.c                   |    5 +-
 drivers/clocksource/timer-imx-tpm.c                |    2 +-
 drivers/cpufreq/intel_pstate.c                     |    5 +
 drivers/crypto/Kconfig                             |    1 -
 drivers/firewire/ohci.c                            |    8 +-
 drivers/firmware/dmi_scan.c                        |   22 +-
 drivers/gpu/drm/drm_dp_dual_mode_helper.c          |   39 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                   |    2 +-
 drivers/gpu/drm/i915/i915_drv.h                    |    6 +-
 drivers/gpu/drm/i915/i915_gem_execbuffer.c         |    2 +-
 drivers/gpu/drm/i915/intel_audio.c                 |    2 +-
 drivers/gpu/drm/i915/intel_cdclk.c                 |   22 +-
 drivers/gpu/drm/i915/intel_pm.c                    |    6 +-
 .../drm/nouveau/nvkm/subdev/pmu/fuc/gf100.fuc3.h   |  746 +++++++--------
 .../drm/nouveau/nvkm/subdev/pmu/fuc/gk208.fuc5.h   |  802 ++++++++--------
 .../drm/nouveau/nvkm/subdev/pmu/fuc/gt215.fuc3.h   | 1006 ++++++++++----------
 .../gpu/drm/nouveau/nvkm/subdev/pmu/fuc/memx.fuc   |   30 +-
 drivers/gpu/drm/vc4/vc4_bo.c                       |    2 +
 drivers/gpu/drm/vc4/vc4_validate_shaders.c         |    1 +
 drivers/hid/hid-roccat-kovaplus.c                  |    2 +
 drivers/infiniband/core/cma.c                      |    8 +-
 drivers/infiniband/core/cq.c                       |   30 +-
 drivers/infiniband/core/uverbs_ioctl.c             |   19 +-
 drivers/infiniband/hw/hfi1/chip.c                  |   18 +-
 drivers/infiniband/hw/hfi1/file_ops.c              |    4 +-
 drivers/infiniband/hw/hfi1/hfi.h                   |    1 +
 drivers/infiniband/hw/hfi1/init.c                  |    4 +-
 drivers/infiniband/hw/i40iw/i40iw_puda.c           |    3 +-
 drivers/infiniband/hw/i40iw/i40iw_puda.h           |    1 +
 drivers/infiniband/hw/i40iw/i40iw_verbs.c          |    2 +
 drivers/infiniband/hw/mlx5/qp.c                    |    8 +-
 drivers/infiniband/ulp/ipoib/ipoib_main.c          |    3 +
 drivers/input/mouse/psmouse-base.c                 |   34 +-
 drivers/input/mouse/synaptics.c                    |   10 +
 drivers/input/touchscreen/stmfts.c                 |   11 +-
 drivers/iommu/exynos-iommu.c                       |    7 +
 drivers/iommu/intel-iommu.c                        |    3 +-
 drivers/irqchip/irq-gic-v3-its-pci-msi.c           |    2 +
 drivers/irqchip/irq-gic-v3-its-platform-msi.c      |    2 +
 drivers/irqchip/irq-gic-v3-its.c                   |    2 +
 drivers/irqchip/irq-gic-v3.c                       |    2 +-
 drivers/md/bcache/alloc.c                          |    4 +-
 drivers/md/bcache/bcache.h                         |    2 +-
 drivers/md/bcache/btree.c                          |    9 +-
 drivers/md/bcache/super.c                          |   23 +-
 drivers/md/bcache/sysfs.c                          |   11 +-
 drivers/md/bcache/writeback.c                      |    7 +-
 drivers/md/dm-mpath.c                              |   14 +-
 drivers/net/ethernet/freescale/gianfar.c           |    9 +-
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c    |   14 +-
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c     |   18 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c        |    3 +
 drivers/net/ethernet/intel/i40evf/i40evf.h         |    1 +
 drivers/net/ethernet/intel/i40evf/i40evf_main.c    |    9 +-
 .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |   35 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   42 +-
 drivers/net/ethernet/intel/igb/igb_ptp.c           |    9 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |    8 +-
 drivers/net/ethernet/netronome/nfp/nfp_main.c      |    1 +
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    |    6 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c  |    6 +-
 drivers/net/wireless/mac80211_hwsim.c              |   11 +-
 drivers/net/xen-netfront.c                         |   46 +-
 drivers/ntb/ntb_transport.c                        |    3 +
 drivers/pci/quirks.c                               |    2 +
 drivers/platform/x86/dell-laptop.c                 |   24 +-
 drivers/platform/x86/thinkpad_acpi.c               |   10 +
 drivers/scsi/arm/fas216.c                          |    2 +-
 drivers/scsi/qla2xxx/qla_init.c                    |    4 +
 drivers/scsi/scsi_devinfo.c                        |    7 +-
 drivers/spi/spi-armada-3700.c                      |    5 +
 .../staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c |    2 +
 drivers/tty/serial/8250/8250_exar.c                |   34 +-
 drivers/tty/serial/8250/8250_port.c                |   26 -
 drivers/usb/musb/musb_core.c                       |    7 +-
 drivers/watchdog/sp5100_tco.h                      |    2 +-
 drivers/xen/grant-table.c                          |    4 +-
 fs/btrfs/ctree.c                                   |   12 +-
 fs/btrfs/disk-io.c                                 |    6 +-
 fs/btrfs/file.c                                    |    9 +
 fs/btrfs/inode.c                                   |   37 +-
 fs/btrfs/raid56.c                                  |   55 +-
 fs/btrfs/volumes.c                                 |    9 +-
 fs/cifs/cifssmb.c                                  |    4 +-
 fs/cifs/dir.c                                      |    9 +-
 fs/dax.c                                           |    2 +-
 fs/f2fs/gc.c                                       |    7 +-
 fs/jffs2/fs.c                                      |    1 -
 fs/nfs/nfs4proc.c                                  |   12 +-
 fs/nfs/nfs4state.c                                 |    5 +-
 fs/nfs/nfs4sysctl.c                                |    2 +-
 fs/ocfs2/acl.c                                     |    6 +
 fs/ocfs2/journal.c                                 |   23 +-
 fs/ocfs2/super.c                                   |    5 +-
 fs/ocfs2/xattr.c                                   |    2 +
 fs/proc/base.c                                     |   29 +-
 fs/proc/kcore.c                                    |    4 +
 fs/ubifs/tnc.c                                     |   21 +-
 include/asm-generic/pgtable.h                      |   15 +
 include/linux/cpumask.h                            |    2 +
 include/linux/etherdevice.h                        |    2 +-
 include/linux/kcore.h                              |    1 +
 include/linux/netfilter/x_tables.h                 |    3 +-
 include/linux/pci.h                                |    7 +
 include/linux/property.h                           |   10 +-
 include/linux/suspend.h                            |    2 +
 include/rdma/ib_verbs.h                            |   23 +-
 include/trace/events/timer.h                       |   20 +-
 kernel/bpf/sockmap.c                               |   19 +-
 kernel/events/callchain.c                          |   21 +-
 kernel/events/core.c                               |    4 +-
 kernel/locking/qspinlock.c                         |    8 +
 kernel/power/power.h                               |    3 -
 kernel/time/alarmtimer.c                           |   34 +-
 lib/test_bpf.c                                     |   31 +-
 mm/fadvise.c                                       |   10 +-
 mm/khugepaged.c                                    |   12 +-
 mm/mempolicy.c                                     |   33 +-
 mm/vmscan.c                                        |   14 +-
 net/bridge/netfilter/ebtables.c                    |   10 +-
 net/ipv4/netfilter/arp_tables.c                    |   12 +-
 net/ipv4/netfilter/ip_tables.c                     |   10 +-
 net/ipv4/tcp_nv.c                                  |    2 +-
 net/ipv6/netfilter/ip6_tables.c                    |   12 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c            |   16 +-
 net/netfilter/x_tables.c                           |   51 +-
 net/netfilter/xt_IDLETIMER.c                       |    1 +
 net/netfilter/xt_LED.c                             |    1 +
 net/netfilter/xt_limit.c                           |    3 +-
 net/netfilter/xt_nfacct.c                          |    1 +
 net/netfilter/xt_statistic.c                       |    1 +
 net/openvswitch/conntrack.c                        |   34 +
 net/rds/ib.c                                       |    3 +-
 net/rxrpc/conn_event.c                             |    1 +
 net/rxrpc/rxkad.c                                  |   92 +-
 net/sunrpc/xprtrdma/backchannel.c                  |   12 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c                  |   12 +-
 net/sunrpc/xprtrdma/verbs.c                        |   32 +-
 net/sunrpc/xprtrdma/xprt_rdma.h                    |    2 +-
 net/sunrpc/xprtsock.c                              |    4 +-
 samples/bpf/Makefile                               |    5 +-
 scripts/kconfig/expr.c                             |    2 +-
 scripts/kconfig/menu.c                             |    1 +
 scripts/kconfig/zconf.y                            |   33 +-
 sound/pci/hda/Kconfig                              |    1 -
 sound/pci/hda/patch_realtek.c                      |    5 +
 sound/soc/au1x/ac97c.c                             |    6 +-
 sound/soc/rockchip/rk3399_gru_sound.c              |   19 +-
 tools/lib/bpf/Makefile                             |    2 +-
 tools/lib/bpf/libbpf.c                             |   26 +
 tools/lib/traceevent/event-parse.c                 |   17 +-
 tools/lib/traceevent/parse-filter.c                |   10 +-
 tools/perf/arch/x86/util/header.c                  |    2 +-
 tools/perf/builtin-c2c.c                           |    5 +-
 tools/perf/builtin-record.c                        |    3 +-
 tools/perf/builtin-report.c                        |    5 +-
 tools/perf/builtin-script.c                        |    5 +-
 tools/perf/perf.h                                  |    1 +
 tools/perf/tests/dwarf-unwind.c                    |    1 +
 .../perf/tests/shell/trace+probe_libc_inet_pton.sh |   21 +-
 tools/perf/util/callchain.c                        |   10 +
 tools/perf/util/callchain.h                        |    2 +
 tools/perf/util/evsel.c                            |   21 +-
 tools/perf/util/unwind-libunwind-local.c           |    9 +-
 tools/testing/selftests/bpf/test_maps.c            |   16 +-
 .../ftrace/test.d/ftrace/func-filter-glob.tc       |    6 +
 .../ftrace/test.d/kprobe/multiple_kprobes.tc       |    4 +-
 tools/testing/selftests/net/reuseport_bpf.c        |   21 +-
 virt/kvm/kvm_main.c                                |    7 +-
 216 files changed, 3025 insertions(+), 1982 deletions(-)
