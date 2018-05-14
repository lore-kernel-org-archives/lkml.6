Return-Path: <luwei.kang@intel.com>
X-Google-Smtp-Source: AB8JxZqw727IQhi7hZvMwUnDs1IrV1cCpQMqtcNtQAQLKrZeoRK95tHJVI56gTJCqBS2h/m6D2L2
ARC-Seal: i=1; a=rsa-sha256; t=1526288584; cv=none;
        d=google.com; s=arc-20160816;
        b=uFtsPh8cx1uMvBIM3E72kss8wJJP5Y1/UcIKXZOLH1R6kqn2ezf1KKFtnx5VPiDII5
         YXb5z0f3wuZ/fddzBairthWL9hZFcwyUBf0Puvf9xWYMSt83fcnnnGMBLazJkfUaVgKu
         nyVTVdLDri50XrAFFJ1Do3WkBdkkYRv7aQURD3xxinic4xTiQI/EIvknqH/w5VvAuiMc
         oYWlnWzUDM5SxAzX5gTJuk/bjsqWTRrHWFksYOsdWy5JJyZgbNTMwop7HoMZgVWqRURI
         4nJ2md8F0/jt5KaCnYpQQa1sLvVoLMPaMKUMQOcbVfuidLjlT6krwBAgl05a/loXG5O8
         iCow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=BlsY8DWussseUdrPFHptQ05E3Uuh9JImFQUxwYMY+wg=;
        b=OD7LOJtDBCouys83BWFhRFYPNxwYkm9I3YN8jUkxe42PUgz0B1ulIV/NjscOTbmnCf
         3BBxAE81ZME7BVSf5bD87bu2GLuoM22haAa+Nw8yWGyctg4FG4cOom1xL7fMDdBhw0ZX
         WWghpaFNu275UtL6yfSSAkW8kpPg9ZB0xGha4ig76X86oKZUaMsghIBFNNlWHJ4MbGA3
         pnj/dUAW7ZjB7GbKnj2N+UGiB1VKJ4r0WJ1b/Osyvxn95mx/GrJUC1tNgFPk7lLI2LpL
         8KLAM+tFPCgIiSq5ZBWUi37GN+1G1UccKTbQ7vNYJ0pFW2y9A2XGXL9qnCLO6NqvniON
         53jA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of luwei.kang@intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=luwei.kang@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="39701855"
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
Subject: [PATCH v8 03/12] perf/x86/intel/pt: Add new bit definitions for Intel PT MSRs
Date: Mon, 14 May 2018 18:57:03 +0800
Message-Id: <1526295432-20640-4-git-send-email-luwei.kang@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
References: <1526295432-20640-1-git-send-email-luwei.kang@intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429578662232971?=
X-GMAIL-MSGID: =?utf-8?q?1600429578662232971?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

These bit definitions are use for emulate MSRs read/write
for KVM. For example, IA32_RTIT_CTL.FabricEn[bit 6] is available
only when CPUID.(EAX=14H, ECX=0):ECX[bit 3] = 1. If KVM guest
try to set this bit with CPUID.(EAX=14H, ECX=0):ECX[bit3] = 0
a #GP would be injected to KVM guest.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
---
 arch/x86/include/asm/msr-index.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 5e8d156..f163f04 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -112,6 +112,7 @@
 #define RTIT_CTL_USR			BIT(3)
 #define RTIT_CTL_PWR_EVT_EN		BIT(4)
 #define RTIT_CTL_FUP_ON_PTW		BIT(5)
+#define RTIT_CTL_FABRIC_EN		BIT(6)
 #define RTIT_CTL_CR3EN			BIT(7)
 #define RTIT_CTL_TOPA			BIT(8)
 #define RTIT_CTL_MTC_EN			BIT(9)
@@ -140,6 +141,8 @@
 #define RTIT_STATUS_BUFFOVF		BIT(3)
 #define RTIT_STATUS_ERROR		BIT(4)
 #define RTIT_STATUS_STOPPED		BIT(5)
+#define RTIT_STATUS_BYTECNT_OFFSET	32
+#define RTIT_STATUS_BYTECNT		(0x1ffffull << RTIT_STATUS_BYTECNT_OFFSET)
 #define MSR_IA32_RTIT_ADDR0_A		0x00000580
 #define MSR_IA32_RTIT_ADDR0_B		0x00000581
 #define MSR_IA32_RTIT_ADDR1_A		0x00000582
-- 
1.8.3.1
