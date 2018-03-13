Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELskgeHu6Lo1tiQ/cojps/OaBFIobcM5J1+VADfBCyvFWveiJ4doRFNVOf6XyRpoVg7rAMr2
ARC-Seal: i=1; a=rsa-sha256; t=1520955599; cv=none;
        d=google.com; s=arc-20160816;
        b=jXTsvmzgLMWS8xkxQyyJy1pwwqqPtqVTRXeewHX4sAftQToN/dYXpXR/KBzK4DCHau
         /m0vF1f1sW/AwxL4AvPF7k+GiryrOkfLQs3VSYFD1J+Q8kx1Hobd9F0mi29eh3VM+MeD
         Fj7FYcfiH0lXB14ONIFXlFfmDdaBpSzGUfdNvVTugy/X82CNAfieXGhYh5db2yMMpsyM
         ZDLT7CjRtuGb3cIG0IsyuUHDPs9n62sUzV8ZAo+uF427Kla2hVRol+5KwIbvVay5BlA6
         aDsOr/WgTbl6Y4lAmdRinpIbyNwtjMW2UD9wGbph+aeerFPx7QWCRcHnBxVB51fRFoCg
         UOeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=gMnjfbkoVn+emhAH2P9GR+o9hbeo6xyXxW0436eSCz4=;
        b=C8ojGkOaSqNXsv291AErTE4U9UkuHoi7FZtpT0MKUFJ98pmRWURUCSzJrLfQHk8upo
         wVmY2/QyLflvA0QvAq5XJb9G0kgUGT5bH1svca2yjL02nkmbG453idEBf+5IHcANFGtX
         MzxwloKLZ7cJV4ALL8UPEnoLEXQhsiP7GCoPOdIa41WfRBaeRCWn8TUcVe7gyRDr5kxV
         JSOIb7yAau/Rot7V9k4s7ulh3sKP3C1kHkEP4ZYUNPa4o5u2aFrvEdFekza5Hl4GQohg
         pbbouDTQeTBOIGzm4H8JosDTwFvDGHdUS74b/+Ge8F7eMaVb11HvBYEsDm26mSEMp3go
         brMA==
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
Subject: [PATCH 4.14 105/140] ALSA: hda/realtek - Make dock sound work on ThinkPad L570
Date: Tue, 13 Mar 2018 16:25:08 +0100
Message-Id: <20180313152505.202223395@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837011394940891?=
X-GMAIL-MSGID: =?utf-8?q?1594837538433735793?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6404,6 +6404,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x2245, "Thinkpad T470", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2246, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x2247, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x2249, "Thinkpad", ALC292_FIXUP_TPT460),
 	SND_PCI_QUIRK(0x17aa, 0x224b, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224c, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
