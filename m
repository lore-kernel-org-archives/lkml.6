Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsrJ4QhQdHQVlmVwQdLxJxgZqt8WWH6j93BbFeUchAtBU9mglbZxt10a8+GTTVdELl64VwU
ARC-Seal: i=1; a=rsa-sha256; t=1520603314; cv=none;
        d=google.com; s=arc-20160816;
        b=0eP500H0yoHD7NEUw/8LVsIMxUWVpivKXpq1zLSzfL2wtOlhaAWJdoO6ZPreJu3wkj
         LXdoXzUCAZS8x6NclOgj9YLFBOGpUKuX3TvPypBLyIMWuhMSJZGscKCjrAJqkGRYf7+u
         kpqCnTnBbzPC9z3CMQZE0qeQk2PVevM/hly6W8PvTv3foKZi7ck5Kg/eTFnnwsLaF9cx
         AhLD/TGZe0yYtSU0vocHJOOG+0bTuz/oDUJ5PX8JmouArDoO6FzScE13VUbaUMkm7JR4
         iTy+27T2eRNHLWPOVajfn/7P9bu5JJCLxxHeyept49/y8k9UiSxJj5kTJIUCsEdhd2kS
         D+ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=oOOy5A2jyKv0uiA/I6R2BZ5aagjwDenCA9Lmt7eE198=;
        b=DqGvlsdhyLzRCI0TgeExAvXLtkzFR1oCXGQjYOrAV4C/d8S/a1JMAitWNHxcB42dOG
         ckRmskLtXN47HElCKa+KfNz2cvQvN3FgvLqaH4vBcmaa9A8kVKzbpvIEAGgNx/1Vftk9
         NytwXaglk/KsBfUFBEOhAMPpWNEeSQNVXZWJppO5UGgdPCCX/EywOdE8EIpa6vKccaNn
         1HLeq/enHDAL2S0E7RGr3553VnMqT/25BpH3EBVvFSlanf+1B/WokWFhhnihwkBbN8rX
         AoFJ6ufaBwnqVAOaF/8w8xV15EUs+hujkaNBnnDuSE5JcfXG4S4CEWZUy1I1OE6lsdg+
         rXGw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=EYrRupQL;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=EYrRupQL;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932162AbeCINsL (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 9 Mar 2018 08:48:11 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:38577 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932130AbeCINsI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Mar 2018 08:48:08 -0500
From: Anders Roxell <anders.roxell@linaro.org>
To: shuah@kernel.org
Cc: skinsbursky@parallels.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests/ipc/msgque: Fix warning implicit declaration
Date: Fri,  9 Mar 2018 14:47:55 +0100
Message-Id: <20180309134755.11101-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594468141220190174?=
X-GMAIL-MSGID: =?utf-8?q?1594468141220190174?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

gcc warns about implicit declaration.

gcc -I../../../../usr/include/    msgque.c  -o msgque
msgque.c: In function ‘restore_queue’:
msgque.c:52:7: warning: implicit declaration of function ‘msgget’
 [-Wimplicit-function-declaration]
  id = msgget(msgque->key, msgque->mode | IPC_CREAT | IPC_EXCL);
       ^~~~~~
msgque.c:66:7: warning: implicit declaration of function ‘msgsnd’
 [-Wimplicit-function-declaration]
   if (msgsnd(msgque->msq_id, &msgque->messages[i].mtype,
       ^~~~~~
msgque.c:76:6: warning: implicit declaration of function ‘msgctl’
 [-Wimplicit-function-declaration]
  if (msgctl(id, IPC_RMID, 0))
      ^~~~~~
msgque.c: In function ‘check_and_destroy_queue’:
msgque.c:87:9: warning: implicit declaration of function ‘msgrcv’
 [-Wimplicit-function-declaration]
   ret = msgrcv(msgque->msq_id, &message.mtype, MAX_MSG_SIZE,
         ^~~~~~
msgque.c: In function ‘main’:
msgque.c:204:15: warning: implicit declaration of function ‘ftok’
 [-Wimplicit-function-declaration]
  msgque.key = ftok(argv[0], 822155650);
               ^~~~

In the current code, we include the headers that the functions want
according to the man pages, and we define MSG_COPY if its not defined.
We also use 'struct msqid_ds' instead of 'struct msqid64_ds'.

I thought about another patch where I just forward declared these
functions. However, I wasn't happy with that patch since it feels that
it forces user space apps to do the same in order to get this to work.
Another reason was that checkpatch.pl complained that I added forward
declarations in the c file.

Fixes: 3a665531a3b7 ("selftests: IPC message queue copy feature test")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/ipc/msgque.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index ee9382bdfadc..3e32917cd7f4 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -3,11 +3,18 @@
 #include <stdio.h>
 #include <string.h>
 #include <errno.h>
-#include <linux/msg.h>
 #include <fcntl.h>
 
+#include <sys/types.h>
+#include <sys/ipc.h>
+#include <sys/msg.h>
+
 #include "../kselftest.h"
 
+#ifndef MSG_COPY
+#    define MSG_COPY        040000  /* copy (not remove) all queue messages */
+#endif
+
 #define MAX_MSG_SIZE		32
 
 struct msg1 {
@@ -129,7 +136,7 @@ int check_and_destroy_queue(struct msgque_data *msgque)
 
 int dump_queue(struct msgque_data *msgque)
 {
-	struct msqid64_ds ds;
+	struct msqid_ds ds;
 	int kern_id;
 	int i, ret;
 
-- 
2.11.0

