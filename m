Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3034830-1517594693-2-80785499887323051
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517594691; b=FNg0s/U2M/NP7EaF77PUiGqNG/s034yIXPr9Gqj0Vp2jP2a
    nAwgBoeRMegNBUIVtPDmEla7vJvoQJfc2W4s5R+7IOR4utnRQGwubghgD6ehiCXd
    uDhIN5KLS89vY6KELc2lhVW//C4LhH4om1GCE+aFUUb9CT1lRlBHAAH8wkemOdjH
    TW3usfAlTRxIQeh39CBcWc4zHX8nVvL9JYG2v35IVaii6w99R/mRX7LfMPJwH0HQ
    6qZ8QJ9nWrkZ7AWRv2bo/3CIdj6nHGrf77P6kY8Fgw1eDeMkbAK+tghjdWAWWsG2
    hKrTW8Ip5MWNm456W17KcSYmLzEcs4EykZh7X9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1517594691; bh=qc35G2qzXTX1wqoq768nM7qI7x
    KitqTq21Tw84vpGcc=; b=PayyBVphVrPmdoo/r9CcKsWCUolN8roDsvKMd1iLRX
    IVYpaW7D9/Gsp5BKOu1sD3jm2OxIrM4dhDh+KA1i9nscToR6cQjm8+Zq51ukL1/y
    jPtziW2Z9C4bMWBTXec7TC9hhiDax5Dnt26Ode+3EV9OyHI4/CKQ3HixL8/JMQpK
    JlH2BDcEXrMyNALxU3Hl94VB8tT/+dMAgMgeOBDoU3P+ccovaYhoGsNHc2TnkmQL
    hEnjOzCtR4aKHxUuCSo71CYUtV3WQUOGrlxJ67ObtG11iL25oCMAXGpMizxL2kj2
    emZqoDxK7B7Z0onikvPs/dzpvFePz8sjlSby8OD47nPg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752856AbeBBSEs (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 13:04:48 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37368 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752519AbeBBRIg (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:08:36 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 4.14 000/156] 4.14.17-stable review
Date: Fri,  2 Feb 2018 17:56:21 +0100
Message-Id: <20180202140840.242829545@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.17-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.14.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.14.17-rc1
X-KernelTest-Deadline: 2018-02-04T14:08+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 4.14.17 release.
There are 156 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Feb  4 14:07:42 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.17-rc1.gz
or in the git tree and branch at:
  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 4.14.17-rc1

Matthew Garrett <mjg59@google.com>
    x86/efi: Clarify that reset attack mitigation needs appropriate userspace

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: synaptics-rmi4 - do not delete interrupt memory too early

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: synaptics-rmi4 - unmask F03 interrupts when port is opened

Wei Yongjun <weiyongjun1@huawei.com>
    test_firmware: fix missing unlock on error in config_num_requests_store()

Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
    iio: chemical: ccs811: Fix output of IIO_CONCENTRATION channels

Fabrice Gasnier <fabrice.gasnier@st.com>
    iio: adc: stm32: fix scan of multiple channels with DMA

Stefan Agner <stefan@agner.ch>
    spi: imx: do not access registers while clocks disabled

Fabio Estevam <fabio.estevam@nxp.com>
    serial: imx: Only wakeup via RTSDEN bit if the system has RTS/CTS

Wei Yongjun <weiyongjun1@huawei.com>
    serial: 8250_uniphier: fix error return code in uniphier_uart_probe()

Masahiro Yamada <yamada.masahiro@socionext.com>
    serial: 8250_of: fix return code when probe function fails to get reset

Tomas Winkler <tomas.winkler@intel.com>
    mei: me: allow runtime pm for platform with D0i3

Ganesh Mahendran <opensource.ganesh@gmail.com>
    android: binder: use VM_ALLOC to get vm area

Martijn Coenen <maco@android.com>
    ANDROID: binder: remove waitqueue when thread exits.

Benjamin Herrenschmidt <benh@kernel.crashing.org>
    usb/gadget: Fix "high bandwidth" check in usb_gadget_ep_match_desc()

Oliver Neukum <oneukum@suse.com>
    usb: uas: unconditionally bring back host after reset

Hemant Kumar <hemantk@codeaurora.org>
    usb: f_fs: Prevent gadget unbind if it is already unbound

Johan Hovold <johan@kernel.org>
    USB: serial: simple: add Motorola Tetra driver

Shuah Khan <shuah@kernel.org>
    usbip: list: don't list devices attached to vhci_hcd

Shuah Khan <shuah@kernel.org>
    usbip: prevent bind loops on devices attached to vhci_hcd

Jia-Ju Bai <baijiaju1990@gmail.com>
    USB: serial: io_edgeport: fix possible sleep-in-atomic

Oliver Neukum <oneukum@suse.com>
    CDC-ACM: apply quirk for card reader

Hans de Goede <hdegoede@redhat.com>
    USB: cdc-acm: Do not log urb submission errors on disconnect

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    USB: serial: pl2303: new device id for Chilitag

OKAMOTO Yoshiaki <yokamoto@allied-telesis.co.jp>
    usb: option: Add support for FS040U modem

Gaurav Kohli <gkohli@codeaurora.org>
    tty: fix data race between tty_init_dev and flush of buf

Gilad Ben-Yossef <gilad@benyossef.com>
    staging: ccree: fix fips event irq handling build

Gilad Ben-Yossef <gilad@benyossef.com>
    staging: ccree: NULLify backup_info when unused

Dmitry Eremin <dmitry.eremin@intel.com>
    staging: lustre: separate a connection destroy from free struct kib_conn

Paolo Bonzini <pbonzini@redhat.com>
    KVM: x86: emulate #UD while in guest mode

Stefan Schake <stschake@gmail.com>
    drm/vc4: Move IRQ enable to PM path

Larry Finger <Larry.Finger@lwfinger.net>
    staging: rtl8188eu: Fix incorrect response to SIOCGIWESSID

Colin Ian King <colin.king@canonical.com>
    usb: gadget: don't dereference g until after it has been null checked

Juergen Gross <jgross@suse.com>
    x86/xen: Support early interrupts in xen pv guests

Icenowy Zheng <icenowy@aosc.io>
    media: usbtv: add a new usbid

Florian Fainelli <f.fainelli@gmail.com>
    ARM: dts: NSP: Fix PPI interrupt types

Florian Fainelli <f.fainelli@gmail.com>
    ARM: dts: NSP: Disable AHCI controller for HR NSP boards

Sara Sharon <sara.sharon@intel.com>
    iwlwifi: fix access to prph when transport is stopped

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    iwlwifi: mvm: fix the TX queue hang timeout for MONITOR vif type

Gustavo A. R. Silva <garsilva@embeddedor.com>
    scsi: ufs: ufshcd: fix potential NULL pointer dereference in ufshcd_config_vreg

Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
    scsi: aacraid: Prevent crash in case of free interrupt during scsi EH path

Vasily Averin <vvs@virtuozzo.com>
    perf/core: Fix memory leak triggered by perf --namespace

Carlos Maiolino <cmaiolino@redhat.com>
    xfs: Properly retry failed dquot items in case of error during buffer writeback

Darrick J. Wong <darrick.wong@oracle.com>
    xfs: ubsan fixes

Arnd Bergmann <arnd@arndb.de>
    drm/omap: displays: panel-dpi: add backlight dependency

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    drm/omap: Fix error handling path in 'omap_dmm_probe()'

Andrey Gusakov <andrey.gusakov@cogentembedded.com>
    drm/bridge: tc358767: fix 1-lane behavior

Andrey Gusakov <andrey.gusakov@cogentembedded.com>
    drm/bridge: tc358767: fix AUXDATAn registers access

Andrey Gusakov <andrey.gusakov@cogentembedded.com>
    drm/bridge: tc358767: fix timing calculations

Andrey Gusakov <andrey.gusakov@cogentembedded.com>
    drm/bridge: tc358767: fix DP0_MISC register set

Andrey Gusakov <andrey.gusakov@cogentembedded.com>
    drm/bridge: tc358767: filter out too high modes

Andrey Gusakov <andrey.gusakov@cogentembedded.com>
    drm/bridge: tc358767: do no fail on hi-res displays

Eric Anholt <eric@anholt.net>
    drm/bridge: Fix lvds-encoder since the panel_bridge rework.

Yisheng Xie <xieyisheng1@huawei.com>
    kmemleak: add scheduling point to kmemleak_scan()

Liu, Changcheng <changcheng.liu@intel.com>
    scripts/faddr2line: extend usage on generic arch

Trond Myklebust <trond.myklebust@primarydata.com>
    SUNRPC: Allow connect to return EHOSTUNREACH

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    quota: Check for register_shrinker() failure.

Geert Uytterhoeven <geert+renesas@glider.be>
    net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit

Christian König <christian.koenig@amd.com>
    drm/amdgpu: don't try to move pinned BOs

Michal Hocko <mhocko@suse.com>
    xfs: fortify xfs_alloc_buftarg error handling

Minwoo Im <minwoo.im.dev@gmail.com>
    nvme-pci: fix NULL pointer dereference in nvme_free_host_mem()

Filipe Manana <fdmanana@suse.com>
    Btrfs: incremental send, fix wrong unlink path after renaming file

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    bnxt_en: Fix an error handling path in 'bnxt_get_module_eeprom()'

Antoine Tenart <antoine.tenart@free-electrons.com>
    net: phy: marvell10g: fix the PHY id mask

Antoine Tenart <antoine.tenart@free-electrons.com>
    net: mvpp2: fix the txq_init error path

Chao Yu <yuchao0@huawei.com>
    quota: propagate error from __dquot_initialize

Robert Lippert <roblip@gmail.com>
    hwmon: (pmbus) Use 64bit math for DIRECT format values

Vasily Averin <vvs@virtuozzo.com>
    lockd: fix "list_add double add" caused by legacy signal interface

Vasily Averin <vvs@virtuozzo.com>
    race of lockd inetaddr notifiers vs nlmsvc_rqst change

Andrew Elble <aweits@rit.edu>
    nfsd: check for use of the closed special stateid

Vasily Averin <vvs@virtuozzo.com>
    grace: replace BUG_ON by WARN_ONCE in exit_net hook

Trond Myklebust <trond.myklebust@primarydata.com>
    nfsd: Ensure we check stateid validity in the seqid operation checks

Trond Myklebust <trond.myklebust@primarydata.com>
    nfsd: CLOSE SHOULD return the invalid special stateid for NFSv4.x (x>0)

Thomas Meyer <thomas@m3y3r.de>
    auxdisplay: img-ascii-lcd: Only build on archs that have IOMEM

Eduardo Otubo <otubo@redhat.com>
    xen-netfront: remove warning when unloading module

Colin Ian King <colin.king@canonical.com>
    i2c: i2c-boardinfo: fix memory leaks on devinfo

Darrick J. Wong <darrick.wong@oracle.com>
    xfs: log recovery should replay deferred ops in order

Darrick J. Wong <darrick.wong@oracle.com>
    xfs: always free inline data before resetting inode fork during ifree

Jan H. Schönherr <jschoenh@amazon.de>
    KVM: Let KVM_SET_SIGNAL_MASK work as advertised

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: fix list_add corruption and soft lockups in fsync

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: VMX: Fix rflags cache during vCPU reset

Wanpeng Li <kernellwp@gmail.com>
    KVM: X86: Fix softlockup when get the current kvmclock

Jeff Layton <jlayton@redhat.com>
    reiserfs: remove unneeded i_version bump

Xin Long <lucien.xin@gmail.com>
    sctp: set sender next_tsn for the old result with ctsn_ack_point plus 1

Xin Long <lucien.xin@gmail.com>
    sctp: avoid flushing unsent queue when doing asoc reset

Xin Long <lucien.xin@gmail.com>
    sctp: only allow the asoc reset when the asoc outq is empty

Josef Bacik <jbacik@fb.com>
    btrfs: fix deadlock when writing out space cache

Chun-Yeow Yeoh <yeohchunyeow@gmail.com>
    mac80211: fix the update of path metric for RANN frame

Johannes Berg <johannes.berg@intel.com>
    mac80211: use QoS NDP for AP probing

Mirza Krak <mirza.krak@endian.se>
    drm/rockchip: dw-mipi-dsi: fix possible un-balanced runtime PM enable

zhangliping <zhangliping02@baidu.com>
    openvswitch: fix the incorrect flow action alloc size

Sagi Grimberg <sagi@grimberg.me>
    nvme-rdma: don't complete requests before a send work request has completed

Dmitry V. Levin <ldv@altlinux.org>
    uapi: fix linux/kfd_ioctl.h userspace compilation errors

Felix Kuehling <Felix.Kuehling@amd.com>
    drm/amdkfd: Fix SDMA oversubsription handling

shaoyunl <Shaoyun.Liu@amd.com>
    drm/amdkfd: Fix SDMA ring buffer size calculation

Felix Kuehling <Felix.Kuehling@amd.com>
    drm/amdgpu: Fix SDMA load/unload sequence on HWS disabled mode

Michael Lyle <mlyle@lyle.org>
    bcache: check return value of register_shrinker

David Howells <dhowells@redhat.com>
    rxrpc: Fix service endpoint expiry

David Howells <dhowells@redhat.com>
    rxrpc: Provide a different lockdep key for call->user_mutex for kernel calls

David Howells <dhowells@redhat.com>
    rxrpc: The mutex lock returned by rxrpc_accept_call() needs releasing

Martin Schwidefsky <schwidefsky@de.ibm.com>
    s390: fix alloc_pgste check in init_new_context again

David Disseldorp <ddiss@suse.de>
    null_blk: fix dev->badblocks leak

James Hogan <jhogan@kernel.org>
    cpufreq: Add Loongson machine dependencies

Hans de Goede <hdegoede@redhat.com>
    ACPI / bus: Leave modalias empty for devices which are not present

Harald Freudenberger <freude@linux.vnet.ibm.com>
    s390/zcrypt: Fix wrong comparison leading to strange load balancing

Thomas Richter <tmricht@linux.vnet.ibm.com>
    s390/topology: fix compile error in file arch/s390/kernel/smp.c

James Smart <jsmart2021@gmail.com>
    nvmet-fc: correct ref counting error when deferred rcv used

Minwoo Im <minwoo.im.dev@gmail.com>
    nvme-pci: avoid hmb desc array idx out-of-bound when hmmaxd set.

Kai-Heng Feng <kai.heng.feng@canonical.com>
    nvme-pci: disable APST on Samsung SSD 960 EVO + ASUS PRIME B350M-A

Sagi Grimberg <sagi@grimberg.me>
    nvme-loop: check if queue is ready in queue_rq

Sagi Grimberg <sagi@grimberg.me>
    nvme-fc: check if queue is ready in queue_rq

Sagi Grimberg <sagi@grimberg.me>
    nvme-fabrics: introduce init command check for a queue that is not alive

Liran Alon <liran.alon@oracle.com>
    KVM: nVMX: Fix vmx_check_nested_events() return value in case an event was reinjected to L2

Nikita Leshenko <nikita.leshchenko@oracle.com>
    KVM: x86: ioapic: Preserve read-only values in the redirection table

Nikita Leshenko <nikita.leshchenko@oracle.com>
    KVM: x86: ioapic: Clear Remote IRR when entry is switched to edge-triggered

Nikita Leshenko <nikita.leshchenko@oracle.com>
    KVM: x86: ioapic: Fix level-triggered EOI and IOAPIC reconfigure race

David Hildenbrand <david@redhat.com>
    KVM: x86: fix em_fxstor() sleeping while in atomic

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: nVMX: Fix mmu context after VMLAUNCH/VMRESUME failure

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: X86: Fix operand/address-size during instruction decoding

Liran Alon <liran.alon@oracle.com>
    KVM: x86: Don't re-execute instruction when not passing CR2 value

Liran Alon <liran.alon@oracle.com>
    KVM: x86: emulator: Return to user-mode on L1 CPL=0 emulation failure

Liran Alon <liran.alon@oracle.com>
    KVM: nVMX/nSVM: Don't intercept #UD when running L2

Abhishek Goel <huntbag@linux.vnet.ibm.com>
    cpupower : Fix cpupower working when cpu0 is offline

Abhishek Goel <huntbag@linux.vnet.ibm.com>
    cpupowerutils: bench - Fix cpu online check

Liu Bo <bo.li.liu@oracle.com>
    Btrfs: bail out gracefully rather than BUG_ON

Nikolay Borisov <nborisov@suse.com>
    btrfs: Fix transaction abort during failure in btrfs_rm_dev_item

Stefan Schake <stschake@gmail.com>
    drm/vc4: Account for interrupts in flight

Markus Trippelsdorf <markus@trippelsdorf.de>
    VFS: Handle lazytime in do_mount()

Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
    scsi: aacraid: Fix hang in kdump

Raghava Aditya Renukunta <RaghavaAditya.Renukunta@microsemi.com>
    scsi: aacraid: Fix udev inquiry race condition

Mike Rapoport <rppt@linux.vnet.ibm.com>
    ima/policy: fix parsing of fsuuid

Lyude Paul <lyude@redhat.com>
    igb: Free IRQs when device is hotplugged

Jesse Chan <jc@linux.com>
    mtd: nand: denali_pci: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jesse Chan <jc@linux.com>
    gpio: ath79: add missing MODULE_DESCRIPTION/LICENSE

Jesse Chan <jc@linux.com>
    gpio: iop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jesse Chan <jc@linux.com>
    power: reset: zx-reboot: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Jason Gerecke <killertofu@gmail.com>
    HID: wacom: Fix reporting of touch toggle (WACOM_HID_WD_MUTE_DEVICE) events

Aaron Armstrong Skomra <skomra@gmail.com>
    HID: wacom: EKR: ensure devres groups at higher indexes are released

Stephan Mueller <smueller@chronox.de>
    crypto: af_alg - whitelist mask and type

Ard Biesheuvel <ard.biesheuvel@linaro.org>
    crypto: sha3-generic - fixes for alignment and big endian operation

Antoine Tenart <antoine.tenart@free-electrons.com>
    crypto: inside-secure - avoid unmapping DMA memory that was not mapped

Antoine Tenart <antoine.tenart@free-electrons.com>
    crypto: inside-secure - fix hash when length is a multiple of a block

Junaid Shahid <junaids@google.com>
    crypto: aesni - Fix out-of-bounds access of the AAD buffer in generic-gcm-aesni

Junaid Shahid <junaids@google.com>
    crypto: aesni - Fix out-of-bounds access of the data buffer in generic-gcm-aesni

Sabrina Dubroca <sd@queasysnail.net>
    crypto: aesni - add wrapper for generic gcm(aes)

Corentin LABBE <clabbe.montjoie@gmail.com>
    crypto: aesni - Use GCM IV size constant

Corentin LABBE <clabbe.montjoie@gmail.com>
    crypto: gcm - add GCM IV size constant

Sabrina Dubroca <sd@queasysnail.net>
    crypto: aesni - fix typo in generic_gcmaes_decrypt

Stephan Mueller <smueller@chronox.de>
    crypto: aesni - handle zero length dst buffer

Hauke Mehrtens <hauke@hauke-m.de>
    crypto: ecdh - fix typo in KPP dependency of CRYPTO_ECDH

Takashi Iwai <tiwai@suse.de>
    ALSA: hda - Reduce the suspend time consumption for ALC256

Linus Walleij <linus.walleij@linaro.org>
    gpio: Fix kernel stack leak to userspace

Patrice Chotard <patrice.chotard@st.com>
    gpio: stmpe: i2c transfer are forbiden in atomic context

Joel Stanley <joel@jms.id.au>
    tools/gpio: Fix build error with musl libc

Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
    KVM: x86: Fix CPUID function for word 6 (80000001_ECX)

Linus Torvalds <torvalds@linux-foundation.org>
    loop: fix concurrent lo_open/lo_release

Peter Zijlstra <peterz@infradead.org>
    futex: Fix OWNER_DEAD fixup


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |   4 +-
 arch/arm/boot/dts/bcm958623hr.dts                  |   4 -
 arch/arm/boot/dts/bcm958625hr.dts                  |   4 -
 arch/mips/kvm/mips.c                               |   7 +-
 arch/powerpc/kvm/powerpc.c                         |   7 +-
 arch/s390/include/asm/mmu_context.h                |   2 +-
 arch/s390/include/asm/topology.h                   |   1 +
 arch/s390/kernel/smp.c                             |   1 +
 arch/s390/kvm/kvm-s390.c                           |   7 +-
 arch/x86/crypto/aesni-intel_asm.S                  | 199 ++++++---------------
 arch/x86/crypto/aesni-intel_glue.c                 |  77 ++++++--
 arch/x86/include/asm/kvm_host.h                    |   3 +-
 arch/x86/include/asm/segment.h                     |  12 ++
 arch/x86/kvm/cpuid.h                               |   2 +-
 arch/x86/kvm/emulate.c                             |  39 +++-
 arch/x86/kvm/ioapic.c                              |  20 ++-
 arch/x86/kvm/vmx.c                                 |  55 +++---
 arch/x86/kvm/x86.c                                 |  20 +--
 arch/x86/mm/extable.c                              |   4 +-
 arch/x86/xen/enlighten_pv.c                        |  37 ++--
 arch/x86/xen/xen-asm_64.S                          |  14 ++
 crypto/Kconfig                                     |   2 +-
 crypto/af_alg.c                                    |  10 +-
 crypto/sha3_generic.c                              |   5 +-
 drivers/acpi/device_sysfs.c                        |   4 +
 drivers/android/binder.c                           |  12 ++
 drivers/android/binder_alloc.c                     |   2 +-
 drivers/auxdisplay/Kconfig                         |   1 +
 drivers/block/loop.c                               |  10 +-
 drivers/block/null_blk.c                           |   5 +-
 drivers/cpufreq/Kconfig                            |   2 +
 drivers/crypto/inside-secure/safexcel_hash.c       |  56 ++++--
 drivers/firmware/efi/Kconfig                       |   5 +-
 drivers/gpio/gpio-ath79.c                          |   3 +
 drivers/gpio/gpio-iop.c                            |   4 +
 drivers/gpio/gpio-stmpe.c                          |  20 +--
 drivers/gpio/gpiolib.c                             |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c  |  47 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c             |   4 +
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c   |   4 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  18 ++
 drivers/gpu/drm/bridge/lvds-encoder.c              |  48 ++++-
 drivers/gpu/drm/bridge/tc358767.c                  |  73 ++++----
 drivers/gpu/drm/omapdrm/displays/Kconfig           |   1 +
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c           |   3 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi.c             |   3 +-
 drivers/gpu/drm/vc4/vc4_irq.c                      |   3 +
 drivers/gpu/drm/vc4/vc4_v3d.c                      |   3 +
 drivers/hid/wacom_sys.c                            |  24 +--
 drivers/hid/wacom_wac.c                            |  16 +-
 drivers/hwmon/pmbus/pmbus_core.c                   |  21 ++-
 drivers/i2c/i2c-boardinfo.c                        |   2 +
 drivers/iio/adc/stm32-adc.c                        |   3 +-
 drivers/iio/chemical/ccs811.c                      |  13 +-
 drivers/input/rmi4/rmi_driver.c                    |  14 +-
 drivers/input/rmi4/rmi_f03.c                       |  64 +++++--
 drivers/md/bcache/btree.c                          |   5 +-
 drivers/media/usb/usbtv/usbtv-core.c               |   1 +
 drivers/misc/mei/pci-me.c                          |   5 +-
 drivers/mtd/nand/denali_pci.c                      |   4 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c  |   4 +-
 drivers/net/ethernet/intel/igb/igb_main.c          |   2 +-
 drivers/net/ethernet/marvell/mvpp2.c               |  20 +--
 drivers/net/ethernet/xilinx/Kconfig                |   1 +
 drivers/net/phy/marvell10g.c                       |   5 +-
 drivers/net/wireless/ath/ath9k/channel.c           |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h        |   2 -
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c     |   2 +
 .../net/wireless/intel/iwlwifi/pcie/trans-gen2.c   |   6 +
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |   9 +
 drivers/net/wireless/st/cw1200/sta.c               |   4 +-
 drivers/net/wireless/ti/wl1251/main.c              |   2 +-
 drivers/net/wireless/ti/wlcore/cmd.c               |   5 +-
 drivers/net/xen-netfront.c                         |  18 ++
 drivers/nvme/host/fabrics.h                        |  30 ++++
 drivers/nvme/host/fc.c                             |  19 +-
 drivers/nvme/host/pci.c                            |  15 +-
 drivers/nvme/host/rdma.c                           |  60 +++----
 drivers/nvme/target/fc.c                           |   9 +-
 drivers/nvme/target/loop.c                         |  25 ++-
 drivers/power/reset/zx-reboot.c                    |   4 +
 drivers/s390/crypto/zcrypt_api.c                   |   4 +-
 drivers/scsi/aacraid/aachba.c                      |  15 +-
 drivers/scsi/aacraid/commsup.c                     |  11 +-
 drivers/scsi/ufs/ufshcd.c                          |   7 +-
 drivers/spi/spi-imx.c                              |  15 +-
 drivers/staging/ccree/ssi_cipher.c                 |   1 +
 drivers/staging/ccree/ssi_driver.c                 |   2 +-
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.c    |   7 +-
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd.h    |   2 +-
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |   6 +-
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c     |  14 +-
 drivers/tty/serial/8250/8250_of.c                  |   5 +-
 drivers/tty/serial/8250/8250_uniphier.c            |   5 +-
 drivers/tty/serial/imx.c                           |  14 +-
 drivers/tty/tty_io.c                               |   8 +-
 drivers/tty/tty_ldisc.c                            |   4 +-
 drivers/usb/class/cdc-acm.c                        |   5 +-
 drivers/usb/gadget/composite.c                     |   7 +-
 drivers/usb/gadget/function/f_fs.c                 |   3 +-
 drivers/usb/gadget/udc/core.c                      |   2 +-
 drivers/usb/serial/Kconfig                         |   1 +
 drivers/usb/serial/io_edgeport.c                   |   1 -
 drivers/usb/serial/option.c                        |   5 +
 drivers/usb/serial/pl2303.c                        |   1 +
 drivers/usb/serial/pl2303.h                        |   1 +
 drivers/usb/serial/usb-serial-simple.c             |   7 +
 drivers/usb/storage/uas.c                          |   7 +-
 fs/btrfs/file.c                                    |   5 +-
 fs/btrfs/free-space-cache.c                        |   3 +-
 fs/btrfs/inode.c                                   |  10 +-
 fs/btrfs/send.c                                    | 124 +++++++++++--
 fs/btrfs/tree-log.c                                |   2 +-
 fs/btrfs/volumes.c                                 |  20 ++-
 fs/lockd/svc.c                                     |  16 +-
 fs/namespace.c                                     |   1 +
 fs/nfs_common/grace.c                              |  10 +-
 fs/nfsd/nfs4state.c                                |  34 ++--
 fs/quota/dquot.c                                   |  22 ++-
 fs/reiserfs/super.c                                |   1 -
 fs/xfs/xfs_aops.c                                  |   6 +-
 fs/xfs/xfs_bmap_item.c                             |  23 +--
 fs/xfs/xfs_bmap_item.h                             |   3 +-
 fs/xfs/xfs_buf.c                                   |  15 +-
 fs/xfs/xfs_dquot.c                                 |  14 +-
 fs/xfs/xfs_dquot_item.c                            |  40 ++++-
 fs/xfs/xfs_inode.c                                 |  21 +++
 fs/xfs/xfs_log_recover.c                           |  75 +++++++-
 fs/xfs/xfs_refcount_item.c                         |  21 +--
 fs/xfs/xfs_refcount_item.h                         |   3 +-
 include/crypto/gcm.h                               |   8 +
 include/linux/kvm_host.h                           |   3 +
 include/linux/tty.h                                |   2 +
 include/net/mac80211.h                             |   8 +-
 include/trace/events/rxrpc.h                       |   2 +
 include/uapi/linux/kfd_ioctl.h                     |  22 +--
 kernel/events/core.c                               |   1 +
 kernel/futex.c                                     |   6 +-
 lib/test_firmware.c                                |   1 +
 mm/kmemleak.c                                      |   2 +
 net/mac80211/mesh_hwmp.c                           |  15 +-
 net/mac80211/mlme.c                                |   2 +-
 net/mac80211/tx.c                                  |  29 ++-
 net/openvswitch/flow_netlink.c                     |  16 +-
 net/rxrpc/af_rxrpc.c                               |  13 ++
 net/rxrpc/ar-internal.h                            |   5 +-
 net/rxrpc/call_accept.c                            |   2 +-
 net/rxrpc/call_object.c                            |  19 +-
 net/rxrpc/conn_client.c                            |   2 +
 net/rxrpc/conn_object.c                            |  42 +++--
 net/rxrpc/net_ns.c                                 |   3 +
 net/rxrpc/sendmsg.c                                |   5 +-
 net/sctp/stream.c                                  |  32 +++-
 net/sunrpc/xprtsock.c                              |   1 +
 scripts/faddr2line                                 |  21 ++-
 security/integrity/ima/ima_policy.c                |   2 +-
 sound/pci/hda/patch_realtek.c                      |   6 +-
 tools/gpio/gpio-event-mon.c                        |   1 +
 tools/power/cpupower/bench/system.c                |   2 +-
 .../cpupower/utils/idle_monitor/cpuidle_sysfs.c    |   9 +-
 tools/usb/usbip/src/usbip_bind.c                   |   9 +
 tools/usb/usbip/src/usbip_list.c                   |   9 +
 virt/kvm/arm/arm.c                                 |   8 +-
 virt/kvm/kvm_main.c                                |  23 +++
 165 files changed, 1521 insertions(+), 729 deletions(-)
