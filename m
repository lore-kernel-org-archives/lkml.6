Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225vSWQp8kNi9N5kxu5Y3RY+f99py1lKCpNJUeUzhFOaK8bNLYFsmtnhwIcyTlWXX/E9ik6E
ARC-Seal: i=1; a=rsa-sha256; t=1519217153; cv=none;
        d=google.com; s=arc-20160816;
        b=bgDn2PFyCw536uwMJCTFbbg5pMlhK328I8vyRqZOMbV3N9URDdjXA8/ldajxpZ+m9I
         u8WWO5A8q8GqwRwxPoh9mMyv9FeAhBNBTl/jXiyYWDWuI2jVzz9M/Ifksp5ec1vBgzC+
         Ir/+wgWCJBy30GxFv0vfB3h6xg5Ryzs1SvcKzn3z397Iyu2I85q0WjAgo9+2sleb+kFf
         R+yOSPJX+fWuY7srw8xsgVpcLDR6+AU0vMsqc3wuMHY31LYE+tfJkSbiFxr/1nwgEUfr
         JP9wujoGLFbDupfMzFhpBg0xnd9aHjs6nnWYmlC7tSY+WsqKDLln38lC9WUEIm4Snjcl
         OCQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TbisU96MRe2skCx7OgjTtKX5PJCXvn6QNEzjFenml5k=;
        b=rU7HyIZnFd71FvLD5SpQ843GlBnxwivyETox3BXfzMrjcqU0dPeh3V5ysfFGoQBdCd
         7CCfjpLX3ec8IZ2hdd8MWsVJbsigtkw7ppVacC3URePJzTOFgAawkNEclB/MSi60RmNX
         PBaqJ72uSa6URoDeQI6vreOqZhFYvAMerA6exgOsSbiw/qypY3iX3ypns6cINRZXfxsd
         qfU7TTKKpJFBB1NNHBAYD2+1eTHyxMRXsADN4ZbnY7K8hhVbBdSSzjvjQdHR9jUqMHXD
         S4yU7tO3wq6TZnxgZ2Ak0HTUTQvpiEr9TRT1Jf+yZLI666VIA40C+8GOH7X5y9UqPmHV
         T9Lw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Hui Wang <hui.wang@canonical.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.4 22/33] ALSA: hda - Fix headset mic detection problem for two Dell machines
Date: Wed, 21 Feb 2018 13:45:05 +0100
Message-Id: <20180221124410.768273041@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014646341023518?=
X-GMAIL-MSGID: =?utf-8?q?1593014646341023518?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hui Wang <hui.wang@canonical.com>

commit 3f2f7c553d077be6a30cb96b2976a2c940bf5335 upstream.

One of them has the codec of alc256 and the other one has the codec
of alc289.

Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5976,6 +5976,11 @@ static const struct snd_hda_pin_quirk al
 		{0x14, 0x90170110},
 		{0x21, 0x02211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0x90a60130},
+		{0x14, 0x90170110},
+		{0x14, 0x01011020},
+		{0x21, 0x0221101f}),
+	SND_HDA_PIN_QUIRK(0x10ec0256, 0x1028, "Dell", ALC255_FIXUP_DELL1_MIC_NO_PRESENCE,
 		ALC256_STANDARD_PINS),
 	SND_HDA_PIN_QUIRK(0x10ec0280, 0x103c, "HP", ALC280_FIXUP_HP_GPIO4,
 		{0x12, 0x90a60130},
@@ -6031,6 +6036,10 @@ static const struct snd_hda_pin_quirk al
 		{0x12, 0x90a60120},
 		{0x14, 0x90170110},
 		{0x21, 0x0321101f}),
+	SND_HDA_PIN_QUIRK(0x10ec0289, 0x1028, "Dell", ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
+		{0x12, 0xb7a60130},
+		{0x14, 0x90170110},
+		{0x21, 0x04211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0290, 0x103c, "HP", ALC269_FIXUP_HP_MUTE_LED_MIC1,
 		ALC290_STANDARD_PINS,
 		{0x15, 0x04211040},
