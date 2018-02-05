Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226RJyZWtocyYYdcIN0SiRYDTe669dGIkODRp2XG/TxqzLAcezGfizM5wP6uRaCyO2mF1ymO
ARC-Seal: i=1; a=rsa-sha256; t=1517855102; cv=none;
        d=google.com; s=arc-20160816;
        b=Z/KDDcRF7t0VK8RZpXu+GZdGYk1pRQ2yHiTp1of8EfF0sLG1fOGgJ+STYxEYaYZwb0
         nAYlxVJHW3ebUbeM3ylaDtBxvRcHVtDiw9DW4zieGGty+LYZ+1X2xJSE1SOqa5OcQDw6
         aYmAnqLNI/7Iz/m5I+Ef18NHwajy/F+HhqUg7R5Mx+kuBN9JMESUi9bdmXhtMZtqTH9H
         Hybq1I+MGsKlqXpdql0mYuXN8LZyeb2EVX80ZxM9AAcrkSSDsgQsP6w40i141IFO6GNl
         wVYNXzEsVrDXEjY79FzGekwEuDRo7Y03XzE0Rj5Ey2YfpiWHMXDUhjrA3p+LmeeQVNEb
         jf6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=WlX3nvf+9wHwVvOm8UOijYwFMSbZCb9hLCuompoGUHU=;
        b=imJMvMYjSCLMplVhFe1SQkZTbrQD8F8FlupspodW+kJPnwoTlhW2Rv4KWt1cwxNN2T
         pW6sqED6bmwc9xo784IMOwHriGown0wMw5lOV7+NJ7PIpPeJ60q9V8WuAxn5HRMWkbER
         iUYeG44rIagQ30INDuZ2trrLu482Rntw52t0TRsansO6Y8XuDIr2LA0A9XZ99Rddf46w
         FUSyMofgLcIZndFdcpyyNDEuj7xyCb/shvL1ucf8IvH+Yrz54j5JqhiHT4edUDBr9YF4
         flDjWWSFqneLV9gS1LMbbK3doHnrFFqNcunuoETEQmNa0pLamF17JU+wFHnfrnL/DzxZ
         xRRQ==
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
	Borislav Petkov <bp@suse.de>,
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
Subject: [PATCH 4.15 05/60] x86/cpufeatures: Add Intel feature bits for Speculation Control
Date: Mon,  5 Feb 2018 10:22:38 -0800
Message-Id: <20180205182214.137394985@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586373896648108?=
X-GMAIL-MSGID: =?utf-8?q?1591586432187549946?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse dwmw@amazon.co.uk

commit fc67dd70adb711a45d2ef34e12d1a8be75edde61

Add three feature bits exposed by new microcode on Intel CPUs for
speculation control.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
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
Link: https://lkml.kernel.org/r/1516896855-7642-3-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/include/asm/cpufeatures.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -320,6 +320,9 @@
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
 #define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
 #define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_SPEC_CTRL		(18*32+26) /* Speculation Control (IBRS + IBPB) */
+#define X86_FEATURE_STIBP		(18*32+27) /* Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
 
 /*
  * BUG word(s)
