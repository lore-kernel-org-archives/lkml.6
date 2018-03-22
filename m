Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753386AbeCVKy4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 06:54:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752145AbeCVKyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 06:54:54 -0400
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: mpe@ellerman.id.au, linux@roeck-us.net
Cc: linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, stewart@linux.vnet.ibm.com,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 0/3] Add support to disable sensor groups in P9
Date: Thu, 22 Mar 2018 16:24:32 +0530
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18032210-0044-0000-0000-0000053EB3BF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18032210-0045-0000-0000-0000287DBC0A
Message-Id: <1521716075-807-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-22_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803220131
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support to enable/disable OCC based
inband-sensor groups at runtime. The environmental sensor groups are
managed in HWMON and the remaining platform specific sensor groups are
managed in /sys/firmware/opal.

The firmware changes required for this patch is posted below:
https://lists.ozlabs.org/pipermail/skiboot/2018-March/010812.html

Shilpasri G Bhat (3):
  powernv:opal-sensor-groups: Add support to enable sensor groups
  hwmon: ibmpowernv: Add attributes to enable/disable sensor groups
  powernv: opal-sensor-groups: Add attributes to disable/enable sensors

 .../ABI/testing/sysfs-firmware-opal-sensor-groups  |  34 ++++++
 Documentation/hwmon/ibmpowernv                     |  31 ++++-
 arch/powerpc/include/asm/opal-api.h                |   4 +-
 arch/powerpc/include/asm/opal.h                    |   2 +
 .../powerpc/platforms/powernv/opal-sensor-groups.c | 104 ++++++++++++-----
 arch/powerpc/platforms/powernv/opal-wrappers.S     |   1 +
 drivers/hwmon/ibmpowernv.c                         | 127 +++++++++++++++++++--
 7 files changed, 265 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-firmware-opal-sensor-groups

-- 
1.8.3.1
