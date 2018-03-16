Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsYZ0nT/X60kFMfbUcZhrjPvs4hxjhDQd6En3yays5PsAZCLdsmgKb7okycQTVKgB90cGJ7
ARC-Seal: i=1; a=rsa-sha256; t=1521214265; cv=none;
        d=google.com; s=arc-20160816;
        b=TROVcBju0f9Uy5m+S0XuZTDi7wOle2lkzGbdXWnFynpWYa4Hfu5IVYCfXviNQSnHX0
         gAbza6gK/GCp3s3oXvyj0g23fLMhLNxNwfiCUuf0gYPiHGGCRnDkbTvXVePgOSaJ1HGT
         MyAyCgvWOsQqpBhX11smJOiPwo1RTkDJp4lIc2d48qGeyVSdGi9g8eKqGB0rzbaUEq7Z
         apEDS9qU5Qu9BYifG1EGCz/0ik9VAzpzCAJOlnF81h5coSpXseN0ZYMSRNUn83mTqHVu
         mA4L9Vc+LSEvV0zgUs+NL8a/w+Cf/7+oORPkhD4RrSB4xip2e84ugpJQlJQrFnbiSzup
         bvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8aMuK14Gw9lTHslmqU8LT1ps7ObB7Fuc9u2c2Ta6ZGA=;
        b=Q/lZ+zojYKfkmzjwTlIBgfSW21szzZUWIXjnRolCQoTd5oIf6U9/NXhmoDFy60BdQX
         WpMjfu+DWF68/EU9HFJP+7cWtO7465WOz8nfXdWe6aFixdjo73Qo052dz1Y7xeo+W2zG
         YezF09wvplUrfqtPbG0n84Ucf7A06D82NGjZrAi/NYVCF5RBBY3AWxj2+rE1JJ90gjl5
         61waNcZg32SfNdLkzOEK8QymKwKV4Ap6pQk5YoGhKHySLIWfAq8I2o74TyyaV4rvvcSc
         Kl93V/dCB1zwBEe4e2yH9IroOw0GiBm7cNbqqhOnly8DxMt3KDKdOY6EpZr8U4+g8fxR
         DmJg==
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
Subject: [PATCH 4.9 33/86] ALSA: hda/realtek - Make dock sound work on ThinkPad L570
Date: Fri, 16 Mar 2018 16:22:56 +0100
Message-Id: <20180316152319.625288645@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108769677367322?=
X-GMAIL-MSGID: =?utf-8?q?1595108769677367322?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5801,6 +5801,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x2245, "Thinkpad T470", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2246, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2247, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x2249, "Thinkpad", ALC292_FIXUP_TPT460),
 	SND_PCI_QUIRK(0x17aa, 0x224b, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224c, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
