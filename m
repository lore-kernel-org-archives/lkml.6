Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuGbA5hE7vF14y6wJqb3hhJU86YvqDl3mu9RjPDMXACRegDOYTr04LV8/P87qfhaq9Jg59V
ARC-Seal: i=1; a=rsa-sha256; t=1520955147; cv=none;
        d=google.com; s=arc-20160816;
        b=Bj8Q2+UwowvKV+HOrgG9+/MyNRpN3EcsR674sl/JKK8ATHh6P2qvvkHA4mrwxWvzfr
         Q7vDZkrLYZM8Hoe3DmnP9qopi5k6v53tyWxwd2Qi0nByW/gd1WnfD2MXv5K8BP/EbG/p
         wGBphD9j6Fm1cpGZ+IT0C+cJcwBOjFNOHy1DYZhouAKkNAkFSEgDcZqyBIIC0h4Spx4d
         TfHJtvmg9FLZvhRLiQEw6BwUicGKk5U+CqPAycjbzu7VKQwOP41RFX9Pz0bzGRruOlGg
         Ozgkfd/HwD8vuTBcxfXjz4lVy150dOH+EKaBaocJjDJM9FZBU3NiGGOn/Btz0LlKs0Mz
         6wXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Vxsfuoio71X3Blu63cKtLQn9MYqq5JWjH1ydSt6aOmc=;
        b=aKR0EH2WBXURSLI+Ukb5jTeYMOiClxsE/NmuDDjYvmKuEvLiUNlH1hev6AJ2fuzVJJ
         RTD2xdRrDucyCEHy5V5Yxcb5n2Y8aGrdhRrfgzeep1T+pYsY1Mj9pPkMhiOYSSNlLv8s
         ea/Hq/UoNYpH+ANkBwfjawm+aviBjOjbxdZ0e2JLx9A+Htme4onjKxUG1POra+HdeiE4
         RAbhSwKmhUcErAUTOyUAT81IhiayXAO3kumzWprMOrdbrrH698+AzP3Jc+RPM5hysdg0
         txgqliXY70Veb74hrhsIzCogcqWZoUxG4H0Tn5HIU7Co592dbHGkGyx8yBPBgqBEtH/v
         TaCA==
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
Subject: [PATCH 4.15 068/146] ALSA: hda/realtek: Limit mic boost on T480
Date: Tue, 13 Mar 2018 16:23:55 +0100
Message-Id: <20180313152325.982727192@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837064026507308?=
X-GMAIL-MSGID: =?utf-8?q?1594837064026507308?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6414,6 +6414,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x224b, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224c, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x225d, "Thinkpad T480", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
