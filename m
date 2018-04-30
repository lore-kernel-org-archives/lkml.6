Return-Path: <SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqoHd18pqFKv0DOV4zf7wElkuHqne9nub1qFTlVRxx86IfnLT2PPUj2zXiNT1fQJvBsgHnG
ARC-Seal: i=1; a=rsa-sha256; t=1525116440; cv=none;
        d=google.com; s=arc-20160816;
        b=dA/3Zf28y6RImt8ldngFxwOdSHhx97dehL9BjNqyWKnbNN4Cl+3Sc0VS6W+NP9KvJw
         UM+i91zNbmvkFpdaZWoJONyKPfY7sn0DzenYVkv5Qs4gFjdeV+nxzQOdX/sNfpZ4Ohq4
         W15rN30AE2YiFc/W21TRZuUp4QAtIoMTHiHgUcHH7Bk2bCM4wjiUsAvkxRICjtXIR243
         tak2+3oj7u4WoSFjWXlysB8H4NxkqZgyku41y62YzR3iGdyohPt4dVblxJmVedANHRcC
         DUnonOEpzj90SivTngZWbpXx7tQgVOxlVZcXmKITbIp8/j4V+BBl9/NWuYwEnOE0Oi+J
         h/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dmarc-filter:arc-authentication-results;
        bh=xH2RzRmXHrDlDFXTEzpuHImBIfMXpMM18IhjYRVkWEs=;
        b=tWShYHLZGAS0Q++LePZ1rFzdYrXGsmQisNbSfpbUv7nGzHZ1hG+6tkuhMa9+GDgn5Z
         LIfiPWe+Tvz0cStJNaH0rtF1Eb1gTHMC7snJc/9ZrUym+liACT2HkUN6vRVB/sCBQpAc
         AT0lL+oORtqX12h3sQgJ5mDATLRgeMEagrra6O2B5UUiTd6f1kdhIMef7MPrcmhy5GED
         5YPYrw47bbDXdLS2BF/v1n/SeiMvmv8OA1MwyhTWBqD2GVyddozRYJehG53Av/URog5O
         ZIj6Cvi0huq5WsHnf1u/e/tqPeJ/Bta62WRVjYP7Wecdo+XOoE6q6IrCWdRIoQs/HLYK
         aC5g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of srs0=k66p=ht=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=K66P=HT=linuxfoundation.org=gregkh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F1A122DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kailang Yang <kailang@realtek.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 49/91] ALSA: hda/realtek - change the location for one of two front mics
Date: Mon, 30 Apr 2018 12:24:31 -0700
Message-Id: <20180430184006.749308970@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599200496886897577?=
X-GMAIL-MSGID: =?utf-8?q?1599200496886897577?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kailang Yang <kailang@realtek.com>

commit 65811834ba56e9ed88117cf6c09880416c9951ab upstream.

On this Lenovo ThinkCentre machine. There are two front mics,
we change the location for one of them.

Relation: f33f79f3d0e5 ("ALSA: hda/realtek - change the location for
one of two front microphones")

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6436,6 +6436,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
+	SND_PCI_QUIRK(0x17aa, 0x312f, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x17aa, 0x3138, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x17aa, 0x313c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
 	SND_PCI_QUIRK(0x17aa, 0x3112, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
