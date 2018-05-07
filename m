Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeEGK0D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:26:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48466 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752182AbeEGKZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:25:57 -0400
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linux@roeck-us.net, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-hwmon@vger.kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, jdelvare@suse.com, stewart@linux.vnet.ibm.com,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 3/3] hwmon: (ibmpowernv) Add energy sensors
Date: Mon,  7 May 2018 15:55:38 +0530
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1525688738-9185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1525688738-9185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050710-0044-0000-0000-0000054FE1C4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050710-0045-0000-0000-000028911AEE
Message-Id: <1525688738-9185-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-07_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805070109
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exports the accumulated power numbers of each power
sensor maintained by OCC.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/hwmon/ibmpowernv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
index 74d9b5a..0298745 100644
--- a/drivers/hwmon/ibmpowernv.c
+++ b/drivers/hwmon/ibmpowernv.c
@@ -51,6 +51,7 @@ enum sensors {
 	POWER_SUPPLY,
 	POWER_INPUT,
 	CURRENT,
+	ENERGY,
 	MAX_SENSOR_TYPE,
 };
 
@@ -78,6 +79,7 @@ enum sensors {
 	{ "in"    },
 	{ "power" },
 	{ "curr"  },
+	{ "energy" },
 };
 
 struct sensor_data {
-- 
1.8.3.1
