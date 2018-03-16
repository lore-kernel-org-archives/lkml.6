Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtmVbShxmm5E3A3yTFSqL5CGavwQwXcuDZmg+wwyPabw6k4Ey4yM18svJSa0b5JbN+oyXtV
ARC-Seal: i=1; a=rsa-sha256; t=1521214208; cv=none;
        d=google.com; s=arc-20160816;
        b=xXA/vFtZXwBmrC3jJN3dOtMdXQuVruX/raH5s3IXDFIIli8M7T0FbYPd6CZLIVoi4L
         NAWOrKskJcEZ/bTVvB+v39knWfKl5DVVVEk6STzGvYrh8imzixS/W/evK8v+BI0X6xBZ
         PV153goiTv0glOmqqavs4N7pCDNb6i0f+SUe4V/lLmqBbKUjWuK7jeTEEFpqjmxo4YfM
         q4XPLAvvKyDpaNqDaiYqGSkHPcaGq7vn/nuP//f4POYMmEeSpfCIGAEwj2MAPusAsEhp
         iML1SXaUFsPpRg3ZFKuesnOIwbFna0P7zaoeiyIGoKDyw1bg9IPrY31OdnVGhwfDqNkH
         BM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=3wD2VK13w1Dk3FGCgfryJDRKho80YmZho7M04m3OJNA=;
        b=qTlDG9tCsCVF37XBQt+9s58Nl3wf/Nm10BT6mSJKtfVdJVTXY6NTdvo+4LxIPlNbqf
         kPtQF/aqYGBV5xIXxu4tfWtA3g3sh8bgJKZN2IDFnqsQA1yJ7ZfBceVfGukBSTOJ06j0
         VYgz/4HbQ32hdAlujkt+DpMGx/xPeQDFeGyxq2NrMtKRRUQB9JENgAqlPCbYFIDhJb6s
         YMWmisAKi/sxcxB9VRQedpZc0COvwkcQxcZMvU7CuqdhgF5cF60n7NZNydse/bj2HpmL
         5uqOHRVMpP7FNBFD26ckYtkR0fEXxKkh0Eh2VYNbdtwp/CK5Bhf7RsqZWfaUj/d1HL1+
         Rxgw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
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
Subject: [PATCH 4.9 06/86] drm/i915: Always call to intel_display_set_init_power() in resume_early.
Date: Fri, 16 Mar 2018 16:22:29 +0100
Message-Id: <20180316152317.652617970@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108709721850142?=
X-GMAIL-MSGID: =?utf-8?q?1595108709721850142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1703,6 +1703,8 @@ static int i915_drm_resume_early(struct
 	if (IS_BROXTON(dev_priv) ||
 	    !(dev_priv->suspended_to_idle && dev_priv->csr.dmc_payload))
 		intel_power_domains_init_hw(dev_priv, true);
+	else
+		intel_display_set_init_power(dev_priv, true);
 
 	enable_rpm_wakeref_asserts(dev_priv);
 
