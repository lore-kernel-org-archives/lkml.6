Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZry3E28O+lPsaPV6mAwIrSiVUeHsaqnyeyCTULfl+bc68a0FS//9FjsO9eKGqJfmgjVWR8o
ARC-Seal: i=1; a=rsa-sha256; t=1526937603; cv=none;
        d=google.com; s=arc-20160816;
        b=0eYVDv5AbI7u1/cVFgNnfEByX64+Ga+9AJaN7mGt54rjFMtO1HL/fOwPzXBZwbK0CL
         tg1YpjUfXZRi3X5TgRq79k++8YMpVdtRO3i4MD1IHHS45vHIB+x2ZpWxhKH3Ew1JDyRw
         5MoVuHa6NjCC+OXM2+X7rk8SuIwZBqo1ClJqfw34B32ARUBPIHpxh5Jteo4m+QdP93qK
         WsXZuREdGdD1Q5La2a2C+1cjNKAQ35YQV/Eokh8eOC51eFqvp5xtTSVugiF6GRxMIs/r
         YJnv6Mk6bQNLiEbA3wCvqzlS/vue02XnW6Rr6CdXLjwgXwvspJ6y3N+t/qBUpudI6iJH
         UhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=MtoXRfmMEo973Tfd5OU8OAUF2dAZfSzyqEvzACeW7PI=;
        b=JGFCGKTn5ECBC5puw8jylruvClVIOLMjVDxtPvgJFQ4sl+o2jFcx0f6n8kDBWm217v
         u5bfMAoL92Nsc/TTwoy+Ek5xNKc4FhM57IQBm971QOk6UTbsMKKYdqMQgK0vni0gaK42
         ER/fdMYkfzY3CIav2wf2pxoYGqzpaApK251CJYdQd7QvB/67hvjTsiJ3V0q6/iXFO+k/
         a3S/pFLyYQz9V8SoeEVqXxdoaDCRT5MXvh6/GrL0YtS3iI8lN2Xzkydq/RyYDhhipyKH
         KEvzBdtea+MwLB/4nus5RLcWK4QlIW+2sBaPwLl7BVyEoAhHsVxASPxMqGaZ7d9hUc0i
         qNuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=SsqQxwk8;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=SsqQxwk8;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 54/95] x86/cpufeatures: Add X86_FEATURE_RDS
Date: Mon, 21 May 2018 23:11:44 +0200
Message-Id: <20180521210458.290436491@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109838920846580?=
X-GMAIL-MSGID: =?utf-8?q?1601110125004671687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 0cc5fa00b0a88dad140b4e5c2cead9951ad36822 upstream

Add the CPU feature bit CPUID.7.0.EDX[31] which indicates whether the CPU
supports Reduced Data Speculation.

[ tglx: Split it out from a later patch ]

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/cpufeatures.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -331,6 +331,7 @@
 #define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
 #define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
 #define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
+#define X86_FEATURE_RDS			(18*32+31) /* Reduced Data Speculation */
 
 /*
  * BUG word(s)
