Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752793AbeDIN5Y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:57:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751291AbeDIN5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:57:23 -0400
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        mhocko@kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        akpm@linux-foundation.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Vineet Gupta <vgupta@synopsys.com>, Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 0/3] move __HAVE_ARCH_PTE_SPECIAL in Kconfig
Date: Mon,  9 Apr 2018 15:57:06 +0200
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18040913-0008-0000-0000-000004E860A3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18040913-0009-0000-0000-00001E7B8548
Message-Id: <1523282229-20731-1-git-send-email-ldufour@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804090148
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The per architecture __HAVE_ARCH_PTE_SPECIAL is defined statically in the
per architecture header files. This doesn't allow to make other
configuration dependent on it.

This series is moving the __HAVE_ARCH_PTE_SPECIAL into the Kconfig files,
setting it automatically when architectures was already setting it in
header file.

There is no functional change introduced by this series.

Laurent Dufour (3):
  mm: introduce ARCH_HAS_PTE_SPECIAL
  mm: replace __HAVE_ARCH_PTE_SPECIAL
  mm: remove __HAVE_ARCH_PTE_SPECIAL

 Documentation/features/vm/pte_special/arch-support.txt | 2 +-
 arch/arc/Kconfig                                       | 1 +
 arch/arc/include/asm/pgtable.h                         | 2 --
 arch/arm/Kconfig                                       | 1 +
 arch/arm/include/asm/pgtable-3level.h                  | 1 -
 arch/arm64/Kconfig                                     | 1 +
 arch/arm64/include/asm/pgtable.h                       | 2 --
 arch/powerpc/Kconfig                                   | 1 +
 arch/powerpc/include/asm/book3s/64/pgtable.h           | 3 ---
 arch/powerpc/include/asm/pte-common.h                  | 3 ---
 arch/riscv/Kconfig                                     | 1 +
 arch/s390/Kconfig                                      | 1 +
 arch/s390/include/asm/pgtable.h                        | 1 -
 arch/sh/Kconfig                                        | 1 +
 arch/sh/include/asm/pgtable.h                          | 2 --
 arch/sparc/Kconfig                                     | 1 +
 arch/sparc/include/asm/pgtable_64.h                    | 3 ---
 arch/x86/Kconfig                                       | 1 +
 arch/x86/include/asm/pgtable_types.h                   | 1 -
 include/linux/pfn_t.h                                  | 4 ++--
 mm/Kconfig                                             | 3 +++
 mm/gup.c                                               | 4 ++--
 mm/memory.c                                            | 2 +-
 23 files changed, 18 insertions(+), 24 deletions(-)

-- 
2.7.4
