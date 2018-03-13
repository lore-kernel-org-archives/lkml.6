Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvdH//Fm7yoNOycny3MHxrSupnNBUba5Ubs7q9Pu5jeHH21ojZfYbGMpB7tsjGy1xgdeE4g
ARC-Seal: i=1; a=rsa-sha256; t=1520955613; cv=none;
        d=google.com; s=arc-20160816;
        b=Y8qSE9tkoqHCC9FNTlXNfvmQmtlv7o2CEVrmqifL4x9oHD+mgAGMU+H6M9kEa9xw6z
         lp5LWLNUed9uADDGEyjiTMCDW2rlHv7O066P5jKdgKGiskOQKuVshA+Mn+nLlKj43+Oc
         sB9slDMCOljwS+4vlzQW3YBiNmKZQxWzhGNRGDF3TWSyjbyRwMWVmaRCmqUo2eP3515P
         Lt9bxkD/5772ovP9M0dvQfobDbunLUbFhN+/sXpg/ApKOrjvYDL6aDFyOEUiGImHQkZK
         dfBcv3njV7EecK+2CS6f5pXcPC5i+qgRn3+/mDy9TYc4s5JrAcpdgcqrmvCxLhTklZyd
         ETIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=v0/rTAbV/wOwXL97rCDb3k+OTqkQgh/bIAqfmtrA7Ag=;
        b=v/smGV2+CQ9CiOxw5FogL1n/vwKrA2/m76LY2HGnZfvcabiUM04s4muRKsYeadYVgN
         j4JtVVDlJWKHr61Xv6N0+Yw6WoeY0Z3kIWoLSaRhnOiOvw7Yfm6oOG/JbsejHsSr6cCV
         FQkgL6PNWqSfRJiPoKAhLfjgQv0BvbXXdffI4uWcd0LtJ//mTzuWlfpW3sWPU9zqNYBm
         j9bPY22chSJjxOTdGhxXWQRGzHc1OOqLaimvAaiNO40Jf3iPKD5+2OpP7eu77WNz7szo
         WNVDQTSz+SmMUuqIp46d2bwOneCIH33Rj1iwx2/abmoQ33VC0D9r7o8JPqS+zElASpDH
         jWUA==
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
Subject: [PATCH 4.14 110/140] ALSA: hda: add dock and led support for HP ProBook 640 G2
Date: Tue, 13 Mar 2018 16:25:13 +0100
Message-Id: <20180313152505.548545055@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837055589542138?=
X-GMAIL-MSGID: =?utf-8?q?1594837553639416482?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -958,6 +958,7 @@ static const struct snd_pci_quirk cxt506
 	SND_PCI_QUIRK(0x1025, 0x054f, "Acer Aspire 4830T", CXT_FIXUP_ASPIRE_DMIC),
 	SND_PCI_QUIRK(0x103c, 0x8079, "HP EliteBook 840 G3", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x807C, "HP EliteBook 820 G3", CXT_FIXUP_HP_DOCK),
+	SND_PCI_QUIRK(0x103c, 0x80FD, "HP ProBook 640 G2", CXT_FIXUP_HP_DOCK),
 	SND_PCI_QUIRK(0x103c, 0x8174, "HP Spectre x360", CXT_FIXUP_HP_SPECTRE),
 	SND_PCI_QUIRK(0x103c, 0x8115, "HP Z1 Gen3", CXT_FIXUP_HP_GATE_MIC),
 	SND_PCI_QUIRK(0x103c, 0x814f, "HP ZBook 15u G3", CXT_FIXUP_MUTE_LED_GPIO),
