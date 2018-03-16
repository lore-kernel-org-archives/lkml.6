Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtkzPeYFNNGAQW5U9Hc1F1C5jWqQU3PdFMKSdFUgRFRBIBjJUNdn28omNWZdM6+h/5TYlhb
ARC-Seal: i=1; a=rsa-sha256; t=1521214274; cv=none;
        d=google.com; s=arc-20160816;
        b=fo1rmu6dWW2KKLoKumITmxpvzC404QE+xV7fYXjpKTHZbufpCW9+Nmo+t97NAxYnVN
         uM6ojqaMXvN5va4aHjg+NR6ZjnT29hvmyX7sgzkUQ7L4WoUKQWqVSlvVh+pbPaZD1P2F
         2sIyCrS7n1BQEHuClZqNTTjKkxwdxzN74GtsSS7J4mKnxBsb2LWT8fF27h9AEkwjbEWn
         TITLiErYsdRiQ4hry4JA3zF2Sn4ai22FTNLQQuWOHvSFsIzxpxtIt/VsRoNGnC7zx0fq
         FsMCok1OaxQmezWgJpsjBc/0hsqMQ8TBJag+/ygEZmeMvmzzJqCUblaFjHGfUyHFDF4v
         9TWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=oqhlBzmZdZS3Lt4Mxs6uLqWkup8YYDiGXZ6x4Cd3Nvc=;
        b=gxvYOVXB0kvHMmGAEapE4tD8ouJqpe6bo6aNq88N6nB5htB1VqOfam8r3464D9C6AB
         LQn79MKxnYY5rnTNrMygFXLtLmDG45hOP3v3TroA+Ql8EPv1Rlo+WDBbznTM5lTB/ac3
         crQjE7Bdl+vmkplzZARRLc9ciLmJ/vtGyH0afT/Coy0skxj8Zpux91QIQtfR+h+OgfS5
         cUawJ5beiFhTKUpNcUNWzVsMNq68BadZ9+SPEmt+L4tshjb5hkkSH6gZ4C9LaU/eqsNa
         wIh8RLDPEPToOPqwRgT5QzH0rHKFl4qju4lGEwJ8vAK8GlpBhlgHKM3qT/nrvdR5oGK+
         RXZw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Dennis Wassenberg <dennis.wassenberg@secunet.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 36/86] ALSA: hda: add dock and led support for HP EliteBook 820 G3
Date: Fri, 16 Mar 2018 16:22:59 +0100
Message-Id: <20180316152319.806376667@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108545934600207?=
X-GMAIL-MSGID: =?utf-8?q?1595108778974582223?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dennis Wassenberg <dennis.wassenberg@secunet.com>

commit aea808172018ca01abf53db808323aed23281835 upstream.

This patch adds missing initialisation for HP 2013 UltraSlim Dock
Line-In/Out PINs and activates keyboard mute/micmute leds
for HP EliteBook 820 G3

Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_conexant.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -849,6 +849,7 @@ static const struct snd_pci_quirk cxt506
 	SND_PCI_QUIRK(0x1025, 0x054c, "Acer Aspire 3830TG", CXT_FIXUP_ASPIRE_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x054f, "Acer Aspire 4830T", CXT_FIXUP_ASPIRE_DMIC),
 	SND_PCI_QUIRK(0x103c, 0x8079, "HP EliteBook 840 G3", CXT_FIXUP_HP_DOCK),
+	SND_PCI_QUIRK(0x103c, 0x807C, "HP EliteBook 820 G3", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
 	SND_PCI_QUIRK(0x103c, 0x8115, "HP Z1 Gen3", CXT_FIXUP_HP_GATE_MIC),
 	SND_PCI_QUIRK(0x1043, 0x138d, "Asus", CXT_FIXUP_HEADPHONE_MIC_PIN),
