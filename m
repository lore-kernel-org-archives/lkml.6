Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755328AbeEaOZL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:25:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755195AbeEaOZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:25:09 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, paul@paul-moore.com,
        linux-integrity@vger.kernel.org, linux-audit@redhat.com
Cc: sgrubb@redhat.com, linux-kernel@vger.kernel.org,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v2 0/4] IMA: work on audit records produced by IMA
Date: Thu, 31 May 2018 10:24:56 -0400
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18053114-0012-0000-0000-0000165C4B8E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009102; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000264; SDB=6.01040334; UDB=6.00532531; IPR=6.00819463;
 MB=3.00021393; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-31 14:25:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18053114-0013-0000-0000-0000530FA4B2
Message-Id: <20180531142500.4193818-1-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=819 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1805310163
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches cleans up some usages of the audit
subsystem's API by IMA. We also introduce a new record type
that IMA creates while parsing policy rules.

   Stefan

v1->v2:
 - dropped several patches that extended existing messages with missing
   fields
 - Using audit_log_task_info() for new record type in last patch
 - rebased on security-next; new message type is now 1807

Stefan Berger (4):
  ima: Call audit_log_string() rather than logging it untrusted
  ima: Use audit_log_format() rather than audit_log_string()
  ima: Do not audit if CONFIG_INTEGRITY_AUDIT is not set
  ima: Differentiate auditing policy rules from "audit" actions

 include/uapi/linux/audit.h           |  1 +
 security/integrity/ima/Kconfig       |  1 +
 security/integrity/ima/ima_policy.c  | 17 +++++++++++++----
 security/integrity/integrity.h       | 15 +++++++++++++++
 security/integrity/integrity_audit.c |  6 +-----
 5 files changed, 31 insertions(+), 9 deletions(-)

-- 
2.13.6
