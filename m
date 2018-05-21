Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpyprzdmVOD2pUde5j5JLN2hOre1FK7Ha9wBGVB4U97K/7PjbOwQu3EU12LDJ2uI43CdIKi
ARC-Seal: i=1; a=rsa-sha256; t=1526937330; cv=none;
        d=google.com; s=arc-20160816;
        b=o2fwqUsX5XIYqZLYN/V2fg7xnrrdF2Q518sWidbNiDGsbzda+ZepSs1d/9CktAvYj6
         isEdlIFxGCg6nC0oO8NBYlXa3pyDXaNi10nP5VkORMA6tSTC4WzQz7F0X/Dw3fu+CR5A
         +9v4qzOKzfFMEUreoJ+ChcuJ+16P5YLB7LqqTwSwyi20K/rE191CHN59hZOTxegu1WNd
         NkBFjATAv+dvKGzX7AQ5U3CIuXuYr7ifSBYz3wa0RvZSppSppySCqku1CTTI2mA0I0L+
         NNBUkvQ10pTeEZclpkt5+bAWzr/mDZRFQ/mBfyzlJuqX7hjZzM+0JIq2awlm2DsjePjh
         c7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=lVGu8nw6pvq3NpPVr+QTu5EGi+E8Gq/h0Tk08UmyfsM=;
        b=TXHJOWR7PglB9AZUmEGFX0C7A4+RAuSsnyp57Lu55P7R6LJqbFi4r5LW/KfVNA13iH
         dZVrMyyXAKTZP611fclK4Bz/GCypRWpkYucc5xrUX2ilsoJH/ZB6jyLlYgH+gmxwW1EQ
         gaZVrxhobmOkhVMZF1pMTlbAw9C95k2qIdCL40wGUyyHs3ULSUW9SHDCG228l0n4m4yK
         01W7O0oTXFhxuVl3tp2g0VDwgRnW8H0WEvdiu6WC+SP3P1dNG3sMIC3IMBoPkDVNE2Jz
         4kSON7gEHVqwov3ETQwQywDAEl6SQZFLIYm1mZL/vU6SWC5ELuWVXbALaq9zOWE17AKo
         ay3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2vkx09fL;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=2vkx09fL;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 42/87] x86/cpufeatures: Add X86_FEATURE_RDS
Date: Mon, 21 May 2018 23:11:18 +0200
Message-Id: <20180521210424.384456853@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109838920846580?=
X-GMAIL-MSGID: =?utf-8?q?1601109838920846580?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 0cc5fa00b0a88dad140b4e5c2cead9951ad36822 upstream

Add the CPU feature bit CPUID.7.0.EDX[31] which indicates whether the CPU
supports Reduced Data Speculation.

[ tglx: Split it out from a later patch ]

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -306,6 +306,7 @@
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
+#define X86_FEATURE_RDS			(18*32+31) /* Reduced Data Speculation */
 
 /*
  * BUG word(s)
