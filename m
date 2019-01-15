Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B3DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C94020656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 11:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="z8h7qLMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfAOLuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 06:50:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55072 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfAOLuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 06:50:13 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so2958765wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 03:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=eQ1RvQDsyqcbI2kYYuKA5kJov6P1VDFMZn9MOVfCwF0=;
        b=z8h7qLMuG4H65WC76Ah3Rk6Cdg9IEtMMSFq8BWh3oaL47ZbVlRRoL7VTRGuw5VzMuB
         pmV8KpBg8uP2kXmQZE7CYBfbqvkpO49SJnSy6j4C9hJYUuRC+KtzbtsEYvHJT4zeiksf
         Ss3SQQu77XW8qx60LeHDBWY3cXjidSQQXcUsChuhdppN9jYIK+eQ2Q50IHiFcxCs8zTX
         17guppGSei7PWrBEUn4/mnOZgLEHNV/2WwB3DNj4Ms4qcYKF+KjGV0hjYSSLwnlgAMaK
         50139gNeF4/QlIBrvL/6gBbyAUGLhN2XfoPzeuSbo1/UsX3TwU7iJ0QWc21XlMSBOAG3
         lHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=eQ1RvQDsyqcbI2kYYuKA5kJov6P1VDFMZn9MOVfCwF0=;
        b=Ver4IaO69zjxGD3MbjzqVXl8pGbx3CK5lzSNWzNFTEJFbWeqo54cvTDo36iz42FYYc
         2Mvi1+k4G29+KUgVn99QfGsMyvaAi7h6s8kv0/AuS7DgWzdtW2OnAhT9aVPP9vgujZU3
         1AxX72gCCxhzMs6ZYFUc9Zldl2slGMxahJV/7lhHpm0iVsq2NjFVQnVTIJ3f/BqIU1pZ
         txAYvrPTL4HJEbY24SQz+UiNXQSq7KClmJywVxBNJbILXXzaG29wNNbhXydnxGSDmZiP
         J5WKj9j4fuzC8dutcEG2iZrDfslTyOWu5h8XUFQCbYA36Vf2AbFLDDrJdIViJ3Vr/BZV
         QTjA==
X-Gm-Message-State: AJcUukcntPChrgKFkfgKZu+48qRirK9EW/C3DmUjUyER0/29a0GoK3AQ
        z2jUpdwJqqsQtTwOBfGyP+mPUw==
X-Google-Smtp-Source: ALg8bN4VWwuvWYflURFUuyWiEj54VsRTqgec/Wvw9CvSIt+x4kGQrjGz5fbE9+zf6z6ncwY/qsKHaQ==
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr1229292wml.121.1547553010375;
        Tue, 15 Jan 2019 03:50:10 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id a132sm40191382wmh.5.2019.01.15.03.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 03:50:09 -0800 (PST)
Message-ID: <5c3dc8f1.1c69fb81.7f7ca.c87c@mx.google.com>
Date:   Tue, 15 Jan 2019 03:50:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Tree: next
X-Kernelci-Branch: pending-fixes
X-Kernelci-Kernel: v5.0-rc2-361-g08b435ee366b
Subject: next/pending-fixes boot bisection: v5.0-rc2-361-g08b435ee366b on
 bcm2837-rpi-3-b-32
To:     Ajit Pandey <ajitp@codeaurora.org>, tomeu.vizoso@collabora.com,
        Rohit kumar <rohitkr@codeaurora.org>,
        guillaume.tucker@collabora.com, Mark Brown <broonie@kernel.org>,
        broonie@kernel.org, matthew.hart@linaro.org, khilman@baylibre.com,
        enric.balletbo@collabora.com
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

next/pending-fixes boot bisection: v5.0-rc2-361-g08b435ee366b on bcm2837-rp=
i-3-b-32

Summary:
  Start:      08b435ee366b Merge remote-tracking branch 'drm-misc-fixes/for=
-linux-next-fixes'
  Details:    https://kernelci.org/boot/id/5c3d7a2759b51458916edd4d
  Plain log:  https://storage.kernelci.org//next/pending-fixes/v5.0-rc2-361=
-g08b435ee366b/arm/bcm2835_defconfig/lab-baylibre/boot-bcm2837-rpi-3-b.txt
  HTML log:   https://storage.kernelci.org//next/pending-fixes/v5.0-rc2-361=
-g08b435ee366b/arm/bcm2835_defconfig/lab-baylibre/boot-bcm2837-rpi-3-b.html
  Result:     8780cf1142a5 ASoC: soc-core: defer card probe until all compo=
nent is added to list

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       next
  URL:        http://git.kernel.org/pub/scm/linux/kernel/git/next/linux-nex=
t.git
  Branch:     pending-fixes
  Target:     bcm2837-rpi-3-b-32
  CPU arch:   arm
  Lab:        lab-baylibre
  Config:     bcm2835_defconfig
  Test suite: boot

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 8780cf1142a59568a3aa77959cbd76b2edb6fd81
Author: Ajit Pandey <ajitp@codeaurora.org>
Date:   Wed Jan 9 14:17:07 2019 +0530

    ASoC: soc-core: defer card probe until all component is added to list
    =

    DAI component probe is not called if it is not present
    in component list during sound card registration.
    Check if component is available in component list for
    platform and cpu dai before soundcard registration.
    =

    Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
    Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
    Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0462b3ec977a..eec92f17dd15 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1027,7 +1027,6 @@ static int snd_soc_init_platform(struct snd_soc_card =
*card,
 				 struct snd_soc_dai_link *dai_link)
 {
 	struct snd_soc_dai_link_component *platform =3D dai_link->platform;
-
 	/*
 	 * FIXME
 	 *
@@ -1129,6 +1128,14 @@ static int soc_init_dai_link(struct snd_soc_card *ca=
rd,
 			link->name);
 		return -EINVAL;
 	}
+
+	/*
+	 * Defer card registartion if platform dai component is not added to
+	 * component list.
+	 */
+	if (!soc_find_component(link->platform->of_node, link->platform->name))
+		return -EPROBE_DEFER;
+
 	/*
 	 * CPU device may be specified by either name or OF node, but
 	 * can be left unspecified, and will be matched based on DAI
@@ -1140,6 +1147,14 @@ static int soc_init_dai_link(struct snd_soc_card *ca=
rd,
 			link->name);
 		return -EINVAL;
 	}
+
+	/*
+	 * Defer card registartion if cpu dai component is not added to
+	 * component list.
+	 */
+	if (!soc_find_component(link->cpu_of_node, link->cpu_name))
+		return -EPROBE_DEFER;
+
 	/*
 	 * At least one of CPU DAI name or CPU device name/node must be
 	 * specified
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [3719876809e745b9db5293d418600c194bbf5c23] sbitmap: Protect swap_lo=
ck from softirqs
git bisect good 3719876809e745b9db5293d418600c194bbf5c23
# bad: [08b435ee366bab63250c375ffea3c94cb02fcd93] Merge remote-tracking bra=
nch 'drm-misc-fixes/for-linux-next-fixes'
git bisect bad 08b435ee366bab63250c375ffea3c94cb02fcd93
# good: [f80eb2d45c4e34750337d1210a78bfe2ebf43b73] Merge remote-tracking br=
anch 'ipsec/master'
git bisect good f80eb2d45c4e34750337d1210a78bfe2ebf43b73
# bad: [e242412b491b4e34643f82c6f422e964beb81704] Merge remote-tracking bra=
nch 'input-current/for-linus'
git bisect bad e242412b491b4e34643f82c6f422e964beb81704
# bad: [eb1c2383c8b929fcc5a56f5698ff3fe3d0ec54e6] Merge remote-tracking bra=
nch 'sound-asoc-fixes/for-linus'
git bisect bad eb1c2383c8b929fcc5a56f5698ff3fe3d0ec54e6
# bad: [04eb1efcd614d6f067b76a355b3a3599667959dc] ASoC: soc-core: Hold clie=
nt_mutex around soc_init_dai_link()
git bisect bad 04eb1efcd614d6f067b76a355b3a3599667959dc
# good: [a41d9dbf5dac5b6a1283ee8001f22807d18352ea] ASoC: qdsp6: q6asm-dai: =
Fix a small memory leak
git bisect good a41d9dbf5dac5b6a1283ee8001f22807d18352ea
# good: [6175471755075d256c1c654151fc1cad183c1e33] ASoC: ti: davinci-mcasp:=
 Move context save/restore to runtime_pm callbacks
git bisect good 6175471755075d256c1c654151fc1cad183c1e33
# good: [44fabd8cdaaa3acb80ad2bb3b5c61ae2136af661] ASoC: atom: fix a missin=
g check of snd_pcm_lib_malloc_pages
git bisect good 44fabd8cdaaa3acb80ad2bb3b5c61ae2136af661
# bad: [239b8b34a856777e562373ae0de605536a7ccade] ASoC: Intel: Boards: move=
 the codec PLL configuration to _init
git bisect bad 239b8b34a856777e562373ae0de605536a7ccade
# bad: [8780cf1142a59568a3aa77959cbd76b2edb6fd81] ASoC: soc-core: defer car=
d probe until all component is added to list
git bisect bad 8780cf1142a59568a3aa77959cbd76b2edb6fd81
# first bad commit: [8780cf1142a59568a3aa77959cbd76b2edb6fd81] ASoC: soc-co=
re: defer card probe until all component is added to list
---------------------------------------------------------------------------=
----
