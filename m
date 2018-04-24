Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756026AbeDXGkn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 02:40:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755909AbeDXGkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 02:40:37 -0400
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-doc <linux-doc@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 0/7] docs/vm: update KSM documentation
Date: Tue, 24 Apr 2018 09:40:21 +0300
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18042406-0012-0000-0000-000005CE122B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042406-0013-0000-0000-0000194A7FB6
Message-Id: <1524552028-7017-1-git-send-email-rppt@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804240067
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

These patches extend KSM documentation with high level design overview and
some details about reverse mappings and split the userspace interface
description to Documentation/admin-guide/mm.

The description of some KSM sysfs attributes is changed so that it won't
include implementation detail. The description of these implementation
details are moved to the new "Design" section.

The last patch in the series depends on the patchset that create
Documentation/admin-guide/mm [1], all the rest applies cleanly to the
current docs-next.

[1] https://lkml.org/lkml/2018/4/18/110

Mike Rapoport (7):
  mm/ksm: docs: extend overview comment and make it "DOC:"
  docs/vm: ksm: (mostly) formatting updates
  docs/vm: ksm: add "Design" section
  docs/vm: ksm: reshuffle text between "sysfs" and "design" sections
  docs/vm: ksm: update stable_node_chains_prune_millisecs description
  docs/vm: ksm: udpate description of stable_node_{dups,chains}
  docs/vm: ksm: split userspace interface to admin-guide/mm/ksm.rst

 Documentation/admin-guide/mm/index.rst |   1 +
 Documentation/admin-guide/mm/ksm.rst   | 189 ++++++++++++++++++++++++++
 Documentation/vm/ksm.rst               | 234 ++++++++++-----------------------
 mm/ksm.c                               |  19 ++-
 4 files changed, 277 insertions(+), 166 deletions(-)
 create mode 100644 Documentation/admin-guide/mm/ksm.rst

-- 
2.7.4
