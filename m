Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+sEVIE3cpRe+cx6TSE+Yvfl3LTxebkJ3g7swMu0/vaBlaM1TTAEhwD5eRxkjcumIlOSFaO
ARC-Seal: i=1; a=rsa-sha256; t=1522168951; cv=none;
        d=google.com; s=arc-20160816;
        b=YT+uzPaTLN0FvpXweI+++V1z4e2j8aPPtyfE16NdAiHd8wXmseOhu0rzJL0odzJyke
         jieP0h5N2uNGewTJO+xucX6dNxULmXs2u7vKGk0vta5rkuObfl53grXwJfvDBYB0lGbG
         LHDJ4i2JZNryQ3bkezRiYH1L6l+aj5W/+uGHSdWoqYQvh78yb+JifXpljK1Niypp1f9D
         eJPtQ+sZcjRlL2qbizqRBwzixl/cJHQYdO86ubTrzrd33kM66aA1UltUIs2XAsVGBxT1
         vquM6QqWwmg+0KWpPfGjqr4oYynPgg3vS/Zguv5R89PDH+KOdXiQnddV+bSUllxBa6QS
         I52Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gVw5vZFlDp2TIN0MzZPZiab27kz2UrLdpAN9ujEp5FQ=;
        b=bVGv20zmBT7HYnkv8xK4srGxvqirkTs0VmoUvX3ghKHfk4BXDg13hNyU/u8o2CLq+9
         AZSGDllgHl2hXpCgbMEf/xZeulE2rXdzgZgrGFC0pqgBj6XsNEf7AX+81FP86uTnTWaE
         F32l8kpk1be4oU6qA3zzBAgMkTscC+5kFt+1b0g3SCYAcqdN5J02xQRk2mbKzqZp28R+
         srBzFWRv/e0ZITDhHlnsE31me6/doBlG9NYe3H9Z6iWcr+yEadz5zrtC5ilc9gwIzvGg
         A1oJunG+cBWccuNmUlcE8lClfU9oJmHol76N4eSI9UDFsb31SFQJLKnmF60Ec6Drc8yu
         kQrw==
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
Subject: [PATCH 4.15 090/105] x86/boot/64: Verify alignment of the LOAD segment
Date: Tue, 27 Mar 2018 18:28:10 +0200
Message-Id: <20180327162803.673749750@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109062756307676?=
X-GMAIL-MSGID: =?utf-8?q?1596109830779754596?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
