Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsVmIfliHK/wuJU3DysJy+hS6hd6i6pe9uLQy5m2/NTS4W7+Hl/6NppVfdZMjrqOYpkYx1N
ARC-Seal: i=1; a=rsa-sha256; t=1520955639; cv=none;
        d=google.com; s=arc-20160816;
        b=Fl7CtwQB95mjnFUnNQ7B6D+uOuQNjErbUpwph/py8fHmAtv6W66mWLvdM4Yf1aAYT7
         Py91PF1QzUpy2NzRugIXQ0e3gnaUm4rHZdiHwPTCAzEkNlnIZDNKhWOC9uNilBmhJOg3
         2AU0JeKn/EsuULmSrQzAnLgbC+8mHfnihJs5GtwcZuWhLjc3TOeJnPjxw5+uQ8e3tiX6
         6+sEoJh01BGo3KKW/Q2w3LdBSLu6u892wunWclfbn+nLsAikVstUG0sebGgZWwo3xmwb
         WMVFy52qbcLQx4VZca5s7h74hslbYQFBBxb7MawtInMPqKRvtV73ha85zG0wPKm/wbrC
         4AnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LfxRgTeGgnAqYUdfkpy/Vzbee6Ahizxv79L9wsCV9WM=;
        b=Cvu+2LXJAuBAMTbSylSPNzBiWVrR7dWqnAzG+zGdJqhz+y6h2kRCH+7SN35qa7TonO
         xDjlxaWf/T4azF/YAYoyp/39KiIii2isVlJbvttRwXkFubiCLdnsifU4WLVhZUu8mzZQ
         FaCKzFfZZTguRuoVd3jPYCh9juGSQiz40h+HtYI/2uxrDJs5N9iaRiZXZMDxf2LzGlct
         xQ2DdStcTDjWhYNXBQE2vite2T+LLsira6M0ZRlyn8j1E1+XnnAytJIW1Ww5cEx0K6/a
         h88Z+qUEnN8T4/GKAEMYpd06hA3sY7zK4TkEfcyZvDFxF65Kk5D+6LGZ0E2YrlAXsN99
         ZyuA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jann Horn <jannh@google.com>,
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
Subject: [PATCH 4.14 119/140] x86/mm: Remove stale comment about KMEMCHECK
Date: Tue, 13 Mar 2018 16:25:22 +0100
Message-Id: <20180313152506.181171205@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836999611273830?=
X-GMAIL-MSGID: =?utf-8?q?1594837581142381805?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jann Horn <jannh@google.com>

commit 3b3a9268bba62b35a29bafe0931715b1725fdf26 upstream.

This comment referred to a conditional call to kmemcheck_hide() that was
here until commit 4950276672fc ("kmemcheck: remove annotations").

Now that kmemcheck has been removed, it doesn't make sense anymore.

Signed-off-by: Jann Horn <jannh@google.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180219175039.253089-1-jannh@google.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/mm/fault.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1252,10 +1252,6 @@ __do_page_fault(struct pt_regs *regs, un
 	tsk = current;
 	mm = tsk->mm;
 
-	/*
-	 * Detect and handle instructions that would cause a page fault for
-	 * both a tracked kernel page and a userspace page.
-	 */
 	prefetchw(&mm->mmap_sem);
 
 	if (unlikely(kmmio_fault(regs, address)))
