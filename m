Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1524142-1518326773-2-2767665019471803740
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518326772; b=S/IihPzPlU6eIhKTbh1G8N27GGnI99waI9AJ7LmGNYiCiQD
    Ph1lDKvPnyD+pYnmdUAfooGJ8EVsbgg2158zYYSVZ8V118Hkyj6Y4la10XLz8qov
    S/7zKaVdI835gMx5gLGYZTp//If7KA2fXnL6HFmzGAp2MgAVBcaqm+FIgJUTchM7
    tjGkdW57nAz9eacJ7aV2gMYQldDnyEIBXzLkdPw71qHoAfrbjPjA5lcdTvYDXoOK
    tkMl9uXPALF4yljtND7j9JsVdhwT7uIazBPm/jDgtzGJaT5To5idewt3hHot+Quv
    BEaGS8OH8oHUCRkBfpBiwPk22Cxl2VR96McAxLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:sender:list-id;
    s=arctest; t=1518326772; bh=XmaSHrqub6rTQlwHRdqYAGQLpAsKIxhzw/R
    /y7zY6UU=; b=L4EpQlb8/NZO3nW3p6UisVfiGPbcFJpuFN00tclcSXfii0CIP1m
    iQulEzuQopcMJeMCi/4/70s+qUbXsROS7nX0tW9Lv/5hgLu0Hnzrlt97BSho+NuJ
    CqZFNg5Glw4s71a0UWnJWJbawha2RtGogfpVkCuaa5ElF5o9q4igQPs5dMUNa6P3
    r+muj1FXCj4mlUNkK0Mf1aOVefAa021v9tD6s+gGj6N2nQ7xnRN+iVU9VCTwb77p
    JWxKbePHwaSl08F3LNkC8K7PtTZ9NGBn2jnGtNO1bSKQivbEZHBOhzxsXWN18JvF
    V1b3Ts9qc1/lzknTyhDjAezlIRH7RS+L3bA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753850AbeBKFYD (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 00:24:03 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41328 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752484AbeBKEdk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:40 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        akpm@linux-foundation.org
Date: Sun, 11 Feb 2018 04:20:02 +0000
Message-ID: <lsq.1518322802.943358572@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 00/79] 3.2.99-rc1 review
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.2.99 release.
There are 79 patches in this series, which will be posted as responses
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Tue Feb 13 12:00:00 UTC 2018.
Anything received after that time might be too late.

All the patches have also been committed to the linux-3.2.y-rc branch of
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-stable-rc.git .
A shortlog and diffstat can be found below.

Ben.

-------------

Al Viro (2):
      autofs4: autofs4_wait() vs. autofs4_catatonic_mode() race
         [4041bcdc7bef06a2fb29c57394c713a74bd13b08]
      autofs4: catatonic_mode vs. notify_daemon race
         [8753333266be67ff3a984ac1f6566d31c260bee4]

Alan (1):
      usbip: Fix sscanf handling
         [2d32927127f44d755780aa5fa88c8c34e72558f8]

Alan Stern (1):
      USB: usbfs: compute urb->actual_length for isochronous
         [2ef47001b3ee3ded579b7532ebdcf8680e4d8c54]

Alex Chen (1):
      ocfs2: should wait dio before inode lock in ocfs2_setattr()
         [28f5a8a7c033cbf3e32277f4cc9c6afd74f05300]

Alexander Potapenko (1):
      sctp: fully initialize the IPv6 address in sctp_v6_to_addr()
         [15339e441ec46fbc3bf3486bb1ae4845b0f1bb8d]

Alexander Steffen (1):
      tpm-dev-common: Reject too short writes
         [ee70bc1e7b63ac8023c9ff9475d8741e397316e7]

Alexandre Belloni (1):
      rtc: set the alarm to the next expiring timer
         [74717b28cb32e1ad3c1042cafd76b264c8c0f68d]

Andreas Rohner (1):
      nilfs2: fix race condition that causes file system corruption
         [31ccb1f7ba3cfe29631587d451cf5bb8ab593550]

Arnd Bergmann (2):
      Input: adxl34x - do not treat FIFO_MODE() as boolean
         [1dbc080c9ef6bcfba652ef0d6ae919b8c7c85a1d]
      isofs: fix timestamps beyond 2027
         [34be4dbf87fc3e474a842305394534216d428f5d]

Bart Van Assche (1):
      IB/srp: Avoid that a cable pull can trigger a kernel crash
         [8a0d18c62121d3c554a83eb96e2752861d84d937]

Bart Westgeest (1):
      staging: usbip: removed #if 0'd out code
         [34c09578179f5838e5958c45e8aed4edc9c6c3b8]

Bernhard Rosenkraenzer (1):
      USB: Add delay-init quirk for Corsair K70 LUX keyboards
         [a0fea6027f19c62727315aba1a7fae75a9caa842]

Brent Taylor (1):
      mtd: nand: Fix writing mtdoops to nand flash.
         [30863e38ebeb500a31cecee8096fb5002677dd9b]

Chuck Lever (1):
      nfs: Fix ugly referral attributes
         [c05cefcc72416a37eba5a2b35f0704ed758a9145]

Colin Ian King (1):
      rtc: interface: ignore expired timers when enqueuing new timers
         [2b2f5ff00f63847d95adad6289bd8b05f5983dd5]

Dan Carpenter (2):
      eCryptfs: use after free in ecryptfs_release_messaging()
         [db86be3a12d0b6e5c5b51c2ab2a48f06329cb590]
      scsi: bfa: integer overflow in debugfs
         [3e351275655d3c84dc28abf170def9786db5176d]

Eric Biggers (1):
      dm bufio: fix integer overflow when limiting maximum cache size
         [74d4108d9e681dbbe4a2940ed8fdff1f6868184c]

Eric Dumazet (1):
      netfilter: xt_TCPMSS: add more sanity tests on tcph->doff
         [2638fd0f92d4397884fd991d8f4925cb3f081901]

Eric W. Biederman (1):
      net/sctp: Always set scope_id in sctp_inet6_skb_msgname
         [7c8a61d9ee1df0fb4747879fa67a99614eb62fec]

Felipe Balbi (1):
      usb: add helper to extract bits 12:11 of wMaxPacketSize
         [541b6fe63023f3059cf85d47ff2767a3e42a8e44]

Gabriele Paoloni (1):
      PCI/AER: Report non-fatal errors only to the affected endpoint
         [86acc790717fb60fb51ea3095084e331d8711c74]

Guenter Roeck (1):
      kaiser: Set _PAGE_NX only if supported
         [61e9b3671007a5da8127955a1a3bda7e0d5f42e8]

Guillaume Nault (5):
      l2tp: don't register sessions in l2tp_session_create()
         [3953ae7b218df4d1e544b98a393666f9ae58a78c]
      l2tp: ensure sessions are freed after their PPPOL2TP socket
         [cdd10c9627496ad25c87ce6394e29752253c69d3]
      l2tp: initialise PPP sessions before registering them
         [f98be6c6359e7e4a61aaefb9964c1db31cb9ec0c]
      l2tp: initialise l2tp_eth sessions before registering them
         [ee28de6bbd78c2e18111a0aef43ea746f28d2073]
      l2tp: protect sock pointer of struct pppol2tp_session with RCU
         [ee40fb2e1eb5bc0ddd3f2f83c6e39a454ef5a741]

Hou Tao (1):
      dm: fix race between dm_get_from_kobject() and __dm_destroy()
         [b9a41d21dceadf8104812626ef85dc56ee8a60ed]

Jan Harkes (1):
      coda: fix 'kernel memory exposure attempt' in fsync
         [d337b66a4c52c7b04eec661d86c2ef6e168965a2]

Jason Gunthorpe (1):
      sctp: Fixup v4mapped behaviour to comply with Sock API
         [299ee123e19889d511092347f5fc14db0f10e3a6]

Jens Axboe (1):
      blktrace: fix unlocked access to init/start-stop/teardown
         [1f2cac107c591c24b60b115d6050adc213d10fc0]

Johan Hovold (2):
      USB: serial: garmin_gps: fix I/O after failed probe and remove
         [19a565d9af6e0d828bd0d521d3bafd5017f4ce52]
      USB: serial: garmin_gps: fix memory leak on probe errors
         [74d471b598444b7f2d964930f7234779c80960a0]

Ladi Prosek (1):
      KVM: nVMX: set IDTR and GDTR limits when loading L1 host state
         [21f2d551183847bc7fbe8d866151d00cdad18752]

Ladislav Michl (1):
      video: udlfb: Fix read EDID timeout
         [c98769475575c8a585f5b3952f4b5f90266f699b]

Lepton Wu (1):
      kaiser: Set _PAGE_NX only if supported
         [not upstream; specific to KAISER backport]

Mark Bloch (1):
      IB/mlx4: Increase maximal message size under UD QP
         [5f22a1d87c5315a98981ecf93cd8de226cffe6ca]

Markus Elfring (1):
      media: omap_vout: Fix a possible null pointer dereference in omap_vout_open()
         [bfba2b3e21b9426c0f9aca00f3cad8631b2da170]

Masami Hiramatsu (1):
      x86/decoder: Add new TEST instruction pattern
         [12a78d43de767eaf8fb272facb7a7b6f2dc6a9df]

Mauro Carvalho Chehab (1):
      [media] cx231xx: Fix the max number of interfaces
         [139d28826b8e2bc7a9232fde0d2f14812914f501]

Michele Baldessari (1):
      media: Don't do DMA on stack for firmware upload in the AS102 driver
         [b3120d2cc447ee77b9d69bf4ad7b452c9adb4d39]

Mike Snitzer (1):
      dm: discard support requires all targets in a table support discards
         [8a74d29d541cd86569139c6f3f44b2d210458071]

Mohamed Ghannam (2):
      RDS: Heap OOB write in rds_message_alloc_sgs()
         [c095508770aebf1b9218e77026e48345d719b17c]
      RDS: null pointer dereference in rds_atomic_free_op
         [7d11f77f84b27cef452cee332f4e469503084737]

Nadav Amit (1):
      KVM: vmx: Inject #GP on invalid PAT CR
         [4566654bb9be9e8864df417bb72ceee5136b6a6a]

NeilBrown (2):
      autofs: don't fail mount for transient error
         [ecc0c469f27765ed1e2b967be0aa17cee1a60b76]
      autofs: fix careless error in recent commit
         [302ec300ef8a545a7fc7f667e5fd743b091c2eeb]

Pablo Neira Ayuso (3):
      netfilter: xt_TCPMSS: fix handling of malformed TCP header and options
         [71ffe9c77dd7a2b62207953091efa8dafec958dd]
      netfilter: xt_TCPOPTSTRIP: don't use tcp_hdr()
         [ed82c437320c48a4032492f4a55a7e2c934158b6]
      netfilter: xt_TCPOPTSTRIP: fix possible mangling beyond packet boundary
         [bc6bcb59dd7c184d229f9e86d08aa56059938a4c]

Paolo Bonzini (1):
      KVM: SVM: obey guest PAT
         [15038e14724799b8c205beb5f20f9e54896013c3]

Phil Oester (2):
      netfilter: xt_TCPMSS: Fix missing fragmentation handling
         [b396966c4688522863572927cb30aa874b3ec504]
      netfilter: xt_TCPMSS: correct return value in tcpmss_mangle_packet
         [1205e1fa615805c9efa97303b552cf445965752a]

Rusty Russell (1):
      x86/smp: Don't ever patch back to UP if we unplug cpus
         [816afe4ff98ee10b1d30fd66361be132a0a5cee6]

Sean Young (1):
      media: rc: check for integer overflow
         [3e45067f94bbd61dec0619b1c32744eb0de480c8]

Shuah Khan (4):
      usbip: fix stub_rx: get_pipe() to validate endpoint number
         [635f545a7e8be7596b9b2b6a43cab6bbd5a88e43]
      usbip: fix stub_rx: harden CMD_SUBMIT path to handle malicious input
         [c6688ef9f29762e65bce325ef4acd6c675806366]
      usbip: fix stub_send_ret_submit() vulnerability to null transfer_buffer
         [be6123df1ea8f01ee2f896a16c2b7be3e4557a5a]
      usbip: prevent vhci_hcd driver from leaking a socket pointer address
         [2f2d0088eb93db5c649d2a5e34a3800a8a935fc5]

Stanislaw Gruszka (1):
      rt2x00usb: mark device removed when get ENOENT usb error
         [bfa62a52cad93686bb8d8171ea5288813248a7c6]

Takashi Iwai (6):
      ALSA: seq: Make ioctls race-free
         [b3defb791b26ea0683a93a4f49c77ec45ec96f10]
      ALSA: timer: Remove kernel warning at compat ioctl error paths
         [3d4e8303f2c747c8540a0a0126d0151514f6468b]
      ALSA: usb-audio: Add sanity checks in v2 clock parsers
         [0a62d6c966956d77397c32836a5bbfe3af786fc1]
      ALSA: usb-audio: Add sanity checks to FE parser
         [d937cd6790a2bef2d07b500487646bd794c039bb]
      ALSA: usb-audio: Fix potential out-of-bound access at parsing SU
         [f658f17b5e0e339935dca23e77e0f3cad591926b]
      ALSA: usb-audio: Fix potential zero-division at parsing FU
         [8428a8ebde2db1e988e41a58497a28beb7ce1705]

Tom Parkin (3):
      l2tp: add session reorder queue purge function to core
         [48f72f92b31431c40279b0fba6c5588e07e67d95]
      l2tp: purge session reorder queue on delete
         [4c6e2fd35460208596fa099ee0750a4b0438aa5c]
      l2tp: push all ppp pseudowire shutdown through .release handler
         [cf2f5c886a209377daefd5d2ba0bcd49c3887813]

Tuomas Tynkkynen (2):
      fs/9p: Compare qid.path in v9fs_test_inode
         [8ee031631546cf2f7859cc69593bd60bbdd70b46]
      net/9p: Switch to wait_event_killable()
         [9523feac272ccad2ad8186ba4fcc89103754de52]

Vasily Gorbik (1):
      s390/disassembler: increase show_code buffer size
         [b192571d1ae375e0bbe0aa3ccfa1a3c3704454b9]

Vijendar Mukunda (1):
      ALSA: hda: Add Raven PCI ID
         [9ceace3c9c18c67676e75141032a65a8e01f9a7a]

Waiman Long (1):
      blktrace: Fix potential deadlock between delete & sysfs ops
         [5acb3cc2c2e9d3020a4fee43763c6463767f1572]

Younger Liu (1):
      ocfs2: fix issue that ocfs2_setattr() does not deal with new_i_size==i_size
         [d62e74be1270c89fbaf7aada8218bfdf62d00a58]

Zhou Chengming (1):
      kprobes, x86/alternatives: Use text_mutex to protect smp_alt_modules
         [e846d13958066828a9483d862cc8370a72fadbb6]

 Documentation/kernel-parameters.txt                |   3 -
 Makefile                                           |   4 +-
 arch/s390/kernel/dis.c                             |   4 +-
 arch/x86/include/asm/alternative.h                 |   4 +-
 arch/x86/kernel/alternative.c                      | 129 +++-------
 arch/x86/kernel/smpboot.c                          |  20 +-
 arch/x86/kvm/svm.c                                 |   7 +
 arch/x86/kvm/vmx.c                                 |   4 +
 arch/x86/kvm/x86.c                                 |   5 +-
 arch/x86/kvm/x86.h                                 |   2 +
 arch/x86/lib/x86-opcode-map.txt                    |   2 +-
 arch/x86/mm/kaiser.c                               |   5 +-
 arch/x86/xen/smp.c                                 |   6 +-
 block/blk-core.c                                   |   3 +
 drivers/char/tpm/tpm.c                             |   6 +
 drivers/infiniband/hw/mlx4/qp.c                    |   2 +-
 drivers/infiniband/ulp/srp/ib_srp.c                |  23 +-
 drivers/input/misc/adxl34x.c                       |   2 +-
 drivers/md/dm-bufio.c                              |  15 +-
 drivers/md/dm-table.c                              |  32 ++-
 drivers/md/dm.c                                    |  12 +-
 drivers/media/rc/ir-lirc-codec.c                   |   9 +-
 drivers/media/video/cx231xx/cx231xx-cards.c        |   3 +-
 drivers/media/video/omap/omap_vout.c               |   3 +-
 drivers/mtd/nand/nand_base.c                       |   9 +-
 drivers/net/wireless/rt2x00/rt2x00usb.c            |   6 +-
 drivers/pci/pcie/aer/aerdrv_core.c                 |   9 +-
 drivers/rtc/interface.c                            |  16 +-
 drivers/scsi/bfa/bfad_debugfs.c                    |   5 +-
 drivers/staging/media/as102/as102_fw.c             |  28 ++-
 drivers/staging/usbip/stub_rx.c                    |  58 +++--
 drivers/staging/usbip/stub_tx.c                    |   7 +
 drivers/staging/usbip/usbip_common.h               |   1 +
 .../staging/usbip/userspace/libsrc/usbip_common.c  |   2 +-
 .../staging/usbip/userspace/libsrc/vhci_driver.c   |   8 +-
 drivers/staging/usbip/vhci_hcd.c                   |  39 ---
 drivers/staging/usbip/vhci_sysfs.c                 |  20 +-
 drivers/usb/core/devio.c                           |  14 ++
 drivers/usb/core/quirks.c                          |   3 +
 drivers/usb/serial/garmin_gps.c                    |  22 +-
 drivers/video/udlfb.c                              |  10 +-
 fs/9p/vfs_inode.c                                  |   3 +
 fs/9p/vfs_inode_dotl.c                             |   3 +
 fs/autofs4/waitq.c                                 |  45 +++-
 fs/coda/upcall.c                                   |   3 +-
 fs/ecryptfs/messaging.c                            |   8 +-
 fs/isofs/isofs.h                                   |   2 +-
 fs/isofs/rock.h                                    |   2 +-
 fs/isofs/util.c                                    |   2 +-
 fs/nfs/nfs4proc.c                                  |  18 +-
 fs/nilfs2/segment.c                                |   6 +-
 fs/ocfs2/alloc.c                                   |   2 +-
 fs/ocfs2/file.c                                    |  18 +-
 include/linux/blkdev.h                             |   1 +
 include/linux/usb/ch9.h                            |  19 ++
 include/net/sctp/sctp.h                            |   2 +
 include/net/sctp/structs.h                         |   8 +-
 kernel/cpu.c                                       |  11 -
 kernel/extable.c                                   |   2 +
 kernel/trace/blktrace.c                            |  76 ++++--
 net/9p/client.c                                    |   3 +-
 net/9p/trans_virtio.c                              |  13 +-
 net/l2tp/l2tp_core.c                               |  42 ++--
 net/l2tp/l2tp_core.h                               |   3 +
 net/l2tp/l2tp_eth.c                                |  96 +++++--
 net/l2tp/l2tp_ppp.c                                | 276 ++++++++++++---------
 net/netfilter/xt_TCPMSS.c                          |  43 ++--
 net/netfilter/xt_TCPOPTSTRIP.c                     |  19 +-
 net/rds/rdma.c                                     |   4 +
 net/sctp/ipv6.c                                    | 160 ++++++------
 net/sctp/protocol.c                                |  12 +-
 net/sctp/socket.c                                  |  33 ++-
 net/sctp/transport.c                               |   4 +-
 net/sctp/ulpevent.c                                |   2 +-
 sound/core/seq/seq_clientmgr.c                     |  10 +-
 sound/core/seq/seq_clientmgr.h                     |   1 +
 sound/core/timer_compat.c                          |  12 +-
 sound/pci/hda/hda_intel.c                          |   3 +
 sound/usb/clock.c                                  |   9 +-
 sound/usb/mixer.c                                  |  19 +-
 80 files changed, 916 insertions(+), 641 deletions(-)

-- 
Ben Hutchings
Sturgeon's Law: Ninety percent of everything is crap.
