Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELspjaUg5hYc3hy2OiW6aQtv7UoJGEm5JLIcRk8tdY+A7LdStaMwTzQ3rYUETKpHL+0gdHPE
ARC-Seal: i=1; a=rsa-sha256; t=1520955611; cv=none;
        d=google.com; s=arc-20160816;
        b=SwuuuTi5waga1Ds7pM1MWH/DzJJhhHM91LhYbs+6B2DQ08k55ZPiYy3E952vGfxj+U
         7XYWlJhwkYorwqLgqVJoneGPUYSYkFz9aozK3rQvs9UP9X+WUKZ83I10HOEnnBoDZruq
         qL4U0nHh1ehWHMSBuSLIOclgTRsiOu0ILLxpid30AxW8wgBpdlOA+RFbTjcV5WU2P6vA
         ppkKmpT4DYQEw4n3SUVb8gD0PLAcTLtT51gvcnuX66DYPpEKlBXkVJH3dJJZcwYGK+UB
         /C89ON/Z4xYEQzRuy8v+Yr7sKUy0zO+Whchk023dpb2F3DGLmGwh5QN5JpmvwBli6s59
         2q5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xT27f+RYKNr3v4AVPMO0iXq4Vg41INI0yWQ5seAi87E=;
        b=LOSkV8df6bdoNC06r+J0MAe9OicNt4mk9UO5oqp9jOhi9Aai4u7qDzPbLdIWy2M5ci
         ytq1PzzAstaZ4/CNz/kK7/A7lUmVemjx1G9YyDkCkWr3H94kpCTv8yotMGsMrX+3vjaC
         4PIIJDr+iSxkJVfGCA7lTKYUabnOJ+EC66yJOJnXwrYAHkSHGul6dmcCf6LneAFVU0cM
         cqYdJ0mpfC4GqQLLb7ZaJRvqVJa+7Kana/jSOSYowGKDk+8cYpsFK//mMKR8thscBQcf
         t15svmiarEefDHbBj5+YFmvZMsIwOPx6JwgLPsMae1XklSTSQGxiW+NDQKpMqztJw84u
         Cijw==
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
Subject: [PATCH 4.14 109/140] ALSA: hda: add dock and led support for HP EliteBook 820 G3
Date: Tue, 13 Mar 2018 16:25:12 +0100
Message-Id: <20180313152505.472170744@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837052681762818?=
X-GMAIL-MSGID: =?utf-8?q?1594837550609366715?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
