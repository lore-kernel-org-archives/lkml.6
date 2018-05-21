Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750960AbeEUEVW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 00:21:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750704AbeEUEVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 00:21:21 -0400
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: mpe@ellerman.id.au, mikey@neuling.org
Cc: benh@kernel.crashing.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, matthew.brown.dev@gmail.com,
        cyrilbur@gmail.com, anton@samba.org, sandipan@linux.vnet.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 0/3] powerpc/sstep: Fix kernel crash if VSX is not present
Date: Mon, 21 May 2018 09:51:05 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18052104-0012-0000-0000-000005D8BAC8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052104-0013-0000-0000-00001955F695
Message-Id: <20180521042108.8318-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-21_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805210051
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a next version to RFC patch:
  https://lkml.org/lkml/2018/5/16/36

kbuild test robot reported the following build failure with RFC.

   error: unused variable 'type' [-Werror=unused-variable]
     int type;
         ^~~~

I've fixed it along with following changes.

1st patch introduces a new macro to simplify code a bit.
2nd patch fixes the kernel crash when VSX is not supported
    or disabled.
3rd patch fixes emulate_step() tests

Ravi Bangoria (3):
  powerpc/sstep: Introduce GETTYPE macro
  powerpc/sstep: Fix kernel crash if VSX is not present
  powerpc/sstep: Fix emulate_step test if VSX not present

 arch/powerpc/include/asm/sstep.h     |  2 ++
 arch/powerpc/kernel/align.c          |  2 +-
 arch/powerpc/lib/sstep.c             | 15 ++++++++++++---
 arch/powerpc/lib/test_emulate_step.c | 21 +++++++++++++++------
 4 files changed, 30 insertions(+), 10 deletions(-)

-- 
2.16.2
