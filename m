Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797899-1518707953-2-1794045936568724568
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
    t=1518707952; b=wN4P5kQ/DhOhcHe8hddI3Ka0quUguRC4NYhLjMC2dCt1Poa
    YnX8vBjexObUDCXC3WvXw6JlTTgnEg7sFVqskWJ244CMfBTzDUmlwzcS6sa11kxV
    Pn4TZ2vDKYrO2sDED0vs/6d2UrbXkYARMvI7UW6dji1a/S+RG0NUtNZbCLyupLyq
    qj4EJW9l2OP7+QdyZkhZy/jjGe5Dm+YAaTO30uFq0HAHCXTet+HoLi6Q6gO11wq6
    Xn+fGVeJg7iKtsrmpEHA9PD0A07sHQoS3hZBtUt3Ph5+D/pPYzu6XNozjqIpp5Li
    7kr4AYrSa4xH7hrSWjwV0UwGpL15vCdDnifDSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1518707952; bh=U8vG/XpZ1oCCq9eAcujv+dp76M
    jggXG45mA4bB77wx8=; b=NcudlV/A9k5dTPYZCW6agi9V5kI51W054Anoym36G5
    IbrNRDC3RhWBSXVptW2hqQ3F/QFnG3q7sHgfgPvxMhz+Ibv/IFrL634JNy7cOYNc
    SW1N0M0Nsru8e0VwhiV9cLTuhcYqYd54/S4Yr7/WaAdo7VVxOmFgfBEy3tIhmG19
    S9O54/aRvZThyRLCr3KFgArZR2hfN4CklR/AFGACnXQ2fegsyhvfIsBkZRiaF8gw
    nx/mK54sp7reUzTyLruGEy/zBqcmwP0ANX8ixtIia+CJ1zPYbQvB7M+aQG8f3i0I
    8Nf3egztkcdd2j6kiO9eU20rOxqxy9/EIMg1VfOd4PxQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161243AbeBOPTI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:19:08 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47720 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161210AbeBOPTF (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:19:05 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/45] 3.18.95-stable review
Date: Thu, 15 Feb 2018 16:16:51 +0100
Message-Id: <20180215144115.863307741@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
User-Agent: quilt/0.65
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.95-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.95-rc1
X-KernelTest-Deadline: 2018-02-17T14:41+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.18.95 release.
There are 45 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat Feb 17 14:40:54 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.95-rc1.gz
or in the git tree and branch at:
  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.95-rc1

Eric W. Biederman <ebiederm@xmission.com>
    mn10300/misalignment: Use SIGSEGV SEGV_MAPERR to report a failed user copy

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    ACPI: sbshc: remove raw pointer from printk() message

Bart Van Assche <bart.vanassche@wdc.com>
    pktcdvd: Fix pkt_setup_dev() error path

James Hogan <jhogan@kernel.org>
    EDAC, octeon: Fix an uninitialized variable warning

Max Filippov <jcmvbkbc@gmail.com>
    xtensa: fix futex_atomic_cmpxchg_inatomic

Mikulas Patocka <mpatocka@redhat.com>
    alpha: fix reboot on Avanti platform

Mikulas Patocka <mpatocka@redhat.com>
    alpha: fix crash if pthread_create races with signal delivery

Eric W. Biederman <ebiederm@xmission.com>
    signal/sh: Ensure si_signo is initialized in do_divide_error

Eric W. Biederman <ebiederm@xmission.com>
    signal/openrisc: Fix do_unaligned_access to send the proper signal

Rasmus Villemoes <linux@rasmusvillemoes.dk>
    kernel/async.c: revert "async: simplify lowest_in_progress()"

Mauro Carvalho Chehab <mchehab@osg.samsung.com>
    media: cxusb, dib0700: ignore XC2028_I2C_FLUSH

Marc Zyngier <marc.zyngier@arm.com>
    arm: KVM: Fix SMCCC handling of unimplemented SMC/HVC calls

Horia Geantă <horia.geanta@nxp.com>
    crypto: caam - fix endless loop when DECO acquire fails

Eric Biggers <ebiggers@google.com>
    crypto: cryptd - pass through absence of ->setkey()

Eric Biggers <ebiggers@google.com>
    crypto: hash - introduce crypto_hash_alg_has_setkey()

Ivan Vecera <ivecera@redhat.com>
    kernfs: fix regression in kernfs_fop_write caused by wrong type

J. Bruce Fields <bfields@redhat.com>
    NFS: commit direct writes even if they fail partially

Trond Myklebust <trond.myklebust@primarydata.com>
    NFS: Add a cond_resched() to nfs_commit_release_pages()

Miquel Raynal <miquel.raynal@free-electrons.com>
    mtd: nand: Fix nand_do_read_oob() return value

Malcolm Priestley <tvboxspy@gmail.com>
    media: dvb-usb-v2: lmedm04: move ts2020 attach to dm04_lme2510_tuner

Malcolm Priestley <tvboxspy@gmail.com>
    media: dvb-usb-v2: lmedm04: Improve logic checking of warm start

Mohamed Ghannam <simo.ghannam@gmail.com>
    dccp: CVE-2017-8824: use-after-free in DCCP code

Shuah Khan <shuahkh@osg.samsung.com>
    usbip: vhci: stop printing kernel pointer addresses in messages

Shuah Khan <shuahkh@osg.samsung.com>
    usbip: stub: stop printing kernel pointer addresses in messages

Shuah Khan <shuahkh@osg.samsung.com>
    usbip: prevent leaking socket pointer address in messages

Yuyang Du <yuyang.du@intel.com>
    usbip: vhci-hcd: Add USB3 SuperSpeed support

Andrew Goodbody <andrew.goodbody@cambrionix.com>
    usb: usbip: Fix possible deadlocks reported by lockdep

Jonathan Dieter <jdieter@lesbg.com>
    usbip: Fix potential format overflow in userspace tools

Shuah Khan <shuahkh@osg.samsung.com>
    usbip: prevent vhci_hcd driver from leaking a socket pointer address

Shuah Khan <shuahkh@osg.samsung.com>
    usbip: fix stub_rx: harden CMD_SUBMIT path to handle malicious input

Shuah Khan <shuahkh@osg.samsung.com>
    usbip: fix stub_rx: get_pipe() to validate endpoint number

Thomas Gleixner <tglx@linutronix.de>
    posix-timer: Properly check sigevent->sigev_notify

Aurelien Aptel <aaptel@suse.com>
    CIFS: zero sensitive data when freeing

Daniel N Pettersson <danielnp@axis.com>
    cifs: Fix autonegotiate security settings mismatch

Matthew Wilcox <mawilcox@microsoft.com>
    cifs: Fix missing put_xid in cifs_file_strict_mmap

Wang Han <wanghan1995315@gmail.com>
    ipv4: Map neigh lookup keys in __ipv4_neigh_lookup_noref()

Eric Biggers <ebiggers@google.com>
    KEYS: encrypted: fix buffer overread in valid_master_desc()

Krzysztof Kozlowski <k.kozlowski@samsung.com>
    ARM: exynos_defconfig: Enable NFSv4 client

Javier Martinez Canillas <javier.martinez@collabora.co.uk>
    ARM: exynos_defconfig: Enable options to mount a rootfs via NFS

Li RongQing <lirongqing@baidu.com>
    tcp: release sk_frag.page in tcp_disconnect

Chunhao Lin <hau@realtek.com>
    r8169: fix RTL8168EP take too long to complete driver initialization.

Junxiao Bi <junxiao.bi@oracle.com>
    qlcnic: fix deadlock bug

Eric Dumazet <edumazet@google.com>
    net: igmp: add a missing rcu locking section

Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
    ip6mr: fix stale iterator

Jason Wang <jasowang@redhat.com>
    vhost_net: stop device during reset owner


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/alpha/kernel/pci_impl.h                       |   3 +-
 arch/alpha/kernel/process.c                        |   3 +-
 arch/arm/configs/exynos_defconfig                  |   7 ++
 arch/arm/kvm/handle_exit.c                         |  13 ++-
 arch/mn10300/mm/misalignment.c                     |   2 +-
 arch/openrisc/kernel/traps.c                       |  10 +-
 arch/sh/kernel/traps_32.c                          |   3 +-
 arch/xtensa/include/asm/futex.h                    |  23 ++---
 crypto/ahash.c                                     |  11 +++
 crypto/cryptd.c                                    |   3 +-
 drivers/acpi/sbshc.c                               |   4 +-
 drivers/block/pktcdvd.c                            |   4 +-
 drivers/crypto/caam/ctrl.c                         |   8 +-
 drivers/edac/octeon_edac-lmc.c                     |   1 +
 drivers/media/usb/dvb-usb-v2/lmedm04.c             |  39 +++++---
 drivers/media/usb/dvb-usb/cxusb.c                  |   2 +
 drivers/media/usb/dvb-usb/dib0700_devices.c        |   1 +
 drivers/mtd/nand/nand_base.c                       |   5 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_83xx_hw.c    |  18 ++--
 drivers/net/ethernet/realtek/r8169.c               |   4 +-
 drivers/usb/usbip/stub_dev.c                       |   3 +-
 drivers/usb/usbip/stub_main.c                      |   5 +-
 drivers/usb/usbip/stub_rx.c                        |  53 ++++++++---
 drivers/usb/usbip/stub_tx.c                        |   4 +-
 drivers/usb/usbip/usbip_common.c                   |  15 +--
 drivers/usb/usbip/usbip_common.h                   |   1 +
 drivers/usb/usbip/usbip_event.c                    |   5 +-
 drivers/usb/usbip/vhci_hcd.c                       | 102 +++++++++++----------
 drivers/usb/usbip/vhci_rx.c                        |  53 ++++++-----
 drivers/usb/usbip/vhci_sysfs.c                     |  45 +++++----
 drivers/usb/usbip/vhci_tx.c                        |  17 ++--
 drivers/vhost/net.c                                |   1 +
 fs/cifs/cifsencrypt.c                              |   3 +-
 fs/cifs/connect.c                                  |   6 +-
 fs/cifs/file.c                                     |  26 +++---
 fs/cifs/misc.c                                     |  14 +--
 fs/cifs/smb2pdu.c                                  |   3 +-
 fs/kernfs/file.c                                   |   2 +-
 fs/nfs/direct.c                                    |   4 +-
 fs/nfs/write.c                                     |   2 +
 include/crypto/internal/hash.h                     |   2 +
 include/net/arp.h                                  |   6 +-
 kernel/async.c                                     |  20 ++--
 kernel/time/posix-timers.c                         |  34 ++++---
 net/dccp/proto.c                                   |   5 +
 net/ipv4/igmp.c                                    |   4 +
 net/ipv4/tcp.c                                     |   6 ++
 net/ipv6/ip6mr.c                                   |   1 +
 security/keys/encrypted-keys/encrypted.c           |  31 +++----
 tools/usb/usbip/libsrc/usbip_common.c              |   9 +-
 tools/usb/usbip/libsrc/usbip_host_driver.c         |  27 +++++-
 tools/usb/usbip/libsrc/vhci_driver.c               |   8 +-
 53 files changed, 405 insertions(+), 280 deletions(-)
