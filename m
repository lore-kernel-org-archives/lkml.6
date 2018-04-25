Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+vipfT9oxtA5ctMQDESBTAerknUbuHTQzvj9907kX7gIUmrSLca7iHWaMp17o02UL/H8DS
ARC-Seal: i=1; a=rsa-sha256; t=1524652684; cv=none;
        d=google.com; s=arc-20160816;
        b=dT3t+SmdIKAi40vjAI5uK8wPAcSerS7zezyqH56Y7TQlonLUjWXAPCSF8WjslggdM2
         OgfeM62C6U3doc5vBELi+pMh3cdczWd1Ac2ySh+F6Pde54j/at/DirXghfwzUmI9Q0ff
         pBgKMWWgu32MhcEAkCzoFgjTerEpbk3iyFb3mM3kxEHslQgXBArVs5jRAYHW1+PzOOBk
         Siq9Ia7r35EpcuyPWkLkrL/JaIaeuXe1/a6tISq7psfW9ZfZDMDUPyjSc1G3vUyH6up8
         OQ6ZkOEP1+rksMl3NSzJQcZL0fb+vZxz7NjG1Rkya6/Gcw+XPdsMV72zT/lA2mzkf4lf
         id4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=eASKLKo7UG5ovf3jFwnIlvSHVqu3J1MJTxnvS4Jn3IM=;
        b=lx02xRgwuTVbiCkxfd4zzzCglXBuuYFS6JaJOY9EGRe3/UFQXzIWy06tI6wLxtnImb
         BTCIODn2gsJ9GA3KI2mwAuP+u6eBUfkN5a3iL6av/EM9RtS2VqpzbM8KZ8fL7ObOuOl7
         VHist/bvLzbfAtv3tntdWXngb7VA7CJb4l4c6vkXH0rc3vuLOE6ui87P94b1lLgWRn9h
         1pf/4Qi9JvdIPF1lbicd7CRfrxtNpXmuWLoP96vaopuD3Hz96b+DZ69ZfQA9oqeho492
         7+lKIWo8nbKUPOmlLs3/w93BSZTM3ehnA2bVOmZGMaaYG9NAldwXG096DwGUkWTGizmk
         /oBg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gaurav K Singh <gaurav.k.singh@intel.com>,
	Abhay Kumar <abhay.Kumar@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 4.14 008/183] drm/i915/audio: Fix audio detection issue on GLK
Date: Wed, 25 Apr 2018 12:33:48 +0200
Message-Id: <20180425103242.939821018@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598713959199503813?=
X-GMAIL-MSGID: =?utf-8?q?1598714213657772700?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gaurav K Singh <gaurav.k.singh@intel.com>

commit b4615730530be85fc45ab4631c2ad6d8e2d0b97d upstream.

On Geminilake, sometimes audio card is not getting
detected after reboot. This is a spurious issue happening on
Geminilake. HW codec and HD audio controller link was going
out of sync for which there was a fix in i915 driver but
was not getting invoked for GLK. Extending this fix to GLK as well.

Tested by Du,Wenkai on GLK board.

Bspec: 21829

v2: Instead of checking GEN9_BC, BXT and GLK macros, use IS_GEN9 macro (Jani N)

Cc: <stable@vger.kernel.org> # b651bd2a3ae3 ("drm/i915/audio: Fix audio enumeration issue on BXT")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gaurav K Singh <gaurav.k.singh@intel.com>
Reviewed-by: Abhay Kumar <abhay.Kumar@intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1523989338-29677-1-git-send-email-gaurav.k.singh@intel.com
(cherry picked from commit 8221229046e862977ae93ec9d34aa583fbd10397)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_audio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/intel_audio.c
+++ b/drivers/gpu/drm/i915/intel_audio.c
@@ -704,7 +704,7 @@ static void i915_audio_component_codec_w
 	struct drm_i915_private *dev_priv = kdev_to_i915(kdev);
 	u32 tmp;
 
-	if (!IS_GEN9_BC(dev_priv))
+	if (!IS_GEN9(dev_priv))
 		return;
 
 	i915_audio_component_get_power(kdev);
