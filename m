Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x224OkRqh3QNgYVFvukN3zxQGSfWMqut3KMxA8JiceQMGBsUcHLQdGScekjngu7WMmhtgZznf
ARC-Seal: i=1; a=rsa-sha256; t=1517855008; cv=none;
        d=google.com; s=arc-20160816;
        b=ai94pUT/Z6kgvTypfHuNnQ0oH6lBYC38jARYKxb/f8FLUN+MDNAiNIMFrEMMSpSTFh
         TOzT6CaegyEZ/5OZQ2OVRsyCQmPAwVr5TkQtnc0S2EWqz7h/2pcyjpr8uUX781ojKaD0
         VYqaD23+ekehOjN3/zFU5pCRtUp1fxEkiMnAh8WNntdljBv2+Zk4YjVeESpUYRA2ATv1
         UOzjNTYbZXnFSnVo7gqXSO5EON2knhikpF+VGDEoK/MHucd8SB/Be2S1GiUak2+XHTg0
         P0r9NtPYXTF6FS6ZKcqmXCyzHd2MZhzGLvFV6rlfOzINzvXKDR2l83BvAE977o3ePVRI
         ZPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=/mCHcdB0zf8W6spLRhH8/NDnmxcferImcBN6zspSGcs=;
        b=gmhqmTRL4HI+o1RbxADfBnn8ioDNlp0m2RGT7fQcPqjQJhmQq/E1fZlxr/Y941MS6h
         awqFb4166eRg7jErktTYEsrF2lXsU8ZQyhIpNQZ4T+D/2Mjsha/f2bI9EV9quvKc1wB4
         /jpmfmoguuQQulc2GiuZk7+IRKtHNZ09uOkHnoraH8AMh+j4MJ0le5S85MyiitzkzDwb
         c5mVJwyE4pxdcYZtmOI32G9/iER+UG4f/Ztv0kksiS3EPChIq8CTFeFbZKvblwReb9zO
         SVDdYCICywO9XdLH5DO33YOkpMQymx6HOM13Iq+tneppSD19aUga4JP321C8tenpxYvX
         FgLA==
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
Subject: [PATCH 4.14 11/64] x86/msr: Add definitions for new speculation control MSRs
Date: Mon,  5 Feb 2018 10:22:30 -0800
Message-Id: <20180205182139.037788485@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586333810903053?=
X-GMAIL-MSGID: =?utf-8?q?1591586333810903053?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
 
