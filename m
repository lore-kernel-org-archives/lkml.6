Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751952AbeEBXKH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 19:10:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751929AbeEBXKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 19:10:04 -0400
From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Keyrings <keyrings@vger.kernel.org>
Cc: Linux Integrity <linux-integrity@vger.kernel.org>,
        Linux Security <linux-security-module@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Subject: [PATCH v6 4/4] KEYS: Print insert-sys-cert information to stdout instead of stderr
Date: Wed,  2 May 2018 19:08:11 -0400
X-Mailer: git-send-email 2.14.3 (Apple Git-98)
In-Reply-To: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
References: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18050223-0020-0000-0000-00000DDA0670
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008959; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000258; SDB=6.01026618; UDB=6.00524345; IPR=6.00805804;
 MB=3.00020894; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-02 23:10:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050223-0021-0000-0000-0000612E662E
Message-Id: <20180502230811.2751-5-mkayaalp@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805020193
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detailed INFO output should go to stdout instead of stderr.

Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
---
 scripts/insert-sys-cert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/insert-sys-cert.c b/scripts/insert-sys-cert.c
index a3bd7ea8a436..caa446fe91b8 100644
--- a/scripts/insert-sys-cert.c
+++ b/scripts/insert-sys-cert.c
@@ -32,7 +32,7 @@
 #define USED_SYM  "system_extra_cert_used"
 #define LSIZE_SYM "system_certificate_list_size"
 
-#define info(format, args...) fprintf(stderr, "INFO:    " format, ## args)
+#define info(format, args...) fprintf(stdout, "INFO:    " format, ## args)
 #define warn(format, args...) fprintf(stdout, "WARNING: " format, ## args)
 #define  err(format, args...) fprintf(stderr, "ERROR:   " format, ## args)
 
-- 
2.17.0
