Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934692AbeB1R5G (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:57:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934462AbeB1R5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:57:00 -0500
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: dhowells@redhat.com
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH 2/3] keys: export find_keyring_by_name()
Date: Wed, 28 Feb 2018 23:25:20 +0530
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180228175521.10287-1-nayna@linux.vnet.ibm.com>
References: <20180228175521.10287-1-nayna@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18022817-0008-0000-0000-000004D61779
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18022817-0009-0000-0000-00001E691867
Message-Id: <20180228175521.10287-2-nayna@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802280218
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exports the function find_keyring_by_name()
to be used by other subsystems.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
 include/linux/key.h      | 2 ++
 security/keys/internal.h | 2 --
 security/keys/keyring.c  | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index e58ee10f6e58..c8d332d4103c 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -346,6 +346,8 @@ static inline key_serial_t key_serial(const struct key *key)
 
 extern void key_set_timeout(struct key *, unsigned);
 
+extern struct key *find_keyring_by_name(const char *name, bool uid_keyring);
+
 /*
  * The permissions required on a key that we're looking up.
  */
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 9f8208dc0e55..8aa8d347a1ab 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -141,8 +141,6 @@ extern key_ref_t keyring_search_aux(key_ref_t keyring_ref,
 extern key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx);
 extern key_ref_t search_process_keyrings(struct keyring_search_context *ctx);
 
-extern struct key *find_keyring_by_name(const char *name, bool uid_keyring);
-
 extern int install_user_keyrings(void);
 extern int install_thread_keyring_to_cred(struct cred *);
 extern int install_process_keyring_to_cred(struct cred *);
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index d0bccebbd3b5..0fd230534685 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1159,6 +1159,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 	read_unlock(&keyring_name_lock);
 	return keyring;
 }
+EXPORT_SYMBOL(find_keyring_by_name);
 
 static int keyring_detect_cycle_iterator(const void *object,
 					 void *iterator_data)
-- 
2.13.6
