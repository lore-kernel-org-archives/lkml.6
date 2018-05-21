Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr99TU1xieS1wSBXZ7SRglZlZpS9BruvbAD+O3S+9DCdXO9cQlmMSnHPInp2sCqHsi6mu/x
ARC-Seal: i=1; a=rsa-sha256; t=1526938014; cv=none;
        d=google.com; s=arc-20160816;
        b=eNNHDpcGYMjl05TzLBZa4j+0WiHxU1JXLHbPe3oUFpj22T/kvC/JdcDiUrjl93rixs
         DB2k1ZuGrbK1PD5pU7drvPjoOcdxamDb4a/itrpFhybfAcMsVCW92gDZHi/O5aUqcoIc
         i4D4+KanOjVsMWF+LNtibfD3NqnR7MSCNLO7b4c7My3/pz5xMp8U+n67NTYKz/yOdv1Z
         ao8mrZX3YwEHSB9phSV9KG9gIUlkotbOjmIHU8/YFn/MLp/M9u5GUujKurwF5Cd76o8Q
         okLbL+NXmrWNjrGV4YTqPJa5mi+OerHEeiAUd0HN9YQLK/zoIDqrFlVnvglPUce1FtHK
         2whg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=MvxBJ+zuF6Ly7j1swy1jQKzdSl7nbMOTz7CravS8BB4=;
        b=g2IZopzi3sCUIeFEP21Z+15hu9tRD3tbem3YMBxlWn+okZZm1P8iIEkA9QeAF3r8mA
         nPUB4z4zmL61rOSJTRelCFLB+yrFYcN24MXvEVMB4Erfal4jv3+mVPaoyVGLBo/HHPbl
         MAEZxdC77XVdTH8fEVaF7oczhpLmiOnvWRFYQyijvXYU9jTCwYgSt9OdPMz66dml7CRl
         Zxhr32tRTYAxRIvhzKcyD0SLFhtjo6+7HcWDqzbR1brA2Lny/uKJu6nJC2yjqxOSf3iw
         B2cCzUSQMeTkrMss4UirKqdRmauD7088tJFbeVVzfgyB1jJZTmlniEIqQiW7cVJljBlq
         Visg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kXf+qpTC;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=kXf+qpTC;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 109/110] x86/bugs: Rename SSBD_NO to SSB_NO
Date: Mon, 21 May 2018 23:12:46 +0200
Message-Id: <20180521210515.102929769@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109970459860027?=
X-GMAIL-MSGID: =?utf-8?q?1601110554815652194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -965,7 +965,7 @@ static void __init cpu_set_bug_bits(stru
 		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
 
 	if (!x86_match_cpu(cpu_no_spec_store_bypass) &&
-	   !(ia32_cap & ARCH_CAP_SSBD_NO))
+	   !(ia32_cap & ARCH_CAP_SSB_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
 	if (x86_match_cpu(cpu_no_speculation))
