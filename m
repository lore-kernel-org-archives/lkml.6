Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x22719E+0m3o1L5B7tQrmTIkiKMwKXbt2yMvzbR/FuvjAMoeDPFQP9301tmwCbPsYW1rWBNzt
ARC-Seal: i=1; a=rsa-sha256; t=1519218523; cv=none;
        d=google.com; s=arc-20160816;
        b=bSEYyGVerEcJgi4qGdvmXrF0zxfRqloprVxWxz7NSxgZedGGf1afLOdVg80p+QGimI
         kM8Klxw8Ev6ymDDsPIlO4SoFRQL7gwPUg11Vyb11CB9zurdAX3nwWvyvB+xdzlQu7GS3
         TFxjHaY3MRFV15UkTCfVAWHvxXV5uCO+FGRJFx/m5swH8w6feGzvG2HQFXZi1+xc9iLG
         GYQaJF1Uwes9R+HmIdXDKR3Q2x57OuWw+kEjsZWJeleyqMylvKMAwylpx3fLfNydBk0i
         jYellviU7wNm/vyZ112tvYr8uG2+dMlzog+7ymNIiRzhdday2oj68BgHlxEDH7jpyrut
         ejsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=lkClBmAEzOUa/k9ReFfM77TC7uFvsWoKBqWq4CV2B7k=;
        b=pvX/Xht9Ib8M3rqTjqawH1iI3O4soDahcQer0FMY6v9XNNQ7zmLa6vj1usfQArEfMF
         Q+RoQ5rgANuYyctNxAEP1i8ufne7myEfIHKREGS24xrAX5YYAwvIx746H6YjhURElYJ5
         J25aZQybHIFsKPEwEXk4dN9sHkkYPz1bPWfNKAXa2PbWf70jjyRw7JMt0dIZyAn8iehI
         ywxwO6Sa/QkZLFdrXTpa+Nh6BKb8w0nqwIk0mIyPflfCTlsSquPou91/RiyQDSaW1kgr
         Zu2kwJpsxGnLztwUytYmvZxFgYtzQVOtgt2zN3tz9M4zb1JLmJ3/+EBX6Yi8BsMLuPlz
         MXCA==
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
Subject: [PATCH 4.15 070/163] selftests/x86/pkeys: Remove unused functions
Date: Wed, 21 Feb 2018 13:48:19 +0100
Message-Id: <20180221124534.355357045@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015321225692352?=
X-GMAIL-MSGID: =?utf-8?q?1593016081976520959?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -393,34 +393,6 @@ pid_t fork_lazy_child(void)
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
 
