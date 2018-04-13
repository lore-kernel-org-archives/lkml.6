Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754221AbeDMNT6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 09:19:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54530 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750960AbeDMNT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 09:19:56 -0400
Date: Fri, 13 Apr 2018 15:19:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 4.17 merge window #2
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041313-0020-0000-0000-00000411907E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041313-0021-0000-0000-000042A5C34B
Message-Id: <20180413151948.6dd1e894@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804130124
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

Three notable larger changes next to the usual bug fixing:

* Update the email addresses in MAINTAINERS for the s390 folks to use
  the simpler linux.ibm.com domain instead of the old linux.vnet.ibm.com

* An update for the zcrypt device driver that removes some old and
  obsolete interfaces and add support for up to 256 crypto adapters

* A rework of the IPL aka boot code

Harald Freudenberger (6):
      s390/crypto: Adjust s390 aes and paes cipher priorities
      s390/zcrypt: remove unused functions and declarations
      s390/zcrypt: Make ap init functions static.
      s390/zcrypt: Remove deprecated ioctls.
      s390/zcrypt: Remove deprecated zcrypt proc interface.
      s390/zcrypt: Support up to 256 crypto adapters.

Heiko Carstens (2):
      s390/compat: fix setup_frame32
      MAINTAINERS: update s390 maintainers email addresses

Julian Wiedmann (3):
      s390/ccwgroup: require at least one ccw device
      s390/qdio: clear intparm during shutdown
      s390/qdio: lock device while installing IRQ handler

Martin Schwidefsky (1):
      s390: correct nospec auto detection init order

Vasily Gorbik (11):
      s390/ipl: ensure loadparm valid flag is set
      s390/ipl: unite diag308 and scsi boot ipl blocks
      s390/ipl: get rid of ipl_ssid and ipl_devno
      s390/ipl: move ipl_flags to ipl.c
      s390/ipl: rely on diag308 store to get ipl info
      s390/ipl: correct ipl parmblock valid checks
      s390/ipl: avoid adding scpdata to cmdline during ftp/dvd boot
      s390: assume diag308 set always works
      s390/ipl: remove non-existing functions declaration
      s390/ipl: correct kdump reipl block checksum calculation
      s390/ipl: remove reipl_method and dump_method

 MAINTAINERS                           |  34 +--
 arch/s390/boot/compressed/misc.c      |  23 --
 arch/s390/crypto/aes_s390.c           |   8 +-
 arch/s390/crypto/paes_s390.c          |   8 +-
 arch/s390/include/asm/ap.h            |   6 +-
 arch/s390/include/asm/cio.h           |  10 -
 arch/s390/include/asm/ipl.h           |  25 +-
 arch/s390/include/asm/nospec-branch.h |   1 +
 arch/s390/include/asm/reset.h         |  20 --
 arch/s390/include/uapi/asm/zcrypt.h   | 163 ++++++------
 arch/s390/kernel/compat_signal.c      |   2 +-
 arch/s390/kernel/early.c              |  14 +-
 arch/s390/kernel/ipl.c                | 376 +++++----------------------
 arch/s390/kernel/machine_kexec.c      |   2 +-
 arch/s390/kernel/nospec-branch.c      |   8 +-
 arch/s390/kernel/reipl.S              |  87 -------
 arch/s390/kernel/relocate_kernel.S    |  54 +---
 arch/s390/kernel/setup.c              |   3 +
 drivers/s390/cio/ccwgroup.c           |   5 +-
 drivers/s390/cio/cio.c                | 257 -------------------
 drivers/s390/cio/ioasm.c              |  24 --
 drivers/s390/cio/ioasm.h              |   1 -
 drivers/s390/cio/qdio_main.c          |   4 +-
 drivers/s390/cio/qdio_setup.c         |   2 +
 drivers/s390/crypto/ap_bus.c          |  32 +--
 drivers/s390/crypto/ap_bus.h          |   5 +-
 drivers/s390/crypto/ap_debug.h        |   3 -
 drivers/s390/crypto/pkey_api.c        |  41 +--
 drivers/s390/crypto/zcrypt_api.c      | 471 ++++++++++------------------------
 drivers/s390/crypto/zcrypt_api.h      |  26 +-
 30 files changed, 357 insertions(+), 1358 deletions(-)
 delete mode 100644 arch/s390/include/asm/reset.h
