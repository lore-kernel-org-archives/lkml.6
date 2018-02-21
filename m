Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225e9BPN+YXwtmKb++UVU+2bTB+zpKM/4RBWlK0TWtU7G+kXYYatv2lEH+qr+rnMXbgftiDm
ARC-Seal: i=1; a=rsa-sha256; t=1519218123; cv=none;
        d=google.com; s=arc-20160816;
        b=eVvewwRYzcxMaTV8u9qnSwhAqxWgCy+J4rvxc5QxZG+075TR06I7NRZFfIfyGTaqUD
         DUwo/vr0w79YW06ntK1zFKpKv6WcYGh3gCgQGpNChleE8Nl9f1iyK4oo1I4FDMhxlAGp
         ec4BwrdeScsLczNkP5l9zNyOvZt2pdHrtYcDpEm8XTP3d2XA76ZTZDvhOnvlgvHKRc2o
         CnyzbvaxBpQ4xtw/sV3VgYXIxoM2Pzp6+NsNK/4/79PhPEemDS/e0nNKWzDUBMzuhDqr
         yVBYVYIgLRZy+vL76jp8KuP5mdndSTRm0JnqgSpTFxyNEFAtUYAMjpPXWV9oQ+nHdTeL
         oWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=yQDtLKXwANYFIx5u5+lZPfG9e7OvaOb0J0iGtVxAfK0=;
        b=wlNJpTRJEC7ggFwEgzg1q05CKS8rNqpXkGjkSJsJEASn9wKqeuzu8jyLIseZuxM1ib
         jhQMO1Mi8MOh0ckyF9wONiBJm2DZbv15w9mmdSjJ4CDm2aK0RztDixf4OS+5lBuAjcg8
         qxv9uiiiIO/+g+30btkDQ3feMczPbzoXdB9e9XSXh72icxY6tnu///R4CnoasTY7m1uC
         ntLmBLEeCTG2ofN/OLIyjuVUhLxm9C0ZGAnypf9YCSxwSjp+UQInkaUyoBcE0qEo/I9Z
         FpgD4PAIvemjoReRlPQtlotUqGXymA60EIKJL6VWpoH7yAbhcar5TQ0T2Uxecgbul2za
         mIiw==
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
Subject: [PATCH 4.14 095/167] arm64: Add missing Falkor part number for branch predictor hardening
Date: Wed, 21 Feb 2018 13:48:26 +0100
Message-Id: <20180221124529.552294901@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015663325630622?=
X-GMAIL-MSGID: =?utf-8?q?1593015663325630622?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -371,8 +371,10 @@ again:
 		u32 midr = read_cpuid_id();
 
 		/* Apply BTAC predictors mitigation to all Falkor chips */
-		if ((midr & MIDR_CPU_MODEL_MASK) == MIDR_QCOM_FALKOR_V1)
+		if (((midr & MIDR_CPU_MODEL_MASK) == MIDR_QCOM_FALKOR) ||
+		    ((midr & MIDR_CPU_MODEL_MASK) == MIDR_QCOM_FALKOR_V1)) {
 			__qcom_hyp_sanitize_btac_predictors();
+		}
 	}
 
 	fp_enabled = __fpsimd_enabled();
