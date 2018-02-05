Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3155980-1517855797-2-7495553400574744380
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517855796; b=jKscGKfe5CzLKJVicn73bzDfPvGoDMeTrBPsCOGNSim81us
    8vPeCnKxk20H74l6hx9YQSjDsTEz8tsCN1aWRr8M9LXVuweYSlo4g8+FenmsY1rL
    rAZ6bHgEIUWYpWcZjXPimhEvU+LhDT8W+3lyAXMzHE1OwZSR0fncBegFg8EhpvpK
    BdMW6gmsGSmOk96pAXFquiT2/IIMuXDU2WFImK1PHf5E0YT480Vab351pIdipOnS
    PDeKwadjJZ6XVzAh5qWbP4e7454jUNXovTLY/31UY7a43Tmdmynd9n/NGJoo0Cct
    6in+avWm/fCEBwfNtzUogL/T67I2kEyWpBd3yWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1517855796; bh=LF3ae9z1AE6ZSmPVq4Qy/yQRZH
    46VmefbIKstf5TKfc=; b=rEElifUzSOqC/psONsiBrp7y+oDwVQgiAD+Mos9tZn
    D5OX/9WzP0cVcgwfkh50iLSbEs2vB9rL31lXRxZNcELua1tDZ07oKKz2ZYqWV7FR
    grYCrAFkYdyvLtkjkSaMEZDIky+fv4Bt/FPCAkrvpTF04GuBQX4ZTRZu56x5M9Xu
    M+QFvWYnyPVoWePUhGWEF65RPTAIU0DVqhsAMmmFNhx0ONxuUVQ9E6aurCsq9yqo
    owFQoRsRFNfvvopJUCs5cvgGttUlO1buZql1nhGo5QqrkvYC81xgAUABwDqAPfbr
    sGRvEkX7khwKyn4rQLcvhYCAe9VmOLTNsZ7uPmScFHXQ==
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
        id S1754036AbeBESgd (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 13:36:33 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:54170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753937AbeBES0v (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 13:26:51 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/36] 3.18.94-stable review
Date: Mon,  5 Feb 2018 10:23:28 -0800
Message-Id: <20180205182351.774761393@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
User-Agent: quilt/0.65
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.94-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.94-rc1
X-KernelTest-Deadline: 2018-02-07T18:23+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.18.94 release.
There are 36 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Wed Feb  7 18:23:41 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.94-rc1.gz
or in the git tree and branch at:
  git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.94-rc1

Jesse Chan <jc@linux.com>
    ASoC: pcm512x: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Stefan Agner <stefan@agner.ch>
    spi: imx: do not access registers while clocks disabled

Mark Salyzyn <salyzyn@android.com>
    selinux: general protection fault in sock_has_perm

Oliver Neukum <oneukum@suse.com>
    usb: uas: unconditionally bring back host after reset

Hemant Kumar <hemantk@codeaurora.org>
    usb: f_fs: Prevent gadget unbind if it is already unbound

Johan Hovold <johan@kernel.org>
    USB: serial: simple: add Motorola Tetra driver

Shuah Khan <shuahkh@osg.samsung.com>
    usbip: list: don't list devices attached to vhci_hcd

Shuah Khan <shuahkh@osg.samsung.com>
    usbip: prevent bind loops on devices attached to vhci_hcd

Jia-Ju Bai <baijiaju1990@gmail.com>
    USB: serial: io_edgeport: fix possible sleep-in-atomic

Oliver Neukum <oneukum@suse.com>
    CDC-ACM: apply quirk for card reader

Hans de Goede <hdegoede@redhat.com>
    USB: cdc-acm: Do not log urb submission errors on disconnect

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    USB: serial: pl2303: new device id for Chilitag

Larry Finger <Larry.Finger@lwfinger.net>
    staging: rtl8188eu: Fix incorrect response to SIOCGIWESSID

Colin Ian King <colin.king@canonical.com>
    usb: gadget: don't dereference g until after it has been null checked

Icenowy Zheng <icenowy@aosc.io>
    media: usbtv: add a new usbid

Gustavo A. R. Silva <garsilva@embeddedor.com>
    scsi: ufs: ufshcd: fix potential NULL pointer dereference in ufshcd_config_vreg

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    quota: Check for register_shrinker() failure.

Geert Uytterhoeven <geert+renesas@glider.be>
    net: ethernet: xilinx: Mark XILINX_LL_TEMAC broken on 64-bit

Robert Lippert <roblip@gmail.com>
    hwmon: (pmbus) Use 64bit math for DIRECT format values

Andrew Elble <aweits@rit.edu>
    nfsd: check for use of the closed special stateid

Trond Myklebust <trond.myklebust@primarydata.com>
    nfsd: CLOSE SHOULD return the invalid special stateid for NFSv4.x (x>0)

Eduardo Otubo <otubo@redhat.com>
    xen-netfront: remove warning when unloading module

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: VMX: Fix rflags cache during vCPU reset

Chun-Yeow Yeoh <yeohchunyeow@gmail.com>
    mac80211: fix the update of path metric for RANN frame

Michael Lyle <mlyle@lyle.org>
    bcache: check return value of register_shrinker

Wanpeng Li <wanpeng.li@hotmail.com>
    KVM: X86: Fix operand/address-size during instruction decoding

Liran Alon <liran.alon@oracle.com>
    KVM: x86: Don't re-execute instruction when not passing CR2 value

Liran Alon <liran.alon@oracle.com>
    KVM: x86: emulator: Return to user-mode on L1 CPL=0 emulation failure

Lyude Paul <lyude@redhat.com>
    igb: Free IRQs when device is hotplugged

Jesse Chan <jc@linux.com>
    gpio: iop: add missing MODULE_DESCRIPTION/AUTHOR/LICENSE

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Make ioctls race-free

Linus Torvalds <torvalds@linux-foundation.org>
    loop: fix concurrent lo_open/lo_release

Richard Weinberger <richard@nod.at>
    um: Remove copy&paste code from init.h

Richard Weinberger <richard@nod.at>
    um: Stop abusing __KERNEL__

Thomas Meyer <thomas@m3y3r.de>
    um: link vmlinux with -no-pie

Dmitry Torokhov <dmitry.torokhov@gmail.com>
    Input: do not emit unneeded EV_SYN when suspending


-------------

Diffstat:

 Makefile                                       |  4 ++--
 arch/um/Makefile                               |  9 +++++----
 arch/um/drivers/mconsole.h                     |  2 +-
 arch/um/include/shared/init.h                  | 24 ++----------------------
 arch/um/include/shared/user.h                  |  2 +-
 arch/x86/include/asm/kvm_host.h                |  3 ++-
 arch/x86/kvm/emulate.c                         |  7 +++++++
 arch/x86/kvm/vmx.c                             |  4 ++--
 arch/x86/kvm/x86.c                             |  2 +-
 arch/x86/um/shared/sysdep/tls.h                |  6 +++---
 drivers/block/loop.c                           | 10 ++++++++--
 drivers/gpio/gpio-iop.c                        |  4 ++++
 drivers/hwmon/pmbus/pmbus_core.c               | 21 ++++++++++++---------
 drivers/input/input.c                          |  5 ++++-
 drivers/md/bcache/btree.c                      |  5 ++++-
 drivers/media/usb/usbtv/usbtv-core.c           |  1 +
 drivers/net/ethernet/intel/igb/igb_main.c      |  2 +-
 drivers/net/ethernet/xilinx/Kconfig            |  1 +
 drivers/net/xen-netfront.c                     | 18 ++++++++++++++++++
 drivers/scsi/ufs/ufshcd.c                      |  7 +++++--
 drivers/spi/spi-imx.c                          | 15 +++++++++++++--
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 14 ++++----------
 drivers/usb/class/cdc-acm.c                    |  5 ++++-
 drivers/usb/gadget/composite.c                 |  7 +++++--
 drivers/usb/gadget/function/f_fs.c             |  3 ++-
 drivers/usb/serial/Kconfig                     |  1 +
 drivers/usb/serial/io_edgeport.c               |  1 -
 drivers/usb/serial/pl2303.c                    |  1 +
 drivers/usb/serial/pl2303.h                    |  1 +
 drivers/usb/serial/usb-serial-simple.c         |  7 +++++++
 drivers/usb/storage/uas.c                      |  7 +++----
 fs/nfsd/nfs4state.c                            | 15 +++++++++++++--
 fs/quota/dquot.c                               |  3 ++-
 net/mac80211/mesh_hwmp.c                       | 15 +++++++++------
 security/selinux/hooks.c                       |  2 ++
 sound/core/seq/seq_clientmgr.c                 | 10 ++++++++--
 sound/core/seq/seq_clientmgr.h                 |  1 +
 sound/soc/codecs/pcm512x-spi.c                 |  4 ++++
 tools/usb/usbip/src/usbip_bind.c               |  9 +++++++++
 tools/usb/usbip/src/usbip_list.c               |  9 +++++++++
 40 files changed, 182 insertions(+), 85 deletions(-)
