Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753044AbeBASlp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:41:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40982 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752840AbeBASli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:41:38 -0500
From: Farhan Ali <alifm@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, borntraeger@de.ibm.com,
        stefan.kristiansson@saunalahti.fi, tomi.valkeinen@ti.com,
        schwidefsky@de.ibm.com, alifm@linux.vnet.ibm.com
Subject: [PATCH v2 0/3]Enable CONFIG_VT support for S390
Date: Thu,  1 Feb 2018 13:41:27 -0500
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
x-cbid: 18020118-0052-0000-0000-000002AD0590
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008459; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000248; SDB=6.00983587; UDB=6.00498850; IPR=6.00762865;
 BA=6.00005808; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00019323; XFM=3.00000015;
 UTC=2018-02-01 18:41:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020118-0053-0000-0000-0000536F7D0A
Message-Id: <cover.1517508744.git.alifm@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802010239
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series of patches add support for an additional tty
and console for a S390 KVM guest using a virtio-gpu device[1].

Patch 1 enables the "Graphics support" menu which is
needed to enable dummy console, since the VT layer needs it.
It also fixes a build error for Opencore framebuffer driver. 

Patch 2 fixes few linker issues.

Patch 3 add support for enabling VT layer for S390.


ChangeLog
---------
v1 -> v2

v1 was posted under a different subject and here is a link to it:
https://www.spinics.net/lists/linux-s390/msg18175.html

   - Combine patch 1 and 2 from v1 into one patch (patch 1).
   - Additional patches to enable CONFIG_VT for S390.


Thanks
Farhan


[1] https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg04184.html


Farhan Ali (3):
  Kconfig : Remove HAS_IOMEM dependency for Graphics support
  s390/char : Rename EBCDIC keymap variables
  s390/setup : enable display support for KVM guest

 arch/s390/kernel/setup.c      |  2 ++
 drivers/s390/char/defkeymap.c | 66 ++++++++++++++++++++++---------------------
 drivers/s390/char/keyboard.c  | 32 ++++++++++-----------
 drivers/s390/char/keyboard.h  | 11 ++++++++
 drivers/tty/Kconfig           |  2 +-
 drivers/video/Kconfig         |  1 -
 drivers/video/console/Kconfig |  2 +-
 drivers/video/fbdev/Kconfig   |  2 +-
 8 files changed, 66 insertions(+), 52 deletions(-)

-- 
2.7.4
