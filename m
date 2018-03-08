Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751072AbeCHU53 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:57:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750787AbeCHU51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:57:27 -0500
From: Eddie James <eajames@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-clk@vger.kernel.org, joel@jms.id.au, mturquette@baylibre.com,
        sboyd@kernel.org, eajames@linux.vnet.ibm.com, mine260309@gmail.com,
        ryan_chen@aspeedtech.com
Subject: [PATCH v2 0/2] clk: aspeed: Fix is_enabled and prevent reset if clock enabled
Date: Thu,  8 Mar 2018 14:57:18 -0600
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
x-cbid: 18030820-0008-0000-0000-0000096EDBC2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008636; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01000200; UDB=6.00508735; IPR=6.00779530;
 MB=3.00019921; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-08 20:57:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030820-0009-0000-0000-00004651161F
Message-Id: <1520542640-9185-1-git-send-email-eajames@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803080226
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are two fixes for the Aspeed clock driver. The first fixes the is_enabled
clock function to account for different clock gates getting disabled with
either 0s or 1s. The second patch addresses some issue found with the LPC
controller clock if it gets reset while the clock is enabled, which it is by
default. Thanks to Lei Yu for tracking down the LPC issue.

Changes since v1:
 - Fix is_enabled.
 - Check for enabled in the spinlock in the enable function.
 - Use is_enabled instead of more code to read the register.

Eddie James (2):
  clk: aspeed: Fix is_enabled for certain clocks
  clk: aspeed: Prevent reset if clock is enabled

 drivers/clk/clk-aspeed.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

-- 
1.8.3.1
