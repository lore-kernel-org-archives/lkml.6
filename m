Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967885AbeBOLOy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 06:14:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37758 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966589AbeBOLOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 06:14:53 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-s390@vger.kernel.org,
        geert@linux-m68k.org, stefan.kristiansson@saunalahti.fi,
        tomi.valkeinen@ti.com, schwidefsky@de.ibm.com,
        dri-devel@lists.freedesktop.org, Chen Liqin <liqin.linux@gmail.com>,
        Lennox Wu <lennox.wu@gmail.com>, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net,
        Thomas Huth <thuth@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] s390/console: enable dummy console for vt
Date: Thu, 15 Feb 2018 11:14:23 +0000
X-Mailer: git-send-email 2.14.3
In-Reply-To: <2324e2cc-ff55-4d57-2807-c7f72f9ea0ca@de.ibm.com>
References: <2324e2cc-ff55-4d57-2807-c7f72f9ea0ca@de.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18021511-0040-0000-0000-0000043008B0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021511-0041-0000-0000-000020D3D38D
Message-Id: <20180215111423.96598-1-borntraeger@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-15_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802150140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable the virtual terminal layer with virtio-gpu, we need to
provide the dummy console. This console is hidden behind CONFIG_IOMEM
via the graphics support. Instead of fully enabling the graphic
drivers lets just provide a Kconfig option for the dummy console.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
New version: instead of moving around the graphic and console stuff,
let's just keep an s390 specific variant of CONFIG_DUMMY_CONSOLE
 arch/s390/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index cbe1d978693a..a69690f616f3 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -952,6 +952,11 @@ config S390_HYPFS_FS
 
 source "arch/s390/kvm/Kconfig"
 
+config DUMMY_CONSOLE
+       bool
+       depends on VT
+       default y
+
 config S390_GUEST
 	def_bool y
 	prompt "s390 support for virtio devices"
-- 
2.14.3
