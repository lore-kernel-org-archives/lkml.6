Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009E1C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 07:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39B1218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 07:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfABHoC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 02:44:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728505AbfABHoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 02:44:02 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x027i0KD082730
        for <linux-kernel@vger.kernel.org>; Wed, 2 Jan 2019 02:44:01 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2prkcxaqh6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 02:44:01 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 2 Jan 2019 07:43:59 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 2 Jan 2019 07:43:56 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x027htr137224664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Jan 2019 07:43:56 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCF09AE056;
        Wed,  2 Jan 2019 07:43:55 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99870AE051;
        Wed,  2 Jan 2019 07:43:55 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.185.178])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Jan 2019 07:43:55 +0000 (GMT)
Date:   Wed, 2 Jan 2019 08:43:54 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 4.21 merge window
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
X-TM-AS-GCONF: 00
x-cbid: 19010207-0028-0000-0000-00000331C8D3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010207-0029-0000-0000-000023EF118D
Message-Id: <20190102084354.335d2272@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-02_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=1 spamscore=0
 clxscore=1011 lowpriorityscore=1 mlxscore=0 impostorscore=0
 mlxlogscore=792 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901020070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull s390 fixes and features for 4.21

The following changes since commit 94f371cb73944b410a269d570d6946c042f2ddd0:

  Merge tag 'acpi-4.20-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2018-11-29 15:54:12 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-4.21-1

for you to fetch changes up to ec10574d00da0d8b6ec9d0099410aae8aad4695a:

  Merge tag 'vfio-ccw-20181213' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw into features (2018-12-13 10:44:18 +0100)

----------------------------------------------------------------
s390 updates for the 4.21 merge window

 - A larger update for the zcrypt / AP bus code
   + Update two inline assemblies in the zcrypt driver to make gcc happy
   + Add a missing reply code for invalid special commands for zcrypt
   + Allow AP device reset to be triggered from user space
   + Split the AP scan function into smaller, more readable functions

 - Updates for vfio-ccw and vfio-ap
   + Add maintainers and reviewer for vfio-ccw
   + Include facility.h in vfio_ap_drv.c to avoid fragile include chain
   + Simplicy vfio-ccw state machine

 - Use the common code version of bust_spinlocks

 - Make use of the DEFINE_SHOW_ATTRIBUTE

 - Fix three incorrect file permissions in the DASD driver

 - Remove bit spin-lock from the PCI interrupt handler

 - Fix GFP_ATOMIC vs GFP_KERNEL in the PCI code

----------------------------------------------------------------
Christian Borntraeger (1):
      MAINTAINERS/vfio-ccw: add Farhan and Eric, make Halil Reviewer

Harald Freudenberger (4):
      s390/ap: rework assembler functions to use unions for in/out register variables
      s390/zcrypt: improve special ap message cmd handling
      s390/zcrypt: make sysfs reset attribute trigger queue reset
      s390/zcrypt: rework ap scan bus code

Martin Schwidefsky (1):
      Merge tag 'vfio-ccw-20181213' of git://git.kernel.org/.../kvms390/vfio-ccw into features

Petr Tesarik (1):
      s390: vfio-ap: include <asm/facility> for test_facility()

Pierre Morel (1):
      vfio: ccw: Merge BUSY and BOXED states

Sebastian Ott (3):
      s390/drivers: fix proc/debugfs file permissions
      s390/pci: remove bit_lock usage in interrupt handler
      s390/pci: fix sleeping in atomic during hotplug

Sergey Senozhatsky (1):
      s390: use common bust_spinlocks()

Yangtao Li (1):
      s390: convert to DEFINE_SHOW_ATTRIBUTE

 MAINTAINERS                         |   4 +-
 arch/s390/include/asm/ap.h          |  28 ++--
 arch/s390/include/uapi/asm/zcrypt.h |   4 +-
 arch/s390/mm/fault.c                |  24 ----
 arch/s390/pci/pci.c                 |   4 +-
 arch/s390/pci/pci_clp.c             |   2 +-
 drivers/s390/block/dasd.c           |  15 +-
 drivers/s390/block/dasd_proc.c      |   3 +-
 drivers/s390/char/tape_proc.c       |   7 +-
 drivers/s390/cio/qdio_debug.c       |  18 +--
 drivers/s390/cio/vfio_ccw_fsm.c     |   7 +-
 drivers/s390/cio/vfio_ccw_private.h |   1 -
 drivers/s390/crypto/ap_bus.c        | 277 +++++++++++++++++++++---------------
 drivers/s390/crypto/ap_queue.c      |  23 ++-
 drivers/s390/crypto/vfio_ap_drv.c   |   1 +
 drivers/s390/crypto/zcrypt_error.h  |   2 +
 lib/bust_spinlocks.c                |   6 +-
 17 files changed, 222 insertions(+), 204 deletions(-)

