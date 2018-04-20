Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754653AbeDTKrb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 06:47:31 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:24767 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754549AbeDTKr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 06:47:29 -0400
X-IronPort-AV: E=Sophos;i="5.49,301,1520899200";
   d="scan'208";a="675575123"
Subject: [PATCH 0/3] Introduce Xen fault injection facility
From: Stanislav Kinsburskii <staskins@amazon.com>
CC: <jakub.kicinski@netronome.com>, <hpa@zytor.com>, <mcroce@redhat.com>,
        <staskins@amazon.com>, <tglx@linutronix.de>, <ggarcia@abra.uab.cat>,
        <daniel@iogearbox.net>, <x86@kernel.org>, <mingo@redhat.com>,
        <xen-devel@lists.xenproject.org>, <axboe@kernel.dk>,
        <konrad.wilk@oracle.com>, <amir.jer.levy@intel.com>,
        <paul.durrant@citrix.com>, <stefanha@redhat.com>,
        <dsa@cumulusnetworks.com>, <boris.ostrovsky@oracle.com>,
        <jgross@suse.com>, <linux-block@vger.kernel.org>,
        <wei.liu2@citrix.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <davem@davemloft.net>,
        <dwmw@amazon.co.uk>, <roger.pau@citrix.com>
Date: Fri, 20 Apr 2018 10:47:20 +0000
Message-ID: <20180420104603.17823.31095.stgit@dev-dsk-staskins-1a-ca5afbf2.eu-west-1.amazon.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3KAlakM016950

This series adds a facility, which can be used to instrument Xen code with
fault injections.
It is based "Fault injection capabilities infrastructure" described here:
- Documentation/fault-injection/fault-injection.txt

First patch adds a generic facility to use anywhere in Xen.
When using it all the fault injection user land control directories (if
any) will appear here:
- /sys/kernel/debug/xen/fault_inject/

To distinguish with generic (or core) Xen fault injections, next two
patches add additional directories to the root path above for blkback and
netback drivers respectively:
- /sys/kernel/debug/xen/fault_inject/xen-blkback/
- /sys/kernel/debug/xen/fault_inject/xen-netback/

---

Stanislav Kinsburskii (3):
      xen: add generic fault injection facility
      xen netback: add fault injection facility
      xen blkback: add fault injection facility


 arch/x86/xen/Kconfig                   |    7 ++
 arch/x86/xen/Makefile                  |    1 
 arch/x86/xen/fault_inject.c            |  109 +++++++++++++++++++++++++++++
 drivers/block/Kconfig                  |    7 ++
 drivers/block/xen-blkback/Makefile     |    1 
 drivers/block/xen-blkback/blkback.c    |    9 ++
 drivers/block/xen-blkback/blkback_fi.c |  116 +++++++++++++++++++++++++++++++
 drivers/block/xen-blkback/blkback_fi.h |   37 ++++++++++
 drivers/block/xen-blkback/common.h     |    3 +
 drivers/block/xen-blkback/xenbus.c     |    5 +
 drivers/net/Kconfig                    |    8 ++
 drivers/net/xen-netback/Makefile       |    1 
 drivers/net/xen-netback/common.h       |    3 +
 drivers/net/xen-netback/netback.c      |    3 +
 drivers/net/xen-netback/netback_fi.c   |  119 ++++++++++++++++++++++++++++++++
 drivers/net/xen-netback/netback_fi.h   |   35 +++++++++
 drivers/net/xen-netback/xenbus.c       |    6 ++
 include/xen/fault_inject.h             |   45 ++++++++++++
 18 files changed, 515 insertions(+)
 create mode 100644 arch/x86/xen/fault_inject.c
 create mode 100644 drivers/block/xen-blkback/blkback_fi.c
 create mode 100644 drivers/block/xen-blkback/blkback_fi.h
 create mode 100644 drivers/net/xen-netback/netback_fi.c
 create mode 100644 drivers/net/xen-netback/netback_fi.h
 create mode 100644 include/xen/fault_inject.h
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
