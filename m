Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225Hh/+N0GyvHrTazYDe/JxYH5dE7bcBQRgyAATU7WwBgFyMvUNLo6ud0sH8QW8X9HPDt+r1
ARC-Seal: i=1; a=rsa-sha256; t=1519218727; cv=none;
        d=google.com; s=arc-20160816;
        b=onOwxgK3T+bwrdMD4WvIkupfQwJbCIJH0FnU5zsrv23bblpWuu0MKbNGPFFe/MjebY
         2fgwOH6J8ibMH2XFcfmui85JZSV746JALdsFWf6J/Rg1I/4BxR7XTmL4s4BqB42e3Yvs
         J7IlAQabg9q79ZqGWceaSD1lMxsUX2V6MIbcDjtIwPG4p+/FdZyTzgoQjPLPZaYtDRbV
         ZAmGegpep9V4XhWJO/SwnaSEW7V+2GJaNDPDfNxezkAJ7tqLhtgiuoTAe+L1aR1utG02
         20+brnOX/iHxct+MrusIBhSbiabT6Rg1oniEwDOLuziZQwJi7RAEY9kgZbw3zC4TJhzl
         EfCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=rPJjBEo3oEAwtrS463PlIpEzTXA5NYrh0IYVUc120eg=;
        b=U+Mam6J+P74kl4Yynhmu4D3ut7903Nw9l1X4Q8s3yzQdpe9IoMBV1h6TgFpma5MFdr
         9wTAU+2KPjut6S6jntltE2AwxHLAfL7IphcWLZdZZekUdGSw/vJulg0iW75YX8GbACd4
         Ui8vhLWspKzEaDZzLiymKO+yu3Z4rn73bGXRmoGc1Cg4/xXPT4Bp8DLOvXaCBSVFLyVx
         Kgd6Rq5opyQjTHYL0YuyRA5VHiUcbMFgk6fBdYkuIqStmWL4iflRtzIkpQNJK2C2BGgI
         4/+qTRCxtSzrGW2UwLfxB53p6N8U8w1WMnW7ykd2940ndw2xPGC2QWK5yWb8eD7UsR9K
         XTiw==
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
Subject: [PATCH 4.15 143/163] ALSA: hda - Fix headset mic detection problem for two Dell machines
Date: Wed, 21 Feb 2018 13:49:32 +0100
Message-Id: <20180221124538.015670189@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014646341023518?=
X-GMAIL-MSGID: =?utf-8?q?1593016296765889527?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6613,6 +6613,11 @@ static const struct snd_hda_pin_quirk al
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
@@ -6681,6 +6686,10 @@ static const struct snd_hda_pin_quirk al
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
