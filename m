Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x227d43svdfSxiLVSuo/YC57j7R7AJwl/mvcXPMJjVDUBbnKQzTYZvzp5AiGqQUSIIe+SPHmt
ARC-Seal: i=1; a=rsa-sha256; t=1518597740; cv=none;
        d=google.com; s=arc-20160816;
        b=RlYDZPA25ms+5sl2nDAhWz3Xu8bfcOG0aV92CMWZInT3bNajq69zQziEJ+mQuqx9AK
         HZd+cNwn+hDL2SnhWQiegsr0ZAexxowK4EoTukZ27sQdiC8LeQr3/DjatcOtMPPYz+/+
         7PtJkUTsjT5X/2fSsZaEKrBDgQzUH7/NMOSo4euxP2vif35X+rgnKDTDa+qqBKEdln++
         AfopY0nRf7YeALn+FjIvkOHB1yDT62QKRio3wgrS1BqHmAlyJnXGwO6kZ9rhSduE3Cf0
         tmmjORxsW3OrrFW7Y1TDp+2JgIbEA9lY/bPy25xFQ9gDDBmAAMv/Iq2ymuX7CeSMS0hV
         oRGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=hGHGBFXgxFd4qC4QUkYF53InZ+eYCfSce10I5/blR8g=;
        b=uPzER4+jcQhG403EN2yIUTpFT/QX1Xsvha2v7DrKeqAe5FqZJfv8ejk6K6vE4yziDh
         SYzjKZc86/Ge+J01H5ipuMJm0fw86Gq10f/9hcw+f+s7hwwQjOEskQfuKKkNhXjvBAtx
         ajG4hszth4hkyEq0oK3zZYHA1hO0hRY7h5K1DVqHllJQwhidZxxO13JAFRQ1m+d6GvLk
         XUwQpLc/to3gHuXHM9VgLXSAY8cXNQI2Juv0AdWzrmNElfqLlki0ZhKbR02NTqmsq236
         h5ajUmlVoPx76VsKwatVcnvZpK2jjECcyZ2IeDf2Hvl/C0VM3RDRxFsQDpAcs9SYWPu2
         3eHQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Wed, 14 Feb 2018 00:36:56 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dan Carpenter <tipbot@zytor.com>
Message-ID: <tip-b4764623932ff364df9a6bc8664ab7697c475339@git.kernel.org>
Cc: torvalds@linux-foundation.org, mingo@kernel.org, peterz@infradead.org,
        karahmed@amazon.de, bp@suse.de, hpa@zytor.com,
        gregkh@linuxfoundation.org, luto@kernel.org, dan.carpenter@oracle.com,
        tglx@linutronix.de, dwmw@amazon.co.uk, linux-kernel@vger.kernel.org
Reply-To: peterz@infradead.org, bp@suse.de, karahmed@amazon.de, hpa@zytor.com,
        mingo@kernel.org, torvalds@linux-foundation.org,
        dan.carpenter@oracle.com, gregkh@linuxfoundation.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, dwmw@amazon.co.uk, tglx@linutronix.de
In-Reply-To: <20180214071416.GA26677@mwanda>
References: <20180214071416.GA26677@mwanda>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/spectre: Fix an error message
Git-Commit-ID: b4764623932ff364df9a6bc8664ab7697c475339
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592365143873210262?=
X-GMAIL-MSGID: =?utf-8?q?1592365143873210262?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  b4764623932ff364df9a6bc8664ab7697c475339
Gitweb:     https://git.kernel.org/tip/b4764623932ff364df9a6bc8664ab7697c475339
Author:     Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate: Wed, 14 Feb 2018 10:14:17 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 14 Feb 2018 08:23:07 +0100

x86/spectre: Fix an error message

If i == ARRAY_SIZE(mitigation_options) then we accidentally print
garbage from one space beyond the end of the mitigation_options[] array.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: KarimAllah Ahmed <karahmed@amazon.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-janitors@vger.kernel.org
Fixes: 9005c6834c0f ("x86/spectre: Simplify spectre_v2 command line parsing")
Link: http://lkml.kernel.org/r/20180214071416.GA26677@mwanda
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4acf16a..d71c8b5 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -174,7 +174,7 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 		}
 
 		if (i >= ARRAY_SIZE(mitigation_options)) {
-			pr_err("unknown option (%s). Switching to AUTO select\n", mitigation_options[i].option);
+			pr_err("unknown option (%s). Switching to AUTO select\n", arg);
 			return SPECTRE_V2_CMD_AUTO;
 		}
 	}
