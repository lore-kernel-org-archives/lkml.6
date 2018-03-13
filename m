Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuDP2ypVwAx/GzFnODKw0z7iEYj9OZeERNH8dMd587RvsSWTVWDNHMEN5lr01U65VPpqa7H
ARC-Seal: i=1; a=rsa-sha256; t=1520955132; cv=none;
        d=google.com; s=arc-20160816;
        b=gZp0+7F65mCPXKVJOOiBLQs2hcHa3KUwry0wKrh0torMMmVkBDclXrdt1F8CNeu2SE
         Qn+MIl9VYTY32QA82p40EBIew5o4fbE129bp9DQO2/cEcfEyFKr6w76+Uq2EUelc3P1M
         134R4cOdl+4L58EOgKQJCTrvV74N/6hlunllZ1VU5CE9V9UYh5tpDxP6FWn+w75Uw4/B
         /9P5kw4WiprkMI357EzaoL79MLbrKoN3Gha6fjZuDEl8HCTTbB1tn1lCOaIVwGf5HA3Z
         lcGV8BNm5mjQo3kbNcHIfquN3pbZtHZz/DZ9uLCd+eUpVCGlvIJDYPR4K4GG0tafwp9b
         aamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=EsfguVCXJWVkMi5GvqtJy0in4vR9TPgN8gTM2mnxHiM=;
        b=GWJMJnIXtIzHGCaBok3LdUIg6VcshBcRBasHBs01CwZYty6ds0H4bHxxL+OOBH7blr
         3gQttGVeI0w1lej9G6Rz5v8CKXexMrBweFSVhG0/MI/nLavgtRTWPCHrP97n9rheY9hB
         E3tlnEnVaPV64JD0DHA1qjtpS8g1KDg0ujyxlF4oZlZBXzK0Rm/htMDtpO4cf7Y0GEu7
         YWUQ/9zPqMPov4m+A6QXLbo1rhHx0tj4QumTDbyNdP4w+VINjjVfH5SCQ1xllknxOAI3
         rUoc1B2XPCdh4MsCqkakzV9lvRtu51yzfw8DUUAl3CNVPeabINWrGdwZzb1c/Qjf2zwi
         o35A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Kailang Yang <kailang@realtek.com>,
	Hui Wang <hui.wang@canonical.com>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.15 073/146] ALSA: hda - Fix a wrong FIXUP for alc289 on Dell machines
Date: Tue, 13 Mar 2018 16:24:00 +0100
Message-Id: <20180313152326.382667346@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152320.439085687@linuxfoundation.org>
References: <20180313152320.439085687@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837049220618613?=
X-GMAIL-MSGID: =?utf-8?q?1594837049220618613?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hui Wang <hui.wang@canonical.com>

commit d5078193e56bb24f4593f00102a3b5e07bb84ee0 upstream.

With the alc289, the Pin 0x1b is Headphone-Mic, so we should assign
ALC269_FIXUP_DELL4_MIC_NO_PRESENCE rather than
ALC225_FIXUP_DELL1_MIC_NO_PRESENCE to it. And this change is suggested
by Kailang of Realtek and is verified on the machine.

Fixes: 3f2f7c553d07 ("ALSA: hda - Fix headset mic detection problem for two Dell machines")
Cc: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Hui Wang <hui.wang@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6793,7 +6793,7 @@ static const struct snd_hda_pin_quirk al
 		{0x12, 0x90a60120},
 		{0x14, 0x90170110},
 		{0x21, 0x0321101f}),
-	SND_HDA_PIN_QUIRK(0x10ec0289, 0x1028, "Dell", ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
+	SND_HDA_PIN_QUIRK(0x10ec0289, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 		{0x12, 0xb7a60130},
 		{0x14, 0x90170110},
 		{0x21, 0x04211020}),
