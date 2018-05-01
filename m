Return-Path: <broonie@sirena.org.uk>
X-Google-Smtp-Source: AB8JxZpKxwNfzYnUmkYwwLBVKG0uTb1obaaMh8XF3txeRrth5BahOENOYHDyDyXVMJTx0fA75ZGu
ARC-Seal: i=1; a=rsa-sha256; t=1525208967; cv=none;
        d=google.com; s=arc-20160816;
        b=Y3HtD3FGtwLy+CyX1h44SqfwN9Zi7Ra/hWYbb7v842EIG0WbLKxKBb07y0l3y0G6So
         d1HDooASgrxa85Z4TAvwMw9hZOGzwyDIs5Bb4ON5JBQICCb5L9FPrpcgf1NFun8BA0Ua
         RuryGCk+mTFp4YHAJxpFXVRu0LDh4mjxW3PatOTTeO5mljsk0mwA0t9Ga4b6jGqgMsES
         zG9p37yGQeVa6QYF6qFKmlENNTKk8yWKKn4J/DrrQub47s9Zo6WBTNMS33IFD/zcMhRd
         WrV0CnMk559WBofz7yrT3qjSY1VvkgDax/wBoKDkJ1rVYUnAEh7B0Ca9h08HbwmnVqQk
         yEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:in-reply-to:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=FcIdcNVUYngOwxa+60OdtwqZciH6ZChnbF3NjAwR/u8=;
        b=j524v9A/44PM6sXQ7jY6/RxshSaAXQoDSQhYsicyhtn7g5zUDx+Kt/9B4tkt/ou0O6
         G6r3uO+2icuGMwX39xS4ewmYKeGZdu4/hWGVv+ghzKsYgaf/op4a68ESZjU6y9RMUMxu
         I0u+Nig8pnwHsHFjUVFuTsqg9cMQsP6heBHwgSlap9x1d6vQgvW/DuWJCwGiG20GNsUU
         M22xMfmxnuV0DiOtqC8NLDy0o8wVBtVlIwe3MAyDlahTiyLQW0D/dDKyDdasTXjnbtCW
         2gEkEwLoiqMeWALadZ5UnlnJKGSQQx36PhwLqDAiJiMC1/OX8RlTMuUBUT0PmbbKqdg6
         +jvA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=E6BfSgPA;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
Authentication-Results: mx.google.com;
       dkim=pass header.i=@sirena.org.uk header.s=20170815-heliosphere header.b=E6BfSgPA;
       spf=pass (google.com: domain of broonie@sirena.org.uk designates 2a01:7e01::f03c:91ff:fed4:a3b6 as permitted sender) smtp.mailfrom=broonie@sirena.org.uk
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Linux-ALSA <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
Subject: Applied "ASoC: trace: remove snd_soc_codec" to the asoc tree
In-Reply-To: <87vadh3pz1.wl%kuninori.morimoto.gx@renesas.com>
Message-Id: <20180501210918.C776144007A@finisterre.ee.mobilebroadband>
Date: Tue,  1 May 2018 22:09:18 +0100 (BST)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596147306520976293?=
X-GMAIL-MSGID: =?utf-8?q?1599297518191290901?=
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
2.17.0
