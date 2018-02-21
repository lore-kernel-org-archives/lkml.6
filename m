Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226apKIBZ+Ldfs7o0x4bdiZEtbYEokByJat+4vojuNfvgWsoArb1eeXxCG7ziMscCxVQBxau
ARC-Seal: i=1; a=rsa-sha256; t=1519217705; cv=none;
        d=google.com; s=arc-20160816;
        b=TDxMsDyk8YHcw86pqsDVYSJu1QUpfOjaJu/2WkRgu9aIbB1TI/UKSVk/1xA/38RZ7V
         xASCdbv/IdOvH08OB5xbS3oB4aqv96h+SRHLcplx7GlyVHTJO5fKA/KZ13Qp2E+Q9cSh
         ku6teqfLuymVYxw0MTxuz6vsxW5IS9oLvUx1AiNN3rYYSy8KJ361FqFIgVOZXGRQNnmc
         jX5S2odr1qfzK5H8l0mxbqnt3dK/b/iHR8CBGyk/Bg9NWDDAK3TKaT40XBnOFVRCCXQz
         PiDA2K9jX03mNHaq5WeReLMJF+zbkHo4BjuOc7F+hmqjaBW95B2EP7AXV51IthwqKd5p
         GiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=G+janLEQLbvQSXwaE3dJw3EqMQYyAXqeEU+sLiWQQ/c=;
        b=CUWI5nTPXb2gwDH6mrHru4CbQmTS+7vc/O3LZLhMENVmT+v3MX+yRcQNtQ2c0dOrjX
         WBZWCQDJF/FNCYlVYUByZN+4Gd4H1Vk3pQ4ejvG2G4W7PcLSjV3xpnkEmGDc5DwJK3WZ
         T1Xk+mWoF/d7soKOyzDcRbUUfEP18ypikPwsmD4NApc8DjWbsobG5Wr5is11gj3HyxsD
         BbBv/M9bQePubuEN8MgTw0SjVAWNkWNr/cEF3Qv+BgeB/S7JZC4LV+6rnXmEqSK9CBfo
         W2xwB43YPO2iDL/TG5mtyX16474TAA8rXlsMqNGZRFIK+hIwejZSUSgKPClGUWJNMwed
         u5Lw==
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
Subject: [PATCH 4.9 25/77] ALSA: hda - Fix headset mic detection problem for two Dell machines
Date: Wed, 21 Feb 2018 13:48:34 +0100
Message-Id: <20180221124433.248953380@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014646341023518?=
X-GMAIL-MSGID: =?utf-8?q?1593015224849545068?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5994,6 +5994,11 @@ static const struct snd_hda_pin_quirk al
 		{0x14, 0x90170110},
 		{0x21, 0x02211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x90a60130},
+		{0x14, 0x90170110},
+		{0x14, 0x01011020},
+		{0x21, 0x0221101f}),
+	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC256_STANDARD_PINS),
 	SND_HDA_PIN_QUIRK(0x10ec0280, 0x103c, "HP", ALC280_FIXUP_HP_GPIO4,
 		{0x12, 0x90a60130},
@@ -6049,6 +6054,10 @@ static const struct snd_hda_pin_quirk al
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
