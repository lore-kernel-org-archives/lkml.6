Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu28UVeg2OrnbRr6v/vY8BetPYOrwjv09ZjcKSh+AhyL+O14SijQvf/fqS+EpADXaQmZzTb
ARC-Seal: i=1; a=rsa-sha256; t=1521214263; cv=none;
        d=google.com; s=arc-20160816;
        b=hHbT2YrzxKJBTz3esI2sY4szxh+3htmP3ALns4uFO9KObsVNEvNjrvapaBEVLuGw+X
         QJSDgmWEzjA6HfRd+41G4VuDis7XurxppVlls51srojfjfC8I4/Qk8yVzxUHpsOcWS8b
         2uaD5P4cia3eUi2T3BGJ6rq3UsX1OekK5dHnsYkqTRfb6psZBpRj3yxYTAxuvJptfLcV
         6vO0HyDhZZgLm8dEU+pmULMJg7DEIjCy6kDtq0f+DRzqnJn/nfnk+b6iona89lJ+hJp+
         1nIQLnpQ1ybrfcMs4Jo/UUsAevT5iRugEeI8wBIe9vAg9CVqmN4obnXM3AzP5DVgcP69
         Zekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8wYmbgKZX0zEioD0smPbs58UmJ76L8QJDo4LPF5Y9d4=;
        b=O0K5cBTXGPtREuP6U6yLSjnJ4IjcpmtIwLr33lZMg9bSqBQxvoPdU+EDsmt0f53/dT
         797tayVgKiUITgxKs+Q3q7dceT9DoxlOPNsHLcUK/L/CTluM5JktTJprqdJmz8UeVNkV
         HEzvbEZlZBWNklXGqGtX8nr4VFFCaYDqmBDUDVsp1NlFkad5fPxLPI9C6inI4OplM3pU
         dHasWg28m/ibP6t7hTsOcZw7VizJGMzfBcQ5d8tunt6iyfnjzkrO5FVRNqg5bu6gXRwx
         x/noiE/juuBzgC/7gpMlNmnHtRnQ5WLflvuWUbUhNe1xNYV6Wds3g9X1NeIWCEeBJzdy
         Sv4w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Benjamin Berg <bberg@redhat.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.9 31/86] ALSA: hda/realtek: Limit mic boost on T480
Date: Fri, 16 Mar 2018 16:22:54 +0100
Message-Id: <20180316152319.500268894@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152317.167709497@linuxfoundation.org>
References: <20180316152317.167709497@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595108767689516038?=
X-GMAIL-MSGID: =?utf-8?q?1595108767689516038?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5788,6 +5788,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x17aa, 0x224b, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224c, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
 	SND_PCI_QUIRK(0x17aa, 0x224d, "Thinkpad", ALC298_FIXUP_TPT470_DOCK),
+	SND_PCI_QUIRK(0x17aa, 0x225d, "Thinkpad T480", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x3112, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
