Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x227rgefGxHm1cFeoEsIgScsIQpoQB7PoTMzyRSRNWLcCv/8f2EPjRZVJ2Pi4psTcBervf6lO
ARC-Seal: i=1; a=rsa-sha256; t=1519218733; cv=none;
        d=google.com; s=arc-20160816;
        b=Kuphxqfh5ezXVERMagK/H7ykClqfVCDWIymPQEr2gRBA4JczbQ8+N0VcY5rvhrFu80
         oXop9fTKZE9rcmvMresLZ81eW4tWTe3433+yqwqBaOeDPnft4ngQxLA143xXqM95qtLn
         3lANlU6KNfNxbG4VGjnkTU5yZiZ9kkFxGoWEyVcYKEeBXyeY/ngfANiLM37AXVIKgwVg
         t98Gw1l5i3PSh9gm9sRT/pi1eBxIlzRA+4x3+47axqaC+jNoN9fwybzZK3UO/6+IrReg
         dvQwbttqXsrz/9S7IkyCfrA2Q5HMLTXuozW7AKd0FSHFPudZ1ybjR9JHqNtX6SuMO7/R
         wkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Zm91muuyVckCZIfPDMEuuuNkSjxTjWTuLGO2+662OIs=;
        b=qHR3Swm+riaBzPfLjQlpCjJjqxwKsRviDRa6NV+H4TW9L8FCcDD/7Vlnc873977yKG
         vI/hDHRjoDsKnteVr/OiY1e/dr95Tn7027tP07w8SZ3q8Tqe5CAuVcOrA/Vu4i7F3xE2
         FtYCDXNLN71IsxaO8crpKnKv5fBCtzCdzh2jhQsN1xreSalxU9rzmxdmJ5C7iis5qfGX
         /vXWfL750UIaHYHX7hvOvLC7KPmxc5pXJ7Xo7/9M5a5B7MEV/v8e/sau9MeQFA0ZnVMh
         N/3TdvqPj5dgN6SLQweEOjlCIZlodF7aFYdWlfuQ/5ckYfsioHe2aayKXyXN6f+BV+XI
         rmXQ==
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
Subject: [PATCH 4.15 145/163] ALSA: hda/realtek - Add headset mode support for Dell laptop
Date: Wed, 21 Feb 2018 13:49:34 +0100
Message-Id: <20180221124538.104075697@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015829281437815?=
X-GMAIL-MSGID: =?utf-8?q?1593016302441522954?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6199,6 +6199,8 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1028, 0x075d, "Dell AIO", ALC298_FIXUP_SPK_VOLUME),
 	SND_PCI_QUIRK(0x1028, 0x0798, "Dell Inspiron 17 7000 Gaming", ALC256_FIXUP_DELL_INSPIRON_7559_SUBWOOFER),
 	SND_PCI_QUIRK(0x1028, 0x082a, "Dell XPS 13 9360", ALC256_FIXUP_DELL_XPS_13_HEADPHONE_NOISE),
+	SND_PCI_QUIRK(0x1028, 0x084b, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
+	SND_PCI_QUIRK(0x1028, 0x084e, "Dell", ALC274_FIXUP_DELL_AIO_LINEOUT_VERB),
 	SND_PCI_QUIRK(0x1028, 0x164a, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x164b, "Dell", ALC293_FIXUP_DELL1_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x1586, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC2),
