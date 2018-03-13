Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvCav2Wf47oyNXmLXkZyJ+EgG9j58lZ5IP/RS2Bc6Io67HadPUETdnTo5UWjRUg+CNQITjR
ARC-Seal: i=1; a=rsa-sha256; t=1520955656; cv=none;
        d=google.com; s=arc-20160816;
        b=owx0P1FuEWE3vkI2zCCD5Na3AWyDHga76QLjNKzmCyWGFzPbh5AYiXnSa43nrhHiGr
         zxLbb8X+57f7rk2BFGJHEWjpyqKUpHl9Tn8n1moWAZXkHZZEhSBHILy/mr0q1/ffhveP
         RqfSeosyLzP2QezPnDa3JWXRUp2/1MctZzJ9lcAezAH0L4KJ2Oe5KzuQvYEyB95dF8DF
         DML+BpT5AR16JSmZtHyxjaz7YmqGkxdScylCzLWik+2xQNrWQXj0ExBCQehWKs3F3p5D
         Q6gPHv2+4/AF3btLSCTQviBh99uYlk12V5+1lpEVpBZLLpOsSTrVQiInUvA0XpI6tQYE
         KujQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=zYKgMXooVifRP8Q1x4BaAZIBaQA2zU6oNYSVDolI6HU=;
        b=OSUbnlZjAdP7BMVKi/WELznqFP7dnsvKM2gNBTqMazbPoFE9BIREPnFmfHAV2HaqAb
         HVSaDUQIxmLYMFzli4P+tdE0qDVaT7/mLT/QfbV5T41yGJTWPADAnyn6Ut0Jgh4uhV7o
         ctEOdJhbOhwhb8lBjVHbMimb6YagMlbU0Sq9iX2ZMaym0fknhaN4oRYRNbQgnTGinmzH
         RBa6c2FRw04Vi5Wcp+LgY47rut8dxX1Mv4RAaqnkX6h0bUHghsle3zxpiH2v/0oRaJXl
         TyKhEygi9eWE2jniakGFRME1W+TU1V3zOi/1Y+htTsTJtw/tz0WJyRouzSuN9QpoojUS
         TZnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Beulich <jbeulich@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 121/140] x86/LDT: Avoid warning in 32-bit builds with older gcc
Date: Tue, 13 Mar 2018 16:25:24 +0100
Message-Id: <20180313152506.315282732@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837008892044685?=
X-GMAIL-MSGID: =?utf-8?q?1594837597713496349?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Beulich <JBeulich@suse.com>

commit f2f18b16c779978ece4a04f304a92ff9ac8fbce5 upstream.

BUG() doesn't always imply "no return", and hence should be followed by
a return statement even if that's obviously (to a human) unreachable.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/5A8AF2AA02000078001A91E9@prv-mh.provo.novell.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/mmu_context.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -74,6 +74,7 @@ static inline void *ldt_slot_va(int slot
 	return (void *)(LDT_BASE_ADDR + LDT_SLOT_STRIDE * slot);
 #else
 	BUG();
+	return (void *)fix_to_virt(FIX_HOLE);
 #endif
 }
 
