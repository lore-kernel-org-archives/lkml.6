Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226/CWcCmQ4tB0U1fIq0Qd97TqqQDu0DzIzm2qweEn0T6i+jQAAuoaWyeCRgdoAChEtAIxl0
ARC-Seal: i=1; a=rsa-sha256; t=1519218675; cv=none;
        d=google.com; s=arc-20160816;
        b=RFsRT4TINZV2Sz57xFJ8SBr4L53ZqOCx6z7hA+Ddy8t3Dj3U1jZaBbKTj0MpiNfOx2
         d8ZO0VqY8CqvmfWd5b+MZMDcVc2W9Iv13NJUDKAIfmTzP0JsbC1MGEYC669p0vp5Dfjr
         TyP/PCrFD+fAxS6JJVXTK60tj6dAcVwVFioGgOcu50pGQUGxph7keLgANpdsonGb2tfR
         qnBGq+GKzlYZ6PuTWQiCN2+SGPRrbpWRrU93xn86qo6sknyYlEVKyZ7KU51OlXqIzEx+
         cXKgBDJ9y9YYa3Yh+Z8E2+JzGvTWnj2iGLGN9EyE+aPZP3JZaCGk/S8QbNr2rb3XhPR+
         bJPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=+y7i7exoJD7yVow4SwZEDfnqHMGk4oTIH8LhKsVtdhI=;
        b=HV2LVe4O1n9g3+WtnOvENickSCMiq3FLfjHD+CjJAMafjA/YOGHSKyMYl9qgLKqhWv
         Lc8+xbJz5K3npDuwvyUuXOWh8Mg8sPOJWP35L5HvzkoSlzZImBCGOT9j/3m3bYlXhljF
         WcFUGcU04+xMkpXitLQdGuexawKyf2hf0FjOAfMenVjTybbeFLW0E6fH7VSxkNCPGkBU
         bJC6vW99qCR21BfT8PBoHTNP6TSJzxttiD7Rm7CFHgeCe7MQ6lKXw76cW3nwSGm3kAeg
         HPwFWboA8ob34wMx6Wl+1XEGnVgyEWGEHgMUbfn3oAVFXFTFE7DkhCgJycbqkRptASRP
         BsVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Shanker Donthineni <shankerd@codeaurora.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.15 095/163] arm64: Add missing Falkor part number for branch predictor hardening
Date: Wed, 21 Feb 2018 13:48:44 +0100
Message-Id: <20180221124535.585976745@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015663325630622?=
X-GMAIL-MSGID: =?utf-8?q?1593016242463520114?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shanker Donthineni <shankerd@codeaurora.org>

commit 16e574d762ac5512eb922ac0ac5eed360b7db9d8 upstream.

References to CPU part number MIDR_QCOM_FALKOR were dropped from the
mailing list patch due to mainline/arm64 branch dependency. So this
patch adds the missing part number.

Fixes: ec82b567a74f ("arm64: Implement branch predictor hardening for Falkor")
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/cpu_errata.c |    9 +++++++++
 arch/arm64/kvm/hyp/switch.c    |    4 +++-
 2 files changed, 12 insertions(+), 1 deletion(-)

--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -408,6 +408,15 @@ const struct arm64_cpu_capabilities arm6
 	},
 	{
 		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
+		MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR),
+		.enable = qcom_enable_link_stack_sanitization,
+	},
+	{
+		.capability = ARM64_HARDEN_BP_POST_GUEST_EXIT,
+		MIDR_ALL_VERSIONS(MIDR_QCOM_FALKOR),
+	},
+	{
+		.capability = ARM64_HARDEN_BRANCH_PREDICTOR,
 		MIDR_ALL_VERSIONS(MIDR_BRCM_VULCAN),
 		.enable = enable_smccc_arch_workaround_1,
 	},
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -400,8 +400,10 @@ again:
 		u32 midr = read_cpuid_id();
 
 		/* Apply BTAC predictors mitigation to all Falkor chips */
-		if ((midr & MIDR_CPU_MODEL_MASK) == MIDR_QCOM_FALKOR_V1)
+		if (((midr & MIDR_CPU_MODEL_MASK) == MIDR_QCOM_FALKOR) ||
+		    ((midr & MIDR_CPU_MODEL_MASK) == MIDR_QCOM_FALKOR_V1)) {
 			__qcom_hyp_sanitize_btac_predictors();
+		}
 	}
 
 	fp_enabled = __fpsimd_enabled();
