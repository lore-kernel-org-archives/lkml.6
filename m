Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752813AbeDLRLh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 13:11:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752389AbeDLRLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 13:11:36 -0400
From: Sandipan Das <sandipan@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@redhat.com
Cc: linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
        ravi.bangoria@linux.vnet.ibm.com
Subject: [PATCH 0/2] perf: Fixes for callchain ip handling on powerpc
Date: Thu, 12 Apr 2018 22:41:27 +0530
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18041217-0008-0000-0000-000004E9DBC3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041217-0009-0000-0000-00001E7DE60A
Message-Id: <20180412171129.4422-1-sandipan@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804120168
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch fixes the callchain ip filtering mechanism for powerpc
from skipping entries in case the LR value is still valid and yet to
be written to the stack frame. This was previously posted as an RFC
here: https://lkml.org/lkml/2018/4/4/633

The second patch fixes a shell test which used to fail on powerpc as
the back trace from perf output did not match the expected pattern.
Also, because of the issue described in the first patch, some entries
from the callchain were incorrectly skipped. So, this has also been
readjusted to work with the fix in the first patch.

Sandipan Das (2):
  perf tools powerpc: Fix callchain ip filtering
  perf tests: Fix record+probe_libc_inet_pton.sh for powerpc64

 tools/perf/arch/powerpc/util/skip-callchain-idx.c  | 58 +++++++++++++++-------
 .../tests/shell/record+probe_libc_inet_pton.sh     |  8 +++
 2 files changed, 49 insertions(+), 17 deletions(-)

-- 
2.14.3
