Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrOsrl8LZ9kquBCVzSSJ4MkrVLjpH5Ne0VCtcFjnxKAl685Bb9NuQItVSnI44ZXihDs3Y6k
ARC-Seal: i=1; a=rsa-sha256; t=1525116454; cv=none;
        d=google.com; s=arc-20160816;
        b=tAD9X1Oc3Qadd2ZpVeIt4veZD7C0DvOEJ+2CUnxSKr8OdjvZhzU1tIsl45iJ/F3Fc1
         x8AlhJYTI4xhHG1+cJbZXNfliqfFVUbNzL5EPotRQCMMbv6QXMdQKEcSuw9/j65Gvpld
         AUy/2A17Fy1iecH2TTXFidpdAqOAmjCnWqgFGWa0j2PYwNzSNTPAmbnx2nZ8rIR1pAjZ
         EI0EK9uxiYFQSEJpsXi6qG1yeiOj1FV8XLhkYp2e96rZHLV6V6XtfGDsNDX0dAm1MEc6
         e+HO0rD3z42sqzLB0QqYCdZlSy1Tz4vMhyFacfWcMNTw+Wtnr3yo3KoRe8NQlgZldYOk
         +G8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=NERrlFtl+J1pMK/4DJR5zwFTw7t9WCSd6V1+I2HR9k8=;
        b=jXcHL6CgWiFrxSz34PBKr1f/u38prxCalREpOBY3UBGhKnT8NFOCUH8Zd5g2YMFJ+g
         7YaSPWThkfGqzcApWfgXsOO9N8jB0OqOY+314x12XfD9ab/RMdbAdgMUIw287BeIriY4
         ncN0iNtxur0lLsjUQQ40ZRKHzSizD9XjFm0mcSkNwYZsXEzRJFDZ07zpK1v11PReOrU4
         537Uqa/TYF/Jj9ieE3lpnnecJZw4e+e8feHiR7+Tg25re/4M3semqDJyOmWJa2ZYDdkd
         05gEYsx4OVYK9S35jm9+RR5tGxYwu21yPK7MKC3jGawvSyKDmcuyoJIhiNvRRVDZIJZz
         5IRQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77DE422DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 34/91] ALSA: dice: fix OUI for TC group
Date: Mon, 30 Apr 2018 12:24:16 -0700
Message-Id: <20180430184005.954053971@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200511040409140?=
X-GMAIL-MSGID: =?utf-8?q?1599200511040409140?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

commit 10412c420af9ba1f3de8483a95d360e5eb5bfc84 upstream.

OUI for TC Electronic is 0x000166, for TC GROUP A/S. 0x001486 is for Echo
Digital Audio Corporation.

Fixes: 7cafc65b3aa1 ('ALSA: dice: force to add two pcm devices for listed models')
Cc: <stable@vger.kernel.org> # v4.6+
Reference: http://standards-oui.ieee.org/oui/oui.txt
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/firewire/dice/dice.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/firewire/dice/dice.c
+++ b/sound/firewire/dice/dice.c
@@ -14,7 +14,7 @@ MODULE_LICENSE("GPL v2");
 #define OUI_WEISS		0x001c6a
 #define OUI_LOUD		0x000ff2
 #define OUI_FOCUSRITE		0x00130e
-#define OUI_TCELECTRONIC	0x001486
+#define OUI_TCELECTRONIC	0x000166
 
 #define DICE_CATEGORY_ID	0x04
 #define WEISS_CATEGORY_ID	0x00
