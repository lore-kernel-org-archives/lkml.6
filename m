Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpQjauPo1zT4DxSu+ddzXkFNjSn9OzYgD0Sr+SYU6LBRaRjyTM3U7FPZRWjWl1v8qNZaHj5
ARC-Seal: i=1; a=rsa-sha256; t=1525116385; cv=none;
        d=google.com; s=arc-20160816;
        b=AqrFghR7xGihGjw2H4paSr2RYBcdblCu5danecKLfyeqi5ZcfDjRqfxEZwDaq64JmG
         EyixoeLe5QqzU1kV9LSDGcPXEqyFYH6Y30W1jI9uuTDU/adOunjz8IeJle5yMwc6prVQ
         7kog8ZAVqbYWR6KJfa0s2TFr6/perIIgh2LwM5OcOSQXTUGLQfNThWap/eFSz6w4TWg6
         8VLs/l3xY0KyLAePD6B7VJcHgLGv+ERZi7OO4fygeKjPc4lyxqXJcfCbaO3WZnXNIG9L
         122Y56udWvl4bwivc+y/8GcwJ3P35bb19n0HFh6IMmgCRUD+B/+r4SN2/uT/XNVsxeHB
         4wxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=uGdC7LIZ3y7+CS+VxJQ/Fw2uX4f2MfcgZtnC3BM8lVI=;
        b=YtqirWo65JiAqwcZjnGTuqiGLb8BqEGEiyFNzI70kc1F0GCCmh2SmgglCryPW2EPmN
         9dZZsiZBzGVKXMnPl20qoJDdPcR8EMs6ondEBaOJIReGPHJZhE6MEXLkG6c5EpqV3EOV
         B6yPG/si2ijG073XVlCjWeG6aHstaDxJQKZtJ7R528STsarkUxqZwOpehG5uv+Y3qbJp
         xqLIN90tJumh1T5tUtfjgTwLXmwCNB7jmcIceMpoQiCVF/rHjqIrRKrxlwn93loVM8fs
         yBjZKqDoJGFaKb4IkEwwsXCPikkl6qui6l4wigrVuMDlRLyu+l+k5jnf6W3txpPQrtys
         L27A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFDA22DCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 24/61] ALSA: dice: fix OUI for TC group
Date: Mon, 30 Apr 2018 12:24:27 -0700
Message-Id: <20180430183953.343122494@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430183951.312721450@linuxfoundation.org>
References: <20180430183951.312721450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200511040409140?=
X-GMAIL-MSGID: =?utf-8?q?1599200439268500789?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
