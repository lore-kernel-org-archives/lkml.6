Return-Path: <jorge.sanjuan@codethink.co.uk>
X-Google-Smtp-Source: AIpwx4+mY36S/KCUZEJkHIAonPgmO8lcsOpLivTRCtstOaLPKdYmspO3Uz6el48yhoDZAndTp9vX
ARC-Seal: i=1; a=rsa-sha256; t=1524590697; cv=none;
        d=google.com; s=arc-20160816;
        b=KurJYnvZvqwHzo/w8PDBdEhCVd4mijfiYTZ4swchtZ1PBQlT4sK9dUEi2XLqbyILCi
         Oz91xyk2AuTE82vSwoiohXt4IbnLl6uM+p+Kng+Ua8EBwAzws0KvKVKN3u5C5qhZInis
         kXQfTIBJax8TpirpmgCYjFsPYPspwsbBDQOQq2nhQz+1A15PDGM31KFDI7J6tBHATArH
         lsUUupOVANt+EsqBNTA+7930P1mq+SifMKChwtn3wZGvkwaQgmlpNQ0cp0jcKnbCMAeS
         ZoDvLm+jeUADoGRj9B7kXc0JLUNJRkPJUE1EM6CbbWDeT270OPBneZz2lk0IrAwrq42g
         0UHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=CeCZd2qiVNsjiyYGAPXv1LdlRhzGfUySnUWgFWh9ozE=;
        b=yXVmE5WvfRFPxluSLVvCTzD7eVb9OSLhnlId6V7jFZZ3HaVWMKu71swzeE2Eckfzxy
         SLndN4U+yHTmOyhnDsPNDjPTTHBBvsz7ojkJhHruh8utFvXS4q1+6sstkKdibPdxZds3
         YWfHp59A+IbUQek1GqDPKHc6bcwsMYwzXErHy48H/dCTCb/Zfda3kAQeuXobPbq+XNIe
         ry+QEpwXf2R36oZNIGZ+JB82Isz/sJiklBams/LeQlc8uAHUKhQorOrtKXOx327CjzD8
         ypyuDiSgDowSP56vxonxFAp1sXJeIxRItQMo7agEArsSFrAt+A3m18EZ+Dfb/5L1HwiV
         9z9Q==
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
	Michael Drake <michael.drake@codethink.co.uk>,
	Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Subject: [PATCH v2 2/4] ALSA: usb-audio: ADC3: Fix channel mapping conversion for ADC3.
Date: Tue, 24 Apr 2018 18:24:43 +0100
Message-Id: <20180424172445.31928-3-jorge.sanjuan@codethink.co.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180424172445.31928-1-jorge.sanjuan@codethink.co.uk>
References: <20180420170327.31569-1-jorge.sanjuan@codethink.co.uk>
 <20180424172445.31928-1-jorge.sanjuan@codethink.co.uk>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598285488536876967?=
X-GMAIL-MSGID: =?utf-8?q?1598649215097018081?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michael Drake <michael.drake@codethink.co.uk>

The channel mapping is defined by bChRelationship, not bChPurpose.

Fixes: 9a2fe9b801f5 ("ALSA: usb: initial USB Audio Device Class 3.0
support")
Reviewed-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Signed-off-by: Michael Drake <michael.drake@codethink.co.uk>
Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
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
