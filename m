Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968741AbeEXULN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:11:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S967788AbeEXULJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:11:09 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, sgrubb@redhat.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 0/8] IMA: work on audit records produced by IMA
Date: Thu, 24 May 2018 16:10:57 -0400
X-Mailer: git-send-email 2.14.3
X-TM-AS-GCONF: 00
x-cbid: 18052420-0056-0000-0000-000004547ED5
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009065; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036001; UDB=6.00529949; IPR=6.00815130;
 MB=3.00021234; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-24 20:11:08
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052420-0057-0000-0000-000008989C34
Message-Id: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805240228
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches cleans up some usages of the audit
subsystem's API by IMA and extends the audit subsystem's API
with API calls for adding new fields to the audit_buffer. Besides
that we extend the existing audit records created while parsing
IMA policy rules with fields that are common for audit records
produced by IMA. Besides that we introduce a new record type
that IMA creates while parsing policy rules.

   Stefan


Stefan Berger (8):
  ima: Call audit_log_string() rather than logging it untrusted
  ima: Use audit_log_format() rather than audit_log_string()
  audit: Implement audit_log_tty()
  audit: Allow others to call audit_log_d_path_exe()
  integrity: Add exe= and tty= before res= to integrity audits
  integrity: Factor out common part of integrity_audit_msg()
  ima: Do not audit if CONFIG_INTEGRITY_AUDIT is not set
  ima: Differentiate auditing policy rules from "audit" actions

 include/linux/audit.h                | 10 ++++++++++
 include/uapi/linux/audit.h           |  3 ++-
 kernel/audit.c                       |  8 ++++++++
 security/integrity/ima/Kconfig       |  1 +
 security/integrity/ima/ima_policy.c  | 12 ++++++++----
 security/integrity/integrity.h       | 26 ++++++++++++++++++++++++++
 security/integrity/integrity_audit.c | 32 +++++++++++++++++++-------------
 7 files changed, 74 insertions(+), 18 deletions(-)

-- 
2.13.6
