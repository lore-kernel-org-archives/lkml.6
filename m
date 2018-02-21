Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2260N+au5EGNwnICyb+JVbqWsi/sW8uZ9piU1tekLaIq2YZZoTzSL11AeV6nTNIASzXhDm4t
ARC-Seal: i=1; a=rsa-sha256; t=1519217797; cv=none;
        d=google.com; s=arc-20160816;
        b=FVXPqLKh3k3GVI23ZJNM5NpvXcmfsEuCKKrXIsAg3iDfGsK5R/jm/jtD21pM9QNLyF
         7HUl/PRC0u22iFNkauft2HKphMJWdz/zU7vqiqgYdjqIrdyxpUDndaTLny5lV8b6lobO
         lXzXiy/OJrXZmd5rQaQaI9JYa4UCwzL0YghIxjNmu3q7jMo7xZue1F8Rte2ZdHW5W3qm
         QRVPj8CzvKfY3xf1Ojc8ATNgOWx+YJiFlMTTwrPwfJCz71Xb/823jSdhk+pAQLsyLI/h
         eR37RmuZE0xiTJvYbtv+Ae0fHsSqxl/bD+mKLWN/7ybQCI5AD7/6JGpH3fi3MfnlUsSo
         CvTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=x8ypUCiXQof5bRFtQsaKSO3q9lyajvuO27aPFGhS/cs=;
        b=famBnfuX7D9RYarRq1egWxS1jcjqv5W+FO9G7qJj7+AeKu+iZcDS5HVyt5xMlfGWfL
         rIfhI6mqMS1RduAdDmZbkueCQdkS3iGAexmhLCUA/JQRvvKUmLYybnuAvaODs+YdoWY5
         7gSpedos1Nz8Apvte5VL9B5ZuAzQzcxr5IaPODrWJVY+qniufz4wQaP3jVdH/xab3x00
         OGi4moldpmhWDejSUPU9Fl2xDNbU7aMBrRND0Dq6A53XTcBBaY6S6OdFlmX67y8Y487l
         gs00mDyPmBNRLgbPkt8deYfk1s7Gyrt3OAyTNC+ooJCzHLZWR5iW4KmvwrRUhOK3p+w3
         1J4A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Shuah Khan <shuahkh@osg.samsung.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 57/77] selftests/x86/pkeys: Remove unused functions
Date: Wed, 21 Feb 2018 13:49:06 +0100
Message-Id: <20180221124434.617897595@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015321225692352?=
X-GMAIL-MSGID: =?utf-8?q?1593015321225692352?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ingo Molnar <mingo@kernel.org>

commit ce676638fe7b284132a7d7d5e7e7ad81bab9947e upstream.

This also gets rid of two build warnings:

  protection_keys.c: In function ‘dumpit’:
  protection_keys.c:419:3: warning: ignoring return value of ‘write’, declared with attribute warn_unused_result [-Wunused-result]
     write(1, buf, nr_read);
     ^~~~~~~~~~~~~~~~~~~~~~

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/protection_keys.c |   28 --------------------------
 1 file changed, 28 deletions(-)

--- a/tools/testing/selftests/x86/protection_keys.c
+++ b/tools/testing/selftests/x86/protection_keys.c
@@ -381,34 +381,6 @@ pid_t fork_lazy_child(void)
 	return forkret;
 }
 
-void davecmp(void *_a, void *_b, int len)
-{
-	int i;
-	unsigned long *a = _a;
-	unsigned long *b = _b;
-
-	for (i = 0; i < len / sizeof(*a); i++) {
-		if (a[i] == b[i])
-			continue;
-
-		dprintf3("[%3d]: a: %016lx b: %016lx\n", i, a[i], b[i]);
-	}
-}
-
-void dumpit(char *f)
-{
-	int fd = open(f, O_RDONLY);
-	char buf[100];
-	int nr_read;
-
-	dprintf2("maps fd: %d\n", fd);
-	do {
-		nr_read = read(fd, &buf[0], sizeof(buf));
-		write(1, buf, nr_read);
-	} while (nr_read > 0);
-	close(fd);
-}
-
 #define PKEY_DISABLE_ACCESS    0x1
 #define PKEY_DISABLE_WRITE     0x2
 
