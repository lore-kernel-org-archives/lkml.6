Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuNLF9gjOPBrxpbUZsK6oT/gDohm7lsgq63kbyWZXl0C5mCcOBjogUVHKNEiIkD9mRlUFPO
ARC-Seal: i=1; a=rsa-sha256; t=1521214277; cv=none;
        d=google.com; s=arc-20160816;
        b=vy/4pKptV0gXq9WnzYPyZ9/kgxV9PK5FmpMg17QPqx4eCMZNrLfz5CLoHxmxDF77+E
         mLi0I9xsS1Ui8aVZvGxjtpXtcYfNXRrCUPoq6/aY9TO1ylOUFVMiGXTXt6i/yJfx4lDe
         X2kIeRg8K0S38kDw13tH5lxg+MGgaeFTfV16IISUcJOV1vJqA7A6RHRlfIiybU8T6uVQ
         xFsg7VV/7NlB1yVzukKl2PrLIvBrlbLe7Td2/uw+xTKm3ucKlYoROXqvJQNF6Hf8a/VZ
         0N51QO76X7sYBlFEN1mFZqB/TOxGqztQ9Ff/fb8TQDCIPXht/xJJvNapj9P18+TzdvMn
         nAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=MErRUv2AIigOywVEZjAdxV1Fou5hcbWy64ydzKNZ45c=;
        b=PJ+0+JSG6sRmMJ0p8h1UE5uVHsBfmrTz66sLEdPuv5kVlJyseIz/WZxJjmdtt3fRlJ
         yVlL/yRakgHo/Q5VcM1ukiHgEwLlzB305ra/+QrYYbhUVJl1PHU4Cy6wJv1ruHS15QyB
         VxZG0QQvKerejYQqmgn+r7qDEB1+w3HizEx65oJThFqzSMsz5Uae9Wisws8wCLXjRYaF
         ummFWGmVPpr1rlnrEMtpAreq7KXJsO2THgSpVCCjQBgfC4U+Jsuri/8DhAKdQj11Qb36
         9xGaX6fh5ijLl6CkEgSSSW0YXC1hXk0n5WMrK6sMCZ15BmITnlJ39YGZJqrqgnkj8r4v
         gBaA==
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
Subject: [PATCH 4.9 37/86] ALSA: hda: add dock and led support for HP ProBook 640 G2
Date: Fri, 16 Mar 2018 16:23:00 +0100
Message-Id: <20180316152319.906384354@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108548882336478?=
X-GMAIL-MSGID: =?utf-8?q?1595108781861900364?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -850,6 +850,7 @@ static const struct snd_pci_quirk cxt506
 	SND_PCI_QUIRK(0x1025, 0x054f, "Acer Aspire 4830T", CXT_FIXUP_ASPIRE_DMIC),
 	SND_PCI_QUIRK(0x103c, 0x8079, "HP EliteBook 840 G3", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x807C, "HP EliteBook 820 G3", CXT_FIXUP_HP_DOCK),
+	SND_PCI_QUIRK(0x103c, 0x80FD, "HP ProBook 640 G2", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
 	SND_PCI_QUIRK(0x103c, 0x8115, "HP Z1 Gen3", CXT_FIXUP_HP_GATE_MIC),
 	SND_PCI_QUIRK(0x1043, 0x138d, "Asus", CXT_FIXUP_HEADPHONE_MIC_PIN),
