Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+kHARa59dbvLq3LEs9DNpRb7sOyztm6a3JTie1ACv9FL/jZJmH8zuaW5ibq6rcYfR7nT08
ARC-Seal: i=1; a=rsa-sha256; t=1522168655; cv=none;
        d=google.com; s=arc-20160816;
        b=KwQo42euqJ+9UZqZNu4c6Fp3ksVbjytSUZ9mjlw3TvEWPwZk/VzRzGUr+4FSg/fL/w
         U88gkR0/xpJ6QYF43RmALHXZL8LhFtUCiWIPSqiL/7OkcaAJ6y/P3t9DXoExflj1Yc1R
         Wcc+NdEAAACd8Y3bfzNfis8BJrMR2/KVywBSX3GeudmfqEeeiylF3CEQLckh3N7qzWRe
         nVbQmcgrln2rZtqpa2JKxEtjy7TzpjBN5IdROQlJsvQZWbtNRDJ1CArU7zu3bok3wAa9
         oBnklPDtPa08d1pWVxFkSXce4FbAoZ7dd6IdKYtomQqUT44UVtlgNyWk8N1vW7Te5gSs
         1L+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=igtS5FKFpv/ezGx3U2+RDgCBr2uRMnP7PCygsld1vHk=;
        b=fZxDdsVMh2DQdyhN+Tr582ugTejcoufhw27fBwpjpw1sEPrwf7SQRc/IfrkLjGhMY6
         9NKqd6lBUwNA2T7wTLDVbMLjRu/Gn0GQRXlQdyavGUGQqAAcTf1/mNIaLxYrqYKpnpuP
         Ddysas0EPN2EVeCK5FUKy6g3WBuXfciN6MhbEilkTwkKuynQ4Em9fa4tyhuqXR1tw4FB
         a16mGQ/mVUDteCJIKIqGSuvxSjYOh2R5hnixsROb8zz3OAQoZMZ2EmGFgbjBqcT1vml1
         /bgajT0JyLJBES/eWzvS4Rthcd94jHP+RWyZBqkyTUUEHmy1SRYmcyUNXgX7wzBcwmJO
         W8iQ==
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
Subject: [PATCH 4.14 085/101] x86/boot/64: Verify alignment of the LOAD segment
Date: Tue, 27 Mar 2018 18:27:57 +0200
Message-Id: <20180327162755.284286444@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109062756307676?=
X-GMAIL-MSGID: =?utf-8?q?1596109519916078103?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -309,6 +309,10 @@ static void parse_elf(void *output)
 
 		switch (phdr->p_type) {
 		case PT_LOAD:
+#ifdef CONFIG_X86_64
+			if ((phdr->p_align % 0x200000) != 0)
+				error("Alignment of LOAD segment isn't multiple of 2MB");
+#endif
 #ifdef CONFIG_RELOCATABLE
 			dest = output;
 			dest += (phdr->p_paddr - LOAD_PHYSICAL_ADDR);
