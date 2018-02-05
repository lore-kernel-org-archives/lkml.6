Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227vnSpQFNNtITTFwLPtzgrDj7fNiW4NGnkDkIa2Q+oBW03IF6giEmwrv4g77rTWClm7Q1Xb
ARC-Seal: i=1; a=rsa-sha256; t=1517855108; cv=none;
        d=google.com; s=arc-20160816;
        b=eIkvdNduQbbrZbdJkUvbQiuIRjBCOLNkUv+cMcRmfhyd2EOqeN1F1wAbHi5bxSfCfg
         oC+zKasI3/1mGxU+0ka4M53qGR+ekhGdIh2SNYJ/8sTyyABoYgjo8/ZGK9p3uk9AF2ys
         n86tGFcZ6eTjSgLQdr4yOZZWzPu282M4hZ0854mpGx2/RBTJm40KK89wlpaxn4U6xDCc
         56kAGQbiPEGKQZjUyC9bDmfLefwFrWrWB7t4vS2Dsq4H2+4WLy78CEHa4QUyLk02WBaA
         pS8RNnZM2UllCiIWnUsW6RR58Qg6aX9rlnEuLA7+hcn9MuoLUtD9Cg/KKLaB9mx8nI+J
         KhOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=krdFpbP9VzsNko3Www8Vb1k19E/s/78RiYQYrTkYBEc=;
        b=MJCmXXTotx8JjGsyYtSqLUHqVhISR8JYRNkIP/k+/4a57yDkIlhVQiht44ubokDquM
         3UNfl2f6NACk/8UAHSNpdoU0ekIN0N0nupoxNtdMA/3bA+NWX0sD/8Mrh5KsBX0EjJDW
         4QJJiDoEyfZFPPTtR5lfcQ96uaTz7PzE+qHZao0ZDnwoKHVbq9+hUTszlO68eXtRvg+I
         iHn35rr8D47nUebN1uxD0QUJLgqbPfNKawwXo4eZwoAHfQ47vExb0aY32iypXJ2B7aiu
         c/zj6hhzSH3fsGlMhZupad7HbQpLE7xsNjTqdvD1YL6vmpK/Va8aKI38+yvrPxuuzIqg
         CdOw==
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
Subject: [PATCH 4.15 07/60] x86/msr: Add definitions for new speculation control MSRs
Date: Mon,  5 Feb 2018 10:22:40 -0800
Message-Id: <20180205182214.217289334@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182213.902626065@linuxfoundation.org>
References: <20180205182213.902626065@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586333810903053?=
X-GMAIL-MSGID: =?utf-8?q?1591586438688420832?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse dwmw@amazon.co.uk

commit 1e340c60d0dd3ae07b5bedc16a0469c14b9f3410

Add MSR and bit definitions for SPEC_CTRL, PRED_CMD and ARCH_CAPABILITIES.

See Intel's 336996-Speculative-Execution-Side-Channel-Mitigations.pdf

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Link: https://lkml.kernel.org/r/1516896855-7642-5-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/include/asm/msr-index.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -39,6 +39,13 @@
 
 /* Intel MSRs. Some also available on other CPUs */
 
+#define MSR_IA32_SPEC_CTRL		0x00000048 /* Speculation Control */
+#define SPEC_CTRL_IBRS			(1 << 0)   /* Indirect Branch Restricted Speculation */
+#define SPEC_CTRL_STIBP			(1 << 1)   /* Single Thread Indirect Branch Predictors */
+
+#define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
+#define PRED_CMD_IBPB			(1 << 0)   /* Indirect Branch Prediction Barrier */
+
 #define MSR_PPIN_CTL			0x0000004e
 #define MSR_PPIN			0x0000004f
 
@@ -57,6 +64,11 @@
 #define SNB_C3_AUTO_UNDEMOTE		(1UL << 28)
 
 #define MSR_MTRRcap			0x000000fe
+
+#define MSR_IA32_ARCH_CAPABILITIES	0x0000010a
+#define ARCH_CAP_RDCL_NO		(1 << 0)   /* Not susceptible to Meltdown */
+#define ARCH_CAP_IBRS_ALL		(1 << 1)   /* Enhanced IBRS support */
+
 #define MSR_IA32_BBL_CR_CTL		0x00000119
 #define MSR_IA32_BBL_CR_CTL3		0x0000011e
 
