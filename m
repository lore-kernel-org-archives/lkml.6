Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B131C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD0D420657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="SeDTKiTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfANNrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:47:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40129 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbfANNrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:47:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so22918269wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 05:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=Hqh4c45HtyR8geflyTast68dHbtj/0QEwIpIbOpnbOE=;
        b=SeDTKiTgGzcfbEbCu94D3gp4EWFPS0l8d/NnLJX3vt//0ZepeF6ou7+SfiRTuuE/ip
         LpEGF4zFU79p8LfQWipuMNNg0vkEeilBrrDG3HcGIJOgFUyoTsziQMpoJXq3sV3Pzx+C
         Nu0SjzFQqJ4Y9Zf98AMqoa1Mca4rFfrXUMei/5YkasavVNv1V+0l0s5zOqtHZBm/Sk0r
         mL3SdaCkMwqjGvq+6HXEuMXsjyZ5HSpj3DgBYMWpZvKT9UecFnvLR0aWKj/wKXfxHFJD
         P9Rq/DFN8hnMYvqeUchn1lLr9ziUT5yIZTQ65K0/X6jkt1OeHQ+YEtZsh0CYfwHpzrKI
         YG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=Hqh4c45HtyR8geflyTast68dHbtj/0QEwIpIbOpnbOE=;
        b=NOe88G8tFHlqOJF3wY5SExEJggstSFXXS9b4UhVI2UMnenpAfQdUnxdsUH902JG7QW
         VXtaU3AP3c459nu9mxBXXBsthUIBddO6yupEwZ6vOGnox9PcD2KDvCYynXpbMMLFFuHD
         m/bNXZ7LoHPQ1PtGSi/3EgyAHvW4I/Br7sW03W0PSuUJmd08GjBM4DMja7hmowLZoRq2
         PgXdUf7sOfAudrZWpmQmkK/MrTk0pC2MMze9YneUVxeRzkPU6U3kefhaLRwAPRjEDN2L
         eWtqmbGal7DuxcgiUMsKzo9bK8GztEEk36cp/5X1ko5Pf/CTE7GWNwD30UyNCHuerwK+
         c5Mg==
X-Gm-Message-State: AJcUukeOYiCL2qJCALG4FvWQoPlhCxy19ER7HOg3VwtclKC/ABpJL/4c
        gBjkIpFx7BJHdtXfMhiCAn2n7w==
X-Google-Smtp-Source: ALg8bN7rzyugdpvAxEUxH0KSE23xbHKSn9+cDr3opaWFhElxkT1Awf8vQE5JkJMc4NTA2k6t3XF4XA==
X-Received: by 2002:a5d:4382:: with SMTP id i2mr24230000wrq.172.1547473633369;
        Mon, 14 Jan 2019 05:47:13 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id v4sm26478762wme.6.2019.01.14.05.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 05:47:12 -0800 (PST)
Message-ID: <5c3c92e0.1c69fb81.36483.c948@mx.google.com>
Date:   Mon, 14 Jan 2019 05:47:12 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Tree: next
X-Kernelci-Branch: pending-fixes
X-Kernelci-Kernel: v5.0-rc1-535-g727b373740d1
Subject: next/pending-fixes boot bisection: v5.0-rc1-535-g727b373740d1 on
 sun8i-h2-plus-libretech-all-h3-cc
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

next/pending-fixes boot bisection: v5.0-rc1-535-g727b373740d1 on sun8i-h2-p=
lus-libretech-all-h3-cc

Summary:
  Start:      727b373740d1 Merge remote-tracking branch 'drm-misc-fixes/for=
-linux-next-fixes'
  Details:    https://kernelci.org/boot/id/5c3c41f159b5145bec6edd6d
  Plain log:  https://storage.kernelci.org//next/pending-fixes/v5.0-rc1-535=
-g727b373740d1/arm/sunxi_defconfig/lab-baylibre/boot-sun8i-h2-plus-libretec=
h-all-h3-cc.txt
  HTML log:   https://storage.kernelci.org//next/pending-fixes/v5.0-rc1-535=
-g727b373740d1/arm/sunxi_defconfig/lab-baylibre/boot-sun8i-h2-plus-libretec=
h-all-h3-cc.html
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
  Target:     sun8i-h2-plus-libretech-all-h3-cc
  CPU arch:   arm
  Lab:        lab-baylibre
  Config:     sunxi_defconfig
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
# good: [6b529fb0a3eabf9c4cc3e94c11477250379ce6d8] Merge tag 'for-5.0-rc1-t=
ag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
git bisect good 6b529fb0a3eabf9c4cc3e94c11477250379ce6d8
# bad: [727b373740d1d3c6d3273cfc6e81d5e9a229b12d] Merge remote-tracking bra=
nch 'drm-misc-fixes/for-linux-next-fixes'
git bisect bad 727b373740d1d3c6d3273cfc6e81d5e9a229b12d
# good: [34aea5d2c46b2581ddf0b78a6119f85c1b3a8d1d] Merge remote-tracking br=
anch 'net/master'
git bisect good 34aea5d2c46b2581ddf0b78a6119f85c1b3a8d1d
# bad: [52bb35a9520ac1746fb34687c5582695813aa00a] Merge remote-tracking bra=
nch 'char-misc.current/char-misc-linus'
git bisect bad 52bb35a9520ac1746fb34687c5582695813aa00a
# bad: [4baf5101d553aae944fa7dc7bd13772eb559d78b] Merge remote-tracking bra=
nch 'sound-asoc-fixes/for-linus'
git bisect bad 4baf5101d553aae944fa7dc7bd13772eb559d78b
# good: [49ff71f99a8826eda5cee76b69f15600d1cbf4b2] Merge remote-tracking br=
anch 'rdma-fixes/for-rc'
git bisect good 49ff71f99a8826eda5cee76b69f15600d1cbf4b2
# good: [678e2b44c8e3fec3afc7202f1996a4500a50be93] ALSA: compress: prevent =
potential divide by zero bugs
git bisect good 678e2b44c8e3fec3afc7202f1996a4500a50be93
# good: [667e9334fa64da2273e36ce131b05ac9e47c5769] ASoC: tlv320aic32x4: Ker=
nel OOPS while entering DAPM standby mode
git bisect good 667e9334fa64da2273e36ce131b05ac9e47c5769
# bad: [239b8b34a856777e562373ae0de605536a7ccade] ASoC: Intel: Boards: move=
 the codec PLL configuration to _init
git bisect bad 239b8b34a856777e562373ae0de605536a7ccade
# bad: [8780cf1142a59568a3aa77959cbd76b2edb6fd81] ASoC: soc-core: defer car=
d probe until all component is added to list
git bisect bad 8780cf1142a59568a3aa77959cbd76b2edb6fd81
# good: [44fabd8cdaaa3acb80ad2bb3b5c61ae2136af661] ASoC: atom: fix a missin=
g check of snd_pcm_lib_malloc_pages
git bisect good 44fabd8cdaaa3acb80ad2bb3b5c61ae2136af661
# first bad commit: [8780cf1142a59568a3aa77959cbd76b2edb6fd81] ASoC: soc-co=
re: defer card probe until all component is added to list
---------------------------------------------------------------------------=
----
