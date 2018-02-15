Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x226daS0CWOtW0koI19r8QJ9cbBmRCVyyIH2KkZKs0raBZe7g2Ft6UkqSFS5kZHF98j/KvECd
ARC-Seal: i=1; a=rsa-sha256; t=1518654979; cv=none;
        d=google.com; s=arc-20160816;
        b=hOCm81yoxVmMZLQf/5c7FQN8rdDyHEXuXkmpo9SzO0S51aDj89wjWkilvBs/mXIxeg
         LmhSQQBeGjAGUIaRstKFeMtDrBTh63WgY0n5lUrD9UT8aUJcF51vnD9ZExh8r83qjhF8
         /NOmUi9OyIej92/zOTdfEelCZ3KMTwcOi6OiJ+1QGorfxoI4qq2qu5w2dFn1SuhOyfaC
         sAAwH0TBtSCvXjKgCNyLwK0pEpm0XDQU5MdK5u8iaWlWTXJ9IU5lYwWu9X6h7FRiuO8w
         nTFwJe57MDRC1obHwqBOshQp8I4cuPt8APlG/WFjT3b3Fw29gm77PvlOmGhYVcx+f/yK
         aUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=c2Kmp/iSMhlUlqxyk8nB7IMdTC46bWKsYzvFLCC4HlU=;
        b=ei97CHVLaFXP5VJbpiPXZz4zKpJYoPb8VsluquyA+lJckx8sVDP4OzvlE6a9dQOT1n
         pAnt5hgULaNPa8LlRV6lV74DlRo/mOOIzuI2/8wbrgy2wTFaXtC1g8ilzgSxCMsjfKUY
         sW9JGDP2C9KLhbnToRmc+CCvckmbzTWXbJ2IG2SkXcL9LSMzSCDBgxeagZWOZFycP1Mv
         emJvJEC6u3GGulPsopFc6a7kkoMtHiK/K1huKIag0t3pcHEcJdEetjQAPlGIOq7jc2JA
         JyzpEzTzI84WX6skVjmOhUm1Lx1/8xMKBN4SELAcc3gyItqVx3Uj2hBYuQqqbL6+sXr3
         IE4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Wed, 14 Feb 2018 16:30:19 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dan Carpenter <tipbot@zytor.com>
Message-ID: <tip-9de29eac8d2189424d81c0d840cd0469aa3d41c8@git.kernel.org>
Cc: hpa@zytor.com, gregkh@linuxfoundation.org, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, bp@suse.de, karahmed@amazon.de,
        dwmw@amazon.co.uk, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        luto@kernel.org
Reply-To: linux-kernel@vger.kernel.org, dan.carpenter@oracle.com,
        torvalds@linux-foundation.org, luto@kernel.org, hpa@zytor.com,
        mingo@kernel.org, gregkh@linuxfoundation.org, peterz@infradead.org,
        bp@suse.de, karahmed@amazon.de, tglx@linutronix.de, dwmw@amazon.co.uk
In-Reply-To: <20180214071416.GA26677@mwanda>
References: <20180214071416.GA26677@mwanda>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/spectre: Fix an error message
Git-Commit-ID: 9de29eac8d2189424d81c0d840cd0469aa3d41c8
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
X-GMAIL-MSGID: =?utf-8?q?1592425163381307031?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  9de29eac8d2189424d81c0d840cd0469aa3d41c8
Gitweb:     https://git.kernel.org/tip/9de29eac8d2189424d81c0d840cd0469aa3d41c8
Author:     Dan Carpenter <dan.carpenter@oracle.com>
AuthorDate: Wed, 14 Feb 2018 10:14:17 +0300
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 15 Feb 2018 01:15:53 +0100

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
