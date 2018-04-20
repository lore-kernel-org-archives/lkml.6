Return-Path: <jorge.sanjuan@codethink.co.uk>
X-Google-Smtp-Source: AIpwx4/CLZa66eSOexjS6Ysvds0bLF/vfNCEj2jT1xt5ghWKEC3CMwYZo2hmDMvrEAm91zvJpSMa
ARC-Seal: i=1; a=rsa-sha256; t=1524243820; cv=none;
        d=google.com; s=arc-20160816;
        b=Ds4uMbKbti0yNw1APWLmrgvg8zFBm8czsXSRSiicifSuDT3nkzLLNECE+kdA7P8VPL
         1Ulm9bZ71wO71VW77vULqEM3zU8M5SWfV/S0DMqWloU50AJo83mDf3eZuRv86y8cH9l3
         /N+OC72LxGkKwmIfmnmiOe93IohMA0Ej8v3SmBtyz3bcmd5kvfl3int8zX/8G1WdgqNH
         nBsVPCHKdgv/FWM5QNX2dp71m/if8ZccOHgnUV0so3076+Ij7vaYGeagAx2+xEn5eY0g
         6c/o+RXOYZVnspazEg3P4fM0QkSFUkp3N/9fD0OmfR91RRHfSH9q9W2kYHUKFMi3Zv9B
         mFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=XSUFj/rnM2wvkkzTb5CWv+T3ENM4/ujWBA3LYpLAFT4=;
        b=XQxaqXzPnIsTqSi5Knx6bf37zHPW4JEl7JJIsH8cWX6F85FLetOqnCGOA4PEkLm5KL
         +KzLcuZkvi3AsxKOukFCZCa5xJ6NUE7QwPUf8MsrJis+OpTZDWyC/xR//o470U4grb87
         E0roqaa3XLVROOR5X045GVJ4NIYFtjFriRdcuGwrv4X/h0Ni7F9vQTwIsd9KYpBY+AUG
         BZEUFeE+kw/Jqq9zAUjNo8QzDZOrcRXFoG/GGDMdtXfqZiDSBwyPB9rZTTtviUIKdGQN
         NaMGvA/feC+YvY2X0k9opG8BKyJH5ZAy0I2id5ShWIynrg9f5fUWCiqAkvirPimM39z5
         vglw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jorge.sanjuan@codethink.co.uk designates 176.9.8.82 as permitted sender) smtp.mailfrom=jorge.sanjuan@codethink.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=codethink.co.uk
From: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Michael Drake <michael.drake@codethink.co.uk>
Subject: [PATCH 2/4] ALSA: usb-audio: ADC3: Fix channel mapping conversion for ADC3.
Date: Fri, 20 Apr 2018 18:03:25 +0100
Message-Id: <20180420170327.31569-3-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285488536876967?=
X-GMAIL-MSGID: =?utf-8?q?1598285488536876967?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Drake <michael.drake@codethink.co.uk>

The channel mapping is defined by bChRelationship, not bChPurpose.

Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
---
 sound/usb/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/stream.c b/sound/usb/stream.c
index 6a8f5843334e..956be9f7c72a 100644
--- a/sound/usb/stream.c
+++ b/sound/usb/stream.c
@@ -349,7 +349,7 @@ snd_pcm_chmap_elem *convert_chmap_v3(struct uac3_cluster_header_descriptor
 			 * TODO: this conversion is not complete, update it
 			 * after adding UAC3 values to asound.h
 			 */
-			switch (is->bChPurpose) {
+			switch (is->bChRelationship) {
 			case UAC3_CH_MONO:
 				map = SNDRV_CHMAP_MONO;
 				break;
-- 
2.11.0
