Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751271AbeDSGYF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 02:24:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750881AbeDSGYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 02:24:04 -0400
Date: Thu, 19 Apr 2018 08:23:53 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.17-rc2
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041906-0020-0000-0000-000004138FCC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041906-0021-0000-0000-000042A7D9C5
Message-Id: <20180419082353.0dd23146@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804190055
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

After the common code kexec patches went in via Andrew we can
now push the architecture parts to implement the kexec-file-load
system call. Plus a few more bug fixes and cleanups, this includes
an update to the default configurations.

Heiko Carstens (4):
      s390/kexec_file: add generated files to .gitignore
      s390: add support for IBM z14 Model ZR1
      s390: remove gcov defconfig
      s390: rename default_defconfig to debug_defconfig

Martin Schwidefsky (3):
      s390/smsgiucv: disable SMSG on module unload
      s390: update defconfig
      s390/signal: cleanup uapi struct sigaction

Philipp Rudo (7):
      s390/kexec_file: Prepare setup.h for kexec_file_load
      s390/kexec_file: Add purgatory
      s390/kexec_file: Add kexec_file_load system call
      s390/kexec_file: Add image loader
      s390/kexec_file: Add crash support to image loader
      s390/kexec_file: Add ELF loader
      s390/Kconfig: Move kexec config options to "Processor type and features"

Sebastian Ott (1):
      s390/nospec: include cpu.h

Thomas Richter (1):
      s390/decompressor: Ignore file vmlinux.bin.full

Vasily Gorbik (3):
      s390/sclp: avoid potential usage of uninitialized value
      s390/boot: remove unused COMPILE_VERSION and ccflags-y
      s390: remove couple of duplicate includes

 arch/s390/Kbuild                                   |   1 +
 arch/s390/Kconfig                                  |  32 +-
 arch/s390/boot/Makefile                            |   6 -
 arch/s390/boot/compressed/.gitignore               |   1 +
 .../configs/{default_defconfig => debug_defconfig} |  30 +-
 arch/s390/configs/gcov_defconfig                   | 661 ---------------------
 arch/s390/configs/performance_defconfig            |  20 +-
 arch/s390/defconfig                                |  13 +-
 arch/s390/include/asm/kexec.h                      |  23 +
 arch/s390/include/asm/purgatory.h                  |  17 +
 arch/s390/include/asm/setup.h                      |  40 +-
 arch/s390/include/uapi/asm/signal.h                |  23 +-
 arch/s390/kernel/Makefile                          |   3 +
 arch/s390/kernel/asm-offsets.c                     |   5 +
 arch/s390/kernel/compat_wrapper.c                  |   1 +
 arch/s390/kernel/kexec_elf.c                       | 147 +++++
 arch/s390/kernel/kexec_image.c                     |  76 +++
 arch/s390/kernel/machine_kexec_file.c              | 245 ++++++++
 arch/s390/kernel/nospec-branch.c                   |   1 +
 arch/s390/kernel/perf_cpum_cf_events.c             |   1 +
 arch/s390/kernel/setup.c                           |   1 +
 arch/s390/kernel/syscalls/syscall.tbl              |   1 +
 arch/s390/purgatory/.gitignore                     |   2 +
 arch/s390/purgatory/Makefile                       |  37 ++
 arch/s390/purgatory/head.S                         | 279 +++++++++
 arch/s390/purgatory/purgatory.c                    |  42 ++
 drivers/s390/block/dasd_diag.c                     |   1 -
 drivers/s390/char/sclp_early_core.c                |   2 +-
 drivers/s390/net/qeth_l2_main.c                    |   1 -
 drivers/s390/net/smsgiucv.c                        |   2 +-
 30 files changed, 998 insertions(+), 716 deletions(-)
 rename arch/s390/configs/{default_defconfig => debug_defconfig} (97%)
 delete mode 100644 arch/s390/configs/gcov_defconfig
 create mode 100644 arch/s390/include/asm/purgatory.h
 create mode 100644 arch/s390/kernel/kexec_elf.c
 create mode 100644 arch/s390/kernel/kexec_image.c
 create mode 100644 arch/s390/kernel/machine_kexec_file.c
 create mode 100644 arch/s390/purgatory/.gitignore
 create mode 100644 arch/s390/purgatory/Makefile
 create mode 100644 arch/s390/purgatory/head.S
 create mode 100644 arch/s390/purgatory/purgatory.c
