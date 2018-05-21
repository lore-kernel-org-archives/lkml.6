Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqVhb3hMLSioUmcHs5lCvpRyMVRDT8G76Kl/cGSGswshhuhISJ0aYtsZpigWnQDz/zDSWMj
ARC-Seal: i=1; a=rsa-sha256; t=1526937810; cv=none;
        d=google.com; s=arc-20160816;
        b=0BHFWVgJFlL3BR9Eh3jKw9GxYzgbbG6DEUva5QJuJwMy8/lGdBh+JkZOT9gRxTCadQ
         +ctzR+hgXQmfUO/BmMBU+tnamOLsGUgbAHVVJ10GKoU4N0rtF4muY7KWD388F5nEeA2t
         IgdvvwtwbQALl/JTtNoQx7sD7E3zW6gzv7tap2B1HPwokrnuWbQi+eOHjl0eYHBNNufC
         JA7mibpYPewxtaqOsrR4P9NDIl6QVf/RC8IeJx4PjxVp6+VRNvfgGPP76U8h3mTfkwSA
         H5G9ZNlqtp39QHteSpZKk9IA0qFWNXJJJcB6LUPkACk0G3OXCfNnenXVJqTK4G7Hahbu
         rPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=rB01O+NiFaXWOuLG0ZNolm2RviIWXr0JXJNgEjhr4Ec=;
        b=jzNo4gszokyfzKmypeUIsXcdDYczhIjyhRLUFtTBu/4gFhaP6NgEc0JGKBwuNVT2Bi
         sN5qey1rPy1wTNQavQg1SIAX4jHV9466zsA4+JUJQ+KGZuZncrpehSDWOqj0DD78xXdp
         yqRP9dk6SjOI69eYPCLtak7eBrbGWJ6zABQvpZe3XDdb1YOGBLeNlzSn+RRmrowsUf5R
         HhFHnZNiURIsjpg187PMwrIHLQGIP7AzV38WElGmDaKdRGj4RGupMrFeHRMoEwG1l+GU
         lY/ZtwUZQNw9NXi/gr3BVG85fKlpOlCnswSVZJ8qBYlkfAeqsCHeZh4lQ8uTkcn3GaDv
         YYmw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Rjh6q7na;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=Rjh6q7na;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jeremy Soller <jeremy@system76.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 008/110] ALSA: hda/realtek - Clevo P950ER ALC1220 Fixup
Date: Mon, 21 May 2018 23:11:05 +0200
Message-Id: <20180521210504.640455271@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110341492205042?=
X-GMAIL-MSGID: =?utf-8?q?1601110341492205042?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jeremy Soller <jeremy@system76.com>

commit 2f0d520a1a73555ac51c19cd494493f60b4c1cea upstream.

This adds support for the P950ER, which has the same required fixup as
the P950HR, but has a different PCI ID.

Signed-off-by: Jeremy Soller <jeremy@system76.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2363,6 +2363,7 @@ static const struct snd_pci_quirk alc882
 	SND_PCI_QUIRK_VENDOR(0x1462, "MSI", ALC882_FIXUP_GPIO3),
 	SND_PCI_QUIRK(0x147b, 0x107a, "Abit AW9D-MAX", ALC882_FIXUP_ABIT_AW9D_MAX),
 	SND_PCI_QUIRK(0x1558, 0x9501, "Clevo P950HR", ALC1220_FIXUP_CLEVO_P950),
+	SND_PCI_QUIRK(0x1558, 0x95e2, "Clevo P950ER", ALC1220_FIXUP_CLEVO_P950),
 	SND_PCI_QUIRK_VENDOR(0x1558, "Clevo laptop", ALC882_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x161f, 0x2054, "Medion laptop", ALC883_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x17aa, 0x3a0d, "Lenovo Y530", ALC882_FIXUP_LENOVO_Y530),
