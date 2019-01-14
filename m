Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D068FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9362820659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="BDCwnhJH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfANOhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:37:55 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33322 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfANOhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:37:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id r24so7527594wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 06:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=uUZPmTowcL4tFtRiWsaHRKZccJHRgWqQkaWSfBzrPug=;
        b=BDCwnhJHSf0zjOATvUz4nsw+XIvtz15eQ+CPsOudrEEuKEBluDzw/lmAHqm+9U450c
         /3CMV15JWaDOexpe0Dchq5MkmSxQY26gt/q4YLoPmL7R/s2bouPu2U0D9O8zD4kr1Ypm
         E6skjvUTPyaqf3N7wqgwKxl8gRNeBMVXmVZXUSS10mM8Hd2k/f9u5PCQwQIVXZBg30ZK
         UavNxfWPZjsBne907q46eAghxZOn3TG1vaO7ek58RJI//Kx/K77UWWTgebhECIfifqMy
         y9yDu9bomkewUzD3GzszXGhgSw+AxWyJgR6GYpzh8gU2yB6OGxOQlp9OdV+f/enRL3sC
         MmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=uUZPmTowcL4tFtRiWsaHRKZccJHRgWqQkaWSfBzrPug=;
        b=B107lBuO2zbW+Ld7fKQwr5vipKgORw+oKj7hikkRwic8g+BDBoDOAMNXESZdll5NxR
         bZuPNsYroAT51lBwRhl5BTKvYvwcl2M0ywczhwC58VsYXgyVQ0NZer7akS/AM/eUiFS6
         CEPu2AJ0QHdIPgY58mQcDhVfF03bFDXRoCoI6rQ1jYNxTc5U2oDxJ5PrOkwuoUEuRz4G
         XoUwcIKQr3NGkUgie3SNT6outQwxp7kaf0hRclMXyqgfBPjtmw+8HZs8uc0GIykTgd70
         mA/ssRIEmuS5qgNo1rGldXTzFEymFSf8eDpadPRpGd5uVIUidFY3uYFIJ9Y5CWfb15B0
         Pfng==
X-Gm-Message-State: AJcUukccM30YbfU319mPdwsZuAx7gHjNY/fr+w62qyi9T+JpLsgtNyah
        +NsKEOkgt+O5j4ykpTBgzOVWAQ==
X-Google-Smtp-Source: ALg8bN6Nw0IM357ADZz1HXXn0i4Zrj/BuXPwRAwTX26xRzOyE0OWoQTdglkbDN8Wn/HgOZyjXpHvCw==
X-Received: by 2002:a1c:5892:: with SMTP id m140mr12169832wmb.60.1547476672510;
        Mon, 14 Jan 2019 06:37:52 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id o4sm65137283wrq.66.2019.01.14.06.37.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 06:37:51 -0800 (PST)
Message-ID: <5c3c9ebf.1c69fb81.4fb13.f95a@mx.google.com>
Date:   Mon, 14 Jan 2019 06:37:51 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Tree: next
X-Kernelci-Branch: pending-fixes
X-Kernelci-Kernel: v5.0-rc1-535-g727b373740d1
Subject: next/pending-fixes boot bisection: v5.0-rc1-535-g727b373740d1 on
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

next/pending-fixes boot bisection: v5.0-rc1-535-g727b373740d1 on bcm2837-rp=
i-3-b-32

Summary:
  Start:      727b373740d1 Merge remote-tracking branch 'drm-misc-fixes/for=
-linux-next-fixes'
  Details:    https://kernelci.org/boot/id/5c3c42c459b5145f216edd41
  Plain log:  https://storage.kernelci.org//next/pending-fixes/v5.0-rc1-535=
-g727b373740d1/arm/bcm2835_defconfig/lab-baylibre/boot-bcm2837-rpi-3-b.txt
  HTML log:   https://storage.kernelci.org//next/pending-fixes/v5.0-rc1-535=
-g727b373740d1/arm/bcm2835_defconfig/lab-baylibre/boot-bcm2837-rpi-3-b.html
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
