Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpMF3aysVj0pJqmLSC883tsrGrMWtFdGFlPYgyX3MCgwHQ05bZF0K14awBEqYjXNH3fZL88
ARC-Seal: i=1; a=rsa-sha256; t=1526938005; cv=none;
        d=google.com; s=arc-20160816;
        b=tRLQZaMKKlmPPW7q7MzVamTdoP3izmmz2+BEXcnQ0P4ZBX9Dpn2JQxsAsJvKL75h1S
         dqSy9fvY2jFIYCrb5fLCVNzGC9bhCKZ/LFCXGZf/NcMZi+ym4/0+E9CFKsRrDbhNQ/Gq
         lTOj3aTD6bSNFKyEBpiErFMNzhRRKXhoelacdnBj2pxVWGYR+3XzmL4dfP02NtOCdH5d
         dHHlXSpT3nmvkpt9JIdc3742r8GsrgLlG3HE8jy6adrF1s443u67JNUF2t/LJH3D6lnV
         1SIkOwu0/MkMirIP9SCgMas5pCIyn86gfRUWZFjgVe6gW9nhKDEKZaBSMU7Vnfd4kEDl
         k+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=cEuZhW5JV3N5zMyUmzbKqyBTzZu3M27V1H/bps29uD8=;
        b=ndoQxCF3NJALzdAposCg5IDFHTH+0nVi43HKz4RKHTBlTgtbdjdq+4OaktwD/Jxfcs
         GmRhf38kuZ9ZgQOQgV8uBRW1hsO9fj/6/1lCz3zwlAifkH/xGvqBQOfuPbHeyMDovUw3
         LlIZkrzqbDrBjC99/hiDwgPU4oRjHU5aWuGdrA17KahLRzO1mO0M7UVM+FXRWgO0Hcbp
         DKdJKJUVIxfhVSa+JasD/FCB210phEeWiDz+tX+2wqHtDh0DnByXpUaxHS9VbmI//jxB
         IHk0MuVaY2QZNJczPXP3PmwxE0zCoJA6XaIScITEPmxi0bPqfFz0qlkk77mkvC2aKP1t
         Gx3w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wZO5hANp;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=wZO5hANp;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.16 098/110] x86/cpufeatures: Add FEATURE_ZEN
Date: Mon, 21 May 2018 23:12:35 +0200
Message-Id: <20180521210514.347457274@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109936296040323?=
X-GMAIL-MSGID: =?utf-8?q?1601110546261209463?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit d1035d971829dcf80e8686ccde26f94b0a069472 upstream

Add a ZEN feature bit so family-dependent static_cpu_has() optimizations
can be built for ZEN.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    1 +
 arch/x86/kernel/cpu/amd.c          |    1 +
 2 files changed, 2 insertions(+)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -218,6 +218,7 @@
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -812,6 +812,7 @@ static void init_amd_bd(struct cpuinfo_x
 
 static void init_amd_zn(struct cpuinfo_x86 *c)
 {
+	set_cpu_cap(c, X86_FEATURE_ZEN);
 	/*
 	 * Fix erratum 1076: CPB feature bit not being set in CPUID. It affects
 	 * all up to and including B1.
