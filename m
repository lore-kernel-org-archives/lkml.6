Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2271igMjaZ6K1C7LyOg5JRjmp0Tt3Eu+kBw4wM2hCLiymyC/du9b9JazdLYqbG6+wcn9Q+rX
ARC-Seal: i=1; a=rsa-sha256; t=1519218076; cv=none;
        d=google.com; s=arc-20160816;
        b=kIv13P37U6xr5ody077csg/xHrQ43w409mjutj/y2uPRhGIU3/TpFXn5kuGL3z9l6b
         SrXHsf+y29kHHF7eZXtst8GhHNpAAB2FelNPEH5NUSz/cOFZBuw0DgzhrEDEYbDd2L76
         9zEfQkzw55SAFeNzGLE92Kfhkf78uJr0ItR3Q4Fuw/cXwUFayrZCyFRO8WJcSopXaLa5
         dEp4/ccliwDLQBegXqu5nlF0PLUEcIhy0CRejzWlOpLfBzD6H67RV4Ll8Q3xBZMGKOlP
         BAHwiypbbxr74LzBc+yxy24/63Te4fIWZRrJFy1nJctXpi3X1/V/FPP+aLJIM2QS/2Vh
         FLnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/KEIyebmvsNVge5XeeybSTDoDb8TFaWTgdnpyvFvkaw=;
        b=FKR4PB1V7iv7Cs7M7K7Wv5EGlfpJLg3IuuvgCjk9x+8fBrmEkS253WhddWEi9P5sCs
         1/Sbn7e73+8hxukyEB5UswTzJ4gB6jnm315QyDNffL07K0RssnM/2XEjMYvruH4vSFR2
         aLM48WFEGqGFbHY/W3747uCjaT0YmGbPyeTJh9HluQTOdjq3joERRm7BVYcTTULY0r7r
         ofgK25alB4mmfbtxdj8VH5TZ68qD2PAVnHPdGJK1ZOxGPdAny0pe6tXTotSZEiniXQAM
         bDAdP1jsXfMoah/kgWplEA2Fn2HN6W/BvUELkZBRSO70D0F6WKuLFgvHuvjfyx5KNFaq
         0fgw==
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
Subject: [PATCH 4.14 069/167] selftests/x86/pkeys: Remove unused functions
Date: Wed, 21 Feb 2018 13:48:00 +0100
Message-Id: <20180221124528.280741604@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015321225692352?=
X-GMAIL-MSGID: =?utf-8?q?1593015613643027425?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
