Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3278546-1521213797-2-17288191809541698689
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521213796; b=BxSgkYy3pIq9ZK/CNNOgvEwzQPalPwyE9GN59PDzMjTGgtE
    EgcKPqZf2hJqcNc8J2Ohy7GKsBAJHWyz82PhyKBuyD0dw6FmDstcCS/3NgboJ9Lx
    41ldT3scPkm9W8DWLH0rdae1LPiKvFr8rM8nfo3fPW+YDuuv0onP0TtSgvqAvfzM
    C3104dCmITRkZVIaZcYPD+f9JVpqjok4cAxqQDmAIMtrVNlmLiVuCN1XCvjSnzqo
    e+c3xgrhOe1qlucJ+XQ+4tOk3IiFCniaUXOjwLrMKgKRiORt2bpwaPg/1YoXXcm5
    kgMba0q3prZ5zrC7fS6Xjk07GZYKU7orIX/4YZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1521213796; bh=UNaQJgv3TXmz4+Jpte2OftA3um
    dJw31nppaIM7gNeFc=; b=PrQuZv4jteAJtYqzP1RpHoAiAHCGWUEKwKsVSdzh1W
    +OGjxCXNTZ4ANZP6Bxw4kB0AvTGjRPUQpaSuj/arrlqOfcza7sbs3D16vXOXGudp
    0vqrY7yoPHAOuBGNEzA1+7PJEDGqvG69Md2QBdiYqCGm4gaElPdsnZeFvxwIc8xU
    MttZlOjP49Dg7SzxbTpU1+0zOCdwfj4nI2NzoMgSecTFgb3ZY/7i0EwuUgs+fJX5
    ib/bQS78cy48Cj5f2ukwHu17DVMT8kdxxsEYkWAP1K0SUArpS4Rxd/uqsAZt9gGe
    V8CJripVr0xeJ3bGZJg2r2C5QDCRXYOBUr7D8lxlvqVw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753102AbeCPPXP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:23:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60744 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752873AbeCPPXO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:23:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: [PATCH 3.18 00/25] 3.18.100-stable review
Date: Fri, 16 Mar 2018 16:22:47 +0100
Message-Id: <20180316152232.750180431@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
User-Agent: quilt/0.65
X-stable: review
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-3.18.100-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-3.18.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 3.18.100-rc1
X-KernelTest-Deadline: 2018-03-18T15:22+00:00
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is the start of the stable review cycle for the 3.18.100 release.
There are 25 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sun Mar 18 15:22:18 UTC 2018.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.100-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 3.18.100-rc1

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    fixup: sctp: verify size of a new chunk in _sctp_make_chunk()

Nikola Ciprich <nikola.ciprich@linuxbox.cz>
    serial: 8250_pci: Add Brainboxes UC-260 4 port serial device

Pete Zaitcev <zaitcev@kotori.zaitcev.us>
    usb: usbmon: Read text within supplied buffer size

Julia Lawall <Julia.Lawall@lip6.fr>
    USB: usbmon: remove assignment from IS_ERR argument

Danilo Krummrich <danilokrummrich@dk-develop.de>
    usb: quirks: add control message delay for 1b1c:1b20

Joel Fernandes <joelaf@google.com>
    staging: android: ashmem: Fix lockdep issue during llseek

Oliver Neukum <oneukum@suse.com>
    uas: fix comparison for error code

Jonas Danielsson <jonas@orbital-systems.com>
    tty/serial: atmel: add new version check for usart

Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
    serial: sh-sci: prevent lockup on full TTY buffers

H.J. Lu <hjl.tools@gmail.com>
    x86: Treat R_X86_64_PLT32 as R_X86_64_PC32

Josh Poimboeuf <jpoimboe@redhat.com>
    x86/module: Detect and skip invalid relocations

Russell King <rmk+kernel@arm.linux.org.uk>
    scripts: recordmcount: break hardlinks

Clay McClure <clay@daemons.net>
    ubi: Fix race condition between ubi volume creation and udev

Florian Westphal <fw@strlen.de>
    netfilter: ipv6: fix use-after-free Write in nf_nat_ipv6_manip_pkt

Florian Westphal <fw@strlen.de>
    netfilter: bridge: ebt_among: add missing match size checks

Florian Westphal <fw@strlen.de>
    netfilter: ebtables: CONFIG_COMPAT: don't trust userland offsets

Eric Dumazet <edumazet@google.com>
    netfilter: IDLETIMER: be syzkaller friendly

Paolo Abeni <pabeni@redhat.com>
    netfilter: nat: cope with negative port range

Paolo Abeni <pabeni@redhat.com>
    netfilter: x_tables: fix missing timer initialization in xt_LED

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: More protection for concurrent write and ioctl races

Takashi Iwai <tiwai@suse.de>
    ALSA: seq: Don't allow resizing pool in use

Seunghun Han <kkamagui@gmail.com>
    x86/MCE: Serialize sysfs changes

Zhang Bo <zbsdta@126.com>
    Input: matrix_keypad - fix race when disabling interrupts

Justin Chen <justinpopo6@gmail.com>
    MIPS: BMIPS: Do not mask IPIs during suspend

himanshu.madhani@cavium.com <himanshu.madhani@cavium.com>
    scsi: qla2xxx: Fix NULL pointer crash due to active timer for ABTS


-------------

Diffstat:

 Makefile                                 |   4 +-
 arch/mips/kernel/smp-bmips.c             |   8 +-
 arch/x86/kernel/cpu/mcheck/mce.c         |  22 +++++-
 arch/x86/kernel/machine_kexec_64.c       |   1 +
 arch/x86/kernel/module.c                 |  14 ++++
 arch/x86/tools/relocs.c                  |   3 +
 drivers/input/keyboard/matrix_keypad.c   |   4 +-
 drivers/mtd/ubi/vmt.c                    |  15 ++--
 drivers/scsi/qla2xxx/qla_init.c          |   1 +
 drivers/staging/android/ashmem.c         |  15 ++--
 drivers/tty/serial/8250/8250_pci.c       |  11 +++
 drivers/tty/serial/atmel_serial.c        |   1 +
 drivers/tty/serial/sh-sci.c              |   2 +
 drivers/usb/core/message.c               |   4 +
 drivers/usb/core/quirks.c                |   3 +-
 drivers/usb/mon/mon_text.c               | 124 +++++++++++++++++++------------
 drivers/usb/storage/uas.c                |   2 +-
 include/linux/usb/quirks.h               |   3 +
 net/bridge/netfilter/ebt_among.c         |  21 +++++-
 net/bridge/netfilter/ebtables.c          |  13 +++-
 net/ipv6/netfilter/nf_nat_l3proto_ipv6.c |   4 +
 net/netfilter/nf_nat_proto_common.c      |   7 +-
 net/netfilter/xt_IDLETIMER.c             |   9 ++-
 net/netfilter/xt_LED.c                   |  12 +--
 net/sctp/sm_make_chunk.c                 |   2 +-
 scripts/recordmcount.c                   |  14 ++++
 sound/core/seq/seq_clientmgr.c           |  21 ++++--
 sound/core/seq/seq_fifo.c                |   2 +-
 sound/core/seq/seq_memory.c              |  14 +++-
 sound/core/seq/seq_memory.h              |   3 +-
 30 files changed, 262 insertions(+), 97 deletions(-)
