Return-Path: <luwei.kang@intel.com>
X-Google-Smtp-Source: AB8JxZr1mdzZubb6gXAkfA/euhut+xaxWQQkRVHG/azrIQVpS6wky5j8Ft4vExl2rTCTZtiJal+9
ARC-Seal: i=1; a=rsa-sha256; t=1526288571; cv=none;
        d=google.com; s=arc-20160816;
        b=kILivNnjUpwfoDFnYERN/9nUXdBolkew7DjxD4Ut/v2M22J5L0Qbg6U9WCRnUNwPmd
         goEz6MnYkS9lT88shcAvXnF8gbr9+u5eyZUf/WN8b+lgx1fWCbM9N03w6Ns7qRn5wfQc
         92ACnZ/7YdD+Mi8RKR1RW2VR+ZWlYoFWTC5+ENocoT2B9RhJSYaBRUHy/Thjdw/DFP/n
         uXPqq8qipxq4Hk3Fk5FwtIjRBUweC3gxdqoN+yItC+VJenDXrQebo7iq2+GYMpQBG+a/
         W2E5lXmm1pkvmE4c8wSrFD1OOgFh0qMWMYDoXiC/BFBs0xSwFWIlP5bW/aI8LYwG7S88
         2tgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=uQfAWHgixgKCjfbAlnVNE7o03aD3sjAugrQnFhqs1+o=;
        b=XUpesRyDSo9Hps9lFPq5YdZ4C3hs5mjes/xJ439Fjm06JspZjzhctLntraHY8awrb2
         dMfvkscWYTwR013vJhELJwDuD2dgNl+B8c2y3zdKge5vxcB3OjwqvPULXUXx0ILUtECN
         V5TGM8C/H93aNsZvqUrTFjSqYYoJ/EfkkL/kqiRyBjny6064fbJSTEhdGm04HUTJB3oG
         W68oGvjABf8mOTlqMlku/XtDB7XFFuprb4NvIeLx0DsMfR8OPFPA+J7DY03pRLzFpXc7
         Jr+XqoObZBC0Fzy2dg4+cwev51FcwwudTixlCaizJOExVIEAk3/L/IXRL8O9qjHuPFs+
         EQ8Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.100 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="39701802"
From: Luwei Kang <luwei.kang@intel.com>
To: kvm@vger.kernel.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	hpa@zytor.com,
	x86@kernel.org,
	chao.p.peng@linux.intel.com,
	thomas.lendacky@amd.com,
	bp@suse.de,
	Kan.liang@intel.com,
	Janakarajan.Natarajan@amd.com,
	dwmw@amazon.co.uk,
	linux-kernel@vger.kernel.org,
	alexander.shishkin@linux.intel.com,
	peterz@infradead.org,
	mathieu.poirier@linaro.org,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	pbonzini@redhat.com,
	rkrcmar@redhat.com,
	david@redhat.com,
	bsd@redhat.com,
	yu.c.zhang@linux.intel.com,
	joro@8bytes.org,
	Luwei Kang <luwei.kang@intel.com>
Subject: [PATCH v8 01/12] perf/x86/intel/pt: Move Intel-PT MSRs bit definitions to a public header
Date: Mon, 14 May 2018 18:57:01 +0800
Message-Id: <1526295432-20640-2-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
References: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429565340015294?=
X-GMAIL-MSGID: =?utf-8?q?1600429565340015294?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Chao Peng <chao.p.peng@linux.intel.com>

Intel Processor Trace virtualization enabling in KVM guest
need to access these MSRs bit definitions, so move them to
public header file msr-index.h.

Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/events/intel/pt.h       | 37 -------------------------------------
 arch/x86/include/asm/msr-index.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 37 deletions(-)

diff --git a/arch/x86/events/intel/pt.h b/arch/x86/events/intel/pt.h
index 0eb41d0..0050ca1 100644
--- a/arch/x86/events/intel/pt.h
+++ b/arch/x86/events/intel/pt.h
@@ -20,43 +20,6 @@
 #define __INTEL_PT_H__
 
 /*
- * PT MSR bit definitions
- */
-#define RTIT_CTL_TRACEEN		BIT(0)
-#define RTIT_CTL_CYCLEACC		BIT(1)
-#define RTIT_CTL_OS			BIT(2)
-#define RTIT_CTL_USR			BIT(3)
-#define RTIT_CTL_PWR_EVT_EN		BIT(4)
-#define RTIT_CTL_FUP_ON_PTW		BIT(5)
-#define RTIT_CTL_CR3EN			BIT(7)
-#define RTIT_CTL_TOPA			BIT(8)
-#define RTIT_CTL_MTC_EN			BIT(9)
-#define RTIT_CTL_TSC_EN			BIT(10)
-#define RTIT_CTL_DISRETC		BIT(11)
-#define RTIT_CTL_PTW_EN			BIT(12)
-#define RTIT_CTL_BRANCH_EN		BIT(13)
-#define RTIT_CTL_MTC_RANGE_OFFSET	14
-#define RTIT_CTL_MTC_RANGE		(0x0full << RTIT_CTL_MTC_RANGE_OFFSET)
-#define RTIT_CTL_CYC_THRESH_OFFSET	19
-#define RTIT_CTL_CYC_THRESH		(0x0full << RTIT_CTL_CYC_THRESH_OFFSET)
-#define RTIT_CTL_PSB_FREQ_OFFSET	24
-#define RTIT_CTL_PSB_FREQ      		(0x0full << RTIT_CTL_PSB_FREQ_OFFSET)
-#define RTIT_CTL_ADDR0_OFFSET		32
-#define RTIT_CTL_ADDR0      		(0x0full << RTIT_CTL_ADDR0_OFFSET)
-#define RTIT_CTL_ADDR1_OFFSET		36
-#define RTIT_CTL_ADDR1      		(0x0full << RTIT_CTL_ADDR1_OFFSET)
-#define RTIT_CTL_ADDR2_OFFSET		40
-#define RTIT_CTL_ADDR2      		(0x0full << RTIT_CTL_ADDR2_OFFSET)
-#define RTIT_CTL_ADDR3_OFFSET		44
-#define RTIT_CTL_ADDR3      		(0x0full << RTIT_CTL_ADDR3_OFFSET)
-#define RTIT_STATUS_FILTEREN		BIT(0)
-#define RTIT_STATUS_CONTEXTEN		BIT(1)
-#define RTIT_STATUS_TRIGGEREN		BIT(2)
-#define RTIT_STATUS_BUFFOVF		BIT(3)
-#define RTIT_STATUS_ERROR		BIT(4)
-#define RTIT_STATUS_STOPPED		BIT(5)
-
-/*
  * Single-entry ToPA: when this close to region boundary, switch
  * buffers to avoid losing data.
  */
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 53d5b1b..5e8d156 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -106,7 +106,40 @@
 #define MSR_PEBS_LD_LAT_THRESHOLD	0x000003f6
 
 #define MSR_IA32_RTIT_CTL		0x00000570
+#define RTIT_CTL_TRACEEN		BIT(0)
+#define RTIT_CTL_CYCLEACC		BIT(1)
+#define RTIT_CTL_OS			BIT(2)
+#define RTIT_CTL_USR			BIT(3)
+#define RTIT_CTL_PWR_EVT_EN		BIT(4)
+#define RTIT_CTL_FUP_ON_PTW		BIT(5)
+#define RTIT_CTL_CR3EN			BIT(7)
+#define RTIT_CTL_TOPA			BIT(8)
+#define RTIT_CTL_MTC_EN			BIT(9)
+#define RTIT_CTL_TSC_EN			BIT(10)
+#define RTIT_CTL_DISRETC		BIT(11)
+#define RTIT_CTL_PTW_EN			BIT(12)
+#define RTIT_CTL_BRANCH_EN		BIT(13)
+#define RTIT_CTL_MTC_RANGE_OFFSET	14
+#define RTIT_CTL_MTC_RANGE		(0x0full << RTIT_CTL_MTC_RANGE_OFFSET)
+#define RTIT_CTL_CYC_THRESH_OFFSET	19
+#define RTIT_CTL_CYC_THRESH		(0x0full << RTIT_CTL_CYC_THRESH_OFFSET)
+#define RTIT_CTL_PSB_FREQ_OFFSET	24
+#define RTIT_CTL_PSB_FREQ		(0x0full << RTIT_CTL_PSB_FREQ_OFFSET)
+#define RTIT_CTL_ADDR0_OFFSET		32
+#define RTIT_CTL_ADDR0			(0x0full << RTIT_CTL_ADDR0_OFFSET)
+#define RTIT_CTL_ADDR1_OFFSET		36
+#define RTIT_CTL_ADDR1			(0x0full << RTIT_CTL_ADDR1_OFFSET)
+#define RTIT_CTL_ADDR2_OFFSET		40
+#define RTIT_CTL_ADDR2			(0x0full << RTIT_CTL_ADDR2_OFFSET)
+#define RTIT_CTL_ADDR3_OFFSET		44
+#define RTIT_CTL_ADDR3			(0x0full << RTIT_CTL_ADDR3_OFFSET)
 #define MSR_IA32_RTIT_STATUS		0x00000571
+#define RTIT_STATUS_FILTEREN		BIT(0)
+#define RTIT_STATUS_CONTEXTEN		BIT(1)
+#define RTIT_STATUS_TRIGGEREN		BIT(2)
+#define RTIT_STATUS_BUFFOVF		BIT(3)
+#define RTIT_STATUS_ERROR		BIT(4)
+#define RTIT_STATUS_STOPPED		BIT(5)
 #define MSR_IA32_RTIT_ADDR0_A		0x00000580
 #define MSR_IA32_RTIT_ADDR0_B		0x00000581
 #define MSR_IA32_RTIT_ADDR1_A		0x00000582
@@ -115,6 +148,7 @@
 #define MSR_IA32_RTIT_ADDR2_B		0x00000585
 #define MSR_IA32_RTIT_ADDR3_A		0x00000586
 #define MSR_IA32_RTIT_ADDR3_B		0x00000587
+#define MSR_IA32_RTIT_ADDR_RANGE	4
 #define MSR_IA32_RTIT_CR3_MATCH		0x00000572
 #define MSR_IA32_RTIT_OUTPUT_BASE	0x00000560
 #define MSR_IA32_RTIT_OUTPUT_MASK	0x00000561
-- 
1.8.3.1
