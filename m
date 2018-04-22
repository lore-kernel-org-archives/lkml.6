Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49KpVFhJXVHVbVjcM+RdmC9jKQ/VyI30Jatyv5wTGZCiuMzKmEbAHukt2tJrVTFUUJBHO7W
ARC-Seal: i=1; a=rsa-sha256; t=1524406153; cv=none;
        d=google.com; s=arc-20160816;
        b=R3ZF5Cz0h/2aJu6IHfumkqVQn4FaXagT/r33HdKWZgDgDNYaAI747MzzG1AWxG/6fb
         6REi0+2sVVA0z0juSvMb22DexhT3at4eGyouilP8aJ8UUfaCvp8iUqjZ6WeaAq5xd5jy
         tkrV6j4auvocYBsQyj1R5pLS3Mp0cCc3g9MIWDXk4Si12tNcAGaXIBo++gjf3eAQgAkt
         LzZdBtVQMCz87D6D4kqgVud956GF7UbzthpR2GPeH23qxrI8yMYihN+VT9x8wOW7NC5y
         rvVvagPujF2s2Lw+JDctIEVLqJGTXVWMwjUcQ1bswxDtjNXuwg22jdDYoHd3A+qreMYS
         RWmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=R0k3C0mu+LHtcJ89ayJMz99SGJM2B2imhPzJfK3wINY=;
        b=t2Q4PHCzp6XEWeMrGZiNW7GwMDjqin64zhDBiqVgRRtFBf+YtaaJcQFnZI2Yzy+9fL
         eXLYQriMz44RTHUK9zJBs/qmyAG+jzBGR4OCmWy0maeIPejAIJ+F38WKnmhTvXir/EFW
         Lvcdr85ke3uDKhfWV2jrsK3V2GIbPdm8dW0bfNZC1cfVUCIhjqFvO/r0aqLjjizwSfTt
         ajurL8noE3fFIO6pyTPar5Clhv0UJMUA5I0EJr3+pYTIuyIMi05AUiC1l8QwN5ThCnVA
         u3bIY6kpCry0+Hdj7+qqC9G8zQpdgbgZ1EKZ4MXgQyNYUeMszMtAAHyFKyNCbpKja8j1
         7eIw==
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
Subject: [PATCH 4.14 132/164] ALSA: hda/realtek - adjust the location of one mic
Date: Sun, 22 Apr 2018 15:53:19 +0200
Message-Id: <20180422135140.786960825@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598455330886007697?=
X-GMAIL-MSGID: =?utf-8?q?1598455706612055150?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6430,6 +6430,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
+	SND_PCI_QUIRK(0x17aa, 0x3138, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x17aa, 0x313c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x17aa, 0x3112, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x3902, "Lenovo E50-80", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
