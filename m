Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvtopFtz5vsCjniYyezNzDeSe5d8eqIDIBXb2vlFZkqUlsrlhobp+gTjo2ei5atV+k46w/y
ARC-Seal: i=1; a=rsa-sha256; t=1520955097; cv=none;
        d=google.com; s=arc-20160816;
        b=y46Ibt+cE6ugeu4QWeDByDohi/H8hWZMLQqse1aNP8C77qX6cA/5Wnr4ghNJqC7W9U
         66rD+G4Vx+2/uNn5YPn3W6MH9ltdat8XkkL3kgecCXpjfoj/Hqb3gLw55HyXEaRspLGt
         XAgO3UEqPQbEkuKVLibl0oM9gZxtR2v9pqY2WqXQfe+t374jyzyRW/5bOjTmXsuGevH7
         gBTaGnb5uMg+crMzMXNkrZdKGiiBFHfOufOdeBIWxPIQrPZ7bbrELRTMRKkUYUxEWT85
         wNDDC9BNLvUjrI6xc6H+GZWs0fMYx7jyTXqFtT6umDoA9eZ4kEH8uET70jV8yMHiuUgo
         dLBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=6pLBFAgZ7VB8fYuAQLTAiLE7EcxCB801uKVdyCEohA8=;
        b=Lzw9HowToYQlV3uFakZZBqG2ZK8Bsok1Xzz6DK85XhtgBH1FCEu3o1MA/ab6mqE9fC
         wP4aadD38qp3qtCNUGQC2nxh7Laofr2jV3920GAj5GWELWSmRslD0JOY8BQEZ+l84WBv
         /FUuPJiQbIGnRaGB7fdrCPZtbi8nKtUZE6p9RGRKQm/79AuY4hbeW9bERQsxiGTZdHBI
         rQKHnq8WChr9iMzUCl5Yr8ZLo6aOFLOpFOEvKGIoTvMkOGdl/LhfhSkfq4NklSs+TgqJ
         sbxU64IlzSh5CESRGodHq5uzbijdLrEkyWwk7NoC1wM9O0bAoB8osSUTF17v7TXOE+GR
         DLQg==
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
Subject: [PATCH 4.15 070/146] ALSA: hda/realtek - Make dock sound work on ThinkPad L570
Date: Tue, 13 Mar 2018 16:23:57 +0100
Message-Id: <20180313152326.140137650@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837011394940891?=
X-GMAIL-MSGID: =?utf-8?q?1594837011394940891?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dennis Wassenberg <dennis.wassenberg@secunet.com>

commit e4c07b3b66b7d6a24c2fe3b1ddeff5cd9b378b3a upstream.

One version of Lenovo Thinkpad T570 did not use ALC298
(like other Kaby Lake devices). Instead it uses ALC292.
In order to make the Lenovo dock working with that codec
the dock quirk for ALC292 will be used.

Signed-off-by: Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6427,6 +6427,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x2245, "Thinkpad T470", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2246, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2247, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x2249, "Thinkpad", ALC292_FIXUP_TPT460),
 	SND_PCI_QUIRK(0x17aa, 0x224b, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224c, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
