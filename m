Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227kBotlsYiZGBHOWjo1rGZ/CLJ8tipRXcQcBary09D3K2GOVP9sUW9O2az9gVd3DDhL1NZZ
ARC-Seal: i=1; a=rsa-sha256; t=1519411326; cv=none;
        d=google.com; s=arc-20160816;
        b=xjwRAzp4RWL7Ok2l9bgvHRm25BRm+GQTaFYVJoI9+bSUGljIIJ9A1OK+KJBeSA2hvl
         PRY/9vCTmm5+soSzsCHUzDpGWro7KDQFdiSPUykRLOXU1h/rUtnAQilJGggAZSge79Jb
         9iHsyz3G+v/WjZLnxofURYr9hASfEbW9suuG4PjqLq2ivlExucJaYB/d4mx8J4FKVwJ5
         IKze8Ob9hjfYklk+7c7rQJRJFX0CGW3ACI18od+YIkvZ63wmm/00y0XwormtnRxVcCoZ
         B89lm5OZyJMmVYAVUPIyKroCvLG948EGR53Jzu8b65xDjgGn46KZKq/SLJfYCDMCVGsG
         LUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GfzL3acHzTqGXjhDODh1xSqhlllYf/lDZobwt/V2FCo=;
        b=Tfc+d6uT8WI/82fj5P9zWyssVQqt+QmnGeniMjEFyaWu/wGhJoQrGEkJWQjKbCznXT
         2SIl0TMeY+3zTIOWst7mECMmjikWvc8wu8oMTbd+LklqU346EhpFOgmFUM7v+aNTc4Hg
         NvEBZdqZqcgC5LJmFZt6vSGI9edAfyuyUZKVP9IMat6tIGjp3KdBvhc4SOxjEFPegoAt
         KxPLFhV89yzxtnhnlLt3rI5EUYYmp1OQo3Mnw+8UT+S5wBmrwlZIV2ZtT9o1+NUjaBvH
         hASLDwX4T8/MdXPojiGEhEqCYB70e/KK5uHPtz77BJOksZewmRmin31g8TVe1M6SOEl5
         dJIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudip@vectorindia.org>,
	Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.4 162/193] drm/gma500: remove helper function
Date: Fri, 23 Feb 2018 19:26:35 +0100
Message-Id: <20180223170351.282987038@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
References: <20180223170325.997716448@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593218250534958900?=
X-GMAIL-MSGID: =?utf-8?q?1593218250534958900?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

commit db9b60400f9253c25ae639797df2d0ff7a35d9d8 upstream.

We were getting build warning about:
drivers/gpu/drm/gma500/mdfld_dsi_output.c:407:2: warning: initialization
	from incompatible pointer type

The callback to dpms was pointing to a helper function which had a
return type of void, whereas the callback should point to a function
which has a return type of int.
On closer look it turned out that we do not need the helper function
since if we call drm_helper_connector_dpms() directly, the first check
that drm_helper_connector_dpms() does is: if (mode == connector->dpms)

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
Link: http://patchwork.freedesktop.org/patch/msgid/1454393155-13142-1-git-send-email-sudipm.mukherjee@gmail.com
Acked-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
[arnd: rebased to 4.4]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/gma500/mdfld_dsi_output.c |   12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

--- a/drivers/gpu/drm/gma500/mdfld_dsi_output.c
+++ b/drivers/gpu/drm/gma500/mdfld_dsi_output.c
@@ -382,16 +382,6 @@ static int mdfld_dsi_connector_mode_vali
 	return MODE_OK;
 }
 
-static void mdfld_dsi_connector_dpms(struct drm_connector *connector, int mode)
-{
-	if (mode == connector->dpms)
-		return;
-
-	/*first, execute dpms*/
-
-	drm_helper_connector_dpms(connector, mode);
-}
-
 static struct drm_encoder *mdfld_dsi_connector_best_encoder(
 				struct drm_connector *connector)
 {
@@ -404,7 +394,7 @@ static struct drm_encoder *mdfld_dsi_con
 
 /*DSI connector funcs*/
 static const struct drm_connector_funcs mdfld_dsi_connector_funcs = {
-	.dpms = /*drm_helper_connector_dpms*/mdfld_dsi_connector_dpms,
+	.dpms = drm_helper_connector_dpms,
 	.save = mdfld_dsi_connector_save,
 	.restore = mdfld_dsi_connector_restore,
 	.detect = mdfld_dsi_connector_detect,
