Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226YICg2GaGHrwTnyno6HIrla/+Qmq72spuJXpriNERv+0Huc3SAiIbFMeva6gMjj/ITHWDV
ARC-Seal: i=1; a=rsa-sha256; t=1519676739; cv=none;
        d=google.com; s=arc-20160816;
        b=D/tMTjKzt7tiyfJWPnP0lkWAnC61/dtpPoTpR/LpajixCFvaIuoraQTjj4H3JSi+0X
         oWTojhCpbqYk02+2Gj6e2suL4mEOUSqCyI/CH+NS3XwiBD/AZNMHLYZCv/wDt0mx3NyY
         Ch5u81wbvNe5sSf09FSBlEbx4YXizRnumcq+esjYypf5LdsXsV0v/iXJdSmyNT09BiUp
         bY2Au6k2COQdZyVq4P78cFFowESfy7hOyR2yZtZI566R+Ur+e/KtoKR35lr5LERsnKBk
         yslDW8Bg6fkuNHZkDgJDN3DXybHb4YJYOLf+NUE4nH5oCAxUF0GbWWHo3bUDQ1YmYBKg
         039A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Kh7NwfCa3y8l0tm4b1wFrenxK4HXZTpO+1aQPDXPaMs=;
        b=aJPICg6B7xsS3aop7Vrylk/x3qnUY80+aTtrUb5qNpEEm+aOCBLqs16agNcOwJsEhY
         c6NdLr0sA/0IJstGoLxizWlCoGkLq28ha1BLq5ODTkmweBxye8NVIUAipnZNtx5wieH+
         F/rh6xIPnNq/CagtEOehp4mgc4i4yxv/aJdzqX8FJkLdmPfpTO3Q22bvRrj4Xr+v1y9v
         MXPW7yQrPtBeeW0iZn9M+zmr6vVB2ygvmF5LwtYWqJDCzrwBdQ7/e2Qz6BSHDDZAmLNR
         UXtwN8LdKWTowpsxevYIKDi5OaBkvltzep0B06VvStvQuS2U2z6FAr5EJEceWcuRhj+L
         vy1A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 83.175.124.243 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Mario Kleiner <mario.kleiner.de@gmail.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 4.14 37/54] drm/edid: Add 6 bpc quirk for CPT panel in Asus UX303LA
Date: Mon, 26 Feb 2018 21:22:14 +0100
Message-Id: <20180226202146.219733350@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226202144.375869933@linuxfoundation.org>
References: <20180226202144.375869933@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496004383920080?=
X-GMAIL-MSGID: =?utf-8?q?1593496557061460390?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 06998a756a3865817b87a129a7e5d5bb66dc1ec3 upstream.

Similar to commit e10aec652f31 ("drm/edid: Add 6 bpc quirk for display
AEO model 0."), the EDID reports "DFP 1.x compliant TMDS" but it support
6bpc instead of 8 bpc.

Hence, use 6 bpc quirk for this panel.

Fixes: 196f954e2509 ("drm/i915/dp: Revert "drm/i915/dp: fall back to 18 bpp when sink capability is unknown"")
BugLink: https://bugs.launchpad.net/bugs/1749420
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Reviewed-by: Mario Kleiner <mario.kleiner.de@gmail.com>
Cc: <stable@vger.kernel.org> # v4.8+
Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20180218085359.7817-1-kai.heng.feng@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/drm_edid.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -111,6 +111,9 @@ static const struct edid_quirk {
 	/* AEO model 0 reports 8 bpc, but is a 6 bpc panel */
 	{ "AEO", 0, EDID_QUIRK_FORCE_6BPC },
 
+	/* CPT panel of Asus UX303LA reports 8 bpc, but is a 6 bpc panel */
+	{ "CPT", 0x17df, EDID_QUIRK_FORCE_6BPC },
+
 	/* Belinea 10 15 55 */
 	{ "MAX", 1516, EDID_QUIRK_PREFER_LARGE_60 },
 	{ "MAX", 0x77e, EDID_QUIRK_PREFER_LARGE_60 },
