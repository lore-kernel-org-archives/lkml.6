Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x226NKFucP1tSlhURrdpN/vjcdmIW/nLLEhc6LMtiCHfv6ZEfwALkJynPYW7VSMZlhuVUp3GR
ARC-Seal: i=1; a=rsa-sha256; t=1518398799; cv=none;
        d=google.com; s=arc-20160816;
        b=EheEbxwNsqqL84P3OqiYJRgUaiOqFRfyPyRudFXfGjZkcjJvcDr6oHF3qMndUMvkwX
         XqDG1HkHqPbmORNZtsv4srDOW9xuNNCzUFVjqBsHOOThiHS7iB6vbKf9kZ4ocWwg5Mm3
         m8N5OJ+A47lT6/rwM5YSwtKrfFPyGd6EUsnqP8OpRppyY2GeVjQK0XE9xdM6AqOkedaa
         70hmwaesRWKALmcvgQng9llUwGqVHq5REhuvf0BoalJhUH6iuLY6ysu2qwpYlvaI6ixB
         QKzHT6YJ4kAdQPDKHd1GUAHB1jrPNBYObs1JozVkJY6VhqJIuLUYUp7kVkIhrPz5ghlf
         3FIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=99WYlB3jdJZo2CqioJ/SOgcB1gKlStBGwh9ZKA9zpjA=;
        b=qY+5uf3NT/Ve+70gsyJq/Lc0XiyMHXRxwzjjM5lQlMrjqb3dyzevZdIzCb261vcQ4S
         3jreB6ICHNuJQf4p0OhhizIraK6xiBErQ6WarMaQJyMZwIq6EldH7OR4b++PvQpKOrT3
         je5pOjfYfVN7+/NDKx4q77N1nTnjfqapTamhiQCLL1JvWW7SN/6L35zy80P3klp8sYNs
         VMfDoFkQNF/24VGi6YySkojXfBNLfAuqADtcl8HbJbx2skjaHEKp5Jvh3Wo7fIEIjlz2
         jm6rVjpTHMCJnVk0cc+ATO/F3Vus3m+M3YtKOiBI19pKJ9CYok33txTiujJ973NZ0nV/
         LpIQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Sun, 11 Feb 2018 04:07:53 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Nadav Amit <tipbot@zytor.com>
Message-ID: <tip-14b1fcc62043729d12e8ae00f8297ab2ffe9fa91@git.kernel.org>
Cc: hpa@zytor.com, mingo@kernel.org, gregkh@linuxfoundation.org,
        arjan@linux.intel.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        namit@vmware.com, dave.hansen@linux.intel.com, peterz@infradead.org,
        jpoimboe@redhat.com, dan.j.williams@intel.com, luto@kernel.org,
        bp@alien8.de, tglx@linutronix.de
Reply-To: mingo@kernel.org, hpa@zytor.com, gregkh@linuxfoundation.org,
        arjan@linux.intel.com, dave.hansen@linux.intel.com,
        torvalds@linux-foundation.org, namit@vmware.com, peterz@infradead.org,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        luto@kernel.org, bp@alien8.de, tglx@linutronix.de,
        dan.j.williams@intel.com
In-Reply-To: <20180209170638.15161-1-namit@vmware.com>
References: <20180209170638.15161-1-namit@vmware.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/mm/pti: Fix PTI comment in entry_SYSCALL_64()
Git-Commit-ID: 14b1fcc62043729d12e8ae00f8297ab2ffe9fa91
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592156540320863207?=
X-GMAIL-MSGID: =?utf-8?q?1592156540320863207?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  14b1fcc62043729d12e8ae00f8297ab2ffe9fa91
Gitweb:     https://git.kernel.org/tip/14b1fcc62043729d12e8ae00f8297ab2ffe9fa91
Author:     Nadav Amit <namit@vmware.com>
AuthorDate: Fri, 9 Feb 2018 09:06:38 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 10 Feb 2018 12:44:51 +0100

x86/mm/pti: Fix PTI comment in entry_SYSCALL_64()

The comment is confusing since the path is taken when
CONFIG_PAGE_TABLE_ISOLATION=y is disabled (while the comment says it is not
taken).

Signed-off-by: Nadav Amit <namit@vmware.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: nadav.amit@gmail.com
Link: http://lkml.kernel.org/r/20180209170638.15161-1-namit@vmware.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/entry/entry_64.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9e48002..932a445 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -213,7 +213,7 @@ ENTRY(entry_SYSCALL_64)
 
 	swapgs
 	/*
-	 * This path is not taken when PAGE_TABLE_ISOLATION is disabled so it
+	 * This path is only taken when PAGE_TABLE_ISOLATION is disabled so it
 	 * is not required to switch CR3.
 	 */
 	movq	%rsp, PER_CPU_VAR(rsp_scratch)
