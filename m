Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt7EderrxfGsv+YgZT3x+hbkzkymzQ2cM1YpXkgSQDtDHjq9V1pOKQrHf1zSkrGkCeCuCVy
ARC-Seal: i=1; a=rsa-sha256; t=1520955608; cv=none;
        d=google.com; s=arc-20160816;
        b=0J0iEndW5pW/cDDvCtiuujlnN71WYA0KE4pUqqjvKpilCAZs3V5Z4ZMpAE30wZtMc0
         QMH2MVQCNM7mETf4aKtV6KTbWHYTB1wqMeYFp6aTBZHwH1nFnRK0XtnDZslbtAx+Gx3U
         HwC3GZV9vNYAO6t7LHMgOrA48CaRYiKatD7OS3q+Q6QOu5zdIxJooDkSL6aseot1Iwx9
         2c4CBsKbD/Jz31O8pyA7Z4fUSw9wmGS9A8Q7OU0kGGzMc9JKNzfiM5+684g5zei2whyv
         exDFEkf4FmIc7doitaCXOAmovkqdZ3B3z1v3ohMmF3o9By6QyPRh/Pq7CdlBlJcv0vAt
         DqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=nJscDpThZE3DXP0ppY45sOcMrX7JUJOnC2y6VuaNrYQ=;
        b=WSbWxTpMLjjIEFaxr2jIj3C1V5noc4Yoi7mDaTs8olPdrCFgN94sl1QU1S3+t7FtXW
         BTVisBgr3272HZIqtuEJk6hsWPOVkXm565CQLaYYYacg6xd6ADBkTIYz0cUX/N4114uB
         S8XypJXgYs9huNWy+3xvA+9/7pFh+KXAKNBfehnTdcTBL1V7vY9EZrFpJGoaiYmaGa6+
         eDsVjbk0R+A0T6yy5bqfhedQDW2rvGXmPne068RbVrrwTPROtVSMcnnjFlFXXJg+CGXr
         3X0Q9eyJ8nrxORQsB7r8JShRp/rRG1PmNFQZ3ZF0GSqB4bQokiNQrbqL+j55ZFO2RHIA
         0olw==
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
Subject: [PATCH 4.14 108/140] ALSA: hda - Fix a wrong FIXUP for alc289 on Dell machines
Date: Tue, 13 Mar 2018 16:25:11 +0100
Message-Id: <20180313152505.396668101@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594837049220618613?=
X-GMAIL-MSGID: =?utf-8?q?1594837548145768920?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -6765,7 +6765,7 @@ static const struct snd_hda_pin_quirk al
 		{0x12, 0x90a60120},
 		{0x14, 0x90170110},
 		{0x21, 0x0321101f}),
-	SND_HDA_PIN_QUIRK(0x10ec0289, 0x1028, "Dell", ALC225_FIXUP_DELL1_MIC_NO_PRESENCE,
+	SND_HDA_PIN_QUIRK(0x10ec0289, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 		{0x12, 0xb7a60130},
 		{0x14, 0x90170110},
 		{0x21, 0x04211020}),
