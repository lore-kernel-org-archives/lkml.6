Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB94C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A9F21477
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wywsdD0V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A9F21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbeJKXEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbeJKXEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:04:33 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E782098A;
        Thu, 11 Oct 2018 15:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272209;
        bh=cTuW1AgOP2jddEweMOTx2LIVnlwJa2bzqXauWpIhA9Y=;
        h=From:To:Cc:Subject:Date:From;
        b=wywsdD0VO8ltJ5Dn3o2trVnJv1Sx+uPfKSCIV4xkmT28fNs60lpF35PVo+Mo1hSbp
         uSZ1IY+NOoBVG3Bwp1T6wRzL8o3jvH7LhD8hDcZQL+q0EZe9GiaV2H/ofho9i+rtmp
         xRjUcqlSvAdZvWhpOXIEMQSWjlzznRgO+e0Krx8E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 000/120] 3.18.124-stable review
Date:   Thu, 11 Oct 2018 17:33:01 +0200
Message-Id: <20181011152549.500488630@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.124-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.124-rc1
X-KernelTest-Deadline: 2018-10-13T15:25+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.18.124 release.
There are 120 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Oct 13 15:25:29 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.124-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.124-rc1

Gao Feng <gfree.wind@vip.163.com>
    ebtables: arpreply: Add the standard target sanity check

Richard Weinberger <richard@nod.at>
    ubifs: Check for name being NULL while mounting

Prateek Sood <prsood@codeaurora.org>
    cgroup: Fix deadlock in cpu hotplug path

Theodore Ts'o <tytso@mit.edu>
    ext4: avoid running out of journal credits when appending to an inline file

Theodore Ts'o <tytso@mit.edu>
    jbd2: don't mark block as modified if the handle is out of credits

Theodore Ts'o <tytso@mit.edu>
    ext4: add more inode number paranoia checks

Theodore Ts'o <tytso@mit.edu>
    ext4: never move the system.data xattr out of the inode body

Theodore Ts'o <tytso@mit.edu>
    ext4: always verify the magic number in xattr blocks

Theodore Ts'o <tytso@mit.edu>
    ext4: add corruption check in ext4_xattr_set_entry()

Theodore Ts'o <tytso@mit.edu>
    ext4: fix false negatives *and* false positives in ext4_check_descriptors()

Theodore Ts'o <tytso@mit.edu>
    ext4: always check block group bounds in ext4_init_block_bitmap()

Theodore Ts'o <tytso@mit.edu>
    ext4: fix check to prevent initializing reserved inodes

Theodore Ts'o <tytso@mit.edu>
    ext4: only look at the bg_flags field if it is valid

Johan Hovold <johan@kernel.org>
    USB: serial: simple: add Motorola Tetra MTP6550 id

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PM / core: Clear the direct_complete flag on errors

Felix Fietkau <nbd@nbd.name>
    mac80211: fix setting IEEE80211_KEY_FLAG_RX_MGMT for AP mode keys

Daniel Drake <drake@endlessm.com>
    PCI: Reprogram bridge prefetch registers on resume

Andy Lutomirski <luto@kernel.org>
    x86/vdso: Fix vDSO syscall fallback asm constraint regression

Andy Lutomirski <luto@kernel.org>
    x86/vdso: Fix asm constraints on vDSO syscall fallbacks

Tomi Valkeinen <tomi.valkeinen@ti.com>
    fbdev/omapfb: fix omapfb_memory_read infoleak

Jann Horn <jannh@google.com>
    proc: restrict kernel stack dumps to root

Linus Torvalds <torvalds@linux-foundation.org>
    Make file credentials available to the seqfile interfaces

Mike Snitzer <snitzer@redhat.com>
    dm thin metadata: fix __udivdi3 undefined on 32-bit

Ashish Samant <ashish.samant@oracle.com>
    ocfs2: fix locking for res->tracking and dlm->tracking_list

Leonard Crestez <leonard.crestez@nxp.com>
    crypto: mxs-dcp - Fix wait logic on chan threads

Aurelien Aptel <aaptel@suse.com>
    smb2: fix missing files in root share directory listing

Josh Abraham <j.abraham1776@gmail.com>
    xen: fix GCC warning and remove duplicate EVTCHN_ROW/EVTCHN_COL usage

Vitaly Kuznetsov <vkuznets@redhat.com>
    xen/manage: don't complain about an empty value in control/sysrq node

Dan Carpenter <dan.carpenter@oracle.com>
    cifs: read overflow in is_valid_oplock_break()

Julian Wiedmann <jwi@linux.ibm.com>
    s390/qeth: don't dump past end of unknown HW header

Kai-Heng Feng <kai.heng.feng@canonical.com>
    r8169: Clear RTL_FLAG_TASK_*_PENDING when clearing RTL_FLAG_TASK_ENABLED

Randy Dunlap <rdunlap@infradead.org>
    hexagon: modify ffs() and fls() to return int

Randy Dunlap <rdunlap@infradead.org>
    arch/hexagon: fix kernel/dma.c build warning

Joe Thornber <ejt@redhat.com>
    dm thin metadata: try to avoid ever aborting transactions

Stephen Rothwell <sfr@canb.auug.org.au>
    fs/cifs: suppress a string overflow warning

Ben Hutchings <ben.hutchings@codethink.co.uk>
    USB: yurex: Check for truncation in yurex_read()

Jann Horn <jannh@google.com>
    RDMA/ucma: check fd type in ucma_migrate_id()

Daniel Black <daniel@linux.ibm.com>
    mm: madvise(MADV_DODUMP): allow hugetlbfs pages

Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
    tools/vm/page-types.c: fix "defined but not used" warning

Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
    tools/vm/slabinfo.c: fix sign-compare warning

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    mac80211: shorten the IBSS debug messages

Ilan Peer <ilan.peer@intel.com>
    mac80211: Fix station bandwidth setting after channel switch

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    mac80211: fix a race between restart and CSA flows

Jon Kuhn <jkuhn@barracuda.com>
    fs/cifs: don't translate SFM_SLASH (U+F026) to backslash

Jia-Ju Bai <baijiaju1990@gmail.com>
    net: cadence: Fix a sleep-in-atomic-context bug in macb_halt_tx()

Xiao Ni <xni@redhat.com>
    RAID10 BUG_ON in raise_barrier when force is true and conf->barrier is 0

Arunk Khandavalli <akhandav@codeaurora.org>
    cfg80211: nl80211_update_ft_ies() to validate NL80211_ATTR_IE

Michael Hennerich <michael.hennerich@analog.com>
    gpio: adp5588: Fix sleep-in-atomic-context bug

Danek Duvall <duvall@comfychair.org>
    mac80211: correct use of IEEE80211_VHT_CAP_RXSTBC_X

Paul Mackerras <paulus@ozlabs.org>
    KVM: PPC: Book3S HV: Don't truncate HPTE index in xlate function

Sakari Ailus <sakari.ailus@linux.intel.com>
    media: v4l: event: Prevent freeing event subscriptions while accessed

Marc Zyngier <marc.zyngier@arm.com>
    arm64: KVM: Sanitize PSTATE.M when being set from userspace

Dan Carpenter <dan.carpenter@oracle.com>
    hwmon: (adt7475) Make adt7475_read_word() return errors

Bo Chen <chenbo@pdx.edu>
    e1000: ensure to free old tx/rx rings in set_ringparam()

Bo Chen <chenbo@pdx.edu>
    e1000: check on netif_running() before calling e1000_up()

Anson Huang <Anson.Huang@nxp.com>
    thermal: of-thermal: disable passive polling when thermal zone is disabled

Theodore Ts'o <tytso@mit.edu>
    ext4: verify the depth of extent tree in ext4_find_extent()

Dave Martin <Dave.Martin@arm.com>
    arm64: KVM: Tighten guest core register access from userspace

Greg Hackmann <ghackmann@android.com>
    staging: android: ion: fix ION_IOC_{MAP,SHARE} use-after-free

Vincent Pelletier <plr.vincent@gmail.com>
    scsi: target: iscsi: Use bin2hex instead of a re-implementation

Alan Stern <stern@rowland.harvard.edu>
    USB: remove LPM management from usb_driver_claim_interface()

Sebastian Andrzej Siewior <bigeasy@linutronix.de>
    Revert "usb: cdc-wdm: Fix a sleep-in-atomic-context bug in service_outstanding_interrupt()"

Oliver Neukum <oneukum@suse.com>
    USB: usbdevfs: restore warning for nonsensical flags

Oliver Neukum <oneukum@suse.com>
    USB: usbdevfs: sanitize flags more

ming_qian <ming_qian@realsil.com.cn>
    media: uvcvideo: Support realtek's UVC 1.5 device

Alexey Dobriyan <adobriyan@gmail.com>
    slub: make ->cpu_partial unsigned int

Alan Stern <stern@rowland.harvard.edu>
    USB: handle NULL config in usb_find_alt_setting()

Alan Stern <stern@rowland.harvard.edu>
    USB: fix error handling in usb_driver_claim_interface()

Geert Uytterhoeven <geert+renesas@glider.be>
    spi: rspi: Fix interrupted DMA transfers

Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
    spi: sh-msiof: Fix handling of write value for SISTR register

Marcel Ziswiler <marcel.ziswiler@toradex.com>
    spi: tegra20-slink: explicitly enable/disable clock

Christophe Leroy <christophe.leroy@c-s.fr>
    serial: cpm_uart: return immediately from console poll

Andy Whitcroft <apw@canonical.com>
    floppy: Do not copy a kernel pointer to user memory in FDGETPRM ioctl

J. Bruce Fields <bfields@redhat.com>
    nfsd: fix corrupted reply to badly ordered compound

Jessica Yu <jeyu@kernel.org>
    module: exclude SHN_UNDEF symbols from kallsyms api

Liam Girdwood <liam.r.girdwood@linux.intel.com>
    ASoC: dapm: Fix potential DAI widget pointer deref when linking DAIs

Zhouyang Jia <jiazhouyang09@gmail.com>
    scsi: bnx2i: add error handling for ioremap_nocache

Zhouyang Jia <jiazhouyang09@gmail.com>
    HID: hid-ntrig: add error handling for sysfs_create_group

Ethan Tuttle <ethan@ethantuttle.com>
    ARM: mvebu: declare asm symbols as character arrays in pmsu.c

Tony Lindgren <tony@atomide.com>
    wlcore: Add missing PM call for wlcore_cmd_wait_for_event_or_timeout()

Dan Carpenter <dan.carpenter@oracle.com>
    rndis_wlan: potential buffer overflow in rndis_wlan_auth_indication()

Kai-Heng Feng <kai.heng.feng@canonical.com>
    ALSA: hda: Add AZX_DCAPS_PM_RUNTIME for AMD Raven Ridge

Zhouyang Jia <jiazhouyang09@gmail.com>
    media: tm6000: add error handling for dvb_register_adapter

Zhouyang Jia <jiazhouyang09@gmail.com>
    drivers/tty: add error handling for pcmcia_loop_config

Alistair Strachan <astrachan@google.com>
    staging: android: ashmem: Fix mmap size validation

Akinobu Mita <akinobu.mita@gmail.com>
    media: soc_camera: ov772x: correct setting of banding filter

Akinobu Mita <akinobu.mita@gmail.com>
    media: s3c-camif: ignore -ENOIOCTLCMD from v4l2_subdev_call for s_power

Nicholas Mc Guire <hofrat@osadl.org>
    ALSA: snd-aoa: add of_node_put() in error path

Vasily Gorbik <gor@linux.ibm.com>
    s390/extmem: fix gcc 8 stringop-overflow warning

Thomas Gleixner <tglx@linutronix.de>
    alarmtimer: Prevent overflow for relative nanosleep

Julia Lawall <Julia.Lawall@lip6.fr>
    usb: wusbcore: security: cast sizeof to int for comparison

Breno Leitao <leitao@debian.org>
    scsi: ibmvscsi: Improve strings handling

Bart Van Assche <bart.vanassche@wdc.com>
    scsi: target/iscsi: Make iscsit_ta_authentication() respect the output buffer size

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    x86/tsc: Add missing header to tsc_msr.c

Hari Bathini <hbathini@linux.ibm.com>
    powerpc/kdump: Handle crashkernel memory reservation failure

Sylwester Nawrocki <s.nawrocki@samsung.com>
    media: exynos4-is: Prevent NULL pointer dereference in __isp_video_try_fmt()

Johan Hovold <johan@kernel.org>
    USB: serial: kobil_sct: fix modem-status error handling

Anton Vasilyev <vasilyev@ispras.ru>
    uwb: hwa-rc: fix memory leak at probe

Dan Williams <dan.j.williams@intel.com>
    x86/numa_emulation: Fix emulated-to-physical node mapping

Matt Ranostay <matt.ranostay@konsulko.com>
    tsl2550: fix lux1_input error in low light

Stafford Horne <shorne@gmail.com>
    crypto: skcipher - Fix -Wstringop-truncation warnings

Roderick Colenbrander <roderick.colenbrander@sony.com>
    HID: sony: Support DS4 dongle

Roderick Colenbrander <roderick.colenbrander@sony.com>
    HID: sony: Update device ids

Catalin Marinas <catalin.marinas@arm.com>
    arm64: Add trace_hardirqs_off annotation in ret_to_user

Li Dongyang <dongyangli@ddn.com>
    ext4: don't mark mmp buffer head dirty

Theodore Ts'o <tytso@mit.edu>
    ext4: fix online resize's handling of a too-small final block group

Theodore Ts'o <tytso@mit.edu>
    ext4: recalucate superblock checksum after updating free blocks/inodes

Theodore Ts'o <tytso@mit.edu>
    ext4: avoid divide by zero fault when deleting corrupted inline directories

Junxiao Bi <junxiao.bi@oracle.com>
    ocfs2: fix ocfs2 read block panic

Vincent Pelletier <plr.vincent@gmail.com>
    scsi: target: iscsi: Use hex2bin instead of a re-implementation

Eric Dumazet <edumazet@google.com>
    ipv6: fix possible use-after-free in ip6_xmit()

Vasily Khoruzhick <vasilykh@arista.com>
    neighbour: confirm neigh entries when ARP packet is received

Colin Ian King <colin.king@canonical.com>
    net: hp100: fix always-true check for link up state

Willy Tarreau <w@1wt.eu>
    net/appletalk: fix minor pointer leak to userspace in SIOCFINDIPDDPRT

Toke Høiland-Jørgensen <toke@toke.dk>
    gso_segment: Reset skb->mac_len after modifying network header

Joel Fernandes (Google) <joel@joelfernandes.org>
    mm: shmem.c: Correctly annotate new inodes for lockdep

Vaibhav Nagarnaik <vnagarnaik@google.com>
    ring-buffer: Allow for rescheduling when removing pages

Willy Tarreau <w@1wt.eu>
    ALSA: emu10k1: fix possible info leak to userspace on SNDRV_EMU10K1_IOCTL_INFO

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: bebob: use address returned by kmalloc() instead of kernel stack for streaming DMA mapping

Sébastien Szymanski <sebastien.szymanski@armadeus.com>
    ASoC: cs4265: fix MMTLR Data switch control


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm/mach-mvebu/pmsu.c                         |  6 +-
 arch/arm64/include/asm/kvm_emulate.h               |  5 ++
 arch/arm64/kernel/entry.S                          |  3 +
 arch/arm64/kvm/guest.c                             | 55 +++++++++++++++-
 arch/hexagon/include/asm/bitops.h                  |  4 +-
 arch/hexagon/kernel/dma.c                          |  2 +-
 arch/powerpc/kernel/machine_kexec.c                |  7 ++-
 arch/powerpc/kvm/book3s_64_mmu_hv.c                |  2 +-
 arch/s390/mm/extmem.c                              |  4 +-
 arch/x86/kernel/tsc_msr.c                          |  1 +
 arch/x86/mm/numa_emulation.c                       |  2 +-
 arch/x86/vdso/vclock_gettime.c                     | 26 ++++----
 crypto/ablkcipher.c                                |  2 +
 crypto/blkcipher.c                                 |  1 +
 drivers/base/power/main.c                          |  5 +-
 drivers/block/floppy.c                             |  3 +
 drivers/crypto/mxs-dcp.c                           | 53 +++++++++-------
 drivers/gpio/gpio-adp5588.c                        | 24 +++++--
 drivers/hid/hid-core.c                             |  3 +
 drivers/hid/hid-ids.h                              |  2 +
 drivers/hid/hid-ntrig.c                            |  2 +
 drivers/hid/hid-sony.c                             |  6 ++
 drivers/hwmon/adt7475.c                            | 14 +++--
 drivers/infiniband/core/ucma.c                     |  6 ++
 drivers/md/dm-thin-metadata.c                      | 34 +++++++++-
 drivers/md/dm-thin.c                               | 73 +++++++++++++++++++---
 drivers/md/raid10.c                                |  5 +-
 drivers/media/i2c/soc_camera/ov772x.c              |  2 +-
 drivers/media/platform/exynos4-is/fimc-isp-video.c | 11 +++-
 drivers/media/platform/s3c-camif/camif-capture.c   |  2 +
 drivers/media/usb/tm6000/tm6000-dvb.c              |  5 ++
 drivers/media/usb/uvc/uvc_video.c                  | 24 +++++--
 drivers/media/v4l2-core/v4l2-event.c               | 37 +++++------
 drivers/media/v4l2-core/v4l2-fh.c                  |  2 +
 drivers/misc/tsl2550.c                             |  2 +-
 drivers/net/appletalk/ipddp.c                      |  8 ++-
 drivers/net/ethernet/cadence/macb.c                |  2 +-
 drivers/net/ethernet/hp/hp100.c                    |  2 +-
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c   |  7 ++-
 drivers/net/ethernet/realtek/r8169.c               |  9 ++-
 drivers/net/wireless/rndis_wlan.c                  |  2 +
 drivers/net/wireless/ti/wlcore/cmd.c               |  6 ++
 drivers/pci/pci.c                                  | 27 +++++---
 drivers/s390/net/qeth_l2_main.c                    |  2 +-
 drivers/s390/net/qeth_l3_main.c                    |  2 +-
 drivers/scsi/bnx2i/bnx2i_hwi.c                     |  2 +
 drivers/scsi/ibmvscsi/ibmvscsi.c                   |  4 +-
 drivers/spi/spi-rspi.c                             | 10 +--
 drivers/spi/spi-sh-msiof.c                         |  3 +-
 drivers/spi/spi-tegra20-slink.c                    | 31 ++++++---
 drivers/staging/android/ashmem.c                   |  6 ++
 drivers/staging/android/ion/ion.c                  | 60 +++++++++++-------
 drivers/target/iscsi/iscsi_target_auth.c           | 45 +++++--------
 drivers/target/iscsi/iscsi_target_tpg.c            |  3 +-
 drivers/thermal/of-thermal.c                       |  7 ++-
 drivers/tty/serial/8250/serial_cs.c                |  6 +-
 drivers/tty/serial/cpm_uart/cpm_uart_core.c        | 10 ++-
 drivers/usb/class/cdc-wdm.c                        |  2 +-
 drivers/usb/core/devio.c                           | 24 ++++++-
 drivers/usb/core/driver.c                          | 28 ++++-----
 drivers/usb/core/usb.c                             |  2 +
 drivers/usb/misc/yurex.c                           |  3 +
 drivers/usb/serial/kobil_sct.c                     | 12 +++-
 drivers/usb/serial/usb-serial-simple.c             |  3 +-
 drivers/usb/wusbcore/security.c                    |  2 +-
 drivers/uwb/hwa-rc.c                               |  1 +
 drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c    |  5 +-
 drivers/xen/events/events_base.c                   |  2 +-
 drivers/xen/manage.c                               |  6 +-
 fs/cifs/cifs_unicode.c                             |  3 -
 fs/cifs/cifssmb.c                                  | 11 +++-
 fs/cifs/misc.c                                     |  8 +++
 fs/cifs/smb2ops.c                                  |  2 +-
 fs/ext4/balloc.c                                   | 21 ++++---
 fs/ext4/dir.c                                      | 20 +++---
 fs/ext4/ext4.h                                     |  8 ---
 fs/ext4/ext4_extents.h                             |  1 +
 fs/ext4/extents.c                                  |  6 ++
 fs/ext4/ialloc.c                                   | 19 +++++-
 fs/ext4/inline.c                                   | 42 ++-----------
 fs/ext4/inode.c                                    |  3 +-
 fs/ext4/mballoc.c                                  |  6 +-
 fs/ext4/mmp.c                                      |  1 -
 fs/ext4/resize.c                                   | 20 ++++++
 fs/ext4/super.c                                    | 14 ++++-
 fs/ext4/xattr.c                                    | 49 +++++++--------
 fs/jbd2/transaction.c                              |  2 +-
 fs/nfsd/nfs4proc.c                                 |  1 +
 fs/ocfs2/buffer_head_io.c                          |  1 +
 fs/ocfs2/dlm/dlmmaster.c                           |  4 +-
 fs/proc/base.c                                     | 14 +++++
 fs/seq_file.c                                      |  7 ++-
 fs/ubifs/super.c                                   |  3 +
 include/linux/netfilter_bridge/ebtables.h          |  5 ++
 include/linux/seq_file.h                           | 13 ++--
 include/linux/slub_def.h                           |  3 +-
 include/media/v4l2-fh.h                            |  1 +
 kernel/cgroup.c                                    |  6 +-
 kernel/module.c                                    |  6 +-
 kernel/time/alarmtimer.c                           |  3 +-
 kernel/trace/ring_buffer.c                         |  2 +
 mm/madvise.c                                       |  2 +-
 mm/shmem.c                                         |  2 +
 mm/slub.c                                          |  6 +-
 net/bridge/netfilter/ebt_arpreply.c                |  3 +
 net/core/neighbour.c                               | 13 ++--
 net/ipv4/af_inet.c                                 |  1 +
 net/ipv6/ip6_offload.c                             |  1 +
 net/ipv6/ip6_output.c                              |  3 +-
 net/mac80211/cfg.c                                 |  2 +-
 net/mac80211/ibss.c                                | 22 +++----
 net/mac80211/main.c                                | 26 ++++++--
 net/mac80211/mlme.c                                | 53 ++++++++++++++++
 net/wireless/nl80211.c                             |  1 +
 sound/aoa/core/gpio-feature.c                      |  4 +-
 sound/firewire/bebob/bebob_maudio.c                | 24 ++++---
 sound/pci/emu10k1/emufx.c                          |  2 +-
 sound/pci/hda/hda_intel.c                          |  3 +-
 sound/soc/codecs/cs4265.c                          |  4 +-
 sound/soc/soc-dapm.c                               |  7 +++
 tools/vm/page-types.c                              |  6 --
 tools/vm/slabinfo.c                                |  4 +-
 123 files changed, 882 insertions(+), 395 deletions(-)


