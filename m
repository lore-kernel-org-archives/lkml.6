Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224BMCx5jeZiAaMpz01f6oFDEqivHCyp7zHF2fq0dRhf51Xf9nRdSGlk03bR8WPGQvYlzcGV
ARC-Seal: i=1; a=rsa-sha256; t=1517855105; cv=none;
        d=google.com; s=arc-20160816;
        b=ezBlGp6FJSC4at2i+pdDmqd130wGv2UutAQHdC66clfNQI6QgIVSeHlsMiORBY5K8j
         lG6KW5krvP4rjds2TjlDyruvReH0L/oP7Dy8ZDGhShRhldQpeud2mz7dWDUUezUzeVUU
         1+clJ+JjVpOaovZL5Ofn//BIcsxa/mVtNZNEJ7xEnHztrJC1b6/QrmNtue7ZwcLhw16c
         kBJzxGirNmb9qyVZt4sQoWYxpiz6L+GG7HI9kCCzZTiEUw/TazYG3aVggGQzcOCYTFhb
         VEG2DAvMEe+i2J0tWnAPGMpIioBX8M7mQotpODeuYcalLGYYELlg1tYIokHMXzf1+5ME
         FjtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=uvBZAPmMgWNXDug/y30tVuAg3HeBQPXhP/NDlJLOK7U=;
        b=KvH3+YMjbzOOAEv3rd7ei0dz6eQzMgN8cJPsoYVWHV14FH2VwuJghnA8Ya7T45qUh6
         JZuHNjXjXzCmjEc+xEWZIFE0bb05jcpwssLLZo1rNJmhHYo9VduyHNWL21NpxOF3LCyr
         L5g4E8e2QvIwW4nUXyw9UgAiok4FwIOQ7SzAtKcdPVjpk35p81ulSZRTQ9Sy90+jEuf1
         dhD7JtwSyyfi95y3c91LTVKrIYudTeVWmINLfCyHprzZv6dfIPedR66m7XGafapMzmix
         knC5v/jyAzJi2m2JCQQQuPoRKleukOGVObJsOoyk2LYwf2xBUo0M4wfqb5u/EG2N67F8
         FwwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 104.132.1.108 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	gnomes@lxorguk.ukuu.org.uk,
	ak@linux.intel.com,
	ashok.raj@intel.com,
	dave.hansen@intel.com,
	karahmed@amazon.de,
	arjan@linux.intel.com,
	torvalds@linux-foundation.org,
	peterz@infradead.org,
	bp@alien8.de,
	pbonzini@redhat.com,
	tim.c.chen@linux.intel.com,
	gregkh@linux-foundation.org
Subject: [PATCH 4.15 06/60] x86/cpufeatures: Add AMD feature bits for Speculation Control
Date: Mon,  5 Feb 2018 10:22:39 -0800
Message-Id: <20180205182214.184700336@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586376831893912?=
X-GMAIL-MSGID: =?utf-8?q?1591586434983325316?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse dwmw@amazon.co.uk

commit 5d10cbc91d9eb5537998b65608441b592eec65e7

AMD exposes the PRED_CMD/SPEC_CTRL MSRs slightly differently to Intel.
See http://lkml.kernel.org/r/2b3e25cc-286d-8bd0-aeaf-9ac4aae39de8@amd.com

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: ak@linux.intel.com
Cc: ashok.raj@intel.com
Cc: dave.hansen@intel.com
Cc: karahmed@amazon.de
Cc: arjan@linux.intel.com
Cc: torvalds@linux-foundation.org
Cc: peterz@infradead.org
Cc: bp@alien8.de
Cc: pbonzini@redhat.com
Cc: tim.c.chen@linux.intel.com
Cc: gregkh@linux-foundation.org
Link: https://lkml.kernel.org/r/1516896855-7642-4-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/include/asm/cpufeatures.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -269,6 +269,9 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* Always save/restore FP error pointers */
+#define X86_FEATURE_AMD_PRED_CMD	(13*32+12) /* Prediction Command MSR (AMD) */
+#define X86_FEATURE_AMD_SPEC_CTRL	(13*32+14) /* Speculation Control MSR only (AMD) */
+#define X86_FEATURE_AMD_STIBP		(13*32+15) /* Single Thread Indirect Branch Predictors (AMD) */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
