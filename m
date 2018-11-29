Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018EAC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EA4A213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wQ1RF4Ec"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EA4A213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730698AbeK3BXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:23:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:46086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729304AbeK3BXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:23:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA07021019;
        Thu, 29 Nov 2018 14:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501094;
        bh=D6tAP3B+eiiiOGqPUQbqRDmWBP/aOEWkdVaO7/LLiiQ=;
        h=From:To:Cc:Subject:Date:From;
        b=wQ1RF4Ec2rYREW1RHrFztfy03an6jeTYGE+4Ncb0KeoqnhOfvQ8SXbjWly8gBtHZF
         5xM0/RkYutX4EtpiBhIjgHM57YXYQruPmkcp6j8rUNkpR5wjqMmnynqMp+wOsOwZAV
         rEb1BGJb0FchB9H9uDjFvWLtO6SBoNQyas48gCsw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.4 00/86] 4.4.166-stable review
Date:   Thu, 29 Nov 2018 15:11:25 +0100
Message-Id: <20181129140109.832117862@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.166-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.4.166-rc1
X-KernelTest-Deadline: 2018-12-01T14:01+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 4.4.166 release.
There are 86 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Dec  1 14:00:43 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.166-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.4.166-rc1

Thomas Zimmermann <tzimmermann@suse.de>
    drm/ast: Remove existing framebuffers before loading driver

Janosch Frank <frankja@linux.ibm.com>
    s390/mm: Check for valid vma before zapping in gmap_discard

Salvatore Mesoraca <s.mesoraca16@gmail.com>
    namei: allow restricted O_CREAT of FIFOs and regular files

Steven Rostedt (VMware) <rostedt@goodmis.org>
    sched/core: Allow __sched_setscheduler() in interrupts when PI is not used

Qu Wenruo <wqu@suse.com>
    btrfs: Ensure btrfs_trim_fs can trim the whole filesystem

Aaron Ma <aaron.ma@canonical.com>
    usb: xhci: fix uninitialized completion when USB3 port got wrong status

Greg Kroah-Hartman <greg@kroah.com>
    tty: wipe buffer if not echoing data

Linus Torvalds <torvalds@linux-foundation.org>
    tty: wipe buffer.

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    iwlwifi: mvm: fix regulatory domain update when the firmware starts

Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
    scsi: qla2xxx: do not queue commands when unloading

Subhash Jadavani <subhashj@codeaurora.org>
    scsi: ufshcd: release resources if probe fails

Subhash Jadavani <subhashj@codeaurora.org>
    scsi: ufs: fix race between clock gating and devfreq scaling work

Venkat Gopalakrishnan <venkatg@codeaurora.org>
    scsi: ufshcd: Fix race between clk scaling and ungate work

Yaniv Gardi <ygardi@codeaurora.org>
    scsi: ufs: fix bugs related to null pointer access and array size

Liping Zhang <zlpnobody@gmail.com>
    netfilter: nf_tables: fix oops when inserting an element into a verdict map

Karthik D A <karthida@marvell.com>
    mwifiex: fix p2p device doesn't find in scan problem

Amitkumar Karwar <akarwar@marvell.com>
    mwifiex: Fix NULL pointer dereference in skb_dequeue()

Johannes Thumshirn <jthumshirn@suse.de>
    cw1200: Don't leak memory if krealloc failes

Ramses Ramírez <ramzeto@gmail.com>
    Input: xpad - add support for Xbox1 PDP Camo series gamepad

Enno Boland <gottox@voidlinux.eu>
    Input: xpad - fix GPD Win 2 controller name

Ethan Lee <flibitijibibo@gmail.com>
    Input: xpad - add GPD Win 2 Controller USB IDs

Marcus Folkesson <marcus.folkesson@gmail.com>
    Input: xpad - avoid using __set_bit() for capabilities

Leo Sperling <leosperling97@gmail.com>
    Input: xpad - fix some coding style issues

Francis Therien <frtherien@gmail.com>
    Input: xpad - add PDP device id 0x02a4

Mark Furneaux <mark@furneaux.ca>
    Input: xpad - add support for PDP Xbox One controllers

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - validate USB endpoint type during probe

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - fix PowerA init quirk for some gamepad models

Arvind Yadav <arvind.yadav.cs@gmail.com>
    Input: xpad - constify usb_device_id

Benjamin Valentin <benpicco@googlemail.com>
    Input: xpad - sync supported devices with XBCD

Benjamin Valentin <benpicco@googlemail.com>
    Input: xpad - sync supported devices with 360Controller

Benjamin Valentin <benpicco@googlemail.com>
    Input: xpad - add USB IDs for Mad Catz Brawlstick and Razer Sabertooth

Benjamin Valentin <benpicco@googlemail.com>
    Input: xpad - sync supported devices with xboxdrv

Benjamin Valentin <benpicco@googlemail.com>
    Input: xpad - sort supported devices by USB ID

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - support some quirky Xbox One pads

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - restore LED state after device resume

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - fix stuck mode button on Xbox One S pad

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - don't depend on endpoint order

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - simplify error condition in init_output

Daniel Tobias <dan.g.tob@gmail.com>
    Input: xpad - move reporting xbox one home button to common function

Daniel Tobias <dan.g.tob@gmail.com>
    Input: xpad - correctly sort vendor id's

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - fix Xbox One rumble stopping after 2.5 secs

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - add product ID for Xbox One S pad

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - power off wireless 360 controllers on suspend

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - fix rumble on Xbox One controllers with 2015 firmware

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - xbox one elite controller support

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - add more third-party controllers

Cameron Gutman <aicommander@gmail.com>
    Input: xpad - prevent spurious input from wired Xbox 360 controllers

Silvan Jegen <s.jegen@gmail.com>
    Input: xpad - add Mad Catz FightStick TE 2 VID/PID

Arnd Bergmann <arnd@arndb.de>
    Input: xpad - remove unused function

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - correct xbox one pad device name

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: xpad - use LED API when identifying wireless controllers

Pavel Rojtberg <rojtberg@gmail.com>
    Input: xpad - workaround dead irq_out after suspend/ resume

Pierre-Loup A. Griffais <githubpublic@plagman.net>
    Input: xpad - update Xbox One Force Feedback Support

Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
    Input: xpad - handle "present" and "gone" correctly

Clement Calmels <clement.calmels@free.fr>
    Input: xpad - remove spurious events of wireless xpad 360 controller

Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
    ath10k: fix kernel panic due to race in accessing arvif list

Greg Hackmann <ghackmann@android.com>
    arm64: remove no-op -p linker flag

Andy Lutomirski <luto@kernel.org>
    x86/entry/64: Remove %ebx handling from error_entry/exit

Nicolas Iooss <nicolas.iooss_linux@m4x.org>
    x86/entry: spell EBX register correctly in documentation

Johan Hovold <johan@kernel.org>
    net: bcmgenet: fix OF child-node lookup

Johan Hovold <johan@kernel.org>
    NFC: nfcmrvl_uart: fix OF child-node lookup

Johan Hovold <johan@kernel.org>
    of: add helper to lookup compatible child node

Yufen Yu <yuyufen@huawei.com>
    tmpfs: make lseek(SEEK_DATA/SEK_HOLE) return ENXIO with a negative offset

Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
    powerpc/numa: Suppress "VPHN is not supported" messages

Prarit Bhargava <prarit@redhat.com>
    kdb: Use strscpy with destination buffer size

Trond Myklebust <trond.myklebust@hammerspace.com>
    SUNRPC: Fix a bogus get/put in generic_key_to_expire()

Russell King <rmk+kernel@armlinux.org.uk>
    ARM: make lookup_processor_type() non-__init

Anson Huang <anson.huang@nxp.com>
    cpufreq: imx6q: add return value check for voltage scale

Scott Wood <oss@buserror.net>
    KVM: PPC: Move and undef TRACE_INCLUDE_PATH/FILE

Mathias Nyman <mathias.nyman@linux.intel.com>
    usb: xhci: Prevent bus suspend if a port connect change or polling state is detected

Erik Schmauss <erik.schmauss@intel.com>
    ACPICA: AML interpreter: add region addresses in global list during initialization

Marc Kleine-Budde <mkl@pengutronix.de>
    can: dev: __can_get_echo_skb(): print error message, if trying to echo non existing skb

Marc Kleine-Budde <mkl@pengutronix.de>
    can: dev: __can_get_echo_skb(): Don't crash the kernel if can_priv::echo_skb is accessed out of bounds

Marc Kleine-Budde <mkl@pengutronix.de>
    can: dev: __can_get_echo_skb(): replace struct can_frame by canfd_frame to access frame length

Marc Kleine-Budde <mkl@pengutronix.de>
    can: dev: can_get_echo_skb(): factor out non sending code to __can_get_echo_skb()

Y.C. Chen <yc_chen@aspeedtech.com>
    drm/ast: fixed cursor may disappear sometimes

Y.C. Chen <yc_chen@aspeedtech.com>
    drm/ast: change resolution may cause screen blurred

Eric Dumazet <edumazet@google.com>
    llc: do not use sk_eat_skb()

Andrew Price <anprice@redhat.com>
    gfs2: Don't leave s_fs_info pointing to freed memory in init_sbd

Xin Long <lucien.xin@gmail.com>
    sctp: clear the transport of some out_chunk_list chunks in sctp_assoc_rm_peer

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    bfs: add sanity check at bfs_fill_super()

Dominique Martinet <dominique.martinet@cea.fr>
    v9fs_dir_readdir: fix double-free on p9stat_read error

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    iwlwifi: mvm: support sta_statistics() even on older firmware

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    MAINTAINERS: Add Sasha as a stable branch maintainer

Aaron Ma <aaron.ma@canonical.com>
    usb: xhci: fix timeout for transition from RExit to U0

Dennis Wassenberg <dennis.wassenberg@secunet.com>
    usb: core: Fix hub port connection events lost


-------------

Diffstat:

 Documentation/sysctl/fs.txt                  |  36 ++
 MAINTAINERS                                  |   1 +
 Makefile                                     |   4 +-
 arch/arm/kernel/head-common.S                |   6 +-
 arch/arm64/Makefile                          |   2 +-
 arch/powerpc/kvm/trace.h                     |   8 +-
 arch/powerpc/kvm/trace_booke.h               |   9 +-
 arch/powerpc/kvm/trace_hv.h                  |   9 +-
 arch/powerpc/kvm/trace_pr.h                  |   9 +-
 arch/powerpc/mm/numa.c                       |   2 +-
 arch/s390/mm/pgtable.c                       |   2 +
 arch/x86/entry/entry_64.S                    |  20 +-
 drivers/acpi/acpica/dsopcode.c               |   4 +
 drivers/cpufreq/imx6q-cpufreq.c              |   7 +-
 drivers/gpu/drm/ast/ast_drv.c                |  21 +
 drivers/gpu/drm/ast/ast_mode.c               |   3 +-
 drivers/input/joystick/xpad.c                | 810 +++++++++++++++++++++------
 drivers/net/can/dev.c                        |  48 +-
 drivers/net/ethernet/broadcom/genet/bcmmii.c |   2 +-
 drivers/net/wireless/ath/ath10k/mac.c        |   6 +
 drivers/net/wireless/cw1200/wsm.c            |  16 +-
 drivers/net/wireless/iwlwifi/mvm/mac80211.c  |  12 +-
 drivers/net/wireless/iwlwifi/mvm/nvm.c       |   5 +-
 drivers/net/wireless/mwifiex/cfg80211.c      |  10 +-
 drivers/net/wireless/mwifiex/wmm.c           |  12 +-
 drivers/nfc/nfcmrvl/uart.c                   |   5 +-
 drivers/of/base.c                            |  25 +
 drivers/scsi/qla2xxx/qla_os.c                |   5 +
 drivers/scsi/ufs/ufs.h                       |   3 +-
 drivers/scsi/ufs/ufshcd-pci.c                |   2 +
 drivers/scsi/ufs/ufshcd-pltfrm.c             |   5 +-
 drivers/scsi/ufs/ufshcd.c                    |  75 ++-
 drivers/tty/n_tty.c                          |  19 +-
 drivers/tty/tty_buffer.c                     |   2 +
 drivers/usb/core/hub.c                       |   4 +-
 drivers/usb/host/xhci-hub.c                  |  66 ++-
 drivers/usb/host/xhci-ring.c                 |   2 +-
 drivers/usb/host/xhci.h                      |   2 +-
 fs/9p/vfs_dir.c                              |  11 -
 fs/bfs/inode.c                               |   9 +-
 fs/btrfs/extent-tree.c                       |  10 +-
 fs/btrfs/ioctl.c                             |  11 +-
 fs/gfs2/ops_fstype.c                         |   2 +-
 fs/namei.c                                   |  53 +-
 include/linux/can/dev.h                      |   1 +
 include/linux/fs.h                           |   2 +
 include/linux/of.h                           |   8 +
 kernel/debug/kdb/kdb_io.c                    |  15 +-
 kernel/debug/kdb/kdb_private.h               |   2 +-
 kernel/debug/kdb/kdb_support.c               |  10 +-
 kernel/sched/core.c                          |   4 +-
 kernel/sysctl.c                              |  18 +
 mm/shmem.c                                   |   4 +-
 net/llc/af_llc.c                             |  11 +-
 net/netfilter/nf_tables_api.c                |   1 +
 net/sctp/associola.c                         |  10 +-
 net/sunrpc/auth_generic.c                    |   8 +-
 57 files changed, 1126 insertions(+), 343 deletions(-)


