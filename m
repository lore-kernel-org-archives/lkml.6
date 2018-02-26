Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225MYYnR4qdmCiuxB1KO1lgxNymMxLwD0sIxrCxeAA5Jlx+efsIl5WWdD2v7fn4sJh7IkXLM
ARC-Seal: i=1; a=rsa-sha256; t=1519676212; cv=none;
        d=google.com; s=arc-20160816;
        b=U4SR6RwE/n7Zj0C65QZEVXwffKwVe+trx0xSCDm0Pl6qNctCYarLXOctJJIgnw58rz
         GyzbHLEnaFl1UiDuJzWzPvTzGAVPO8C9IdCOQI8KiUAxDREpuooYKsqd7/4ly3ZR8QF+
         Z8pTiBSPT24A34HDc9wJkObg+vwCscdClpQxp/Dfy2yMEnoZK6EoI5kgPNrCQdru9VAp
         Y1d6ZYhR7d3w79QvT4JW/WdqNlUL6+lhR46+QqPhWO1FKyuCjj2SaIfO03S+lJqTnT2z
         Uj3j3bf8QQZLIpNPm+teuDIpxjcgPMpnP7fDZs4tJ2tVUWDwxtHU/R1dVRhLaJeaAR5R
         Y9AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=VCMkkYdk4QFdf3e+xR7sCUoBAcOnbJO4HRr6Ad0nys8=;
        b=skaGDV24QKtHk/Bpn1gRgCoZu/bZRtAjyL71NzsmfeHot2PMOgFqISPrLPrkAe/OOy
         ZvGpGQcqcnQ44QUiltcLayt+KZQeIfZnGB1lSFAN0gdlXTqjEPoJ1/JIQ1qhoNMLc/cl
         8F++RCpno3qF480ppjXeVKB7YA8YSeqVAuwLCFojdKNo2MTnvr9jbBIp3FBW5p4x8b+0
         2smmQwtnRKWt0dQYQICn910hdRSuxE70TPINWSK4qEf5Qd03V1TZdh6SmRLzU1646ItS
         +ppahXVwAmGBJxEfY3zmLJudvXUrxdbCR94KNNOMCdbF3hLfLxZwfBri7QT3lHtXwYGB
         wMpg==
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
Subject: [PATCH 4.4 16/22] drm/edid: Add 6 bpc quirk for CPT panel in Asus UX303LA
Date: Mon, 26 Feb 2018 21:16:16 +0100
Message-Id: <20180226201559.436941282@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593496004383920080?=
X-GMAIL-MSGID: =?utf-8?q?1593496004383920080?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -106,6 +106,9 @@ static struct edid_quirk {
 	/* AEO model 0 reports 8 bpc, but is a 6 bpc panel */
 	{ "AEO", 0, EDID_QUIRK_FORCE_6BPC },
 
+	/* CPT panel of Asus UX303LA reports 8 bpc, but is a 6 bpc panel */
+	{ "CPT", 0x17df, EDID_QUIRK_FORCE_6BPC },
+
 	/* Belinea 10 15 55 */
 	{ "MAX", 1516, EDID_QUIRK_PREFER_LARGE_60 },
 	{ "MAX", 0x77e, EDID_QUIRK_PREFER_LARGE_60 },
