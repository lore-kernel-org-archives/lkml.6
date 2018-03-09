Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbeCIPkG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 10:40:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56552 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932224AbeCIPjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 10:39:31 -0500
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: dhowells@redhat.com
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v2 2/3] keys: export find_keyring_by_name()
Date: Fri,  9 Mar 2018 21:08:02 +0530
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180309153803.25859-1-nayna@linux.vnet.ibm.com>
References: <20180309153803.25859-1-nayna@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18030915-0020-0000-0000-00000400CE2D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030915-0021-0000-0000-0000429517C8
Message-Id: <20180309153803.25859-2-nayna@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803090194
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exports the function find_keyring_by_name() to be used by
other subsystems.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
Changelog:

v2:
* Fix the patch description per line length as suggested by Mimi

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
index 41bcf57e96f2..4b9c3f1166d1 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1152,6 +1152,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 	read_unlock(&keyring_name_lock);
 	return keyring;
 }
+EXPORT_SYMBOL(find_keyring_by_name);
 
 static int keyring_detect_cycle_iterator(const void *object,
 					 void *iterator_data)
-- 
2.13.6
