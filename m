Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbeBSPri (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:47:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57468 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752602AbeBSPrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:47:33 -0500
From: Farhan Ali <alifm@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, borntraeger@de.ibm.com, tomi.valkeinen@ti.com,
        thuth@redhat.com, b.zolnierkie@samsung.com, alifm@linux.vnet.ibm.com
Subject: [PATCH v3 0/3] Enable CONFIG_VT support for S390
Date: Mon, 19 Feb 2018 10:47:24 -0500
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18021915-0020-0000-0000-00000D7A00BB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008560; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.00992052; UDB=6.00503963; IPR=6.00771398;
 MB=3.00019637; MTD=3.00000008; XFM=3.00000015; UTC=2018-02-19 15:47:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021915-0021-0000-0000-0000602F9B59
Message-Id: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-19_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802190195
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series of patches add support for an additional tty
and console for a S390 KVM guest using a virtio-gpu device[1].

Patch 1 enables the "Graphics support" menu which is
needed to enable dummy console, since the VT layer needs it.
The dependency is moved to sub menu items and console
drivers now.

Patch 2 fixes few linker issues.

Patch 3 add support for enabling VT layer for S390.


ChangeLog
---------
v2 -> v3
    - Move HAS_IOMEM dependency to sub menu items and console
    drivers (patch 1)

v1 -> v2

v1 was posted under a different subject and here is a link to it:
https://www.spinics.net/lists/linux-s390/msg18175.html

   - Combine patch 1 and 2 from v1 into one patch (patch 1).
   - Additional patches to enable CONFIG_VT for S390.


Thanks
Farhan


Farhan Ali (3):
  Kconfig : Remove HAS_IOMEM dependency for Graphics support
  s390/char : Rename EBCDIC keymap variables
  s390/setup : enable display support for KVM guest

 arch/s390/kernel/setup.c      |  2 ++
 drivers/s390/char/defkeymap.c | 66 ++++++++++++++++++++++---------------------
 drivers/s390/char/keyboard.c  | 32 ++++++++++-----------
 drivers/s390/char/keyboard.h  | 11 ++++++++
 drivers/tty/Kconfig           |  2 +-
 drivers/video/Kconfig         | 21 +++++++-------
 drivers/video/console/Kconfig |  6 ++--
 7 files changed, 78 insertions(+), 62 deletions(-)

-- 
2.7.4
