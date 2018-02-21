Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226f3BBFh+AHUlXllBapXMEg6P6Z9+YYFyR2qKdN3uyBRdyRr0l1H/Ocp9Fb1Doc2gifsKE5
ARC-Seal: i=1; a=rsa-sha256; t=1519218282; cv=none;
        d=google.com; s=arc-20160816;
        b=R4Pjf6TCvp96XR0w22Rf1RKuP6JSYMOHPY3tGOgkHAWkw44HWlJc68nPt2GxVDBfwI
         3cYo9lFy/LrVxlzkIsKRIHYugqoX8dTTkUCDT+PVie7iY4/cCwmgfg1BbViyKxOW64a0
         /c8WaY+pFppukKDFT7be2WoL+K/u7aDTQAw0fYdQE3MZW0GRYUK5UXgAYZ25WL/zSheQ
         Mnf54ef5wOfmmiExEbYcuTrVwb1jSw/jeGlYAUBfMEjghaxl5emMnMvenycl1AAIFQBC
         uxfhBVFhWnKTx1ylY9/DGJ8hvsuI1FF22ni50nID96mfGBBu5wfl4f6kmoj0lTH1hj0m
         Q24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Gebkx9xG3ZA4X7v3NZc4K/GSWimp07t03B2EjR0gXBc=;
        b=Fgs5+N0lnebKkWIT5ncJwN0XWNYlQUvwg9SsUQXcvgXLHTLOoAqSTyu92sP5kjcS0b
         VAcyNA2+ZYVBDpLfzrmXz/9nEITC7q6mece2U7Tp49SjDDxQ7vfeIPX0sw4NsiQiFArN
         aCImVfJVjfau+yFNG6rBeSFLOZRnLf14lQx68hqxktg1wynVxK8WnFfqe3zlNrVVEQge
         bLkdLhP/rkqNFzvTtfAaHlrKEcbRuBt/K3ypnC1S/mtrEljEXIYErnSf0DVPNN7zMGgG
         Ygg+egK45HLaRn34R+JifGSkkH9y1w5eF3eJMztQA9aF8Z3tsAd0RT6sTFaXTT9T9b+U
         49IA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 144/167] ALSA: hda/realtek - Add headset mode support for Dell laptop
Date: Wed, 21 Feb 2018 13:49:15 +0100
Message-Id: <20180221124532.615259554@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015829281437815?=
X-GMAIL-MSGID: =?utf-8?q?1593015829281437815?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit 40e2c4e5a7efcd50983aacbddd3c617e776018bf upstream.

This platform had two Dmic and single Dmic.
This update was for single Dmic.

This commit was for two Dmic.

Fixes: 75ee94b20b46 ("ALSA: hda - fix headset mic problem for Dell machines...")
Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6176,6 +6176,8 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1028, 0x075d, "Dell AIO", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x1028, 0x0798, "Dell Inspiron 17 7000 Gaming", ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER),
 	SND_PCI_QUIRK(0x1028, 0x082a, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
+	SND_PCI_QUIRK(0x1028, 0x084b, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
+	SND_PCI_QUIRK(0x1028, 0x084e, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
