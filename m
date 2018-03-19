Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvdEMGixnTvTQn5DyTKk3kuw4eA44rOcbvKw5L8v2OqiGqgdplCCKeOA5kxlfHLQ2wN9e2v
ARC-Seal: i=1; a=rsa-sha256; t=1521483447; cv=none;
        d=google.com; s=arc-20160816;
        b=C4K1oSO2/vi0fj2heHJTtiANI31zHAVqFC56oiLnAqP56oVN4P4niBufyQaOJJ20oI
         Oe2FEVO/TVIwXFhbrMtQEq7XJqhupehqJvKKufpwzBjw3t28EHLqaLDjx3lXBQeQ4/g3
         sIKlSS0xMtFDVp9ocWgAHKp2YWVUul+RP7K14meOEs79NjYy72ixUyVr6n2TzDriXTTD
         jbk44qytBsJJ6VuafLvEQHzoLJ7yDlRGoOZahs53bcHMqSK7LJ5KPwAGKJi7xAehdRJ1
         /t6eTZZpK57Aomwjil0dqBTfSs9NvcKqQ0P1lcFsG2iHOcgoAbvAwhd3mBx/2nsVjMcJ
         6xIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=RqH42LyGjO/+kmMY38nDdNRb9bWKIFlT8oFmftX+ZMU=;
        b=h9G+v+Ih1spdbshQpIqqMQHH9cH5vuHRMbywuYWRW/9uudQDvN+yOG4aWzdATis2ce
         B7CwONIKijRlvp8rcB/OGEGgii0/i1dvTWCDSbrb48x9ykfR38mN9d7fvZx2liuWR115
         eQ8QFQJf1T/AurfAnLtfnr2BRmaQ7ZgkheuwVfF6n/0YQSWStPrtVmU7z126vteq4FYu
         cVV+vakKw/3ELUOfZWc47iprhVRR1Ip/3G0GSiPKYpiAU88BwD/Ez9eOsF3VecWopngh
         Rbo0CNU2Ptnm9b8Kt1YWWgXVHMESVZY/IOlTyX6xYoaRDN2d9dkTA2CF284p+qHxsnUa
         eIEA==
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
Subject: [PATCH 4.4 110/134] selftests/x86/entry_from_vm86: Exit with 1 if we fail
Date: Mon, 19 Mar 2018 19:06:33 +0100
Message-Id: <20180319171905.147688634@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391027196234846?=
X-GMAIL-MSGID: =?utf-8?q?1595391027196234846?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
