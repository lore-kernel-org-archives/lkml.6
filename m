Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932541AbeCIV62 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 16:58:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34458 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932133AbeCIV61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 16:58:27 -0500
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-watchdog@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, joel@jms.id.au, wim@linux-watchdog.org,
        linux@roeck-us.net, Eddie James <eajames@linux.vnet.ibm.com>
Subject: [PATCH 0/2] aspeed: watchdog: fix system reset and read alt-boot option
Date: Fri,  9 Mar 2018 15:58:18 -0600
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18030921-0008-0000-0000-000002E2C9B6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008643; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01000701; UDB=6.00509032; IPR=6.00780031;
 MB=3.00019945; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-09 21:58:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030921-0009-0000-0000-000038837DE4
Message-Id: <1520632700-25800-1-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803090259
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series provides a fix to correctly set the reset mode of the control
register. Previously, configuring anything other than a full chip reset would
not reset anything when the watchdog timer expires. The series also provides a
patch to read in the existing aspeed,alt-boot boolean option from the
device-tree and set the appropriate bit in the control register.

Milton Miller (2):
  watchdog: aspeed: Fix translation of reset mode to ctrl register
  watchdog: aspeed: Allow configuring for alternate boot

 drivers/watchdog/aspeed_wdt.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
1.8.3.1
