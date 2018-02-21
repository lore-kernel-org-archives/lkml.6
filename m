Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x22570JZ2aBQGeT4M3AagRKOpY4VGGUcG+g6zFO3NyiPRAdhBHYYsmoFMQeQSOguuGubVEU8G
ARC-Seal: i=1; a=rsa-sha256; t=1519218259; cv=none;
        d=google.com; s=arc-20160816;
        b=bnrw+dUz2EATHmJKR2UUyvKX5JUCkHfEHmhi/1qXLwknBQF9SDCfwSOJbbUGD9kakW
         YJLHdIl54M1T8x+m67iJldK5eNzsbsEHmWvNyEKcKXYdr93JeSQAkLM9vmOTvqv5AYOn
         d5/fIP22hPuPKZujiuwnbPUfxZhhsI8/R5GEwPicJ7pCu+7lVqCQe/YY8hP95z5rf2oL
         9Ex3l08HbhTEWxKiav2CFIKbhEwDQxA8gG5JhIKQv02cTZzoVevueAipzFpkMLhgpt+U
         nelq06b8ON2Qf6UpbHSp4MsXFvlqsx8mt5bT7LkBkIjIZpqXCMkxeuyN+vKvCUmYrfKG
         GA5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1I6Sj+eIkTFLpq1GnHDnbiBNH7TspVkzapaC+MPP6W4=;
        b=kKc6mHAXnPbxfaCo06xayS8ndhmjtAJPHoVWzR7qIXN8IUIyQmKjkXevBcEJe4NOZ3
         J6sYiVTATC42opcJ+53jMAGg2KnJj6UJ1pJD+ye3qaxxRAtGVaSAYD8yCqGmrkHNeHAV
         VMq/OJdK9iBg8oyMBvYum1fxC8OU/iHnVlBRP57G5sCw4ZIUEquZuoKAmoZDI1RdDvYF
         Ca4d+fkdOqGtvI9ut16JTHvGhYvma4uZZqyM5+bnspjtNUpKINLrK18rc7pAYf/KX59L
         GKnfSgvBPV2czNJ0VaVm14n8TpYXMwpy9AvPxknnUvfL0++6TktM4Za9845LYfsZ/I2O
         Uhew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hui Wang <hui.wang@canonical.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 142/167] ALSA: hda - Fix headset mic detection problem for two Dell machines
Date: Wed, 21 Feb 2018 13:49:13 +0100
Message-Id: <20180221124532.502927904@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014646341023518?=
X-GMAIL-MSGID: =?utf-8?q?1593015806107197220?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hui Wang <hui.wang@canonical.com>

commit 3f2f7c553d077be6a30cb96b2976a2c940bf5335 upstream.

One of them has the codec of alc256 and the other one has the codec
of alc289.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6585,6 +6585,11 @@ static const struct snd_hda_pin_quirk al
 		{0x14, 0x90170110},
 		{0x21, 0x02211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x90a60130},
+		{0x14, 0x90170110},
+		{0x14, 0x01011020},
+		{0x21, 0x0221101f}),
+	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC256_STANDARD_PINS),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1043, "ASUS", ALC256_FIXUP_ASUS_MIC,
 		{0x14, 0x90170110},
@@ -6653,6 +6658,10 @@ static const struct snd_hda_pin_quirk al
 		{0x12, 0x90a60120},
 		{0x14, 0x90170110},
 		{0x21, 0x0321101f}),
+	SND_HDA_PIN_QUIRK(0x10ec0289, 0x1028, "Dell", ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0xb7a60130},
+		{0x14, 0x90170110},
+		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0290, 0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1,
 		ALC290_STANDARD_PINS,
 		{0x15, 0x04211040},
