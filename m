Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuZjwXP1+hIKRZzARY42m+g9drFbeVtmNOPYXSeZgLOgxFDexYZsg4t213BPoxXS0r5hCar
ARC-Seal: i=1; a=rsa-sha256; t=1520955669; cv=none;
        d=google.com; s=arc-20160816;
        b=uMXRAfKR+RGTUO4Gev7mcsICNNNWmwG6mtGR1GW1tPBcum7mJeG+fPztwBieo9PmYN
         3EMd5zbvMAs9fqGEuwLpup5MwegB+VpY2AEC63xnCxisHPaT8cYCc9CMiUiDa44ZD51s
         HuCyHzP/0aZjGtDSk7rMYgsoj29s5kyWikD6dPyvmc+ewyIR7lznS8kEwR7EAe5zVT17
         w9YaAy2w5Ay2zEqo3ym+yJfqkw9FMr2Nj97sq/TDFRl7no8PfUDqPVEIKHJMDwS2dKf1
         UkajYTyV6R37VOeCcVAxyYBvDTok1a4es0kKAkifqlDqT8QvEQe8/xMkGFkrxEpn0CvZ
         SoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=iYOWtFyNnU/P9FF7XJm8z4D+ISBBIfBS4OWLQJF2HbY=;
        b=cPcY8LZLhD5nHSeyNMSIfJyO/kFB0UvA8VXYjbYnxTrbjEyWhEX3G1N9wH6P64HgXC
         iKwY/SsraycDgiCaTnMvr/3Le7a6gW/nSZojncWpN/+UO7Oc5N3pxCb1H2AOPppC3sUI
         zKthvVGProN6EuuHn2Fv7WmSph43uKCyS2vwQwm/Xxx5RIQXt+SB+Qdr6PLiUBLzoNma
         P0iDkhJ8x98G6N+kv3rZHKSNRNWeGCdzX5SJ/4pD0ksHZmhkMFZwJC401zK3DixqSOPS
         r1pDln30D2mtPy46A5hjZdX+4TFty/tPDiPowyeZSwhVI73qryoezF6kY580A+2gzi4t
         Yh9g==
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
Subject: [PATCH 4.14 122/140] x86-64/realmode: Add instruction suffix
Date: Tue, 13 Mar 2018 16:25:25 +0100
Message-Id: <20180313152506.375980644@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837015003164026?=
X-GMAIL-MSGID: =?utf-8?q?1594837611757053327?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Beulich <JBeulich@suse.com>

commit 8554004a0231dedf44d4d62147fb3d6a6db489aa upstream.

Omitting suffixes from instructions in AT&T mode is bad practice when
operand size cannot be determined by the assembler from register
operands, and is likely going to be warned about by upstream GAS in the
future (mine does already). Add the single missing suffix here.

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
Link: http://lkml.kernel.org/r/5A8AF5F602000078001A9230@prv-mh.provo.novell.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/realmode/rm/trampoline_64.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -102,7 +102,7 @@ ENTRY(startup_32)
 	 * don't we'll eventually crash trying to execute encrypted
 	 * instructions.
 	 */
-	bt	$TH_FLAGS_SME_ACTIVE_BIT, pa_tr_flags
+	btl	$TH_FLAGS_SME_ACTIVE_BIT, pa_tr_flags
 	jnc	.Ldone
 	movl	$MSR_K8_SYSCFG, %ecx
 	rdmsr
