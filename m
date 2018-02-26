Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsJrIcW3YrAKDH8oHs+ZqBdmmV1IXZcygj566jfXX8NMKDDgYdl0BclY0VkEj8abqFN0d1l
ARC-Seal: i=1; a=rsa-sha256; t=1519676494; cv=none;
        d=google.com; s=arc-20160816;
        b=nu6YiEizziCNCuHIWVbQLckAIjz7NASfBEfN7P1bisz6cBW6r+7PKrehqG2IzLmfE8
         MzLLKeQSovVP9t7/R1P5GKU/8t/+1mifJ+K50ntunp2PxIRsQD0zSZOJhrzpVp4f962G
         eyYyKiphjNDjRxDzaccXmcXj/gIfD2rFW0O7zCvkIHkiMLc/GId7Xf9eH2UUvpnE2/Tn
         ib3Chs6U+CtC3cF9YRwh96hquYOAsVnLK+LXYceYwOVYFzLFZGmNmsltPEOWSySgB5+6
         cUkarvMXiXNNWUqINeEGEj3IphDDzh6T3ZRyVFFsJOM+u8/UNzsk2S8rRLXSZTKkjHHV
         ed7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aalfLn3YzfLAZN3gX8Dgk1D9ooRSHQXhv2eCzLqi02Q=;
        b=XmtbXTgmrvB3ICyJBHWoYXAwYqC0W4KgPyO8BvhUsQbN1Nki/Yf82HbgVy1ooRQRC6
         wjxCVoFdMDquyQd/UwUzGBXgHKiiFo1nbCzu2/1gtVNktHdxVYcRnvmRC/+s2v9BBAvn
         MAAQollath88qlJFU4Z273QPUvplIYy/MoOJQXQ8uPhrAglBbKsC9ZMU6gMmoWRAG+b0
         +d3XcoLA/jOmN8fhZX2/ex2yaQByNMX1NM5khINrKaaebFjMO2B/B2uOL0hPfQgs8g7b
         1bJ8EWHWYlwjiHIa8XSGXXztxP5A854Q1m+eHhMdf/LgnS5VF42TNFEXODdX4L+hCpKh
         0C/w==
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
Subject: [PATCH 4.9 17/39] drm/edid: Add 6 bpc quirk for CPT panel in Asus UX303LA
Date: Mon, 26 Feb 2018 21:20:38 +0100
Message-Id: <20180226201644.438807933@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201643.660109883@linuxfoundation.org>
References: <20180226201643.660109883@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496004383920080?=
X-GMAIL-MSGID: =?utf-8?q?1593496300416085443?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -107,6 +107,9 @@ static const struct edid_quirk {
 	/* AEO model 0 reports 8 bpc, but is a 6 bpc panel */
 	{ "AEO", 0, EDID_QUIRK_FORCE_6BPC },
 
+	/* CPT panel of Asus UX303LA reports 8 bpc, but is a 6 bpc panel */
+	{ "CPT", 0x17df, EDID_QUIRK_FORCE_6BPC },
+
 	/* Belinea 10 15 55 */
 	{ "MAX", 1516, EDID_QUIRK_PREFER_LARGE_60 },
 	{ "MAX", 0x77e, EDID_QUIRK_PREFER_LARGE_60 },
