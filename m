Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtrihXID2kSVU6dhRuFJvI8wtV/jtXWpwZkakx6VIrp3FBENtFK2S/ff9RhuSdFCq6mPOuK
ARC-Seal: i=1; a=rsa-sha256; t=1520955480; cv=none;
        d=google.com; s=arc-20160816;
        b=NuEXmKfjANxadQMpq7xqQGJVZVBfspECvadrF9mnWOykDaLl4wc6nJ16J0/AVyEGhu
         PViZCHi697ZaGz2cJEb7qCNvXBOy44BveOUwZYN/N0O8X70zo/KReIB9WyMhvT+/0E6z
         1VAIelJBOw76Tlfa/ClwG4cZIxNs7DTjBDETvXoCEqNATEmehkJZdvYDFovdIg6zr1Wx
         leZljuvqtrYzrvMCfPpJHiKhgby8lKMrh9uKqYC0MBS7NnVs43GKgOqxLs7W0fujQoEy
         Ym9maHJ4LUR6qLyj2JKDTelXjzx/eDnHOhO05dOrBEsuoBvD/A6QJB663DtDbFqKqfEE
         +U9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IQ34v4ZgyN/a1C6x4e/9pjEpJaztLLe/MWweG71sngo=;
        b=LxR68C+XkcYY9wuQqR9Tkgp2vr7GQldRCCRQ01GXIWmLCR9eQZWVIUMEn3oa8PuUDw
         EliSE0rZyAI1j/B5Ovl4Cunk8didVnJVf+AdXXyyhfdoqe4XJs94ieB4dwvys08/Sk/R
         Dm3iTkPEXB2HTVRqJyWoBD/BUr6PuYRyVTQHlpHx7ZCutSu/S+gnlSlorl/+x5FQFvsk
         7w77x7zgvr8ONJ1lLjygHWzp17S4S4JY9XKaG4rxMmEwzHgfV3hm1JANh2wUGhcbed7e
         xxj4lpHNZncK5/9SA5h6AAv4JH782SnyCQYj0CvmcYQk0p9pLc+9HZmj6ve5F2i5sh13
         /d1A==
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
Subject: [PATCH 4.14 060/140] drm/i915: Always call to intel_display_set_init_power() in resume_early.
Date: Tue, 13 Mar 2018 16:24:23 +0100
Message-Id: <20180313152502.271262402@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836884824750960?=
X-GMAIL-MSGID: =?utf-8?q?1594837413634046736?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1806,6 +1806,8 @@ static int i915_drm_resume_early(struct
 	if (IS_GEN9_LP(dev_priv) ||
 	    !(dev_priv->suspended_to_idle && dev_priv->csr.dmc_payload))
 		intel_power_domains_init_hw(dev_priv, true);
+	else
+		intel_display_set_init_power(dev_priv, true);
 
 	i915_gem_sanitize(dev_priv);
 
