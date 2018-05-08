Return-Path: <SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZqlNd6b0to5iLuBZV6uisY+5OxO+W09ibtPiVV7RU0meFaz8mofFA9rLMAMCnrlGXO2pd6r
ARC-Seal: i=1; a=rsa-sha256; t=1525767118; cv=none;
        d=google.com; s=arc-20160816;
        b=q8ErbaQwLVnwhQUeuSf4noAn9U4cjHMITUzLUw0xdLlPNBSfMYkxNFSFfBnEIMZvLx
         0wrwFzamm70jZqKWMx8Kz+3JQ7o3DMjtdYiBqbX1lxMIsmWxHVmo4770q/XvifPPLNiN
         FtWLlyHgVnvSzRSABOx1n5eNM8EfFTGEn/sPjbMjbbTeCBTjkK7U6TjRqQ3+oDVdO39Q
         W5mNl6obK+IF7I6iAos6XzG4V+RMqJ3F2kMlTsPIB5yxn2onEFMwWOSqQla5Xh7Li8Rd
         UwE06zVCqkU3vlso1dOBgHBMe0GT8sF6jlAsRUJ7OA2jCEy2QE3uRkEQPMJuhj56pbwp
         dlyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=VoWI9t5JyBi2lOEMSuQzGXWdxCJD4HxtbU6BfXI6ICo=;
        b=Vn/Bji77lheS210otnRkKRYjhBOK63Lg/nt9pvTNYdXFE6SRQj41OMT+w7DXyVEabA
         4TnaaBEPlSk8DdXCJ+9wNVx5zKjBv7/CPltNGfWIUKILRpZEuH8qsb6nceR//EM/1u2R
         IaHfxRSE8a3TZWsSP0SfIF97/d+ocgnsK+E6S4A0tTOFunbi1FWr6f6nOFWZSzblK9Ur
         /155qAyKWvGX+hdoXoLBFOLe9SXQShYsDBfZjsKdFFaZCGbaXH9XonU7ualri8qsOQWe
         nZ943k7CGGAaPGdPay3LuXUnyMtZ1A7lmcNsZEHzYEJ4UOINyJA6X+iFn3ZehHg0GK6c
         A3EQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GkiqIucf;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=GkiqIucf;
       spf=pass (google.com: domain of srs0=4in3=h3=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=4In3=H3=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.16 03/52] ALSA: hda - Fix incorrect usage of IS_REACHABLE()
Date: Tue,  8 May 2018 10:10:01 +0200
Message-Id: <20180508073928.496691064@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508073928.058320984@linuxfoundation.org>
References: <20180508073928.058320984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1599882781942424191?=
X-GMAIL-MSGID: =?utf-8?q?1599882781942424191?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -3832,7 +3832,7 @@ static void alc280_fixup_hp_gpio4(struct
 	}
 }
 
-#if IS_REACHABLE(INPUT)
+#if IS_REACHABLE(CONFIG_INPUT)
 static void gpio2_mic_hotkey_event(struct hda_codec *codec,
 				   struct hda_jack_callback *event)
 {
