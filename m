Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELuPK/ZhxDqNPvwKyxKYN1kKWzPr0nw2ULj4qgIMsZs4FFHocYIAlqZ/qrDjI3gXNHNkWCNu
ARC-Seal: i=1; a=rsa-sha256; t=1520824079; cv=none;
        d=google.com; s=arc-20160816;
        b=Mnd954f+ZmGsIFJkuB1lelk70Ungvz/GInnNfYsT7YZ3Np98HrclZ2Wajuc8FXBjkd
         FeAe53QItY56A4wWk+23K0wIiNqYhQKb0iOyaqP/FEMkeVnxWqIJ2HPSOxOlyOjpANFb
         13clsIsmSdZPuJI1ZmS7VZTfmD3/hN0rhuG4AK2l5MBeSgw7TZXVqi5EDRvCHF9Iv0lV
         5BDzxXxOIUvx0amPeizZ4IycziLQsz5ISEAeDJlvbH17ynbZGiEf61L1wCJpClxhrFnd
         MXsZJMq8jgYvXN7pFAmerGdSYqCwzXZI4LgE1K0/M3Z51HGTwb4wXEAj7jjGfesZoVMA
         o5dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=LQQhr6sgnLM8ltjMyHuhWRBs/9GwL9xPEgaMYfb9heA=;
        b=I33mOvrqvhhuOq11LJym6scx1I0hfkPxncJHRFlohn/lkOHZ4RDyQFsNgZICHfBAGP
         0P79yHCBteDEpVsfB8AXRZPWHlmud0xgXogrkfBHkNKhy8HOBtXerIuxJ5edGbY3qK5u
         dlNeMek/QbZ7DUc3EyAwAiXQhrnoR85ptcI7ApzojWJEaby8gGO/lr1DCUtzSQQ1Bnpw
         agsyYkwtzUxL39CXoNZ9Lgov4YPuf0Hj02nh11VZAGeu30AYbkQ2l285VoHKdqTi0Y84
         d+wf/h0uNeww5c3X2YY5UKPyTwKHQis8Wx+1ZPPLtr8Q8Qe81mT2p8Mv3/zrtJeILVUy
         j3xw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Rik van Riel" <riel@redhat.com>,
 "Andi Kleen" <ak@linux.intel.com>,
 "David Woodhouse" <dwmw@amazon.co.uk>,
 "Tim Chen" <tim.c.chen@linux.intel.com>,
 gnomes@lxorguk.ukuu.org.uk,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Paul Turner" <pjt@google.com>,
 "Kees Cook" <keescook@google.com>,
 "Andy Lutomirski" <luto@amacapital.net>,
 "Greg Kroah-Hartman" <gregkh@linux-foundation.org>,
 "Jiri Kosina" <jikos@kernel.org>,
 "Dave Hansen" <dave.hansen@intel.com>,
 "Thomas Gleixner" <tglx@linutronix.de>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.503311824@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 044/104] x86/cpufeatures: Add X86_BUG_SPECTRE_V[12]
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699630087745134?=
X-GMAIL-MSGID: =?utf-8?q?1594699630087745134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 99c6fa2511d8a683e61468be91b83f85452115fa upstream.

Add the bug bits for spectre v1/2 and force them unconditionally for all
cpus.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: Rik van Riel <riel@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kees Cook <keescook@google.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linux-foundation.org>
Cc: Paul Turner <pjt@google.com>
Link: https://lkml.kernel.org/r/1515239374-23361-2-git-send-email-dwmw@amazon.co.uk
[bwh: Backported to 3.2: assign the first available bug numbers]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/include/asm/cpufeature.h | 2 ++
 arch/x86/kernel/cpu/common.c      | 3 +++
 2 files changed, 5 insertions(+)

--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -215,6 +215,8 @@
 #define X86_BUG(x)		(NCAPINTS*32 + (x))
 
 #define X86_BUG_CPU_MELTDOWN	X86_BUG(0) /* CPU is affected by meltdown attack and needs kernel page table isolation */
+#define X86_BUG_SPECTRE_V1	X86_BUG(1) /* CPU is affected by Spectre variant 1 attack with conditional branches */
+#define X86_BUG_SPECTRE_V2	X86_BUG(2) /* CPU is affected by Spectre variant 2 attack with indirect branches */
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
 
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -770,6 +770,9 @@ static void __init early_identify_cpu(st
 
 	if (c->x86_vendor != X86_VENDOR_AMD)
 		setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
+
+	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
+	setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
 }
 
 void __init early_cpu_init(void)
