Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtlPCoE8k53Z8zz5sPCImm0IcJLAHMf//O2bVfYToLT/OkWPwP5XKF42dEDxDeOlw3yTB7u
ARC-Seal: i=1; a=rsa-sha256; t=1521484053; cv=none;
        d=google.com; s=arc-20160816;
        b=xhgpkfyUzxAr9hSLLMAISeXuovcVBSWuGmQLp41ONgXZywgSpNf2fmQtRXUA4wL9hr
         nrSr9DzQ5XYzPBvv+KRJBG6mTy3RZahTqcRMxjNhPg4uydCyafiSF88LVyAphggzWnsK
         5CX6PPq/jzc7u+bynu09Z3ANee8RJbkDbTGQ1bWN+ESEqe7D9WoWnKo3+dV6qv6x1FwM
         fkzTiBkLxHoUoixClk7IPSY32FlcnNsDYO8wkXE3vJ5Lp6m0q5fu1qtQdzqeaCdIPHt+
         qBsSoEcfzB1DRJVQciwi6EnWVVVEg4SozVUHqcatLGuo+ks8muFnk1/sVaCScWOB4Dwp
         hB8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oWozJH3EZidN1vz80HTcu5JOPiCzQ5n2uSq9Dn2T9sg=;
        b=QCi6XQqeS4aaQMXZ1+cASP6cmNz/HvN7avL5v3Z5TO1j6cBR2/PelNCItPNEmZp6Fa
         exyAiE4ZvAgK5wy8Ht0rJPDIeZNXfyo7Cvb2X7ngYkM4XGP6cxDq9qjRsfjNnqHVLST9
         IM3rov9ZFUX43GMQnb7K+Oacu6UKTBU6ua0692T7vfsRZ51oDrjuuTkxrASuLMj81hY5
         LeurWhSAf5Z1KERzcbQtKMIyt3S3soCn/QAZHbYWC2+eSFe3sJ9yH9rNx1HkFcHt8ALH
         wpEACN4QKB4MW/i+9eUYwXjn4NtQ8JNDTW7CZnJlsGd4+0LsmPRtd7r4bKpmmSC850LU
         1A4g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Stas Sergeev <stsp@list.ru>,
	Thomas Gleixner <tglx@linutronix.de>,
	bartoldeman@gmail.com,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 213/241] selftests/x86/entry_from_vm86: Exit with 1 if we fail
Date: Mon, 19 Mar 2018 19:07:58 +0100
Message-Id: <20180319180759.990889173@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391027196234846?=
X-GMAIL-MSGID: =?utf-8?q?1595391662762286898?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit 327d53d005ca47b10eae940616ed11c569f75a9b upstream.

Fix a logic error that caused the test to exit with 0 even if test
cases failed.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stas Sergeev <stsp@list.ru>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: bartoldeman@gmail.com
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/b1cc37144038958a469c8f70a5f47a6a5638636a.1521003603.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/x86/entry_from_vm86.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/testing/selftests/x86/entry_from_vm86.c
+++ b/tools/testing/selftests/x86/entry_from_vm86.c
@@ -231,7 +231,7 @@ int main(void)
 	clearhandler(SIGSEGV);
 
 	/* Make sure nothing explodes if we fork. */
-	if (fork() > 0)
+	if (fork() == 0)
 		return 0;
 
 	return (nerrs == 0 ? 0 : 1);
