Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvgkXrusuUf05Z/8GwKUdb8rijy4xe24+YOxHJQprUb0Jfy4qfktwttgrC4jYRdQwfexeJc
ARC-Seal: i=1; a=rsa-sha256; t=1520955593; cv=none;
        d=google.com; s=arc-20160816;
        b=EUIIXzff3PvBt2R5CvGc70TFZ50PoB9YvQoyCiex/b7P7KaHoHdqjErXS6naNCWJvv
         mtIcJEueDWGvkvLN+u7jRInxnVJDDc/DkPvaecdONdwyGU8yBGZ/9wt/7IJuuukf8Wyj
         1NMfU8h+GTTg+mMiqR+lZuT7M+CD6ZhhGarGrz9/xDvxxfdAUqiYITAis5+Yo9oPfkv1
         eESBFam5wIoWSDOGM3cb0GIOmxdun89DOBg/YVzYPUGLU6VwelpqtSyLQaq3Nm+9LNYn
         jfUvRuLbMKEtedrfvYnxiQxpe4c7dxt2Usz+/+m9jL0eW+wYDWob+IstWOm/A2F07G7H
         0K5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=IDu0izOHLyydEP+sRpugX01fKd4nBouWZuTanVeDoIk=;
        b=KkE8Za+ulska2Kh5TVbGVamyENJPa0BmI3czrrAs6n8FVRR0heTdlf86aKpKdPkq7R
         xYyh1ot4QZuuF0gYreRHf64o8v6oriM0A16EOM0tJz5+q98NGG/o+Kv5LNxejyRM93Uc
         zExTTP3MYFS0DrX69OgT1tF1r6mEl4Y8u8cUVvDduJXQ9iHxwH/5asYOqKY1vbs3v1Wp
         wETcoho+43+bBMGzjBzhbPeFV3hp/f9cnnqoNyodDY53BKryNnl7rcRRc8R57sMFRcF0
         NyGxbdaDoJmyXZPbf5Ltm9qqSTEZa+DYmVMs7KudtUx6RgJNUfiGWQBjrdLTlXj1YvM+
         H45Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Benjamin Berg <bberg@redhat.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 103/140] ALSA: hda/realtek: Limit mic boost on T480
Date: Tue, 13 Mar 2018 16:25:06 +0100
Message-Id: <20180313152505.071846652@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837064026507308?=
X-GMAIL-MSGID: =?utf-8?q?1594837532615216388?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Berg <bberg@redhat.com>

commit 85981dfd6b0a0fd9ed87ca4a525981b67c21f098 upstream.

The internal mic boost on the T480 is too high. Fix this by applying the
ALC269_FIXUP_LIMIT_INT_MIC_BOOST fixup to the machine to limit the gain.

Signed-off-by: Benjamin Berg <bberg@redhat.com>
Tested-by: Benjamin Berg <bberg@redhat.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6391,6 +6391,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x224b, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224c, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x225d, "Thinkpad T480", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
