Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226v1bsUGR1jn2TKEQeW9fyD7LJit58mG1rMcdnaZ2rmPVPMBegCGY4tuGyFqZ5pMTVwVtwp
ARC-Seal: i=1; a=rsa-sha256; t=1519218114; cv=none;
        d=google.com; s=arc-20160816;
        b=nwKh4NbmdAId9L8Ke1K+NR7GBjroluhCGBp0ZxOF6CGv4Ed3c0ZU0ZNSXf7ZLKutaY
         p13Oi88c9uPbK1JATNYFq9zytsymleT5LPNVTCrEfBa9BpBc49fnJcd6n8ifvxnBxykn
         KVdWbEx6wtMbERdejAh6ILw4t6kmFebTs4dk7iB0x8dcSxRHR61C4X4XVRs8dfRaCsHl
         Aa4ePgoRbfkHWPoHRKN4vNqBLqZC4TVJLS/90IrMiqpoijXAu7+6asU95BfNbach2WeD
         rpI7qdIVMjrUUWLqMDNONTfDrb60iOX+IsXYxkXjsc/yqeTjCkavrOJKkJ4fIVAKWh1l
         Kqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KJkOLQhcZWZRwGQkaaw5yCt/Lqmo2fNgI/7/9XHpgPY=;
        b=rRhCQ8YkZjtZO2/NiKs9Z7lTzaFXv5+SLvHLckBlp9KZu78Uv9h1TrkBDU4vJa7c17
         tmeOXg4iNj3Y3CstWjQDh51+P9UZ45Oq3op6IVaWxGxbNItc7kitEERb8X5TzFYTgBdu
         7iB14d6dCA5vburosxxt1MVz1CgxDxxpPtsDDY6LhCa4bDD36vB4Isy2+tVLMobu/t9G
         YLQU9lEA/JWeD7ttRb4BnMq+2n3XniE6+iLJGdGX+dd22cU0po+vySOBS5RcWG/PS5Ya
         qpOFpRP9HRw0ZxYCxYzeFkQq+ivD3IMGtsjIKK8v3LI5BowQqpMcly0+Ok7ehtZJgOvL
         0Eog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Andy Lutomirski <luto@kernel.org>,
	Dmitry Safonov <dsafonov@virtuozzo.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 070/167] selftests/x86: Do not rely on "int $0x80" in test_mremap_vdso.c
Date: Wed, 21 Feb 2018 13:48:01 +0100
Message-Id: <20180221124528.344125537@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015323232886251?=
X-GMAIL-MSGID: =?utf-8?q?1593015653274500709?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dominik Brodowski <linux@dominikbrodowski.net>

commit 2cbc0d66de0480449c75636f55697c7ff3af61fc upstream.

On 64-bit builds, we should not rely on "int $0x80" working (it only does if
CONFIG_IA32_EMULATION=y is enabled).

Without this patch, the move test may succeed, but the "int $0x80" causes
a segfault, resulting in a false negative output of this self-test.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org
Link: http://lkml.kernel.org/r/20180211111013.16888-4-linux@dominikbrodowski.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/test_mremap_vdso.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/tools/testing/selftests/x86/test_mremap_vdso.c
+++ b/tools/testing/selftests/x86/test_mremap_vdso.c
@@ -90,8 +90,12 @@ int main(int argc, char **argv, char **e
 			vdso_size += PAGE_SIZE;
 		}
 
+#ifdef __i386__
 		/* Glibc is likely to explode now - exit with raw syscall */
 		asm volatile ("int $0x80" : : "a" (__NR_exit), "b" (!!ret));
+#else /* __x86_64__ */
+		syscall(SYS_exit, ret);
+#endif
 	} else {
 		int status;
 
