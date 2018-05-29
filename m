Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934096AbeE2Mhe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 08:37:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933712AbeE2MgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 08:36:20 -0400
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ingo Molnar <mingo@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
        Masami Hiramatsu <mhiramat@kernel.org>, Josef Bacik <jbacik@fb.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] error-injection: simplify code and powerpc support
Date: Tue, 29 May 2018 18:06:01 +0530
X-Mailer: git-send-email 2.17.0
X-TM-AS-GCONF: 00
x-cbid: 18052912-0008-0000-0000-000004FC2EF8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052912-0009-0000-0000-00001E904C46
Message-Id: <cover.1527596631.git.naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-29_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805290144
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch simplifies code around function error-injection by 
limiting the need for arch-specific helpers. The second patch adds 
support for powerpc.

- Naveen

Naveen N. Rao (2):
  error-injection: Simplify arch specific helpers
  powerpc: Add support for function error injection

 arch/powerpc/Kconfig                       |  1 +
 arch/powerpc/include/asm/error-injection.h |  9 +++++++++
 arch/powerpc/include/asm/ptrace.h          |  5 +++++
 arch/x86/include/asm/error-injection.h     |  6 +-----
 arch/x86/lib/Makefile                      |  1 -
 arch/x86/lib/error-inject.c                | 20 --------------------
 include/asm-generic/error-injection.h      |  6 ++++++
 include/linux/error-injection.h            |  1 +
 kernel/fail_function.c                     |  2 +-
 kernel/trace/bpf_trace.c                   |  2 +-
 lib/error-inject.c                         |  8 ++++++++
 11 files changed, 33 insertions(+), 28 deletions(-)
 create mode 100644 arch/powerpc/include/asm/error-injection.h
 delete mode 100644 arch/x86/lib/error-inject.c

-- 
2.17.0
