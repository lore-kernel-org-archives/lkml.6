Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvTGI/ZUsiu6L7L1sdwhlqg6gVP8+rJipbRyOO9VUsnXTkKGwFaNwDHGYxhkL3GX7NZaP0o
ARC-Seal: i=1; a=rsa-sha256; t=1520954865; cv=none;
        d=google.com; s=arc-20160816;
        b=ec2QPXse7W/vazqfoZJOCXUT7d8ZkazQS58KKgV0qlAnwEMTX7c3gC/zYj0wVNuaMJ
         qL5+9O3D6XZs2S596ZhhURF2doYyQWmHYMnhsnHzn2hGBQBTV1Yldg+1z08F63aM8DjC
         WUqpUd+kstNBl+eS/3L8K04L22rowGuDule8wMFP6PFbaXeKD7uZkSRWyzWxub86RMzy
         K+Y84a9jL2IjywCZeLQmwtuOVuMW9nWhKUZpz3ir/MiNmrl5un3Osmu759ET1eOSPlJ2
         M6FGjcUZjyLYmxioNf/6Z24QTiB7pWjg7TXfXJEB6w6xvJXXH3IDktA4B1e1a/27nCWS
         JYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=hpdMEFvE2MPgVB7+6mrjZ+6aAwevoLPcs1x/Y2mKsAQ=;
        b=y1eBd5CFjcNjPxvYnn7wG+sDBc89UPc6+NAwjM2H7pouWCvqlHs+tml+ADZJcZfMDS
         qgVJgdT/0a1XrRLJ+9RNVgQU0hpW46TV6uYv+lyefYr8CC8xpKOLtP4opXVI0t+53xK0
         28t1dSPMhujc9lakTHxyyd6XKofZqtlLUM6to/Z5CiueLkL9EVV1ePC8b+BjPtSIsOPg
         QecHjR2PYVQcs8DlPOIvf2zaNLezo/WgFMO7DjQFGN/jRO9GuFQQV/r+iVDeqkbzjVa+
         Mdi/xe0+gyEL4g/MVSVpFAa65kT6ie07fwIdHt1ZV0z+Uv2sFLVgcxXNb2Vcl1oFRIGr
         qE+g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Mika Kahola <mika.kahola@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	intel-gfx@lists.freedesktop.org,
	Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 4.15 010/146] drm/i915/audio: fix check for av_enc_map overflow
Date: Tue, 13 Mar 2018 16:22:57 +0100
Message-Id: <20180313152321.396639946@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594836769072954901?=
X-GMAIL-MSGID: =?utf-8?q?1594836769072954901?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jani Nikula <jani.nikula@intel.com>

commit 72a6d72c2cd03bba7b70117b63dea83d2de88057 upstream.

Turns out -1 >= ARRAY_SIZE() is always true. Move the bounds check where
we know pipe >= 0 and next to the array indexing where it makes most
sense.

Fixes: 9965db26ac05 ("drm/i915: Check for fused or unused pipes")
Fixes: 0b7029b7e43f ("drm/i915: Check for fused or unused pipes")
Cc: <stable@vger.kernel.org> # v4.10+
Cc: Mika Kahola <mika.kahola@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: intel-gfx@lists.freedesktop.org
Reviewed-by: Dhinakaran Pandiyan <dhinakaran.pandiyan@intel.com>
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180214173840.25360-1-jani.nikula@intel.com
(cherry picked from commit cdb3db8542d854bd678d60cd28861b042e191672)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_audio.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/gpu/drm/i915/intel_audio.c
+++ b/drivers/gpu/drm/i915/intel_audio.c
@@ -754,11 +754,11 @@ static struct intel_encoder *get_saved_e
 {
 	struct intel_encoder *encoder;
 
-	if (WARN_ON(pipe >= ARRAY_SIZE(dev_priv->av_enc_map)))
-		return NULL;
-
 	/* MST */
 	if (pipe >= 0) {
+		if (WARN_ON(pipe >= ARRAY_SIZE(dev_priv->av_enc_map)))
+			return NULL;
+
 		encoder = dev_priv->av_enc_map[pipe];
 		/*
 		 * when bootup, audio driver may not know it is
