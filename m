Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrPZzOPqrCD18TAbraz5d2FlcvrMq0OeTYnX6GwD0Xsh9jlKejRFGub8A1ClRippL6fv7lN
ARC-Seal: i=1; a=rsa-sha256; t=1526937424; cv=none;
        d=google.com; s=arc-20160816;
        b=DMW5whJH1jTJbbU5kwgwyoHSJ9YwVJ1iyl1ddbj51wQAmAhrZBf8VkWsfjw+pNz/cQ
         8WHR/GygE+Go1XGphpCh/+olIvrtkOxsNsYlqecCQHgE2nhi5dhsXITpKm4MaLGLJ4qX
         +uUl9D+I9pUmj58gBkxI5tDt7GXt5jrxFOTl4z5DFo48/e34IPPU3BROQJiVjCHYt9Hb
         OOogpFm8TeYthxmyFis3a+sYwJK1JDP8ArNzJ9GWHclUaIGp3UmjVPTnbnaQ1KRZ70Oj
         M3M4WxtP3nHZ1SqpytjvIcQQEw4bjoJenx671AyZB6rTdt6fe1SudjEIDYOmlhep5gKy
         0P0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=mZCaXCrTTycD+llOLf3XePrEx9Sonum6xpM1jSQBhj4=;
        b=PWCKHx/vwrgiOr76yrFYZGIa+icS70lgz4/fXftGd/WfTGnkifNQ5Zp8uW3hZhrvS3
         bkz3g2NzJSKHZsoCKezIfvzNLQYW4rXTk6O0eIELjJcYQXlyqlzkkvtmf3ixPu42y7oy
         LKavokyQQqSKrLe+sXRrK5GJGhtrzaYpuxJ1tBtp698FdLT4NhBYklsQBmXlHYVhSlsw
         YAMdIlhS3WnOAZskkckpe8TMQLDp4Zx3tGcJhchgQ/0YzUeqvRThbuj0nWVm8mfNRIm6
         CuwiprKR/yI2ZWQDkqnec8/+U4NCof/QiPizLH8XkX7YQenxwvuQsa1+8QmehsgZ6DxI
         Tc2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RCOp8AEA;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=RCOp8AEA;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 76/87] x86/cpufeatures: Add FEATURE_ZEN
Date: Mon, 21 May 2018 23:11:52 +0200
Message-Id: <20180521210426.603209543@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109936296040323?=
X-GMAIL-MSGID: =?utf-8?q?1601109936296040323?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit d1035d971829dcf80e8686ccde26f94b0a069472 upstream

Add a ZEN feature bit so family-dependent static_cpu_has() optimizations
can be built for ZEN.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    2 ++
 arch/x86/kernel/cpu/amd.c          |    1 +
 2 files changed, 3 insertions(+)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -212,6 +212,8 @@
 #define X86_FEATURE_IBRS	( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB	( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP	( 7*32+27) /* Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_ZEN		( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
+
 
 /* Virtualization flags: Linux defined, word 8 */
 #define X86_FEATURE_TPR_SHADOW  ( 8*32+ 0) /* Intel TPR Shadow */
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -751,6 +751,7 @@ static void init_amd_bd(struct cpuinfo_x
 
 static void init_amd_zn(struct cpuinfo_x86 *c)
 {
+	set_cpu_cap(c, X86_FEATURE_ZEN);
 	/*
 	 * Fix erratum 1076: CPB feature bit not being set in CPUID. It affects
 	 * all up to and including B1.
