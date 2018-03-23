Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1990790-1521832763-2-17704220990383697363
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521832763; b=fwE4HEAwolFGwS280APHo1JV9tuwd57D4sqr9rYxwGgJ6Y2
    yHPlQzn2mrJTPxP+eSwvxb8VeWkCtC3XlDmqlTMKK0UG+OoZdvCUtTDKM2EdcIL6
    xe1MtzO/6VjwA/98tm5Wub2S2oP4QReOEZ6EGt5h22VRtyazqGeDMnykjkfJ5JTx
    m79Kk2Tz+cc0t3uS5FYE2/2bEIUvf0MnR6ziUBml1/K8lJb+ityHlNI8reCZvUuU
    Wp/Se6eMZALteF+U6BVjC/aqvY9cCdssiW0TNpauzAkDqYySANSG2jJA2DCFy3oi
    2ERqKxvBl+J3pCLlm2X49Z8XU8ZW1Bv5RvRqgTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=arctest; t=1521832763; bh=
    PhTtlQ/qacGgc3uuIIaIvD6ALMo2I3c6YQaAnXEHEj4=; b=jvSGKAzVcVawNUiE
    irOJGn6hzBHMesVflTIRYGJWcmJDEtjpGOdidovtHZBQchEfh5bUeroXTA3D6hST
    1z+hsiG0TKkJewYzQzol1zXc0l+66pbBKzEdRy+EkMbvLdaocCb7u8OeKm03P8Av
    AmoH8I7xvgbYzZRyyQWlYqIhF7Lckm983F0QgB/2Wjo0STXjFtPcd2QO4FNT9uv6
    V+NnEFZ/xBWRRYn0h14S5bni5gSRA2gduWaObEnPrWoV4Y1KVOV5upeTwds/2+RS
    lNgVkcLcx3VHz0JnyTEylGitGr8Cgc0/3UUQofr6mbJTeiDCd6Wqy1rfMdD/MIEl
    ykRJMA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbeCWTSG (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 15:18:06 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44648 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752527AbeCWTSC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Mar 2018 15:18:02 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linux Containers <containers@lists.linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 23 Mar 2018 14:16:08 -0500
Message-Id: <20180323191614.32489-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87vadmobdw.fsf_-_@xmission.com>
References: <87vadmobdw.fsf_-_@xmission.com>
X-XM-SPF: eid=1ezSCN-00033I-FQ;;;mid=<20180323191614.32489-5-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+FF/1b+tb6ZT8A9rwzMryYeKLSzo2qChM=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa05.xmission.com
X-Remote-Spam-Level: ****
X-Remote-Spam-Status: No, score=4.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TVD_RCVD_IP,T_TooManySym_01,T_TooManySym_02,
        T_XMDrugObfuBody_04,XMNoVowels,XMSubLong autolearn=disabled version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_04 obfuscated drug references
X-Remote-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ****;Linux Containers <containers@lists.linux-foundation.org>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 274 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.1 (1.1%), b_tie_ro: 2.1 (0.7%), parse: 1.26 (0.5%),
        extract_message_metadata: 16 (6.0%), get_uri_detail_list: 2.3 (0.8%),
        tests_pri_-1000: 9 (3.2%), tests_pri_-950: 1.70 (0.6%), tests_pri_-900: 1.38
        (0.5%), tests_pri_-400: 24 (8.9%), check_bayes: 23 (8.4%), b_tokenize: 10
        (3.7%), b_tok_get_all: 6 (2.2%), b_comp_prob: 2.3 (0.8%), b_tok_touch_all:
        2.6 (1.0%), b_finish: 0.71 (0.3%), tests_pri_0: 206 (75.0%),
        check_dkim_signature: 0.60 (0.2%), check_dkim_adsp: 2.8 (1.0%),
        tests_pri_500: 7 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 05/11] shm: Move struct shmid_kernel into ipc/shm.c
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

All of the users are now in ipc/shm.c so make the definition local to
that file to make code maintenance easier.  AKA to prevent rebuilding
the entire kernel when struct shmid_kernel changes.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/shm.h | 23 -----------------------
 ipc/shm.c           | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/include/linux/shm.h b/include/linux/shm.h
index 2bbafacfbfc9..c7cb18405ad7 100644
--- a/include/linux/shm.h
+++ b/include/linux/shm.h
@@ -3,32 +3,9 @@
 #define _LINUX_SHM_H_
 
 #include <linux/list.h>
-#include <asm/page.h>
 #include <uapi/linux/shm.h>
 #include <asm/shmparam.h>
 
-struct shmid_kernel /* private to the kernel */
-{	
-	struct kern_ipc_perm	shm_perm;
-	struct file		*shm_file;
-	unsigned long		shm_nattch;
-	unsigned long		shm_segsz;
-	time64_t		shm_atim;
-	time64_t		shm_dtim;
-	time64_t		shm_ctim;
-	pid_t			shm_cprid;
-	pid_t			shm_lprid;
-	struct user_struct	*mlock_user;
-
-	/* The task created the shm object.  NULL if the task is dead. */
-	struct task_struct	*shm_creator;
-	struct list_head	shm_clist;	/* list by creator */
-} __randomize_layout;
-
-/* shm_mode upper byte flags */
-#define	SHM_DEST	01000	/* segment will be destroyed on last detach */
-#define SHM_LOCKED      02000   /* segment will not be swapped */
-
 #ifdef CONFIG_SYSVIPC
 struct sysv_shm {
 	struct list_head shm_clist;
diff --git a/ipc/shm.c b/ipc/shm.c
index 387a786e7be1..0565669ebe5c 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -48,6 +48,28 @@
 
 #include "util.h"
 
+struct shmid_kernel /* private to the kernel */
+{
+	struct kern_ipc_perm	shm_perm;
+	struct file		*shm_file;
+	unsigned long		shm_nattch;
+	unsigned long		shm_segsz;
+	time64_t		shm_atim;
+	time64_t		shm_dtim;
+	time64_t		shm_ctim;
+	pid_t			shm_cprid;
+	pid_t			shm_lprid;
+	struct user_struct	*mlock_user;
+
+	/* The task created the shm object.  NULL if the task is dead. */
+	struct task_struct	*shm_creator;
+	struct list_head	shm_clist;	/* list by creator */
+} __randomize_layout;
+
+/* shm_mode upper byte flags */
+#define SHM_DEST	01000	/* segment will be destroyed on last detach */
+#define SHM_LOCKED	02000   /* segment will not be swapped */
+
 struct shm_file_data {
 	int id;
 	struct ipc_namespace *ns;
-- 
2.14.1

