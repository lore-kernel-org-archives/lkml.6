Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38361C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C5C21582
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lEBh6sj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0C5C21582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391073AbeKLIXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:23:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389297AbeKLIXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:23:33 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC1BE2241B;
        Sun, 11 Nov 2018 22:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975615;
        bh=UxvOd5dfWx0hfo+AqnVXqzW6Rnf8zkibcb2M2UYyZ88=;
        h=From:To:Cc:Subject:Date:From;
        b=lEBh6sj9ryCy20Ass78RBU1UmoncFxncfCAbR3QOhEtgTmTvXf+AWgFTi6pB4ZGc+
         v2iNH33jrSZ0m8udzoyqocrGP4HcZq/v8rENHyMW6Qo9zI1ye4QNA1Gbwc01Z/nc6X
         AMDoA2FFMwlpfrHKdqc3wGEh081xGtofB7M5Ox48=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.9 000/141] 4.9.137-stable review
Date:   Sun, 11 Nov 2018 14:24:19 -0800
Message-Id: <20181111221627.853046496@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.137-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.137-rc1
X-KernelTest-Deadline: 2018-11-13T22:16+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.9.137 release.
There are 141 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue Nov 13 22:15:38 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.137-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.9.137-rc1

Josef Bacik <jbacik@fb.com>
    btrfs: set max_extent_size properly

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix null pointer dereference on compressed write path error

Qu Wenruo <wqu@suse.com>
    btrfs: qgroup: Dirty all qgroups before rescan

Filipe Manana <fdmanana@suse.com>
    Btrfs: fix wrong dentries after fsync of file that got its parent replaced

Josef Bacik <josef@toxicpanda.com>
    btrfs: make sure we create all new block groups

Josef Bacik <jbacik@fb.com>
    btrfs: reset max_extent_size on clear in a bitmap

Josef Bacik <josef@toxicpanda.com>
    btrfs: wait on caching when putting the bg cache

Jeff Mahoney <jeffm@suse.com>
    btrfs: don't attempt to trim devices that don't support it

Jeff Mahoney <jeffm@suse.com>
    btrfs: iterate all devices during trim, instead of fs_devices::alloc_list

Jeff Mahoney <jeffm@suse.com>
    btrfs: fix error handling in free_log_tree

Qu Wenruo <wqu@suse.com>
    btrfs: locking: Add extra check in btrfs_init_new_buffer() to avoid deadlock

Qu Wenruo <wqu@suse.com>
    btrfs: Handle owner mismatch gracefully when walking up tree

Johan Hovold <johan@kernel.org>
    soc/tegra: pmc: Fix child-node lookup

Thor Thayer <thor.thayer@linux.intel.com>
    arm64: dts: stratix10: Correct System Manager register size

Nicolas Pitre <nicolas.pitre@linaro.org>
    Cramfs: fix abad comparison when wrap-arounds occur

Colin Ian King <colin.king@canonical.com>
    rpmsg: smd: fix memory leak on channel create

Tri Vo <trong@android.com>
    arm64: lse: remove -fcall-used-x0 flag

Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
    media: em28xx: make v4l2-compliance happier by starting sequence on zero

Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
    media: em28xx: fix input name for Terratec AV 350

Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
    media: tvp5150: avoid going past array on v4l2_querymenu()

Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
    media: em28xx: use a default format if TRY_FMT fails

Juergen Gross <jgross@suse.com>
    xen: fix xen_qlock_wait()

He Zhe <zhe.he@windriver.com>
    kgdboc: Passing ekgdboc to command line causes panic

Hans Verkuil <hverkuil@xs4all.nl>
    media: v4l2-tpg: fix kernel oops when enabling HFLIP and OSD

Maciej W. Rozycki <macro@linux-mips.org>
    TC: Set DMA masks for devices

Aaro Koskinen <aaro.koskinen@iki.fi>
    MIPS: OCTEON: fix out of bounds array access on CN68XX

Christophe Leroy <christophe.leroy@c-s.fr>
    powerpc/msi: Fix compile error on mpc83xx

Wenwen Wang <wang6495@umn.edu>
    dm ioctl: harden copy_params()'s copy_from_user() from malicious users

Amir Goldstein <amir73il@gmail.com>
    lockd: fix access beyond unterminated strings in prints

Trond Myklebust <trondmy@gmail.com>
    nfsd: Fix an Oops in free_session()

Trond Myklebust <trond.myklebust@hammerspace.com>
    NFSv4.1: Fix the r/wsize checking

Lukas Wunner <lukas@wunner.de>
    genirq: Fix race on spurious interrupt detection

He Zhe <zhe.he@windriver.com>
    printk: Fix panic caused by passing log_buf_len to command line

Steve French <stfrench@microsoft.com>
    smb3: on kerberos mount if server doesn't specify auth type use krb5

Steve French <stfrench@microsoft.com>
    smb3: do not attempt cifs operation in smb3 query info error path

Steve French <stfrench@microsoft.com>
    smb3: allow stats which track session and share reconnects to be reset

Andreas Kemnade <andreas@kemnade.info>
    w1: omap-hdq: fix missing bus unregister at removal

Eugen Hristev <eugen.hristev@microchip.com>
    iio: adc: at91: fix wrong channel number in triggered buffer mode

Eugen Hristev <eugen.hristev@microchip.com>
    iio: adc: at91: fix acking DRDY irq on simple conversions

Alexey Khoroshilov <khoroshilov@ispras.ru>
    iio: adc: imx25-gcq: Fix leak of device_node in mx25_gcq_setup_cfgs()

Lars-Peter Clausen <lars@metafoo.de>
    iio: ad5064: Fix regulator handling

Arnd Bergmann <arnd@arndb.de>
    kbuild: fix kernel/bounds.c 'W=1' warning

Mike Kravetz <mike.kravetz@oracle.com>
    hugetlbfs: dirty pages as they are added to pagecache

Eric Biggers <ebiggers@google.com>
    ima: fix showing large 'violations' or 'runtime_measurements_count'

Horia Geantă <horia.geanta@nxp.com>
    crypto: tcrypt - fix ghash-generic speed test

Ondrej Mosnacek <omosnace@redhat.com>
    crypto: lrw - Fix out-of bounds access on counter overflow

Eric W. Biederman <ebiederm@xmission.com>
    signal/GenWQE: Fix sending of SIGKILL

Bin Meng <bmeng.cn@gmail.com>
    PCI: Add Device IDs for Intel GPU "spurious interrupt" quirk

Qiuxu Zhuo <qiuxu.zhuo@intel.com>
    EDAC, skx_edac: Fix logical channel intermediate decoding

Tony Luck <tony.luck@intel.com>
    EDAC, {i7core,sb,skx}_edac: Fix uncorrected error counting

Breno Leitao <leitao@debian.org>
    HID: hiddev: fix potential Spectre v1

Wang Shilong <wshilong@ddn.com>
    ext4: propagate error from dquot_initialize() in EXT4_IOC_FSSETXATTR

Lukas Czerner <lczerner@redhat.com>
    ext4: initialize retries variable in ext4_da_write_inline_data_begin()

Al Viro <viro@zeniv.linux.org.uk>
    gfs2_meta: ->mount() can get NULL dev_name

Jan Kara <jack@suse.cz>
    jbd2: fix use after free in jbd2_log_do_checkpoint()

Takashi Iwai <tiwai@suse.de>
    ASoC: intel: skylake: Add missing break in skl_tplg_get_token()

Alexander Duyck <alexander.h.duyck@linux.intel.com>
    libnvdimm: Hold reference on parent while scheduling async init

Stefan Nuernberger <snu@amazon.com>
    net/ipv4: defensive cipso option parsing

Luca Coelho <luciano.coelho@intel.com>
    iwlwifi: mvm: check return value of rs_rate_from_ucode_rate()

Shuah Khan (Samsung OSG) <shuah@kernel.org>
    usbip:vudc: BUG kmalloc-2048 (Not tainted): Poison overwritten

Lubomir Rintel <lkundrak@v3.sk>
    libertas: don't set URB_ZERO_PACKET on IN USB transfer

Juergen Gross <jgross@suse.com>
    xen: make xen_qlock_wait() nestable

Juergen Gross <jgross@suse.com>
    xen: fix race in xen_qlock_wait()

Vasilis Liaskovitis <vliaskovitis@suse.com>
    xen/blkfront: avoid NULL blkfront_info dereference on device removal

Dr. Greg Wettstein <greg@wind.enjellic.com>
    tpm: Restore functionality to xen vtpm driver.

Joe Jin <joe.jin@oracle.com>
    xen-swiotlb: use actually allocated size on check physical continuous

Marek Szyprowski <m.szyprowski@samsung.com>
    ARM: dts: exynos: Mark 1 GHz CPU OPP as suspend OPP on Exynos5250

Marek Szyprowski <m.szyprowski@samsung.com>
    ARM: dts: exynos: Convert exynos5250.dtsi to opp-v2 bindings

Viresh Kumar <viresh.kumar@linaro.org>
    arm: dts: exynos: Add missing cooling device properties for CPUs

Viresh Kumar <viresh.kumar@linaro.org>
    ARM: dts: exynos: Remove "cooling-{min|max}-level" for CPU nodes

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Check the non-cached stream buffers more explicitly

Paul Cercueil <paul@crapouillou.net>
    dmaengine: dma-jz4780: Return error if not probed from DT

Eric W. Biederman <ebiederm@xmission.com>
    signal: Always deliver the kernel's SIGKILL and SIGSTOP to a pid namespace init

James Smart <jsmart2021@gmail.com>
    scsi: lpfc: Correct soft lockup when running mds diagnostics

Alexandre Belloni <alexandre.belloni@bootlin.com>
    uio: ensure class is registered before devices

Waiman Long <longman@redhat.com>
    driver/dma/ioat: Call del_timer_sync() without holding prep_lock

Loic Poulain <loic.poulain@linaro.org>
    usb: chipidea: Prevent unbalanced IRQ disable

Horia Geantă <horia.geanta@nxp.com>
    crypto: caam - fix implicit casts in endianness helpers

Suzuki K Poulose <suzuki.poulose@arm.com>
    coresight: etb10: Fix handling of perf mode

Tonghao Zhang <xiangxia.m.yue@gmail.com>
    PCI/MSI: Warn and return error if driver enables MSI/MSI-X twice

Shaohua Li <shli@fb.com>
    MD: fix invalid stored role for a disk

Theodore Ts'o <tytso@mit.edu>
    ext4: fix argument checking in EXT4_IOC_MOVE_EXT

Alexandre Belloni <alexandre.belloni@bootlin.com>
    usb: gadget: udc: atmel: handle at91sam9rl PMC

Jorgen Hansen <jhansen@vmware.com>
    VMCI: Resource wildcard match fixed

Javier Martinez Canillas <javierm@redhat.com>
    tpm: suppress transmit cmd error logs when TPM 1.2 is disabled/deactivated

Denis Drozdov <denisd@mellanox.com>
    IB/ipoib: Clear IPCB before icmp_send

Parav Pandit <parav@mellanox.com>
    RDMA/core: Do not expose unsupported counters

Wenwen Wang <wang6495@umn.edu>
    scsi: megaraid_sas: fix a missing-check bug

Finn Thain <fthain@telegraphics.com.au>
    scsi: esp_scsi: Track residual for PIO transfers

Michal Hocko <mhocko@suse.com>
    cgroup, netclassid: add a preemption point to write_classid

Martin Willi <martin@strongswan.org>
    ath10k: schedule hardware restart if WMI command times out

Sebastian Basierski <sebastianx.basierski@intel.com>
    ixgbevf: VF2VF TCP RSS

Douglas Anderson <dianders@chromium.org>
    pinctrl: ssbi-gpio: Fix pm8xxx_pin_config_get() to be compliant

Douglas Anderson <dianders@chromium.org>
    pinctrl: spmi-mpp: Fix pmic_mpp_config_get() to be compliant

Stephen Boyd <swboyd@chromium.org>
    pinctrl: qcom: spmi-mpp: Fix drive strength setting

Hans de Goede <hdegoede@redhat.com>
    ACPI / LPSS: Add alternative ACPI HIDs for Cherry Trail DMA controllers

Masami Hiramatsu <mhiramat@kernel.org>
    kprobes: Return error if we fail to reuse kprobe instead of BUG_ON()

Arend van Spriel <arend.vanspriel@broadcom.com>
    brcmfmac: fix for proper support of 160MHz bandwidth

YueHaibing <yuehaibing@huawei.com>
    pinctrl: qcom: spmi-mpp: Fix err handling of pmic_mpp_set_mux

Ben Hutchings <ben@decadent.org.uk>
    x86: boot: Fix EFI stub alignment

Christian Hewitt <christianshewitt@gmail.com>
    Bluetooth: btbcm: Add entry for BCM4335C0 UART bluetooth

Viresh Kumar <viresh.kumar@linaro.org>
    cpufreq: dt: Try freeing static OPPs only if we have added them

Lubomir Rintel <lkundrak@v3.sk>
    x86/olpc: Indicate that legacy PC XO-1 platform should not register RTC

Shaul Triebitz <shaul.triebitz@intel.com>
    iwlwifi: pcie: avoid empty free RB queue

Yu Zhao <yuzhao@google.com>
    mmc: sdhci-pci-o2micro: Add quirk for O2 Micro dev 0x8620 rev 0x01

Prarit Bhargava <prarit@redhat.com>
    cpupower: Fix coredump on VMWare

Sanskriti Sharma <sansharm@redhat.com>
    perf strbuf: Match va_{add,copy} with va_end

Sanskriti Sharma <sansharm@redhat.com>
    perf tools: Cleanup trace-event-info 'tdata' leak

Sanskriti Sharma <sansharm@redhat.com>
    perf tools: Free temporary 'sys' string in read_event_files()

Thierry Reding <treding@nvidia.com>
    hwmon: (pwm-fan) Set fan speed to 0 on suspend

Janosch Frank <frankja@linux.ibm.com>
    s390/sthyi: Fix machine name validity indication

Serhey Popovych <serhe.popovych@gmail.com>
    tun: Consistently configure generic netdev params via rtnetlink

Omar Sandoval <osandov@fb.com>
    swim: fix cleanup on setup error

Omar Sandoval <osandov@fb.com>
    ataflop: fix error handling during setup

Waiman Long <longman@redhat.com>
    locking/lockdep: Fix debug_locks off performance problem

Wolfram Sang <wsa+renesas@sang-engineering.com>
    i2c: rcar: cleanup DMA for all kinds of failure

Masami Hiramatsu <mhiramat@kernel.org>
    selftests: ftrace: Add synthetic event syntax testcase

Nathan Chancellor <natechancellor@gmail.com>
    net: qla3xxx: Remove overflowing shift statement

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    x86/fpu: Remove second definition of fpu in __fpu__restore_sig()

David Miller <davem@davemloft.net>
    perf cpu_map: Align cpu map synthesized events properly.

Song Muchun <smuchun@gmail.com>
    sched/fair: Fix the min_vruntime update logic in dequeue_entity()

David S. Miller <davem@davemloft.net>
    sparc64: Make proc_id signed.

David S. Miller <davem@davemloft.net>
    sparc: Fix single-pcr perf event counter management.

Florian Westphal <fw@strlen.de>
    xfrm: policy: use hlist rcu variants on insert

Jiri Olsa <jolsa@kernel.org>
    Revert "perf tools: Fix PMU term format max value calculation"

Eric Dumazet <edumazet@google.com>
    bpf: do not blindly change rlimit in reuseport net selftest

Sai Praneeth <sai.praneeth.prakhya@intel.com>
    x86/speculation: Support Enhanced IBRS on future CPUs

He Zhe <zhe.he@windriver.com>
    x86/corruption-check: Fix panic in memory_corruption_check() when boot option without value is provided

Jiri Kosina <jkosina@suse.cz>
    x86/speculation: Enable cross-hyperthread spectre v2 STIBP mitigation

Alex Stanoev <alex@astanoev.com>
    ALSA: ca0106: Disable IZD on SB0570 DAC to fix audio pops

Jeremy Cline <jcline@redhat.com>
    ALSA: hda - Add mic quirk for the Lenovo G50-30 (17aa:3905)

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Fix headphone pin config for ASUS G751

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Add quirk for ASUS G751 laptop

Helge Deller <deller@gmx.de>
    parisc: Fix map_pages() to not overwrite existing pte entries

John David Anglin <dave.anglin@bell.net>
    parisc: Fix address in HPMC IVA

Jan Glauber <jglauber@cavium.com>
    ipmi: Fix timer race with module unload

Erik Schmauss <erik.schmauss@intel.com>
    ACPICA: AML interpreter: add region addresses in global list during initialization

Maciej S. Szmigiero <mail@maciej.szmigiero.name>
    pcmcia: Implement CLKRUN protocol disabling for Ricoh bridges

Hou Tao <houtao1@huawei.com>
    jffs2: free jffs2_sb_info through jffs2_kill_sb()

Dmitry Bazhenov <bazhenov.dn@gmail.com>
    hwmon: (pmbus) Fix page count auto-detection.

Tang Junhui <tang.junhui.linux@gmail.com>
    bcache: fix miss key refill->end in writeback


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/exynos3250.dtsi                  |  16 +++
 arch/arm/boot/dts/exynos4210.dtsi                  |  15 ++-
 arch/arm/boot/dts/exynos4412.dtsi                  |   2 -
 arch/arm/boot/dts/exynos5250.dtsi                  | 116 ++++++++++++++++-----
 arch/arm/boot/dts/exynos5420-cpus.dtsi             |  16 ---
 arch/arm/boot/dts/exynos5422-cpus.dtsi             |  16 ---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   2 +-
 arch/arm64/lib/Makefile                            |   2 +-
 arch/mips/cavium-octeon/executive/cvmx-helper.c    |   2 +-
 arch/parisc/kernel/entry.S                         |   2 +-
 arch/parisc/kernel/traps.c                         |   3 +-
 arch/parisc/mm/init.c                              |   8 +-
 arch/powerpc/include/asm/mpic.h                    |   7 ++
 arch/s390/kvm/sthyi.c                              |   8 +-
 arch/sparc/include/asm/cpudata_64.h                |   2 +-
 arch/sparc/kernel/perf_event.c                     |  17 ++-
 arch/x86/boot/tools/build.c                        |   7 ++
 arch/x86/include/asm/cpufeatures.h                 |   1 +
 arch/x86/include/asm/nospec-branch.h               |   1 +
 arch/x86/kernel/check.c                            |  15 +++
 arch/x86/kernel/cpu/bugs.c                         |  77 ++++++++++++--
 arch/x86/kernel/cpu/common.c                       |   3 +
 arch/x86/kernel/fpu/signal.c                       |   1 -
 arch/x86/platform/olpc/olpc-xo1-rtc.c              |   3 +
 arch/x86/xen/spinlock.c                            |  35 +++----
 crypto/lrw.c                                       |   7 +-
 crypto/tcrypt.c                                    |   3 +
 drivers/acpi/acpi_lpss.c                           |   2 +
 drivers/acpi/acpica/dsopcode.c                     |   4 +
 drivers/block/ataflop.c                            |  25 +++--
 drivers/block/swim.c                               |  13 ++-
 drivers/block/xen-blkfront.c                       |   3 +
 drivers/bluetooth/btbcm.c                          |   1 +
 drivers/char/ipmi/ipmi_ssif.c                      |  10 +-
 drivers/char/tpm/tpm-interface.c                   |   3 +-
 drivers/char/tpm/xen-tpmfront.c                    |   2 +-
 drivers/cpufreq/cpufreq-dt.c                       |  34 +++---
 drivers/crypto/caam/regs.h                         |  28 ++---
 drivers/dma/dma-jz4780.c                           |   5 +
 drivers/dma/ioat/init.c                            |   9 +-
 drivers/edac/i7core_edac.c                         |   1 +
 drivers/edac/sb_edac.c                             |   1 +
 drivers/edac/skx_edac.c                            |   3 +-
 drivers/hid/usbhid/hiddev.c                        |  18 +++-
 drivers/hwmon/pmbus/pmbus.c                        |   2 +
 drivers/hwmon/pmbus/pmbus_core.c                   |   5 +-
 drivers/hwmon/pwm-fan.c                            |  12 ++-
 drivers/hwtracing/coresight/coresight-etb10.c      |   4 +
 drivers/i2c/busses/i2c-rcar.c                      |   6 +-
 drivers/iio/adc/at91_adc.c                         |   6 +-
 drivers/iio/adc/fsl-imx25-gcq.c                    |   6 ++
 drivers/iio/dac/ad5064.c                           |  53 +++++++---
 drivers/infiniband/core/sysfs.c                    |  19 ++--
 drivers/infiniband/ulp/ipoib/ipoib_cm.c            |   8 +-
 drivers/md/bcache/btree.c                          |   2 +-
 drivers/md/dm-ioctl.c                              |  18 ++--
 drivers/md/md.c                                    |   4 +
 drivers/media/common/v4l2-tpg/v4l2-tpg-core.c      |   2 +-
 drivers/media/i2c/tvp5150.c                        |   2 +-
 drivers/media/usb/em28xx/em28xx-cards.c            |   4 +-
 drivers/media/usb/em28xx/em28xx-video.c            |   8 +-
 drivers/misc/genwqe/card_base.h                    |   2 +-
 drivers/misc/genwqe/card_dev.c                     |   9 +-
 drivers/misc/vmw_vmci/vmci_driver.c                |   2 +-
 drivers/misc/vmw_vmci/vmci_resource.c              |   3 +-
 drivers/mmc/host/sdhci-pci-o2micro.c               |   3 +
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c  |   4 +
 drivers/net/ethernet/qlogic/qla3xxx.c              |   2 -
 drivers/net/tun.c                                  |   2 +
 drivers/net/wireless/ath/ath10k/wmi.c              |   6 ++
 .../net/wireless/broadcom/brcm80211/brcmutil/d11.c |  34 +++++-
 .../broadcom/brcm80211/include/brcmu_wifi.h        |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c        |  24 ++++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |  32 ++++--
 drivers/net/wireless/marvell/libertas/if_usb.c     |   2 -
 drivers/nvdimm/bus.c                               |   4 +
 drivers/pci/msi.c                                  |   9 +-
 drivers/pci/quirks.c                               |   4 +
 drivers/pcmcia/ricoh.h                             |  35 +++++++
 drivers/pcmcia/yenta_socket.c                      |   3 +-
 drivers/pinctrl/qcom/pinctrl-spmi-mpp.c            |  27 +++--
 drivers/pinctrl/qcom/pinctrl-ssbi-gpio.c           |  28 +++--
 drivers/rpmsg/qcom_smd.c                           |   7 +-
 drivers/scsi/esp_scsi.c                            |   1 +
 drivers/scsi/esp_scsi.h                            |   2 +
 drivers/scsi/lpfc/lpfc_sli.c                       |   7 ++
 drivers/scsi/mac_esp.c                             |   2 +
 drivers/scsi/megaraid/megaraid_sas_base.c          |   3 +
 drivers/soc/tegra/pmc.c                            |   2 +-
 drivers/tc/tc.c                                    |   8 +-
 drivers/tty/serial/kgdboc.c                        |   5 +
 drivers/uio/uio.c                                  |   9 ++
 drivers/usb/chipidea/otg.h                         |   3 +-
 drivers/usb/gadget/udc/atmel_usba_udc.c            |   2 +
 drivers/usb/usbip/vudc_main.c                      |  10 +-
 drivers/w1/masters/omap_hdq.c                      |   2 +
 drivers/xen/swiotlb-xen.c                          |   6 ++
 fs/btrfs/extent-tree.c                             |  47 +++++++--
 fs/btrfs/free-space-cache.c                        |  32 ++++--
 fs/btrfs/inode.c                                   |   1 +
 fs/btrfs/qgroup.c                                  |   1 +
 fs/btrfs/relocation.c                              |   2 +-
 fs/btrfs/tree-log.c                                |  39 +++++--
 fs/cifs/cifs_debug.c                               |   3 +
 fs/cifs/cifs_spnego.c                              |   6 +-
 fs/cifs/inode.c                                    |  10 +-
 fs/cramfs/inode.c                                  |   3 +-
 fs/ext4/inline.c                                   |   2 +-
 fs/ext4/ioctl.c                                    |   4 +-
 fs/ext4/move_extent.c                              |   8 +-
 fs/gfs2/ops_fstype.c                               |   3 +
 fs/jbd2/checkpoint.c                               |   4 +-
 fs/jffs2/super.c                                   |   4 +-
 fs/lockd/host.c                                    |   2 +-
 fs/nfs/nfs4client.c                                |  16 +--
 include/linux/tc.h                                 |   1 +
 kernel/bounds.c                                    |   4 +-
 kernel/cpu.c                                       |  11 +-
 kernel/irq/manage.c                                |   8 +-
 kernel/kprobes.c                                   |  27 +++--
 kernel/locking/lockdep.c                           |   4 +-
 kernel/printk/printk.c                             |   7 +-
 kernel/sched/fair.c                                |   2 +-
 kernel/signal.c                                    |   2 +-
 lib/debug_locks.c                                  |   2 +-
 mm/hugetlb.c                                       |   6 ++
 net/core/netclassid_cgroup.c                       |   1 +
 net/ipv4/cipso_ipv4.c                              |  11 +-
 net/sunrpc/svc_xprt.c                              |   2 +-
 net/xfrm/xfrm_policy.c                             |   8 +-
 security/integrity/ima/ima_fs.c                    |   6 +-
 sound/pci/ca0106/ca0106.h                          |   2 +-
 sound/pci/hda/hda_controller.h                     |   1 +
 sound/pci/hda/hda_intel.c                          |  11 +-
 sound/pci/hda/patch_conexant.c                     |   1 +
 sound/pci/hda/patch_realtek.c                      |  20 ++++
 sound/soc/intel/skylake/skl-topology.c             |   1 +
 tools/perf/util/event.c                            |   1 +
 tools/perf/util/pmu.c                              |  13 +--
 tools/perf/util/strbuf.c                           |  10 +-
 tools/perf/util/trace-event-info.c                 |   2 +
 tools/perf/util/trace-event-read.c                 |   5 +-
 tools/power/cpupower/utils/cpufreq-info.c          |   2 +
 tools/power/cpupower/utils/helpers/amd.c           |   5 +
 .../inter-event/trigger-synthetic-event-syntax.tc  |  80 ++++++++++++++
 tools/testing/selftests/net/reuseport_bpf.c        |  13 ++-
 147 files changed, 1116 insertions(+), 360 deletions(-)


