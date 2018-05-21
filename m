Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZriS4RkvISGxFWryN0oVCaZuJgAGkpNgirg2iTMHEpSrnlzHNRSnza8HI/YNVhGWrk1dlBx
ARC-Seal: i=1; a=rsa-sha256; t=1526937456; cv=none;
        d=google.com; s=arc-20160816;
        b=TPD6SP/HAbKLVleLLHp0BygC4VIPxv5exi8PVpH3vXALs5tye1qETOOpDaSOLbZcsq
         A0BeM1NFfEp75Z5tyZxleciHEodSnc4tVGX2D4jkEFY8H7GWsLLLIWjXv5mYld8sZXcL
         ME6FudljQKFynEYrVz1dLH8QGzU3hNVvMlpgJ2aCpwCt2AduZoSaDyBJImdNBTI4P8OS
         qrx7pdWlB3HdBF7foKysBmGH3FuLCco0nUrXHgTol0F3tLFWzfWFmjl4EXgEet3WgjDz
         6Ef/chIga9PX5jdSF1Hq5kQLtcqXyGjXTPE3QvarG0+1+6o64JmbsSGXJvRTrKHNntm2
         TuPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=iA3u8GrttN6o4xk/EIHd11zpjYkyQD/4bGmbpgNn0Ts=;
        b=MADJzlETAjTcCiRDCKrxrb7qI/FpUGIrGyNryzC4E5WNHQ6pSRKcGB5HADxpXkeX/7
         gFY7QPr6x46GCtwcpMKVe2XV8Wdlv57CcnySseOutwJ+aQszqMxR+6xzmzqBno29Tc0l
         x1vWFdNEp7vDiO/rkIF0hFxYXdSIhQVWCGi0tOgABFAteO1rPwac1xgr7iuJQ+lQN19R
         sn1gaeB9TFEY9FvrdLQtk/B2dR8WB/iuq28YXevc7E9M4xTWolnnkhQn3vhatKJrYeav
         Ig28L7zLzOl9X3yvZx5uVkxpwxOHLiq6lJ8lEvrOHsx/MlwOIC6FanGR6XakmRgmvCA/
         qIqg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EpdSO7BT;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=EpdSO7BT;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4.9 87/87] x86/bugs: Rename SSBD_NO to SSB_NO
Date: Mon, 21 May 2018 23:12:03 +0200
Message-Id: <20180521210427.343116922@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601109970459860027?=
X-GMAIL-MSGID: =?utf-8?q?1601109970459860027?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

commit 240da953fcc6a9008c92fae5b1f727ee5ed167ab upstream

The "336996 Speculative Execution Side Channel Mitigations" from
May defines this as SSB_NO, hence lets sync-up.

Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/msr-index.h |    2 +-
 arch/x86/kernel/cpu/common.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -63,7 +63,7 @@
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
@@ -926,7 +926,7 @@ static void __init cpu_set_bug_bits(stru
 		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
 
 	if (!x86_match_cpu(cpu_no_spec_store_bypass) &&
-	   !(ia32_cap & ARCH_CAP_SSBD_NO))
+	   !(ia32_cap & ARCH_CAP_SSB_NO))
 		setup_force_cpu_bug(X86_BUG_SPEC_STORE_BYPASS);
 
 	if (x86_match_cpu(cpu_no_speculation))
