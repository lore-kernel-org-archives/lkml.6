Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZrAiTrT499MsLx49j8VGBHKDctyHuT2raRsJIOv+AimyxYBMpmpFXgy1v3ohPsJW9afRDxR
ARC-Seal: i=1; a=rsa-sha256; t=1525116500; cv=none;
        d=google.com; s=arc-20160816;
        b=YwHhnabMCqqT/sZz0z7i6GDgp+CgAD+SrKsaZTP2mZ2rxnNEcRdqHKIrWmvx3jBjj2
         WmI5Dz9ffGKfo/FS5TCLB1Z4aPjvBscc/kt/WgY1n/IAJaoa00pud5QYSj5BQI7n42p9
         AOOziDf6monmOloEV6ROBHI3CeJGB2aSog3eM2lKP2SnvCP4QMntkRJHGGk6yxy1JQ2K
         K4SvtKDVmY9NKkFre3UeyipQv340HdKUQnkqN/gQDaPxtltJbYYwE46kHQOiFeBVsbvS
         1v4tcRnfsuge/pKZB5H7GN3L4TYar7uS8XfC5uqzQV4ffIM+Mjx4Bf6aOizbvdhaVzf0
         7Qiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=4lYZ8OGG/lk+dkyoLr2ItUDLEkaXLb213upie2qWBkU=;
        b=Yw5DTgZ6aV4CYvVGgEWkMZua5grHAwe3yH5SaC+QJ0LlMsa32N3yL/LTPR/nmdxKwG
         2ppP63r/nrYY1/6tV8h+O5AQD2U9dEApA6GwGfInQqqSLbE07OYTaqMn5PZDGjGYnXrH
         18pe5tv6fnuPnd4lMNWRWvaOltkFxVEfxR83gVdyVQWhyJdUW19u0dI5NaSmTJjXDwql
         4DngeGOw3uJhSqWwZYF9a4tGDDV7LdW5FkKeFNlMRj/gLY3pfEVGoT/YBvBf/5ZMHVI6
         hc8S+rTp5WrEXLsPOZ5lyuzCzUcFE9EEiHpnJRuix7yxPx5Df+uH+V6rzXyiVoiLPuL3
         yqLA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B58022DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 053/113] ALSA: hda/realtek - change the location for one of two front mics
Date: Mon, 30 Apr 2018 12:24:24 -0700
Message-Id: <20180430184017.304036621@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200496886897577?=
X-GMAIL-MSGID: =?utf-8?q?1599200559338811514?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit 65811834ba56e9ed88117cf6c09880416c9951ab upstream.

On this Lenovo ThinkCentre machine. There are two front mics,
we change the location for one of them.

Relation: f33f79f3d0e5 ("ALSA: hda/realtek - change the location for
one of two front microphones")

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6576,6 +6576,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
+	SND_PCI_QUIRK(0x17aa, 0x312f, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x17aa, 0x3138, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x17aa, 0x313c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x17aa, 0x3112, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
