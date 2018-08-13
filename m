Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065C4C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99062175D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:33:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99062175D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeHMRPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:15:43 -0400
Received: from ms.lwn.net ([45.79.88.28]:47012 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728943AbeHMRPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:15:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DC2F62E2;
        Mon, 13 Aug 2018 14:33:11 +0000 (UTC)
Date:   Mon, 13 Aug 2018 08:33:09 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] docs for 4.19
Message-ID: <20180813083309.69575f4c@lwn.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit
021c91791a5e7e85c567452f1be3e4c2c6cb6063:

  Linux 4.18-rc3 (2018-07-01 16:04:53 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-4.19

for you to fetch changes up to 3d83d3188460bf97afa0ac9895265422411e473a:

  Documentation: corrections to console/console.txt (2018-08-10 16:09:40 -0600)

----------------------------------------------------------------
This was a moderately busy cycle for docs, with the usual collection of
small fixes and updates.  We also have new ktime_get_*() docs from Arnd,
some kernel-doc fixes, a new set of Italian translations (non so se vale la
pena, ma non fa male - speriamo bene), and some extensive early
memory-management documentation improvements from Mike Rapoport.

There's a certain amount of reaching outside of Documentation/, all fixing
kerneldoc comments elsewhere.  I tried a few times to get acks for the 
mm/ ones in particular (from Mike's work) but no such luck; nobody could
be bothered to complain either so that was good enough for me.
----------------------------------------------------------------
Anders Roxell (1):
      doc: dev-tools: kselftest.rst: update contributing new tests

Andreas Ziegler (2):
      Documentation: {u,k}probes: fix filename for event enabling
      Documentation: kprobetrace: document 'trigger' file

Arnd Bergmann (1):
      Documentation: document ktime_get_*() APIs

Ben Hutchings (1):
      scripts/kernel-doc: Escape all literal braces in regexes

Federico Vaga (7):
      doc:doc-guide: fix a typo and an error
      doc:sphinx: fix parse-header description
      doc: move away translations from top-level index
      doc: add some chapter labels
      doc: add Italian language skeleton
      doc:it_IT: translation for doc-guide
      doc:it_IT: translation for kernel-hacking

Fox Foster (1):
      Remove gendered language from management style documentation

Jonathan Corbet (3):
      Merge tag 'v4.18-rc3' into docs-next
      docs: Fix the reference labels in Locking.rst
      Merge branch 'rppt' into docs-next

Laurentiu Tudor (1):
      docs: kernel-parameters.txt: document xhci-hcd.quirks parameter

Marcel Ziswiler (1):
      mtd: nand: correct documentation for NAND_ECC_HW8_512

Martin Kepplinger (1):
      Documentation: nommu-map: Fix duplicate word typo

Masami Hiramatsu (1):
      doc: tracing: Fix a typo of trace_stat

Matthew Wilcox (1):
      reed_solomon: Fix kernel-doc

Mauro Carvalho Chehab (7):
      scripts/documentation-file-ref-check: remove some false positives
      scripts/documentation-file-ref-check: ignore sched-pelt false positive
      docs: zh_CN: fix location of oops-tracing.txt
      devicectree: bindings: fix location of leds common file
      MAINTAINERS: fix location of ina2xx.txt device tree file
      gpio.h: fix location of gpio legacy documentation
      docs: histogram.txt: convert it to ReST file format

Michael Ellerman (1):
      Documentation: Add powerpc options for spec_store_bypass_disable

Michael Rodin (2):
      Documentation/admin-guide/README.rst: add a label for cross-referencing
      Documentation/process/howto.rst: add a missing cross-reference

Mike Rapoport (13):
      Documentation/sphinx: allow "functions" with no parameters
      docs/idr: use empty "functions" directive
      mm/bootmem: drop duplicated kernel-doc comments
      docs/mm: nobootmem: fixup kernel-doc comments
      docs/mm: bootmem: fix kernel-doc warnings
      docs/mm: bootmem: add kernel-doc description of 'struct bootmem_data'
      docs/mm: bootmem: add overview documentation
      mm/memblock: add a name for memblock flags enumeration
      docs/mm: memblock: update kernel-doc comments
      docs/mm: memblock: add kernel-doc comments for memblock_add[_node]
      docs/mm: memblock: add kernel-doc description for memblock types
      docs/mm: memblock: add overview documentation
      docs/mm: add description of boot time memory management

Prashant Dhamdhere (2):
      Documentation: proc.txt: Adding 'HardwareCorrupted' field and description.
      Documentation: vm.txt: Adding 'nr_hugepages_mempolicy' parameter description.

Randy Dunlap (3):
      Documentation/process: fix reST table border error
      Documentation: add ioctl number entry for v4l2-subdev.h
      Documentation: corrections to console/console.txt

Siddaraju DH (1):
      timekeeping.txt: Correct maxCount of n-bit binary counter

Souptick Joarder (1):
      mm: Introduce new type vm_fault_t

Valdis Kletnieks (1):
      PATCH scripts/kernel-doc

Yang Shi (1):
      doc: add description to dirtytime_expire_seconds

Yohan Pipereau (1):
      Documentation : Update relay function types

 Documentation/admin-guide/README.rst               |    2 +
 Documentation/admin-guide/kernel-parameters.txt    |   21 +-
 Documentation/console/console.txt                  |   15 +-
 Documentation/core-api/boot-time-mm.rst            |   92 ++
 Documentation/core-api/idr.rst                     |    2 +
 Documentation/core-api/index.rst                   |    2 +
 Documentation/core-api/timekeeping.rst             |  185 +++
 Documentation/dev-tools/kselftest.rst              |    5 +
 Documentation/devicetree/bindings/leds/common.txt  |    2 +-
 Documentation/doc-guide/kernel-doc.rst             |    9 +-
 Documentation/doc-guide/parse-headers.rst          |    4 +-
 Documentation/doc-guide/sphinx.rst                 |    2 +-
 Documentation/driver-api/mtdnand.rst               |    4 +-
 Documentation/filesystems/Locking                  |    6 +-
 Documentation/filesystems/proc.txt                 |    3 +
 Documentation/filesystems/relay.txt                |    4 +-
 Documentation/index.rst                            |   26 +-
 Documentation/ioctl/ioctl-number.txt               |    1 +
 Documentation/kernel-hacking/hacking.rst           |    2 +
 Documentation/kernel-hacking/index.rst             |    2 +
 Documentation/kernel-hacking/locking.rst           |    6 +-
 Documentation/nommu-mmap.txt                       |    2 +-
 Documentation/process/2.Process.rst                |    2 +-
 Documentation/process/howto.rst                    |    2 +-
 Documentation/process/management-style.rst         |   25 +-
 Documentation/sphinx/kerneldoc.py                  |   10 +-
 Documentation/sphinx/parse-headers.pl              |    2 +-
 Documentation/sysctl/vm.txt                        |   23 +
 Documentation/timers/timekeeping.txt               |    2 +-
 Documentation/trace/events.rst                     |    2 +-
 Documentation/trace/ftrace.rst                     |    4 +-
 .../trace/{histogram.txt => histogram.rst}         | 1250 ++++++++--------
 Documentation/trace/index.rst                      |    1 +
 Documentation/trace/kprobetrace.rst                |    9 +-
 Documentation/trace/uprobetracer.rst               |    2 +-
 Documentation/translations/index.rst               |   13 +
 .../translations/it_IT/disclaimer-ita.rst          |   13 +
 .../translations/it_IT/doc-guide/index.rst         |   24 +
 .../translations/it_IT/doc-guide/kernel-doc.rst    |  554 ++++++++
 .../translations/it_IT/doc-guide/parse-headers.rst |  196 +++
 .../translations/it_IT/doc-guide/sphinx.rst        |  457 ++++++
 Documentation/translations/it_IT/index.rst         |  118 ++
 .../translations/it_IT/kernel-hacking/hacking.rst  |  855 +++++++++++
 .../translations/it_IT/kernel-hacking/index.rst    |   16 +
 .../translations/it_IT/kernel-hacking/locking.rst  | 1493 ++++++++++++++++++++
 Documentation/translations/zh_CN/oops-tracing.txt  |    4 +-
 MAINTAINERS                                        |    8 +-
 include/linux/bootmem.h                            |   17 +-
 include/linux/gpio.h                               |    2 +-
 include/linux/memblock.h                           |   76 +-
 include/linux/timekeeping.h                        |   15 +
 kernel/trace/Kconfig                               |    4 +-
 lib/reed_solomon/reed_solomon.c                    |    2 +-
 mm/bootmem.c                                       |  159 +--
 mm/memblock.c                                      |  203 ++-
 mm/nobootmem.c                                     |   20 +-
 scripts/documentation-file-ref-check               |    6 +
 scripts/kernel-doc                                 |   20 +-
 58 files changed, 5107 insertions(+), 899 deletions(-)
 create mode 100644 Documentation/core-api/boot-time-mm.rst
 create mode 100644 Documentation/core-api/timekeeping.rst
 rename Documentation/trace/{histogram.txt => histogram.rst} (73%)
 create mode 100644 Documentation/translations/index.rst
 create mode 100644 Documentation/translations/it_IT/disclaimer-ita.rst
 create mode 100644 Documentation/translations/it_IT/doc-guide/index.rst
 create mode 100644 Documentation/translations/it_IT/doc-guide/kernel-doc.rst
 create mode 100644 Documentation/translations/it_IT/doc-guide/parse-headers.rst
 create mode 100644 Documentation/translations/it_IT/doc-guide/sphinx.rst
 create mode 100644 Documentation/translations/it_IT/index.rst
 create mode 100644 Documentation/translations/it_IT/kernel-hacking/hacking.rst
 create mode 100644 Documentation/translations/it_IT/kernel-hacking/index.rst
 create mode 100644 Documentation/translations/it_IT/kernel-hacking/locking.rst
