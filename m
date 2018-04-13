Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AIpwx48V1viSyNpfQKvABk8Jnwf/rG6SrfGrFJrmBw+bGuY9bwVFElbIkdETqoke2tA5qm/JNzOf
ARC-Seal: i=1; a=rsa-sha256; t=1523618713; cv=none;
        d=google.com; s=arc-20160816;
        b=jYoAGjURhuKyYAw2RPmwNPerNbmYXdhRF423TFV/KlzWLVejan2RKImvhPJRn1bsqL
         xJzWCqbvlpQJSaYmr1xbU2EpWjj1RJcAUBhstkHgSQ6MHAc9ifmsuIAvFK9L6RzNWfNq
         rVT00hT3STzgqB4syOZkqhBY5jA33eNwFVLPM22QpPnOxp2zNOguqDvkn4v8oOn2glcx
         4Kyk2DKo6Z12zktI27hYFaIE1efC9b9/gcvCKgnYm1Cs9TWadiOOiUtuY/SkkHo3VQiM
         MkHz9ksuuK9Ins4iuVNG9AfUUqpwGCXUjvGyXjNv511TCYDjM7sMiZ7iEjTEW/E37728
         BgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=SuMqc3dMzj6/7MWbNR2gWFH8hnKMXIPE/5MUEnYYGiY=;
        b=FbE/IJSEMOjAeTT06K8OrPT89SzoWB8NgLIRRlMgvOVFWtlXusQIWSzBROVFA98EDt
         pLhgC6AEakYjnwcZZJ0i7HkOToevFikvwNolrlHc48V3vZW0Hk6x4ban0pOyjZT61Dbc
         5RUIroYcowt8ZDdOYIL/bI75g9EcaaGJwUQNbhfKTR99ovo/WuKv4Z92o5zon0B0Bkna
         3jrPQeopLJVvFWqjTaujG0iZo00WAH8ft0QmfvsMYMNd8eFCMFciw+BDEDBYgH0rQy8n
         W3gvPmsxTHl5ERXGg2uNULOkgaAiN9uyz3e0HMPcMxz+8TwR8sSXvboYxyg88BNeiCLa
         ga5w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=cDU3kF1b;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=cDU3kF1b;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Linux-ALSA <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: trace: remove snd_soc_codec" to the asoc tree
In-Reply-To: <87vadh3pz1.wl%kuninori.morimoto.gx@renesas.com>
Message-Id: <E1f6wpH-0000OO-Ue@debutante>
Date: Fri, 13 Apr 2018 12:25:07 +0100
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596147306520976293?=
X-GMAIL-MSGID: =?utf-8?q?1597630015885342484?=
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
