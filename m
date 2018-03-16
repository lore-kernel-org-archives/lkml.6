Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv8wf7cF9LvZ8efQC8ntfCr58XAez02meaYqWYFM+gznccNYgqETPG5F+vVPv/jppE9oahD
ARC-Seal: i=1; a=rsa-sha256; t=1521214720; cv=none;
        d=google.com; s=arc-20160816;
        b=QbLOVW9z45dcJ1dTGEC3FshV3xK/XJASiAc+MMfr2Vty97h+1L9aaK7Knh8UPKK0Tj
         CdSOrZkYt2QJcM5t3IjxuWjeC+IIuAz7Y2AjDnSxaJo6JALANePrflOdDnQs6cpLFA/R
         uxh4HreTHM5ddVtGq/t60bn7yIrOSeRxI24+GVIYRpouYjxJjE4kEXBTR8wzdHAM4mFz
         6U5hGuqHT4scjrebyF0vhQ5DyywCZkd1D1DlDDCDJgEbcxhtBpdUlSph3c2MpPbb6oec
         JRhEYA5bMdEvAsQgUFWxQgBjKBkWa61ZYU+2scY6gmPVmUfk6yNOPifC2flyDgjtsaZ1
         /dAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=cUg+Q0zM/6rXrb7IY13yRat96mG0qqe17Eehq1p4ZbA=;
        b=HWfbLHrSCgyB/9OWUkyYnYYigWCxe2tO6GjsIqwFcCYZmYwFwRjT1HTOV862jz20Du
         rLJtg1rRbAsggur+zvNo+O7Zk/bEAsVD++XZjrD8PY3xmus/RwvQaB+LUW12MI+ueutr
         aCph7LDrwqPvlaHjZ+leEzRRYtZKEM1R+cwqIW+yf2TangGh+Q0zg4PNJ6A/5dqdT1Wi
         kSXlJr52QKNpBI81bysUmowFKksEZvmHavYmYE0IZ3BlEJoNc6IpEdDOc0VMbEvlMZpt
         o3ju8MkT4566RoP5fuLlDW3AOvx18e8ts7nRemLA9OGxKQKApaHKClibuzOHVOXOIsFD
         6Gwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@siol.net>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 069/109] drm/sun4i: Fix format mask in DE2 driver
Date: Fri, 16 Mar 2018 16:23:38 +0100
Message-Id: <20180316152333.745406171@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109247265959839?=
X-GMAIL-MSGID: =?utf-8?q?1595109247265959839?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jernej Skrabec <jernej.skrabec@siol.net>


[ Upstream commit a2407f4bd1f3001d6b46f6d32eb1cc98a60f5a43 ]

Format mask is one bit too short. Fix it.

Fixes: 9d75b8c0b999 (drm/sun4i: add support for Allwinner DE2 mixers)

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20171201060550.10392-2-jernej.skrabec@siol.net
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/sun4i/sun8i_mixer.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
@@ -80,7 +80,7 @@
 
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_EN		BIT(0)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_MASK	GENMASK(2, 1)
-#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK	GENMASK(11, 8)
+#define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_MASK	GENMASK(12, 8)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MASK	GENMASK(31, 24)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_MODE_DEF	(1 << 1)
 #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_ARGB8888	(0 << 8)
