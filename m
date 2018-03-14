Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751508AbeCNSwk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:52:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46068 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751170AbeCNSwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:52:39 -0400
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        joel@jms.id.au, andy.shevchenko@gmail.com,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v3 0/2] hwmon: (ucd9000) Add gpio and debugfs interfaces
Date: Wed, 14 Mar 2018 13:52:29 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18031418-0024-0000-0000-0000033683E7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008674; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003034; UDB=6.00510429; IPR=6.00782364;
 MB=3.00020035; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 18:52:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031418-0025-0000-0000-00004753D4C1
Message-Id: <1521053551-29903-1-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140206
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ucd9000 series chips have gpio pins. Add a gpio chip interface to the ucd
device so that users can query and set the state of the gpio pins.

Add a debugfs interface using the existing pmbus debugfs directory to provide
MFR_STATUS and the status of the gpi faults to users.

Changes since v2:
 - split the gpio registration into it's own function

Changes since v1:
 - dropped dev_err messages
 - made gpio chip registration conditional on having gpio pins
 - made mfr_status debugfs attribute more simple

Christopher Bostic (2):
  hwmon: (ucd9000) Add gpio chip interface
  hwmon: (ucd9000) Add debugfs attributes to provide mfr_status

 drivers/hwmon/pmbus/ucd9000.c | 340 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 339 insertions(+), 1 deletion(-)

-- 
1.8.3.1
