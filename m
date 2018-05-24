Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971376AbeEXUMh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 16:12:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40524 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S968776AbeEXULR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 16:11:17 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, sgrubb@redhat.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 4/8] audit: Allow others to call audit_log_d_path_exe()
Date: Thu, 24 May 2018 16:11:01 -0400
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18052420-0040-0000-0000-000004317D48
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009065; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01036001; UDB=6.00529949; IPR=6.00815130;
 MB=3.00021234; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-24 20:11:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18052420-0041-0000-0000-000008379AE6
Message-Id: <20180524201105.3179904-5-stefanb@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805240228
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the prototype for audit_log_d_path_exe() so that it can be
called by IMA later in this series.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 include/linux/audit.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 2deb76c74d10..65eca0795308 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -144,6 +144,8 @@ extern void		    audit_log_untrustedstring(struct audit_buffer *ab,
 extern void		    audit_log_d_path(struct audit_buffer *ab,
 					     const char *prefix,
 					     const struct path *path);
+extern void		    audit_log_d_path_exe(struct audit_buffer *ab,
+						 struct mm_struct *mm);
 extern void		    audit_log_key(struct audit_buffer *ab,
 					  char *key);
 extern void		    audit_log_link_denied(const char *operation);
@@ -192,6 +194,9 @@ static inline void audit_log_d_path(struct audit_buffer *ab,
 				    const char *prefix,
 				    const struct path *path)
 { }
+static inline void audit_log_d_path_exe(struct audit_buffer *ab,
+					struct mm_struct *mm)
+{}
 static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
 static inline void audit_log_link_denied(const char *string)
-- 
2.13.6
