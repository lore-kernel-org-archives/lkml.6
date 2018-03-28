Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AIpwx48aI43hHi6cwfdCr7JA3vw8WLxM4RRpKXFe04VpQGRUvwpDCuPYByM/Y7LAzkTbh6tYG88F
ARC-Seal: i=1; a=rsa-sha256; t=1522204691; cv=none;
        d=google.com; s=arc-20160816;
        b=0f4cfSKuPZjFuHxS7m4kAshLFGtAYjI5rj1jXn0v7z4+8OA4wpv66BEKtC0jaltslU
         D5mQ/mNCerXM4YQZTS0uge6SKWZ/DwDN12dLRS5sABfg+QOgzDpk9iU18+OZ0UXZVww0
         5tVYpY2ME0hgXQy/R7IGQI6n9beMWNpTtVm6IY/8lA9A4pbNQBfzGmW/TJEgp0oGDWFw
         OFYAJp3kQ4DFt9u24XF5kjeuIhVLGUaqK6iwoLeAF6X3amBY+FITzbHyluQIay3T1gnw
         iJCi82tZSXuQMSnFCNOBg6VME7e1FtUw8Djb45nbrIN/XkYUMR0gZygjS3QQSz97K1jk
         zYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=iffAyOvCDIFpFnnFLwcofzMT7hyrnaGHX70xJuOlBVU=;
        b=orGnF0nyLMDyQIbD1ggg/gGrZkPc3jV2u/rfazmCk6pspxAMmf6gDE2WEKjvsE+CP4
         sWAXz8f44JWWHftTbZ7olKQwfGLJ7H36nJRwF276oPudFNQVccGMFHmMaBiePLZqqqnN
         35kD9QGRuzELe8WIGzgwXz6scjq3SvP0SrI0m7nAD5dkLBuvaIf/AQCGUXdqgqTKbZVh
         XottSrtMeflqbeMa8daQ8P9iLdBTukQmEZaKmIbfVhTq2mxPWA+bJYkjVzBOV9y/j/CG
         KK8qQPI8E+eGTJv8NJpLJbVi28IJ0aqg/fCf+kTSL/nkWfLUdMFAN+KB3Vb9Z0FVjKm2
         EhIw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=Zefnt9q2;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=Zefnt9q2;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Linux-ALSA <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: trace: remove snd_soc_codec" to the asoc tree
In-Reply-To: <87vadh3pz1.wl%kuninori.morimoto.gx@renesas.com>
Message-Id: <20180328023803.0810944007A@finisterre.ee.mobilebroadband>
Date: Wed, 28 Mar 2018 03:38:02 +0100 (BST)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596147306520976293?=
X-GMAIL-MSGID: =?utf-8?q?1596147306520976293?=
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

>From 211b4415ecb254e167837206756dea123342689c Mon Sep 17 00:00:00 2001
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
2.16.2
