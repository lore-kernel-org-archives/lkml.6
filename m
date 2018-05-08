Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZo+NY/wW18BIrUtusmjoegY1dBozmuxAQAsQP4oMxLYboWpKRPkB+VEDtef5bW7XopdkTuw
ARC-Seal: i=1; a=rsa-sha256; t=1525767276; cv=none;
        d=google.com; s=arc-20160816;
        b=n2Zq8HbqcKvkOVekQRnp1kjGlKeucfaRdzBpr0KDbHkRD+tbM4Wjy2FwjOmuiHNL7X
         ojND3BJMTyxP7GYBBqm/9nLThqZy9oN8CXDrp3fFutxWsKBqXWiWBwt2M4EfuktNJcOZ
         PF6YnXFyoT0fwzocaPXWFjGv+Y2TccUIaVRkY+sEBUxlgA2g2VZHLLqwSwORoFFSyUEO
         hfv44jLR4ghaUSqXfqCXlCM6I0DxYUgXeCt0aPQ9RBUR3iH5WQOyddKf+MjBi6MD5Obf
         ZMBowdYis4bknsPTJl7qjG6wc/lftRL5YmDAAgryCww3/GSC0+J+BMwgRAYSWTUYjoy2
         cyQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=Z9F3B8MFpkqhsPFuD6mFhZEGy3fPSKLskCqXqnj32co=;
        b=WtIq8fVLZEjmkR6MF8HcP3chKPtnPtzdnuj6j2L9/SJv0lnDpHMuVfzsAlbH1pPWc/
         bIv8SBV+ysk466X0FiiJdAsdLDQBtYwJXRdkXtwSNjqzVk4Z7giJTuMRQKiOWBvhq4M/
         ci1sIcY2XDh4bym2V1+nO2AMHQT8lY4eszHIiNGulCeV6S8lAWoYUGGbe3ahNY9kSZJ6
         LcIOFM+EUJVy41rFmpZ+LZE3TPQW+vMI8A/Q+SQT1Io7JmOSknDYAUI5qBnCRi5jW66N
         9cfw/a28mvSISf7nnwrckIa1a7JLBH+AI+z6t9sDhLCMDOI0f7AHqxzzhmFV+C9M87nu
         YNRA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ostAnIDQ;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=ostAnIDQ;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.14 07/43] ALSA: hda - Fix incorrect usage of IS_REACHABLE()
Date: Tue,  8 May 2018 10:10:26 +0200
Message-Id: <20180508074005.206318855@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882781942424191?=
X-GMAIL-MSGID: =?utf-8?q?1599882947479292661?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

commit 6a30abaa40b62aed46ef12ea4c16c48565bdb376 upstream.

The commit c469652bb5e8 ("ALSA: hda - Use IS_REACHABLE() for
dependency on input") simplified the dependencies with IS_REACHABLE()
macro, but it broke due to its incorrect usage: it should have been
IS_REACHABLE(CONFIG_INPUT) instead of IS_REACHABLE(INPUT).

Fixes: c469652bb5e8 ("ALSA: hda - Use IS_REACHABLE() for dependency on input")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3722,7 +3722,7 @@ static void alc280_fixup_hp_gpio4(struct
 	}
 }
 
-#if IS_REACHABLE(INPUT)
+#if IS_REACHABLE(CONFIG_INPUT)
 static void gpio2_mic_hotkey_event(struct hda_codec *codec,
 				   struct hda_jack_callback *event)
 {
