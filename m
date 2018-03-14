Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752108AbeCNUUk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 16:20:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751626AbeCNUUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 16:20:38 -0400
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Subject: [PATCH 0/4] Code improvements in integrity and IMA
Date: Wed, 14 Mar 2018 17:20:16 -0300
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18031420-0024-0000-0000-000003368E28
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008674; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01003063; UDB=6.00510447; IPR=6.00782393;
 MB=3.00020035; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-14 20:20:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031420-0025-0000-0000-000047540424
Message-Id: <20180314202020.3794-1-bauerman@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803140218
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

These patches come from the "appended signatures support for IMA appraisal"
series. They are code improvements and cleanups and I decided to submit
them separately for a couple of reasons:

1. they stand on their own and could be included in v4.17;

2. this will simplify the original patch series a bit, by having it contain
   only the patches actually necessary to implement the feature.

These are the changes made to them since v5 of the modsig series:

- Patch "integrity: Remove unused macro IMA_ACTION_RULE_FLAGS"
  - New patch.

- Patch "ima: Improvements in ima_appraise_measurement()"
  - Moved is_ima_sig() to its own patch (not in this series).

Mimi Zohar (1):
  ima: Improvements in ima_appraise_measurement()

Thiago Jung Bauermann (3):
  integrity: Remove unused macro IMA_ACTION_RULE_FLAGS
  ima: Simplify ima_eventsig_init()
  integrity: Introduce struct evm_xattr

 security/integrity/evm/evm_crypto.c       |  4 ++--
 security/integrity/evm/evm_main.c         | 10 ++++----
 security/integrity/ima/ima_appraise.c     | 40 ++++++++++++++++++-------------
 security/integrity/ima/ima_template_lib.c | 11 +++------
 security/integrity/integrity.h            |  6 ++++-
 5 files changed, 39 insertions(+), 32 deletions(-)
