Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225dAjNREqHMHw8YEKr3KK49TH2Uz4D2TGDCiJbkJegbpKCIEeMRfblr7HhVsRcc/GAFeKWr
ARC-Seal: i=1; a=rsa-sha256; t=1519218514; cv=none;
        d=google.com; s=arc-20160816;
        b=deoEi9xZJvx5DX/vZOHx9MIVCYJl2SYTkyGtFcThNr0z4tvkVQtniBYtZlKMRFiHiZ
         ZH3FHZVgR0RoBhDIXO1q7WFbLnRoE73OSuLBu0CWHAfJtEHPq2ku0GYXc8h47GCQB/YH
         IKNP4DtE3A/9CbFOOtTYd//jlpbBQdPhEnw4iDQm99ydo8smg+ArZKpjZiC4ud2XxvRD
         iPAtVx50bEFtEj0Pia4AclkEFDUK4l+lTkfnHYCDVCY6CBewbbgji6tayD3hEYdehkEs
         ohNmbR4kpBP26Pdb8HhpKQS0PqRJKVbSGgn+R3xRyoPhwqHmMBULfy+su44mw9oGXDx2
         5eYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=STaZaYL+LPoFucFlUgeTPiRCwxc0568MAudWDPLJA5c=;
        b=mZYNq6wa3qgoDRkb9dQc8to51ljosFy5wSfMOPWbzjcudppUL3dyY5Vz2TFzMF/M0a
         12hNNqDq9HJ+ZjVsVRvmaMygvIRGMU/JdtygcM0hCD2iVOZqaMhSr3Pb4DTA80SW82u+
         VViOXXUgPmhJGdhz3IXFavwt1+rBhEj+YpoFUod2pzOw3X6s0HDTPUgBrtNLY65HoUue
         0+v6h8IwR9TB1LoDX/uN6+JxVfFdmGjeSE1R19EdvnoJvRu/HIDH08AE6eFlgmQEQeyj
         NkxtRZFFXgEBj1dQK1Mwv0US3aq7DDDxYqp7Dn4vijT7rMYkyZME0AXevIqZho9CVOFQ
         7y2g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Borislav Petkov <bp@suse.de>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux@dominikbrodowski.net,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 067/163] x86/entry/64: Remove the unused icebp macro
Date: Wed, 21 Feb 2018 13:48:16 +0100
Message-Id: <20180221124534.153709453@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015603424118021?=
X-GMAIL-MSGID: =?utf-8?q?1593016073328901119?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Borislav Petkov <bp@suse.de>

commit b498c261107461d5c42140dfddd05df83d8ca078 upstream.

That macro was touched around 2.5.8 times, judging by the full history
linux repo, but it was unused even then. Get rid of it already.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux@dominikbrodowski.net
Link: http://lkml.kernel.org/r/20180212201318.GD14640@pd.tnic
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/calling.h |    4 ----
 1 file changed, 4 deletions(-)

--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -159,10 +159,6 @@ For 32-bit we have the following convent
 	.if \pop_rdi
 	popq %rdi
 	.endif
-	.endm
-
-	.macro icebp
-	.byte 0xf1
 .endm
 
 /*
