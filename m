Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvEgZ+cJ8EbEMeUex9nSOwaR334fMrW3xUe1lo3Lx0zwzaTdBVd3h+mwlJ8CIEM41wPMCRc
ARC-Seal: i=1; a=rsa-sha256; t=1520955138; cv=none;
        d=google.com; s=arc-20160816;
        b=KQllisSLTDfCKK2RKWqh/2GwcMrZA8xe/gAkUl9S/1Pr0E4bERvuDXF5IP4YnBqLMm
         tNCEPgH1KDLA+fP1B+LQ8XPvz7nULtUv+5oNR/Llxy7WnxyioM5H8ryRcPo/J9uAe7bX
         HXZTusCuytnylVrr/l0yJwjxvFH+F2bBu1icWMH3UbZk4DvHAL09MJiGrttfGvwvOud1
         lc3kdxvdKbH5q6mY1g+ETBDEsupzGQGmv88JrCTvVZ2LaGiCfcDC4hV9ajkSP+jqlFeI
         bENbDfm30vkB+WkABjDmvab8tHVwtT+f3K2i0Ns7NZJbdnSqklRexYjKHUuN3J1hCyB4
         z3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=0FR1m0He0nvGjpstbafmxWgmi5jTfBrlrthz5Wnx1fA=;
        b=rOcIHmdLL/Y9d83ecdWeu17eazcEbmk/Hfwikub65M8Rv2I2z5ti3lq289FplTaWIC
         9u+HFUlI/oHZqh7oUPL4QBbQnlbWlVNKUFwvkGarriIC0SquTsE9LdeBfKVGYM301s70
         CZ6pbJsTFUMoi6Y7xC0AtihHsGjpxuOIr8S5bPb6Y9250FSkLLNh8Wv5Ep8kmQ1IZkNE
         oFqFKMbx0cU2q1NAix/IWQWE43EGEGmQBtS/L7zLXAfVMSzUbS7v2eOfwPE4DsznktJx
         yQWZjgK72bBeA9tYaqXoKe3IsJuIJ3ynXUZ7JOZl2nmZvg5tmdSe8CwfutCfRUhCpcQp
         J/0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dennis Wassenberg <dennis.wassenberg@secunet.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 075/146] ALSA: hda: add dock and led support for HP ProBook 640 G2
Date: Tue, 13 Mar 2018 16:24:02 +0100
Message-Id: <20180313152326.531139258@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837055589542138?=
X-GMAIL-MSGID: =?utf-8?q?1594837055589542138?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dennis Wassenberg <dennis.wassenberg@secunet.com>

commit 099fd6ca0ad25bc19c5ade2ea4b25b8fadaa11b3 upstream.

This patch adds missing initialisation for HP 2013 UltraSlim Dock
Line-In/Out PINs and activates keyboard mute/micmute leds
for HP ProBook 640 G2

Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_conexant.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -958,6 +958,7 @@ static const struct snd_pci_quirk cxt506
 	SND_PCI_QUIRK(0x1025, 0x054f, "Acer Aspire 4830T", CXT_FIXUP_ASPIRE_DMIC),
 	SND_PCI_QUIRK(0x103c, 0x8079, "HP EliteBook 840 G3", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x807C, "HP EliteBook 820 G3", CXT_FIXUP_HP_DOCK),
+	SND_PCI_QUIRK(0x103c, 0x80FD, "HP ProBook 640 G2", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
 	SND_PCI_QUIRK(0x103c, 0x8115, "HP Z1 Gen3", CXT_FIXUP_HP_GATE_MIC),
 	SND_PCI_QUIRK(0x103c, 0x814f, "HP ZBook 15u G3", CXT_FIXUP_MUTE_LED_GPIO),
