Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48cLSfUxmtEepmSDP9F2JEucU7p9j37LsssVdp9V9UQFWAthWkn8g2H3IMmNezLJGX/I80N
ARC-Seal: i=1; a=rsa-sha256; t=1522168360; cv=none;
        d=google.com; s=arc-20160816;
        b=O+YFWzJVEk1mYqOftwDlMp7VlU59Jd7+l7GKZAWDhCm4VyOnkOKkh9IuDqOi7Hp8li
         4kG7vt8+tHrZdB0+FV+wMY2BrVSDtrGtYIYyp5BHhREkR63NYBmLQGQw1qcm7nGAxGQM
         UjTeNYRs+0He5LM6xqHOj0cvNYDDyw3AJUjkFFMfBQd2998GYAAJ8TJxLTCEpqJnORzm
         nAB3WNra8ZxUkBL8pJNpWt4vP0jVMzcLr4f+PLqX0IFyeHJfOCafoGlfU908wQVifjif
         rdkDttYjrZE0FPiJqI8cHCa+AR45BDHUuLqgVjvahI7nZ96VUPnnTHpH9XlwbQniCvq9
         6xLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=L7xsApS5OzAsDqaLx5Uz0TpbINTu3nDEXDdSZ97d68I=;
        b=JLb6pIFBs6oILKjIiWDusN1I1XUI63t83btU3uS8anmA3uC4n5WFgSPzkJFXv3OV9D
         +FYloklifstosDEvt8+ffE8Er9TjdY4IvfSSoLV9qLVQbM6yvmtgZnGJ8JTqd7K9uS2u
         Q3vRtN9crU2ASLGGTzfRpsz1Qiehm2EZ8/2Ho5otY23f37KAXpK6VuM//No7FXVh5klG
         MrVIY5QUy7VUmlJDBfgsQ764qTQxD8e3UWH9FXpkTe7l4tUrsETwG0cL6ZD8OpaTheNE
         gu1HKqSD/ie6drgr2ydF71cRWibwwm1M31aeg9GhIOMKjWCUzT4Kvtkm2VCiWYEjRC85
         7wsw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"H.J. Lu" <hjl.tools@gmail.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juergen Gross <jgross@suse.com>,
	Kees Cook <keescook@chromium.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.9 52/67] x86/boot/64: Verify alignment of the LOAD segment
Date: Tue, 27 Mar 2018 18:27:44 +0200
Message-Id: <20180327162730.311816865@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109062756307676?=
X-GMAIL-MSGID: =?utf-8?q?1596109210828644628?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: H.J. Lu <hjl.tools@gmail.com>

commit c55b8550fa57ba4f5e507be406ff9fc2845713e8 upstream.

Since the x86-64 kernel must be aligned to 2MB, refuse to boot the
kernel if the alignment of the LOAD segment isn't a multiple of 2MB.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/CAMe9rOrR7xSJgUfiCoZLuqWUwymRxXPoGBW38%2BpN%3D9g%2ByKNhZw@mail.gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/boot/compressed/misc.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -299,6 +299,10 @@ static void parse_elf(void *output)
 
 		switch (phdr->p_type) {
 		case PT_LOAD:
+#ifdef CONFIG_X86_64
+			if ((phdr->p_align % 0x200000) != 0)
+				error("Alignment of LOAD segment isn't multiple of 2MB");
+#endif
 #ifdef CONFIG_RELOCATABLE
 			dest = output;
 			dest += (phdr->p_paddr - LOAD_PHYSICAL_ADDR);
