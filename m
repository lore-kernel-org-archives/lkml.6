Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuKYoLuwrxeIWpajqXZPxgMbOfbnBG1n8mpxO2yIUcbHi0WErVYPm5Q2UZqhONVJHWYinMH
ARC-Seal: i=1; a=rsa-sha256; t=1519411226; cv=none;
        d=google.com; s=arc-20160816;
        b=H96f+DQoMkWubBO4PHDz0LWPLbBJXvaDP5L2kvj7Z2WsrdUecJUHrAqQ82g2qubi4Q
         a0o6xwudM9ZJmvUDVA6oB5TltoP4KarK1GG1JFtJ0Iwl+u/JPrhKT4XiZ/zd9QGVAwoN
         ujJp306uGNAvsLERy90+AXGj1uLGHsCJNgskqxwIkJ0nTxKjj/LXKPqJM6yXUXoicBs9
         XXkg+9odLR6bKyM2JYpq/VFg9TMM0EVSr8xeCSUpD1X16/5AldK+TH3OzF4/8i/3Kz/V
         rKogALkoSy21Ih71UZOBskRFStHiQEuO2e9DVbWzP07TslveY+D2GZNBSUxxq0qNatpo
         KZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HK+7Hr6iMvGzsdN8oCW4IDX8O44+e7ZQYnEtUx+XWQM=;
        b=FNB1WtDru0ymV0JB6QLqDU+5+6Kay88DgPIK2U7igOqCrrxtohIE33K/lW6NO5xn4w
         OGgRPfH2iIEBrMLQM3gf+Dup42F3+6OneV1fUflsfeTvojWDy+lh79+8d13/6FBO49l0
         NU7k+p6M69Hxx8e9zTCE/GPRZ24O7ibd7eWAb3y6nARtnkmozjmJeB6PcxHHAK3LNhdM
         6FjZrU93Un3/tWKA4y0ANDYUn+gYhS/e+39SJfXEAfV0HRMBFwNsrqny6lX2uTfBj8ta
         mqRXsM0o2ob5kgTTbSLpz3FpcpcTzKWcTu6rnUHSCdOMwjVgAhTdysXMdjrrLP5ZgqBi
         VsHw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jeff Law <law@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Kees Cook <keescook@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Paul Turner <pjt@google.com>,
	Jack Wang <jinpu.wang@profitbricks.com>,
	Greg Kroah-Hartman <gregkh@linux-foundation.org>
Subject: [PATCH 4.4 165/193] x86/retpoline: Remove the esp/rsp thunk
Date: Fri, 23 Feb 2018 19:26:38 +0100
Message-Id: <20180223170351.803060842@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218145765294080?=
X-GMAIL-MSGID: =?utf-8?q?1593218145765294080?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Waiman Long <longman@redhat.com>

commit 1df37383a8aeabb9b418698f0bcdffea01f4b1b2 upstream.

It doesn't make sense to have an indirect call thunk with esp/rsp as
retpoline code won't work correctly with the stack pointer register.
Removing it will help compiler writers to catch error in case such
a thunk call is emitted incorrectly.

Fixes: 76b043848fd2 ("x86/retpoline: Add initial retpoline support")
Suggested-by: Jeff Law <law@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Kees Cook <keescook@google.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/1516658974-27852-1-git-send-email-longman@redhat.com
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
[jwang: cherry pick to 4.4]
Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/asm-prototypes.h |    1 -
 arch/x86/lib/retpoline.S              |    1 -
 2 files changed, 2 deletions(-)

--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -37,5 +37,4 @@ INDIRECT_THUNK(dx)
 INDIRECT_THUNK(si)
 INDIRECT_THUNK(di)
 INDIRECT_THUNK(bp)
-INDIRECT_THUNK(sp)
 #endif /* CONFIG_RETPOLINE */
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -36,7 +36,6 @@ GENERATE_THUNK(_ASM_DX)
 GENERATE_THUNK(_ASM_SI)
 GENERATE_THUNK(_ASM_DI)
 GENERATE_THUNK(_ASM_BP)
-GENERATE_THUNK(_ASM_SP)
 #ifdef CONFIG_64BIT
 GENERATE_THUNK(r8)
 GENERATE_THUNK(r9)
