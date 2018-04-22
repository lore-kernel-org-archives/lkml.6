Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49js29QnGt8GShSHWZpH7iiZu5ckgkcrEIEKwEFcF2J21iWvxHclRkDpaiL9n76FBEMyTnZ
ARC-Seal: i=1; a=rsa-sha256; t=1524405795; cv=none;
        d=google.com; s=arc-20160816;
        b=ayl/ZdOSgmPUGvllIBsRc0eXdpdI/cgmeVwyqPR/g2naXaiefBnRq11+O4gqNfSlT1
         MfbLyxcKRF1xcIb4XNCEYfEpGAozjqGaroAS2nEpqGLqLcTHsrfqF+p7JGp/o6vULv2L
         4L6rf0a0bxQm2gK8Ww2nSow/soh+pplIek6pICZ9nVA3X4N1YN+/2++4ZLcVpoZmRHgj
         JIfafRy2MuU5cX7djZHYbsx1C9b9CHpck6YulAyrPhfBtT6G9N9Tmbwd0/pgAZN0zAZJ
         muRtgWysSF7y/xoA5OAgwWkfMPwcQ145tKcee3tmRdW66cWwh0xlCHBlrfTksx+1pzv6
         XFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PLJ6bQFx6+G0KOaMyccsySlukWNE/8qIWrF1JQRvKUU=;
        b=RHWsyeOoI226/DDk+i6stisXTpNYDt5lt6YtG8dcpvf0faO0eUJpIr6Hsk/xL5nI88
         9s9Z/LpDndN8E7Yt2KsBe+Mry4HlSrjeHo6r+lZ/O7WrXg66uedAXkeXL/gpT0VadXh9
         xDQaIML/Py9aYShWwgRLA9bVXjhWPkKDT5/J6lquhZaCTM4BePgRceROi2TNZdBM8Oji
         hdB1PAUxfBCuAeK+O3sv7Dl2mbRZhVYhXk1cos0VavlZTtOMIXgxXUP3tNBrvNIg7E/9
         TZp/XPIL/KHL79cQc0+zlVbqEIX9oYXnArHDhljm7TnZIp/CcuVceXnYKbyNl0CP2U+D
         c6Ow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hui Wang <hui.wang@canonical.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 162/196] ALSA: hda/realtek - adjust the location of one mic
Date: Sun, 22 Apr 2018 15:53:02 +0200
Message-Id: <20180422135112.605020129@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455330886007697?=
X-GMAIL-MSGID: =?utf-8?q?1598455330886007697?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hui Wang <hui.wang@canonical.com>

commit a3dafb2200bf3c13905a088e82ae11f1eb275a83 upstream.

There are two front mics on this machine, if we don't adjust the
location for one of them, they will have the same mixer name,
pulseaudio can't handle this situation.

After applying this FIXUP, they will have different mixer name,
then pulseaudio can handle them correctly.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6575,6 +6575,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
+	SND_PCI_QUIRK(0x17aa, 0x3138, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x17aa, 0x313c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x17aa, 0x3112, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
