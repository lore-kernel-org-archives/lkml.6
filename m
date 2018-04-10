Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49yD9rmaWbSBLqN/uH9e69VUucSsnOXQ5B5laTQFT1dtt4fSDakdgAML5k6+cFCMtx13GKF
ARC-Seal: i=1; a=rsa-sha256; t=1523399440; cv=none;
        d=google.com; s=arc-20160816;
        b=yqai4PkeNI6LMK50cXF2PTfAI0eA97+nP3cTPyGo/Xk3Ww9XcDC1UfIFurc5UBsXP8
         vwqTEcqjX/Z+gg8sKbM6zU/aSWD6FQ+/FJllgMzb+Rj8RWe0bNQWhd97Gdk0vwQNBI6b
         uCdp6A1uzuxbIwGLad/24Jm49gyl8Gbz7KF+IKBld0mGDA4q163wXv/iknDJiTHaXeVo
         VywtLA8sYRLhpLhRjOmbCkL16U6qzsRUpe5UAiIepbMyDJRuR81FAJ8gTvuEeLCokuC3
         cTtaCBP8mPOYGT5uaKOTxeXjw7ZtGdu+xNm220lUYJZRYulsUNhCpaZpomwKLTb4JSrH
         0i4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=s/pYd60673XmALbZbXJYTCn4CyznjWkLxHnWEBvOOaI=;
        b=Lyilk+W3/ysAKgw3648qzxRTqfXKAZeJFFUihwRyMhw1V6XTeYUdjQHlRr3aPW+ZdP
         IN9bZJEAIpUfmR/rAdxcziMxYpTLXtLQvyRfDb9CXC6mKzNo6i56mj2s6eZ69szwxll2
         /fe6DUH9u4w5oflLpHSxzspSGT0I7MHGFY5JtWRBrtgez33YTcnlq9AIgdorcXcxqH9B
         c45twDuog1rXxcjhc8xwG3pbP52kmkpSYJL1ZywL6vqGkXyxd5bsh3auQztnWNJfai50
         fu8xW8tHubSxQKq2mvNfhlEw5L1JLEz8q3FJ5pWO32IhSH2CcLtQ8t1kazOZP6JJrSJ8
         exxA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Radhakrishna Sripada <radhakrishna.sripada@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Kai Heng Feng <kai.heng.feng@canonical.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 4.15 108/168] drm/i915/cnp: Properly handle VBT ddc pin out of bounds.
Date: Wed, 11 Apr 2018 00:24:10 +0200
Message-Id: <20180410212804.844814404@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212800.144079021@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1597400091205347540?=
X-GMAIL-MSGID: =?utf-8?q?1597400091205347540?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rodrigo Vivi <rodrigo.vivi@intel.com>

commit 6e3322c226f15bc1838007f5a75566f1482b8e40 upstream.

If the table result is out of bounds on the array map
there is something really wrong with VBT pin so we don't
return that vbt_pin, but only return 0 instead.

This basically reverts commit 'a8e6f3888b05 ("drm/i915/cnp:
Ignore VBT request for know invalid DDC pin.")'

Also this properly fixes commit 9c3b2689d01f ("drm/i915/cnl:
Map VBT DDC Pin to BSpec DDC Pin.")

v2: Do in a way that we don't break other platforms. (Jani)

v3: Keep debug message (Jani)

v4: Don't mess with 0 mapping was noticed by Jani and
    addressed with a simple solution suggested by Lucas
    that makes this even simpler.

Fixes: a8e6f3888b05 ("drm/i915/cnp: Ignore VBT request for know invalid DDC pin.")
Fixes: 9c3b2689d01f ("drm/i915/cnl: Map VBT DDC Pin to BSpec DDC Pin.")
Cc: Radhakrishna Sripada <radhakrishna.sripada@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Suggested-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180125222524.22059-1-rodrigo.vivi@intel.com
(cherry picked from commit 3393ce1ed8fc43dbdb83952facaf04e644ca1d54)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/i915/intel_bios.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/intel_bios.c
+++ b/drivers/gpu/drm/i915/intel_bios.c
@@ -1107,6 +1107,7 @@ static void sanitize_aux_ch(struct drm_i
 }
 
 static const u8 cnp_ddc_pin_map[] = {
+	[0] = 0, /* N/A */
 	[DDC_BUS_DDI_B] = GMBUS_PIN_1_BXT,
 	[DDC_BUS_DDI_C] = GMBUS_PIN_2_BXT,
 	[DDC_BUS_DDI_D] = GMBUS_PIN_4_CNP, /* sic */
@@ -1116,9 +1117,9 @@ static const u8 cnp_ddc_pin_map[] = {
 static u8 map_ddc_pin(struct drm_i915_private *dev_priv, u8 vbt_pin)
 {
 	if (HAS_PCH_CNP(dev_priv)) {
-		if (vbt_pin > 0 && vbt_pin < ARRAY_SIZE(cnp_ddc_pin_map))
+		if (vbt_pin < ARRAY_SIZE(cnp_ddc_pin_map)) {
 			return cnp_ddc_pin_map[vbt_pin];
-		if (vbt_pin > GMBUS_PIN_4_CNP) {
+		} else {
 			DRM_DEBUG_KMS("Ignoring alternate pin: VBT claims DDC pin %d, which is not valid for this platform\n", vbt_pin);
 			return 0;
 		}
