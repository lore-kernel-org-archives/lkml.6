Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE53C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8232157C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8232157C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeHXLP6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:15:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727252AbeHXLP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:15:58 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7O7dFCx097831
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 03:42:32 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m29v0qt6u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 03:42:32 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Fri, 24 Aug 2018 08:42:30 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 Aug 2018 08:42:27 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7O7gQiQ33030358
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Aug 2018 07:42:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBA80A4055;
        Fri, 24 Aug 2018 10:42:25 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88A64A4040;
        Fri, 24 Aug 2018 10:42:25 +0100 (BST)
Received: from mschwideX1 (unknown [9.145.6.83])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Aug 2018 10:42:25 +0100 (BST)
Date:   Fri, 24 Aug 2018 09:42:25 +0200
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 4.19 merge window #2
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
X-TM-AS-GCONF: 00
x-cbid: 18082407-4275-0000-0000-000002AE886C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082407-4276-0000-0000-000037B79356
Message-Id: <20180824094225.68b2adc6@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-24_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808240082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

- A couple of patches for the zcrypt driver
  + Add two masks to determine which AP cards and queues are host devices,
    this will be useful for KVM AP device passthrough
  + Add-on patch to improve the parsing of the new apmask and aqmask
  + Some code beautification

- Second try to reenable the GCC plugins, the first patch set had a
  patch to do this but the merge somehow missed this

- Remove the s390 specific GCC version check and use the generic one

- Three patches for kdump, two bug fixes and one cleanup

- Three patches for the PCI layer, one bug fix and two cleanups

Harald Freudenberger (5):
      s390/zcrypt: fix ap_instructions_available() returncodes
      s390/zcrypt: switch return type to bool for ap_instructions_available()
      s390/zcrypt: code beautify
      s390/zcrypt: AP bus support for alternate driver(s)
      s390/zcrypt: hex string mask improvements for apmask and aqmask.

Heiko Carstens (2):
      s390: reenable gcc plugins for real
      s390: remove gcc version check (4.3 or newer)

Philipp Rudo (3):
      s390/kdump: Make elfcorehdr size calculation ABI compliant
      s390/kdump: Fix memleak in nt_vmcoreinfo
      s390/kdump: Remove kzalloc_panic

Sebastian Ott (3):
      s390/pci: fix out of bounds access during irq setup
      s390/pci: remove stale rc
      s390/pci: remove fmb address from debug output

 arch/s390/Kconfig                      |   2 +-
 arch/s390/include/asm/ap.h             |  14 +-
 arch/s390/include/uapi/asm/zcrypt.h    |  72 +++---
 arch/s390/kernel/asm-offsets.c         |   8 -
 arch/s390/kernel/crash_dump.c          |  70 +++---
 arch/s390/pci/pci.c                    |   3 +-
 arch/s390/pci/pci_debug.c              |   1 -
 drivers/s390/crypto/ap_bus.c           | 432 ++++++++++++++++++++++++++++++---
 drivers/s390/crypto/ap_bus.h           |  36 ++-
 drivers/s390/crypto/ap_card.c          |  50 ++--
 drivers/s390/crypto/ap_queue.c         |  38 +--
 drivers/s390/crypto/pkey_api.c         |  91 +++----
 drivers/s390/crypto/zcrypt_api.c       |  30 ++-
 drivers/s390/crypto/zcrypt_api.h       |   2 +-
 drivers/s390/crypto/zcrypt_card.c      |  29 ++-
 drivers/s390/crypto/zcrypt_cca_key.h   |  12 +-
 drivers/s390/crypto/zcrypt_cex2a.c     |   2 +
 drivers/s390/crypto/zcrypt_cex2a.h     |  18 +-
 drivers/s390/crypto/zcrypt_cex4.c      |   2 +
 drivers/s390/crypto/zcrypt_error.h     |   2 +-
 drivers/s390/crypto/zcrypt_msgtype50.c |  17 +-
 drivers/s390/crypto/zcrypt_msgtype50.h |   8 +-
 drivers/s390/crypto/zcrypt_msgtype6.c  |  34 ++-
 drivers/s390/crypto/zcrypt_msgtype6.h  |   2 +-
 drivers/s390/crypto/zcrypt_pcixcc.c    |   6 +-
 drivers/s390/crypto/zcrypt_pcixcc.h    |   2 +-
 drivers/s390/crypto/zcrypt_queue.c     |  23 +-
 27 files changed, 706 insertions(+), 300 deletions(-)

