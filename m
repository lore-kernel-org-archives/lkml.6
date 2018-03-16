Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtkFUgZVeCkuN+/BLOXd7nOUAHSFRnH36zcsv/9NWwcfWrNk5thtfItAUOvbFQWbo+nlcLP
ARC-Seal: i=1; a=rsa-sha256; t=1521215076; cv=none;
        d=google.com; s=arc-20160816;
        b=gSQjkZIMj4SRrWegwlZu+q5mAiSELxWR8gVnN+TF/KNPTbRYOUVfrjNz2PuDdiDUrb
         l4gjRawI5HHgWAgGb6LxlEM8Jtx/RD+PSK0wENy1TPndLVzlsdHUCgIC0SuqavM3C0u+
         G2g8+gqQvraJ7GFN9TW7UjnIW041Mjtg1WJjAfnw/pm735pIWvBkFmFbx5OJVBQEgwSE
         mIclmjvnyYFlLWp/i663Exix6V9iSbGn9WzAskn/MstjQjVy/Ge8BDgibIHi5XMIjbYt
         nVxOwbEf6mxYeKNgb21v2oI0+NuTSOSZ1qvVD5mb22dcg9ZXfakLv7QbghQQVQYhnzZk
         ZtEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aCbcuSd3FF1XBC3lX1XFfDel/Z9ZsHzj8Pw77uff2co=;
        b=eiCP5RQQ1TV1NA+5+Wx7N7vzQxTR1D+hUsU7ilN+fcPs4NrnU+G74sttaPNLdGdHJX
         v2a0QgileM3U2dNNqLqQZKIT3tTLc/tv+rUzIQBPdo4/npCycRImQRkA+zNasw2YRqQO
         tKopuHSkcjvun9QeU9KDddgBScT4npDTZXsgK1s4VVsFXclOa+nKqv9YoPbUZYeDcAKW
         TtXp5vLTbdrLlLSMNClZgpiTEQvJUOoxYKomGJfN+DYrLMceBOtoQTBZOdGL0ZkE38ff
         ozr6BeafITozjYDMt4DKyA0ShzqA4QhIDs/gnk0pn/nsj/A8eX3mcOSdrHP2xFLxO3dp
         hSbw==
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
Subject: [PATCH 4.15 084/128] drm/sun4i: Fix format mask in DE2 driver
Date: Fri, 16 Mar 2018 16:23:45 +0100
Message-Id: <20180316152340.798397223@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109247265959839?=
X-GMAIL-MSGID: =?utf-8?q?1595109620833118150?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
