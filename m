Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225PS7qxF3R3aNR/yC2dtotqe8HtPBRfZ1gXxACKUged+LuaDyJ5dYuSlE1eMjjD7dH2va5p
ARC-Seal: i=1; a=rsa-sha256; t=1519218171; cv=none;
        d=google.com; s=arc-20160816;
        b=MB1JG24LuMO/0zYGeTq6UU8SpUaxf0Sf+ml6xmKuV2gs71unAFWT5uKn54cgqiOmeb
         hEV22yF1Xqarl6jUGpKSbjeMECm60ugf5OVmSqmEP8zngjorApym2v7yF2FEvi/x4VO3
         yJUO9Wi9BTuXqw9kNeM8Dv0VmOjFx1Yne7wNK6JnuxbSvEO4m4+bd2WnJr91Vnx1xndX
         h4gnFrXfxaGgUjMYEfJy6hD6zqFnL6vxJsxTSL92aNN7BGrtF43aYCatvRpZGvigtOlD
         77wzTLclIHy2c+YxvvF1ste5ROm4Z/Es/qFlbRgqXfXsJayaPD+A5YFvyHB/mEFItIaU
         l1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nw2J/dvkqxaRGOkIcVsHR7KaXeEKKKcoBOZad+20zjs=;
        b=hV+5pWx/r3gI4AU0k6BHRBmazA+JSQMlOlKDC4dasmrmprgWYdwnQkrADgP0X8HkNn
         nYehNDVmjCvRmHKXUgQAIulGCq063GrFIYfwkWf6NT4qD/a0twp+1AQe8LputSj96vrS
         Lrz6BouP9kB7uxZPGBSPpkQul5hPUwqw60vgs23hnvH8+xbgY2OqiyuQdFGxD9zYaTmo
         R5AMf34AKBdB1G+WDe/YfYViO1umfysMgOUygdflGHhahF5YOnjliehgGS9Nc40ppKjz
         G6mpRXZVm/FMDx4tzHgl5wweM1TmzrOXh6J7IOhfIzE3670IqntAMlws3MigQUUNa+s+
         6h1g==
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
Subject: [PATCH 4.14 068/167] selftests/x86: Clean up and document sscanf() usage
Date: Wed, 21 Feb 2018 13:47:59 +0100
Message-Id: <20180221124528.233369851@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015713811581521?=
X-GMAIL-MSGID: =?utf-8?q?1593015713811581521?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
