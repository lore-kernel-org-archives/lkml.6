Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AIpwx49qvhnVrhItzGGBrdiip9PZA/vdGJvTfMMJ59spz+2GEa5vDxvMqOiaN/7BfHa5dpb9xr8y
ARC-Seal: i=1; a=rsa-sha256; t=1523294125; cv=none;
        d=google.com; s=arc-20160816;
        b=vp9VaKeLMjjHLVimUKUZsr2pj/6WxBvNFwSxnXJCb/2JTe17RsVEmUSKZsWbN9KgWe
         Pn85PB/IANZyvEdrfscKTqgnNH/zQTgpjgITOgKoabhyk60smi7Z85m/bZj/VWf2PAKl
         AKsHJKd+38uqBStZDoZDIznxL+MsbKYY47vjcQlnSnSj5RZ5K97NYQzFseQXUWp+K46i
         6StoOYPpL3mKsgO/eG+WRt7xYG0LxNKM0/EQdaoE99geZIIn3qk08wW/tvO8ucvW6PIJ
         EjL3kMTRZqUD86XA49zPegbXAicrB6eorlx2vVX9vZkeHtLP1tQCHLnmkiy8oJZpS2cv
         bopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=+u84+BPGm5nChFbdXZvLFLvWBQbCA5A9pkrVEz/U670=;
        b=TlIpw6+rlrjx0zMz/Sj44LWbZaLFCfZ/xFOYxtY4Hm1D8XAcp9RQYU5XNhKzK+KyeI
         aI1EkJXruTj/USzxQBPasa8ss1AyZzgmzhXV5oqdHBJ2Kjea8M1TpI7TMA+Kh0Ir7r6J
         WlWDy+FLaJEZs+dFt8nkT2y58WWfE0l0T1E0thLjINoK2IqGw6XMyYEPtHAhnzGF6U94
         R3wcJrzibXCAIsuDrcwm+fqCzv1YYvpvaLXjd2Vi8qfxUugo6ZdLcoogTCeDLJ0bSkJw
         OzmTezSol9Zt/HOenL55N8GhhGegugFoqz8s4vxLwd4OpWVUIoJER6p4OYPOkn+pqjom
         ljJA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Mon, 9 Apr 2018 10:14:41 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-4ddee6efdcd0259fdd5014312bd536325e6d3429@git.kernel.org>
Cc: bp@alien8.de, peterz@infradead.org, arjan@linux.intel.com,
        gregkh@linuxfoundation.org, hughd@google.com, tglx@linutronix.de,
        aarcange@redhat.com, hpa@zytor.com, mingo@kernel.org,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org, namit@vmware.com,
        dave.hansen@linux.intel.com, torvalds@linux-foundation.org,
        luto@kernel.org, dan.j.williams@intel.com, keescook@google.com,
        jgross@suse.com, dwmw2@infradead.org
Reply-To: jgross@suse.com, dwmw2@infradead.org, keescook@google.com,
        luto@kernel.org, dan.j.williams@intel.com,
        torvalds@linux-foundation.org, namit@vmware.com,
        dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, hughd@google.com, aarcange@redhat.com,
        gregkh@linuxfoundation.org, peterz@infradead.org,
        arjan@linux.intel.com, bp@alien8.de
In-Reply-To: <20180406205513.079BB265@viggo.jf.intel.com>
References: <20180406205513.079BB265@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm: Comment _PAGE_GLOBAL mystery
Git-Commit-ID: 4ddee6efdcd0259fdd5014312bd536325e6d3429
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597289661093401125?=
X-GMAIL-MSGID: =?utf-8?q?1597289661093401125?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  4ddee6efdcd0259fdd5014312bd536325e6d3429
Gitweb:     https://git.kernel.org/tip/4ddee6efdcd0259fdd5014312bd536325e6d3429
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:55:13 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 9 Apr 2018 18:27:33 +0200

x86/mm: Comment _PAGE_GLOBAL mystery

I was mystified as to where the _PAGE_GLOBAL in the kernel page tables
for kernel text came from.  I audited all the places I could find, but
I missed one: head_64.S.

The page tables that we create in here live for a long time, and they
also have _PAGE_GLOBAL set, despite whether the processor supports it
or not.  It's harmless, and we got *lucky* that the pageattr code
accidentally clears it when we wipe it out of __supported_pte_mask and
then later try to mark kernel text read-only.

Comment some of these properties to make it easier to find and
understand in the future.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180406205513.079BB265@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/head_64.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 48385c1074a5..8344dd2f310a 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -399,8 +399,13 @@ NEXT_PAGE(level3_ident_pgt)
 	.quad	level2_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
 	.fill	511, 8, 0
 NEXT_PAGE(level2_ident_pgt)
-	/* Since I easily can, map the first 1G.
+	/*
+	 * Since I easily can, map the first 1G.
 	 * Don't set NX because code runs from these pages.
+	 *
+	 * Note: This sets _PAGE_GLOBAL despite whether
+	 * the CPU supports it or it is enabled.  But,
+	 * the CPU should ignore the bit.
 	 */
 	PMDS(0, __PAGE_KERNEL_IDENT_LARGE_EXEC, PTRS_PER_PMD)
 #else
@@ -431,6 +436,10 @@ NEXT_PAGE(level2_kernel_pgt)
 	 * (NOTE: at +512MB starts the module area, see MODULES_VADDR.
 	 *  If you want to increase this then increase MODULES_VADDR
 	 *  too.)
+	 *
+	 *  This table is eventually used by the kernel during normal
+	 *  runtime.  Care must be taken to clear out undesired bits
+	 *  later, like _PAGE_RW or _PAGE_GLOBAL in some cases.
 	 */
 	PMDS(0, __PAGE_KERNEL_LARGE_EXEC,
 		KERNEL_IMAGE_SIZE/PMD_SIZE)
