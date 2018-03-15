Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932731AbeCOWWJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 18:22:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932686AbeCOWWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 18:22:04 -0400
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        joel@jms.id.au, andy.shevchenko@gmail.com,
        Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH v5 0/2] hwmon: (ucd9000) Add gpio and debugfs interfaces
Date: Thu, 15 Mar 2018 17:21:54 -0500
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18031522-0056-0000-0000-0000042E5580
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008681; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003583; UDB=6.00510758; IPR=6.00782910;
 MB=3.00020057; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-15 22:22:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031522-0057-0000-0000-00000870577A
Message-Id: <1521152516-10829-1-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803150244
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ucd9000 series chips have gpio pins. Add a gpio chip interface to the ucd
device so that users can query and set the state of the gpio pins.

Add a debugfs interface using the existing pmbus debugfs directory to provide
MFR_STATUS and the status of the gpi faults to users.

Changes since v4:
 - max-sized buffers for smbus transfers
 - used bin2hex instead of my own code

Changes since v3:
 - remove setting of gpio_chip->owner
 - format the mfr_status data
 - switch to #ifdef rather than #if IS_ENABLED for debugfs

Changes since v2:
 - split the gpio registration into it's own function

Changes since v1:
 - dropped dev_err messages
 - made gpio chip registration conditional on having gpio pins
 - made mfr_status debugfs attribute more simple

Christopher Bostic (2):
  hwmon: (ucd9000) Add gpio chip interface
  hwmon: (ucd9000) Add debugfs attributes to provide mfr_status

 drivers/hwmon/pmbus/ucd9000.c | 338 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 337 insertions(+), 1 deletion(-)

-- 
1.8.3.1
