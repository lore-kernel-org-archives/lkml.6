Return-Path: <pn@denx.de>
X-Google-Smtp-Source: AH8x226kTZGhVDPrqM/tPPoV66fRPAUMmoOBRgCLfAXLf01aRriBGp+79cuR56xna3XbTvx9AZui
ARC-Seal: i=1; a=rsa-sha256; t=1518686776; cv=none;
        d=google.com; s=arc-20160816;
        b=PV6NlzEqyzKKvkFdkS+rpvOTYZga6mwk2p4J25e5gZw2RPAFQyk/8wvKDEPNQEZsEo
         casnbCqGXDk9TBEkim/FgskKDyYSKxcTMSXvKEQkTyyfU5Gd6sp1azT1waGQk5Isw1YJ
         7/2xjYZGPcq6MFUOOlL8LKNKZ0l0ImErolv3FtTSuiQXYkVPYVWGQLx+TOkd1EY1UqFL
         XV25E0puVQNono+qQRZOPhB6a8AvnyWeIIUyN7PppY177OxobkdUJEw5zYyG5fEX0TwG
         CIw4qqyoXAp1MTa3k9UHgtO7W+IHlgERKPHWJo3TL953HC94JaxBAULvlJf/7aujCM7y
         /2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=2/SWMGJLP53fgwuJu5qO4Jbv/mz/xXKRTrvLFkz7to8=;
        b=EGLAqQ8rUZegbIGg6+Z7n+uj+24O+I+wMVfpKpsF3dWNFQD0W1njGgbwURWB4Rf/BZ
         Z1f2h4i8DsWmIGktt288hMiBDUCzE8p1yjT5zwFQnXupl6Lyt2kcUvi7JRqI36BYbdJD
         mvrynCvinZVNCSI0jccXW+TsXsjP6hej94zSMJLid0I3B7Aa78BQDWOpZYQAoaIofy1h
         SKsi+uA8YtW5crNxusv039aRRTOVcGJoPOe3rO7nmy51u5G8AVTeJy7yNYTuk9LvEaLh
         6MBNRKAqeM9OuW8OvnUqo0furFCANM+6ED2GAcHyI87jmCBKQmXUA8XVK3sUEIOt00Nl
         SFqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 212.18.0.9 is neither permitted nor denied by best guess record for domain of pn@denx.de) smtp.mailfrom=pn@denx.de
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 212.18.0.9 is neither permitted nor denied by best guess record for domain of pn@denx.de) smtp.mailfrom=pn@denx.de
X-Auth-Info: /cb8OYMVZ2cZpROjfLNH1pTUYyWGKgWJgyi54oGk3bU=
From: Parthiban Nallathambi <pn@denx.de>
To: slongerbeam@gmail.com
Cc: p.zabel@pengutronix.de,
	mchehab@kernel.org,
	gregkh@linuxfoundation.org,
	linux-media@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Parthiban Nallathambi <pn@denx.de>
Subject: [PATCH v2] media: imx: capture: reformat line to 80 chars or less
Date: Thu, 15 Feb 2018 10:25:45 +0100
Message-Id: <20180215092545.25475-1-pn@denx.de>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <ee47261e-aa6d-150f-e7f0-b80c74fdec1d@gmail.com>
References: <ee47261e-aa6d-150f-e7f0-b80c74fdec1d@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592458505557415299?=
X-GMAIL-MSGID: =?utf-8?q?1592458505557415299?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is a cleanup patch to fix line length issue found
by checkpatch.pl script.

In this patch, line 144 have been wrapped.

Signed-off-by: Parthiban Nallathambi <pn@denx.de>
---
Changes in v2:
- Changed commit message

 drivers/staging/media/imx/imx-media-capture.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/imx/imx-media-capture.c b/drivers/staging/media/imx/imx-media-capture.c
index 576bdc7e9c42..0ccabe04b0e1 100644
--- a/drivers/staging/media/imx/imx-media-capture.c
+++ b/drivers/staging/media/imx/imx-media-capture.c
@@ -141,7 +141,8 @@ static int capture_enum_frameintervals(struct file *file, void *fh,
 
 	fie.code = cc->codes[0];
 
-	ret = v4l2_subdev_call(priv->src_sd, pad, enum_frame_interval, NULL, &fie);
+	ret = v4l2_subdev_call(priv->src_sd, pad, enum_frame_interval,
+			       NULL, &fie);
 	if (ret)
 		return ret;
 
-- 
2.14.3
