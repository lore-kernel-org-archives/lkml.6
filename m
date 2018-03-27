Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48g92jJwwhEDQFbUkqsN5e4BDvPqNzh2jBeg1wJuvd1bPkZWiEnQlCN20sxenzAu+WL6Bwf
ARC-Seal: i=1; a=rsa-sha256; t=1522168219; cv=none;
        d=google.com; s=arc-20160816;
        b=jWIiv9pfnct7rzlO2MNWubjLfDW6kFEY7rQCsfRL+/yYxurF6/Ct4wQgVqgeTCj0oB
         j+BmQZ4flhi9u9S+4f+lzQihapbXex1ID9gjB2IYu2kT3lFOXc1ZK+8G3mU8UCgzYjXO
         a6xW9mX9A3ol+X5433+jUNkRQEENznZh4OpvVSslSGqCmWJytlJO6/nu1MX/ll+pL4fz
         CYopWPxDSFbKprV7yI6jaYYDsflSfkODxdp0DNyBg88BR6nZGyUHrxPiB8llkMy+K6Pc
         PEad8MihNK4D7Eydb/pjuOGEl2W6Luv2yDeu+RjWKkB4dKUhP7hil6rkvIV0wMYxXeNG
         7hQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Iz9O12fqpPgwA8bwKL2MjZ/fNGBq+G/paIE043/BoLY=;
        b=qZn0Yq90zNgdJYAkmwRbasD0qklc7xuH/XRCe4YAq2pi76gXJqbPFQCqnFCiHJBPpg
         kq/Ts8xJiUXS9Ilyw1meI1OIUIcCJGfdHJj+V/7y+Bfyxbgj+ZO+GB+bi1z2m8P2bHfi
         IiiXsY9lIm1kZ3g7ZMsmXeCjJybSOr171PPpqcRk1CxA9iqhRjOYjadDApBUSh0CgbBo
         tOP4R2jbkX5uwfk6+z4NNRo+kmJC6RY/emCCr3l7DrV9nTFMzIhHODKD/3JOnREH8blQ
         O268+ydzPB87ThsZNsgYvGXddgPHTSk24/SZDUig+QJlhrTStae0M+Yot7dCYd/dOwI/
         HDaA==
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
Subject: [PATCH 4.4 37/43] x86/boot/64: Verify alignment of the LOAD segment
Date: Tue, 27 Mar 2018 18:27:41 +0200
Message-Id: <20180327162718.493958167@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109062756307676?=
X-GMAIL-MSGID: =?utf-8?q?1596109062756307676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -366,6 +366,10 @@ static void parse_elf(void *output)
 
 		switch (phdr->p_type) {
 		case PT_LOAD:
+#ifdef CONFIG_X86_64
+			if ((phdr->p_align % 0x200000) != 0)
+				error("Alignment of LOAD segment isn't multiple of 2MB");
+#endif
 #ifdef CONFIG_RELOCATABLE
 			dest = output;
 			dest += (phdr->p_paddr - LOAD_PHYSICAL_ADDR);
