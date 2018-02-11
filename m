Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x226UniK2nAnvMvh92s/XpWyiASKcPUsnsZbU3jKtm+SQdmaeq55UlRpzrC5APN16YdD9vY++
ARC-Seal: i=1; a=rsa-sha256; t=1518383166; cv=none;
        d=google.com; s=arc-20160816;
        b=aadjFn7+IWwzQzmZiER77/aAsH8mCd+OBQCUU3s2emVke88PuT8QSlR8vkOVK13hcB
         vfuKi4j0VEeVGElCR6CHGAg7Xggybasl1z88B3jHTxy05JF5EXSZDm2rlFk4NXV+3bXr
         gY8J1CB74KrdQMklbSrl4acE8ZdENqU+xI9TbdENzgxRhkof7IuA3vdshUI16EusPxzL
         59j1R+B5mxaXq1TTilAJ5w5SjYJBwM5sVv5Ph85jGR1UJlFUyuldevIUs9O0AVg3T5mi
         EQTMAQPHn3Ke/oeybXZ8CRXHKcKy+YGWrOMzSIorLTJeDWn2PaIPT7sMVcQm/N+fK04w
         3wHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=+FPdmBPpMx3oPq1/rtcETZ+srbHp6FdwGKEePTOpIX0=;
        b=ZRoFvAnfCd+C8ZOT+wBXMT9snY97CdfO78jZpg+4ixLfJtUTdi3+rn0QZO0FKBFcRD
         IwUliz2o6M4t3hJlb+3S4g+ky/uUOW62jSXfVZmHTPMdCAGT1i6AcrC9K+9tGEOajQIn
         1mUAqECyyifPQTJGATdPLfMslaxmaczPfxZKIbwP+JPbsSxWwTXiigzwPWmMuWtWaOA+
         KdpMjj1VpHLWkMuSBD0nMCMxjAtQvjWAqcSUNhJGjELTUvLUnGS7hC+k4uWVUvVZ8pBE
         MKWIe/1vqmtQVx6okDbav2UGKyQKtMP5tu2v6+Eomygv6nJigl6WFpQix2csz5Fq6fuJ
         lNCg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753711AbeBKVGF (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 11 Feb 2018 16:06:05 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:60916 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753665AbeBKVGF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Feb 2018 16:06:05 -0500
Date: Sun, 11 Feb 2018 21:59:24 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Ingo Molnar <mingo@kernel.org>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        Andrew Lutomirski <luto@kernel.org>
Subject: [PATCH] selftests/x86: clarify that there is no buffer overflow on
 sscanf usage
Message-ID: <20180211205924.GA23210@light.dominikbrodowski.net>
References: <20180211111013.16888-1-linux@dominikbrodowski.net>
 <20180211111013.16888-3-linux@dominikbrodowski.net>
 <20180211112153.f2ni5mcuut6f6zvq@gmail.com>
 <20180211121714.GA11096@isilmar-4.linta.de>
 <20180211130029.GA23754@light.dominikbrodowski.net>
 <20180211182428.e7isprkt6hbuq3dk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180211182428.e7isprkt6hbuq3dk@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592140147310711169?=
X-GMAIL-MSGID: =?utf-8?q?1592140147310711169?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Suggested-by: Ingo Molnar <mingo@kernel.org>
CC: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

---

> Yeah, probably - but still, this connection and the sscanf() guarantee is not 
> obvious at first sight, so please improve this to derive from the same value 
> (define a LINE_MAX size or such), plus maybe add a comment to the sscanf() line 
> that this is safe because strlen(name) >= strlen(line).

Sounds reasonable. Patch (which applies on top of the five patches for
selftests/x86 I sent out earlier today) is attached.

Thanks,
	Dominik

diff --git a/tools/testing/selftests/x86/test_vdso.c b/tools/testing/selftests/x86/test_vdso.c
index 558c8207e7b9..7ade625f10ed 100644
--- a/tools/testing/selftests/x86/test_vdso.c
+++ b/tools/testing/selftests/x86/test_vdso.c
@@ -26,6 +26,9 @@
 # endif
 #endif
 
+/* max length of lines in /proc/self/maps - anything longer is skipped here */
+#define MAPS_LINE_LEN 128
+
 int nerrs = 0;
 
 typedef long (*getcpu_t)(unsigned *, unsigned *, void *);
@@ -37,17 +40,19 @@ static void *vsyscall_getcpu(void)
 {
 #ifdef __x86_64__
 	FILE *maps;
-	char line[128];
+	char line[MAPS_LINE_LEN];
 	bool found = false;
 
 	maps = fopen("/proc/self/maps", "r");
 	if (!maps) /* might still be present, but ignore it here, as we test vDSO not vsyscall */
 		return NULL;
 
-	while (fgets(line, sizeof(line), maps)) {
+	while (fgets(line, MAPS_LINE_LEN, maps)) {
 		char r, x;
 		void *start, *end;
-		char name[128];
+		char name[MAPS_LINE_LEN];
+
+		/* sscanf is safe here as strlen(name) >= strlen(line) */
 		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
 			   &start, &end, &r, &x, name) != 5)
 			continue;
diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 7a744fa7b786..ee92e4727f18 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -33,6 +33,9 @@
 # endif
 #endif
 
+/* max length of lines in /proc/self/maps - anything longer is skipped here */
+#define MAPS_LINE_LEN 128
+
 static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 		       int flags)
 {
@@ -98,7 +101,7 @@ static int init_vsys(void)
 #ifdef __x86_64__
 	int nerrs = 0;
 	FILE *maps;
-	char line[128];
+	char line[MAPS_LINE_LEN];
 	bool found = false;
 
 	maps = fopen("/proc/self/maps", "r");
@@ -108,10 +111,12 @@ static int init_vsys(void)
 		return 0;
 	}
 
-	while (fgets(line, sizeof(line), maps)) {
+	while (fgets(line, MAPS_LINE_LEN, maps)) {
 		char r, x;
 		void *start, *end;
-		char name[128];
+		char name[MAPS_LINE_LEN];
+
+		/* sscanf is safe here as strlen(name) >= strlen(line) */
 		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
 			   &start, &end, &r, &x, name) != 5)
 			continue;
