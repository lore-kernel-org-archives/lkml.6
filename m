Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2263AmMoqiOYhkcZjeyml7xKxS9ijmAsd3ttJm3H5V++XZcw0olSLlk/C/gaQ+aqCFmA3E1V
ARC-Seal: i=1; a=rsa-sha256; t=1519218520; cv=none;
        d=google.com; s=arc-20160816;
        b=VvqYCI1gCNtf5hKd7UEOT8ViJcosvju0go56WP0wtRsrtLOos+GFfg2djGT/MF6y/d
         HbIVly1Emh47aQ1jhOhZ447oT2FlfzGdxKRD9O+IvUcH1kIe2ZWwgVuwFgRLTniWSX4k
         p5yaCVKGGYdChdBmEO+vRWkg1N1HSpuokDbxCB7xG363TLCS1rVm0uOFaOYvzqzaMXAv
         LqW4OcYcjX9nzyXiyfPjJlC/4aCPUuqsyaoEl3IdukYEJfBOZ0oTYhLA7GVcajelnG7s
         UkVqetvfXG1T7OSroO39xmGZrt5Ed+C+gzIgQkz7N1HJ4lrYG+yW1TNSu3PtQXhweSUO
         Lu4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Zt11f7o1/xKfS0nwUMI5kZuxrVbo8nocck3cbpkgJG4=;
        b=AVVkuvKHsVTcALkYkY060brwIx3RcG9oTjDl3Wcu33kGSrKvGphI0zvwkicNfoLrGv
         w1dj/Uc0mu9syWhnxflpUcfsR3uRVs/AOC5yn6xLqnxThKpMxvdVspMHsSnp9nwS7rIK
         J18mzXIhE0bZlhOe4LWC8LoQ5FYmlf08PuCQ/n/nlTnf0n04Jjy2wHLEc6kxtZDt91yq
         fEBwjsZTMYPpVo/tO6pp+i8XNlaQYxXby+EtLqzhxCGqNYUfcesMBPyWSpfKEGch9vpu
         fs3xCeRN5bMqgB+nyRbDq8mmWHeTQ+/libblmFctMM2po6QUmV368an5/QtPgDjTEG4j
         BYbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Lutomirski <luto@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org
Subject: [PATCH 4.15 069/163] selftests/x86: Clean up and document sscanf() usage
Date: Wed, 21 Feb 2018 13:48:18 +0100
Message-Id: <20180221124534.300516334@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015713811581521?=
X-GMAIL-MSGID: =?utf-8?q?1593016079162298404?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit d8e92de8ef952bed88c56c7a44c02d8dcae0984e upstream.

Replace a couple of magically connected buffer length literal constants with
a common definition that makes their relationship obvious. Also document
why our sscanf() usage is safe.

No intended functional changes.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andrew Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org
Link: http://lkml.kernel.org/r/20180211205924.GA23210@light.dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/test_vdso.c     |   11 ++++++++---
 tools/testing/selftests/x86/test_vsyscall.c |   11 ++++++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

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
+		/* sscanf() is safe here as strlen(name) >= strlen(line) */
 		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
 			   &start, &end, &r, &x, name) != 5)
 			continue;
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
+		/* sscanf() is safe here as strlen(name) >= strlen(line) */
 		if (sscanf(line, "%p-%p %c-%cp %*x %*x:%*x %*u %s",
 			   &start, &end, &r, &x, name) != 5)
 			continue;
