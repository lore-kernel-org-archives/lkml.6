Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr/s+3NCYq7AUnSCp3Pq2iLU/TRi4d89ftFQF0LHpNmJaZU6lQZMCq7WPLu+dbOZ+QulXUA
ARC-Seal: i=1; a=rsa-sha256; t=1526937683; cv=none;
        d=google.com; s=arc-20160816;
        b=VcvpWm60WBwz2R3o0fN0waT4k01gmbNQjvwYOr30IoSu2628wnFE+O/i0MKbNN7lQp
         YT3LdrJlNLd4CXnFbc5RQtHK3VvQhO+x0nM6cuJ3Hnei+IKjrSEOo0LYvAi8mtWe6TlS
         HN5TUbBDROcLb0w/YR1IduOnbzcO+c1mVcyomYVzuChkZDnMJfLvC4AQS1scYzvt+w+G
         LKAgz+us7MFZvrJyrtBv57oCFix5DvZK3ZMK9lvRj7w5mua1qCE9RStWh+8nBT/qf8pj
         qXOcBLGcH55qGI2TICzo0Ag7NDV1cmGeh8ygs98RdvJCQjXc1fbQkhjo0HWAAkiov3Ih
         EbXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=/T00VIP8QM3TjvhYAMmuhF4+Zb/T5UIHpTBeCwZcKKs=;
        b=V9QnKgQLZn/P0wxshGermRG8OtMhV4LHQiAnbgj3FPxFwPa6VPiKVzJyMaVyLpD7W6
         AaHOLzB8WOZNncmi463jAUS+sNqUMtDw9o/0B3rfOXX9Xetd7l11d4enkqxibyBHykqX
         DCb4+IQWsUklCUfWlEONmBiQv5ahMHH8iWI3Jvg9a1IBERgv4jxpTMi2YCK+LoPDrdqT
         9LxOLTeSZc+VeJcpmp17Qqgq9poe87ip/2mGbsqgyNr3gZARgIZUnpk8GOd1dC6mMHkX
         jRXx1U2p4/KB0BBz0KN+T2kidv/0O46IvzDhs4Vl6veFBn3UcIuoZyeJfVmH680TtByV
         PGqg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=prRTVqPl;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=prRTVqPl;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@suse.de>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: [PATCH 4.14 84/95] x86/cpufeatures: Add FEATURE_ZEN
Date: Mon, 21 May 2018 23:12:14 +0200
Message-Id: <20180521210502.502985619@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109936296040323?=
X-GMAIL-MSGID: =?utf-8?q?1601110208849090717?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -786,6 +786,7 @@ static void init_amd_bd(struct cpuinfo_x
 
 static void init_amd_zn(struct cpuinfo_x86 *c)
 {
+	set_cpu_cap(c, X86_FEATURE_ZEN);
 	/*
 	 * Fix erratum 1076: CPB feature bit not being set in CPUID. It affects
 	 * all up to and including B1.
