Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZr51TrJ4IxLY/9FLEMCBTLuvdideinQH4+X1y38+jcgg40ecYWdbnRyAxjKj+gT5K7biQ96
ARC-Seal: i=1; a=rsa-sha256; t=1526937530; cv=none;
        d=google.com; s=arc-20160816;
        b=tkKN/fkaBJdyWDUTokq9vJdWn47wmuIrqdgZK6tWmWw+xYVYCoJK6hC8NGjs4K7cQN
         LKgjdw8VFsvNHGnGkPE5J76jyPLFXyVaMoE6IeezKkmwq0Hr6e8Nh50dNLQ/xjeayz7v
         s/4ZFrQqU884U4Zwy5IFJR2w0+XU4NliNY+IcvzQYs3vC1sFiOUvR2XZybtTu+z3woY8
         PX8IzaOoP7yff89I9m3cRVPhltVKVeYOfHZTT6k++2L9UbicYMJM8I63Z5i3nMooshbi
         edmH/LPB2JeaMXxDakfg4QTPmEZ67l1HZ+NC06N0sJEbMLMkU16wWj1H3Smo5yKKgDTs
         q7bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=P+khoYZf2mHQcf5UjVWTvXEfdvZNOI296Jn3ZU8MwHs=;
        b=RuVOnTUuU0rJVrB2f7oEkNwW6DmbcJUvGZH0UhjajWxUUhdBea/KQst7pdnCzmZc4x
         D78tfq6Va4DsMX7p3EzUn4PjIMW1QrQvi3qyrki8lCpRsLIbe4UD3f4a+LPC0TI6eayN
         v75j+nCCpJ0HX69qGt/llnSCkHQRHzqHuJj2SBByxmGbf/jZji4KkTUBryiCLT/ltiJq
         X5uMErk1RgYe/BkApQLK101U5YNUehXzR/FFFgv2qMX8ltL4gLS71Lm2Ds2TGcMFLTKo
         rm/hZPstVskF8pPZbExSvlbIC6IrHIlCh37YJw8rliONEhstzOgh/vHi9yE4esKosz3r
         usFA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JBqEqzML;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=JBqEqzML;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Michel Thierry <michel.thierry@intel.com>,
	mesa-dev@lists.freedesktop.org,
	Mika Kuoppala <mika.kuoppala@linux.intel.com>,
	Oscar Mateo <oscar.mateo@intel.com>,
	Chris Wilson <chris@chris-wilson.co.uk>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.14 27/95] drm/i915/gen9: Add WaClearHIZ_WM_CHICKEN3 for bxt and glk
Date: Mon, 21 May 2018 23:11:17 +0200
Message-Id: <20180521210453.951043722@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110047588810636?=
X-GMAIL-MSGID: =?utf-8?q?1601110047588810636?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Michel Thierry <michel.thierry@intel.com>

commit b579f924a90f42fa561afd8201514fc216b71949 upstream.

Factor in clear values wherever required while updating destination
min/max.

References: HSDES#1604444184
Signed-off-by: Michel Thierry <michel.thierry@intel.com>
Cc: mesa-dev@lists.freedesktop.org
Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Cc: Oscar Mateo <oscar.mateo@intel.com>
Reviewed-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Link: https://patchwork.freedesktop.org/patch/msgid/20180510200708.18097-1-michel.thierry@intel.com
Cc: stable@vger.kernel.org
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180514165445.9198-1-michel.thierry@intel.com
(backported from commit 0c79f9cb77eae28d48a4f9fc1b3341aacbbd260c)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_reg.h        |    3 +++
 drivers/gpu/drm/i915/intel_engine_cs.c |    4 ++++
 2 files changed, 7 insertions(+)

--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -7044,6 +7044,9 @@ enum {
 #define SLICE_ECO_CHICKEN0			_MMIO(0x7308)
 #define   PIXEL_MASK_CAMMING_DISABLE		(1 << 14)
 
+#define GEN9_WM_CHICKEN3			_MMIO(0x5588)
+#define   GEN9_FACTOR_IN_CLR_VAL_HIZ		(1 << 9)
+
 /* WaCatErrorRejectionIssue */
 #define GEN7_SQ_CHICKEN_MBCUNIT_CONFIG		_MMIO(0x9030)
 #define  GEN7_SQ_CHICKEN_MBCUNIT_SQINTMOB	(1<<11)
--- a/drivers/gpu/drm/i915/intel_engine_cs.c
+++ b/drivers/gpu/drm/i915/intel_engine_cs.c
@@ -900,6 +900,10 @@ static int gen9_init_workarounds(struct
 	I915_WRITE(GEN8_L3SQCREG4, (I915_READ(GEN8_L3SQCREG4) |
 				    GEN8_LQSC_FLUSH_COHERENT_LINES));
 
+	/* WaClearHIZ_WM_CHICKEN3:bxt,glk */
+	if (IS_GEN9_LP(dev_priv))
+		WA_SET_BIT_MASKED(GEN9_WM_CHICKEN3, GEN9_FACTOR_IN_CLR_VAL_HIZ);
+
 	/* WaVFEStateAfterPipeControlwithMediaStateClear:skl,bxt,glk,cfl */
 	ret = wa_ring_whitelist_reg(engine, GEN9_CTX_PREEMPT_REG);
 	if (ret)
