Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZokY0DLxWliJSV2Z+8v2T2+N0NHUjotEgmvFpOzJazApfoMsEBpHMVSt5wd38A5uuV80Qbr
ARC-Seal: i=1; a=rsa-sha256; t=1526937716; cv=none;
        d=google.com; s=arc-20160816;
        b=bsRpiSumCvF6da/jfWVSx7QaDrSbJVZ1qxIH4WyxuBQSw8Yk29CUxIfpaI4KKmQ7Wv
         kip5OeJC0zPyKFaA54zwoy9XIRf8f6LnOCYtIL1Tel8ovbKuVVn82ObE3iQ9DH1YKvSQ
         6HweTe81ZJTv2yjOtJ392YHsN0VO6PA31YsvIKQtyjK1gJiZNV1431ePrJRHm0lbmXzY
         KEHfTCSF9cLYqmCnBBeOp2hIFLQ7tFHIIzMHuZRpTb2+kVe6fs2ZUuLXnmTT2xfpeBtG
         ExphYtahezS6HtbEVUcC51gpmNVMXllRu3We9abcm4R/k6q3uS6z8OGeEVZR6JId0+PO
         /Klg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=BwHocBgHy2GasWzaMfzodG+GZg770piwRHMuSFjlgq8=;
        b=nD/zei7gk/4pJYH81t1aixVNWM0uIbGoEarDLFCYWj3HfhpjNX7e6fauSchOP+ZL9v
         NkYy9XUxa5nyVapDknuKU0jwr4Ks5PXpjOUtMkVcYF2VesXq6W5en8lB36VPav/2ltO5
         UeVO67H5BvIo4xOqaU+RTBqIgwdFkYkipNfIuV5nfYqLGt2tFN73FuOOAXOS2UH8seqU
         iJkT5uDemHapzIe1E7gn3mBH707/jdhspTHSyenM+WUYVXI+OxY3ZVEaymMMtFVSFdNm
         SldICz67KEjYI2r+3uUAKzp/jq9VR9WjmCqiXIYnHMqynB91i/IYDauexnHF+WrInoai
         dgWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LaizM/vT;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=LaizM/vT;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 95/95] x86/bugs: Rename SSBD_NO to SSB_NO
Date: Mon, 21 May 2018 23:12:25 +0200
Message-Id: <20180521210503.578070858@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109970459860027?=
X-GMAIL-MSGID: =?utf-8?q?1601110243340009935?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 240da953fcc6a9008c92fae5b1f727ee5ed167ab upstream

The "336996 Speculative Execution Side Channel Mitigations" from
May defines this as SSB_NO, hence lets sync-up.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/msr-index.h |    2 +-
 arch/x86/kernel/cpu/common.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -70,7 +70,7 @@
 #define MSR_IA32_ARCH_CAPABILITIES	0x0000010a
 #define ARCH_CAP_RDCL_NO		(1 << 0)   /* Not susceptible to Meltdown */
 #define ARCH_CAP_IBRS_ALL		(1 << 1)   /* Enhanced IBRS support */
-#define ARCH_CAP_SSBD_NO		(1 << 4)   /*
+#define ARCH_CAP_SSB_NO			(1 << 4)   /*
 						    * Not susceptible to Speculative Store Bypass
 						    * attack, so no Speculative Store Bypass
 						    * control required.
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -941,7 +941,7 @@ static void __init cpu_set_bug_bits(stru
 		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
 
 	if (!x86_match_cpu(cpu_no_spec_store_bypass) &&
-	   !(ia32_cap & ARCH_CAP_SSBD_NO))
+	   !(ia32_cap & ARCH_CAP_SSB_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
 	if (x86_match_cpu(cpu_no_speculation))
