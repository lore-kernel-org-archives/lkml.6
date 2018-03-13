Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvK2zoOdaWNGkeQtflAS7wERumDUQGJbt378pog1whKHxFz9aXO2FwN+O4+Osdd9w0STKwk
ARC-Seal: i=1; a=rsa-sha256; t=1520955135; cv=none;
        d=google.com; s=arc-20160816;
        b=XmNP0/Koe1X3mBoJCLzZjln6cRxOGYV45Y3B2sxruJKcgP/VT/KbrJ6GYGlxpQMgud
         7UoC79brhxjGbF1bc1ZyHlkQxVmQ+RXWwlpM6xvGLIb3yVSLs9S8z32SuqjhiMlASAwo
         wDhLxXhI81xh3qAo1Ahxnpjr8mSYhKRdHzqbV9GoGTRoyv8eYwlclSLNJXr6xuJmcC8C
         EcQQ0lLBara+jliPCEnFwCliQxezStP7ZtXtqFv37xxqwuDd82lFoJpHnXoU6gnXgb0F
         jL1T1a6Zker1BDZj1TNnZl9dBj+pB2gkJ9+buLgA5U7QClOyy8SrcTxFTEZ4Usen6Avo
         RW2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Fban1SOE1LCUISVlUFW0b0mf2VV0kkrA0wtaGnI6/8g=;
        b=MVmcdaf0G/uqmFkLdEiNP75gjwlNmBqr+A4niBnP8hA/qfXHJ1jjHlRgizFobzQWAA
         vg5zAzkTu3h1wpLMED3QJ0EvX5FkcyvXihZdNZP8wU5Z6Wg5v5wQZhbj6VsjuwO2XyJL
         yKUG2ujKAgOBy7qiaWTTfxegKGuTiNYWAYAv1COuaNsB/USRfP/hnDQKONy6ggMdSaU4
         5zm4qxjw+H0alJ+vyEif8XBNxfCtd2OCBNgMw2MZ3yRCtWugtpQwm3mKvKJd/e/H+FyK
         CVev/XUOYMwPWUcJ2uCre6oWviR9sI9LSN6bhNN/ciD+2EzKdMbh8/LWP0h5OdnFD/RS
         ehBg==
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
Subject: [PATCH 4.15 074/146] ALSA: hda: add dock and led support for HP EliteBook 820 G3
Date: Tue, 13 Mar 2018 16:24:01 +0100
Message-Id: <20180313152326.441856550@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837052681762818?=
X-GMAIL-MSGID: =?utf-8?q?1594837052681762818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -957,6 +957,7 @@ static const struct snd_pci_quirk cxt506
 	SND_PCI_QUIRK(0x1025, 0x054c, "Acer Aspire 3830TG", CXT_FIXUP_ASPIRE_DMIC),
 	SND_PCI_QUIRK(0x1025, 0x054f, "Acer Aspire 4830T", CXT_FIXUP_ASPIRE_DMIC),
 	SND_PCI_QUIRK(0x103c, 0x8079, "HP EliteBook 840 G3", CXT_FIXUP_HP_DOCK),
+	SND_PCI_QUIRK(0x103c, 0x807C, "HP EliteBook 820 G3", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
 	SND_PCI_QUIRK(0x103c, 0x8115, "HP Z1 Gen3", CXT_FIXUP_HP_GATE_MIC),
 	SND_PCI_QUIRK(0x103c, 0x814f, "HP ZBook 15u G3", CXT_FIXUP_MUTE_LED_GPIO),
