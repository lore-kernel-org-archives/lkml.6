Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv9jULiYW/EjjOF9waQ6ei8uw25WqIaILWflqobnAOk4tgFA5s7YoBuYB0pyMABnW5/1wLy
ARC-Seal: i=1; a=rsa-sha256; t=1520954976; cv=none;
        d=google.com; s=arc-20160816;
        b=V/6PoNKckUOcPVkS4YLpKAowgyCS8F5mKa8X+BOuFPmvkLseGfcaQJ3z7mUL4LDlfp
         4UpwMcFx99qre9+B+XG4TY+MBkzAeH/nFh6WnTP7/AdGtPjsaSwQKO4wki57vHE8Hetb
         qWiG4HzgCvnP56yCZjxsGm8p+9KaH5ccxYFHeb3Rnwz/Fmf+fH0mXEe1Ztkqi4T+svlm
         FAJjimFBlosTeyKJanshtu/OXRz3hgpvc2AsmsuT2zrDjtiEocmnenM63wQBaX0O2fZK
         lLrRWXO+0gc1HnMaEC7Wh9t5ujV8f1P+Ti/jmDYczp8Kvuiz5vWUA7gfPR0dPZDwwSRj
         OWGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=SgZc8wKp2ehetBmanGmwB9rAQmU74q1GgStc+qQ89Zo=;
        b=uiFXYFzUcPicr/5asIQnWxiH4tXf0KU7j+4+dOEwH7Q4e8pVuRGWXaF/g1E5obaCo4
         Fv89F2sVIoM7mY1bwR9rt+T9Vmfqj4HF1fmyggbegXqHjUn6WhQgYFBsRFeKQOn5wNND
         34R+Q00Ox+tukGhSdVd5DzqXsLHqnDh0vMtNmtdYcdXiuI21iw+/zOfmklQaAT4nR0eR
         AC5105ZIhgS1U2lXZlGKzGnsNVeCJplvjb6cvdAjh48+o0T2PCXBEPvzp7cfJk6YIbMr
         lngxCFJ8ZjAPgSVPHPj8Dss7IpdI2NlZ5AZkPiV9hFkcEh7gGn4xvyrygPJIV3d6z171
         vFTA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Nivedita Swaminathan <nivedita.swaminathan@intel.com>,
	Imre Deak <imre.deak@intel.com>,
	Patrik Jakobsson <patrik.jakobsson@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.15 019/146] drm/i915: Always call to intel_display_set_init_power() in resume_early.
Date: Tue, 13 Mar 2018 16:23:06 +0100
Message-Id: <20180313152321.970491646@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836884824750960?=
X-GMAIL-MSGID: =?utf-8?q?1594836884824750960?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

commit d13a8479f3584613b6aacbb793eae64578b8f69a upstream.

intel_power_domains_init_hw() calls set_init_power, but when using
runtime power management this call is skipped. This prevents hw readout
from taking place.

Signed-off-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=104172
Link: https://patchwork.freedesktop.org/patch/msgid/20180116155324.75120-1-maarten.lankhorst@linux.intel.com
Fixes: bc87229f323e ("drm/i915/skl: enable PC9/10 power states during suspend-to-idle")
Cc: Nivedita Swaminathan <nivedita.swaminathan@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Patrik Jakobsson <patrik.jakobsson@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: <stable@vger.kernel.org> # v4.5+
Reviewed-by: Imre Deak <imre.deak@intel.com>
(cherry picked from commit ac25dfed15d470d7f23dd817e965b54aa3f94a1e)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/i915_drv.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -1827,6 +1827,8 @@ static int i915_drm_resume_early(struct
 	if (IS_GEN9_LP(dev_priv) ||
 	    !(dev_priv->suspended_to_idle && dev_priv->csr.dmc_payload))
 		intel_power_domains_init_hw(dev_priv, true);
+	else
+		intel_display_set_init_power(dev_priv, true);
 
 	i915_gem_sanitize(dev_priv);
 
