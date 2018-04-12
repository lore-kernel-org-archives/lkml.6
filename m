Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AIpwx49nASE7cjZMYiQy0tG38j3ktU8WjUKsVHMmANe2JwbluULrq14V00X36ch48Z9Emzep0gxp
ARC-Seal: i=1; a=rsa-sha256; t=1523549838; cv=none;
        d=google.com; s=arc-20160816;
        b=0KIn5J18NOA5RXmOy35BhxY0QkDJ4i+oKJjsaOueVVBd1shc6lL2TEPmAYBe8I5e2w
         inBUyTR4GbyDbfAmC7iWOdyaXvvT1IUEeUJ+6wFbVshdbc89g7U1LoiO95fnPO99uj0Z
         kUvwgSkKkB9wJcNN8d3B8y+iGNrKAGKE+0g3iUlgx2XULUQ6UPHmknOwzG7KQBhh5ytM
         l+11s+bcZhTMNlQj3ocVBwNo786RvXw1EUtT/AqCZULkS0s7Myw8zOaRsn+eHoI4ZkAA
         16rUcP/C7sZe6mwpJzuLdqRpozjVDooaJ3Gk420VGruN3t8jhDzrHui6T5elCyIB4pJa
         e3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=SuMqc3dMzj6/7MWbNR2gWFH8hnKMXIPE/5MUEnYYGiY=;
        b=dG3i2wBBhdH17a21ie/14ZQkHkiw4EYcAfWNk48dMlAp+WLfLm+RYc39bZxo6V1Gpk
         nFcoIhOg46+jNoOBBvfURtjj/a3cIEAacajUAkqPSXd+R2UikEvkt4unsrJYgIxzxJNz
         rBWNjlbGtVhhTVWxkmz1LtzPWmxA5l2XNpVY0KlqKmFJ2Cj7jDb78qyekc5HhMauwq4i
         tk4rARXtkCHEc5bWQEvCSrIbWvObmm7Z/85DqnBnq3j9zOzTyY7C66eWhJUIMnh+RZul
         r0CqFz0gNWbowlTAvJlb9p+d+pPTyN7+YUgApPVtncAXyvvm898ZbqywYIZ8uucZq7pU
         depg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=HsCPs+pj;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=HsCPs+pj;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Linux-ALSA <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: trace: remove snd_soc_codec" to the asoc tree
In-Reply-To: <87vadh3pz1.wl%kuninori.morimoto.gx@renesas.com>
Message-Id: <E1f6euL-0008KO-Vb@debutante>
Date: Thu, 12 Apr 2018 17:17:09 +0100
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596147306520976293?=
X-GMAIL-MSGID: =?utf-8?q?1597557795724163426?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The patch

   ASoC: trace: remove snd_soc_codec

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 03a364502bebb5f464853c6ec5d49e85195600ca Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 28 Mar 2018 02:18:13 +0000
Subject: [PATCH] ASoC: trace: remove snd_soc_codec

snd_soc_codec is replaced to snd_soc_component,
and it is not used in this file.
Let's remove it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/trace/events/asoc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/trace/events/asoc.h b/include/trace/events/asoc.h
index ccd1a3bdff46..40c300fe704d 100644
--- a/include/trace/events/asoc.h
+++ b/include/trace/events/asoc.h
@@ -12,7 +12,6 @@
 #define DAPM_ARROW(dir) (((dir) == SND_SOC_DAPM_DIR_OUT) ? "->" : "<-")
 
 struct snd_soc_jack;
-struct snd_soc_codec;
 struct snd_soc_card;
 struct snd_soc_dapm_widget;
 struct snd_soc_dapm_path;
-- 
2.17.0
