Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227664gM5Jj8flbGrGcnZKk5Sd5DzkN3Q3nc//LaSMGjXNNleC7cQ/6ln0DWxHFwtx57rrwr
ARC-Seal: i=1; a=rsa-sha256; t=1517855050; cv=none;
        d=google.com; s=arc-20160816;
        b=QLqpX0M9/CUlf74oAhoUeF/By+u/+MbTOCZ/SjyTZbdXq19QqJdtdgpJdZzZpyVIkR
         IsPdZr4QV04xu5SqOebomcu7V9BJQivpJDPwr/YSFOW1JvjIxiECx3TcIoKEgTD3wSVI
         GCXQEB2K7Qn/wg8XCo5UitfRBVheYaXv+CAA/OSXzS8MFRXxzYPSdcb8pYaTABOi2NOb
         7r+Lh42XdP5GQKWNuWu4wxMEzqTh6v8w3eR6Ir1BfgCT8pOf6dXQrV29F9OwBLneGRW7
         4h7coa3Y6x1C+C/DyDpcTAOb0TyySUWaUkDp5WXn6o1NqZmnQLDJbQZg5SOgg3ojwLcR
         GaPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=HJKbN3Tp+YhDtYfPGQU8sv2xJZcPwAB/XxM+3DT2ND0=;
        b=UApweGi+bLlV6qh0R0VLMxnD9Ofw63JuAkXzLcq8P2r5Qz/SkCYwbd0R8JHR3LQpH4
         Gl4PfhtcKjwyieGuKXRrqJYki+2zF0C4NO4VILOl/xQzAj+WjD8IZy2Dc7KmWm7IioDy
         Q/4hrm50oId91ieeCpzVJtJFalKt1lGzakQaLWmwGOJYUuahbenvSa8I3iE5zNW48l40
         NCkWjyN4HT0NijFDcHabpC2Ee/9CUF9KaEO8LAAMK1dZGlmNxA9TjLH+OAyiXCfIA5ej
         JbKhkHsfgnlbB6VfGYcIu4tXGeB3xJK+FjM35ErWnzOWKJfNm7raAbGmzAvOMtftAkTe
         1ebg==
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
	Tom Lendacky <thomas.lendacky@amd.com>,
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
Subject: [PATCH 4.14 10/64] x86/cpufeatures: Add AMD feature bits for Speculation Control
Date: Mon,  5 Feb 2018 10:22:29 -0800
Message-Id: <20180205182138.995762359@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180205182138.571333346@linuxfoundation.org>
References: <20180205182138.571333346@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1591586376831893912?=
X-GMAIL-MSGID: =?utf-8?q?1591586376831893912?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse dwmw@amazon.co.uk

commit 5d10cbc91d9eb5537998b65608441b592eec65e7

AMD exposes the PRED_CMD/SPEC_CTRL MSRs slightly differently to Intel.
See http://lkml.kernel.org/r/2b3e25cc-286d-8bd0-aeaf-9ac4aae39de8@amd.com

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
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
Link: https://lkml.kernel.org/r/1516896855-7642-4-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 arch/x86/include/asm/cpufeatures.h |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -269,6 +269,9 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* Always save/restore FP error pointers */
+#define X86_FEATURE_AMD_PRED_CMD	(13*32+12) /* Prediction Command MSR (AMD) */
+#define X86_FEATURE_AMD_SPEC_CTRL	(13*32+14) /* Speculation Control MSR only (AMD) */
+#define X86_FEATURE_AMD_STIBP		(13*32+15) /* Single Thread Indirect Branch Predictors (AMD) */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
 #define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
