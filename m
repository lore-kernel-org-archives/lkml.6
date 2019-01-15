Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E21C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8539420656
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="EYhbne25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbfAOKWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:22:15 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36173 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbfAOKWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:22:14 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so2309935wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 02:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=JsMm5r1HYdUveWh8AXUl7moBsK36fpMSTsEtyH2eeIo=;
        b=EYhbne25QKKxDXsNgkIRV2E3oaKYGCESmrjFoT2HFdoODsQx/HumP5Xus1QJQ1H84S
         Zri6Bs7Wu5PNbI4QT8GZNOHmOJlv25l5fAGxe/EAWDADIVXNNWJzBtP8WKDpEDuibueZ
         kqQTWJGFbmUv4mU7sHHf2mKyh2MfczHdIj3BxnDxeAXtiRTmHwQ2LrGff7qjcJn72r9d
         bOBgROg50dj2EcbQrYLNMU8X8tIBzDPfB8BPdzzZ8UPfldjcltmQu6BwAYL4j2CgSpN3
         vFoZz7SIucd4aLfedi3/Scxd2C7tCVwLqNRUHjcIvgTdM1rnPJRPuw0OtA6ZywGJtZRp
         Diiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=JsMm5r1HYdUveWh8AXUl7moBsK36fpMSTsEtyH2eeIo=;
        b=UzzRq2SqKvZLJHaedApEfpvGYUqFZkU9ZoSx6q9VVfpgYbYFiVboYFz78B4zx1hLIH
         ueLkjn5J+xqdo3WT6oYC6nxmWhDOCnsRGj+Qd+r62/s0tdhjkvAi+vjEPUkThkzWKzd2
         V6PwYY+ZjDeHD6u5qHo9OCBU7DyX3J9OSNP05EtZgCGsXlBt5/av4Dd6cqFBYf58LrV/
         73Z8EIggeLe8gdPNn9xTAlwUsb0bnpEBaPiTGtJJeXO2a9/NVtvS6e6W34bGGKF7ATk4
         pvRDFpAwgKmtn0HKq/h9ejwr5ca5dY63521GdO7DmopspJCXgRv11KUpE238Yq1EHZqn
         njNQ==
X-Gm-Message-State: AJcUuke8sRV930mEFgIjM0iYFPqExrvePxqatO8NieMPEHsMNMI0yEKj
        vT0h3CYadG5Lc44vOotQ2dAAEw==
X-Google-Smtp-Source: ALg8bN7UuWbM/Xa4Fjnzw4aqp/mDg0Jwy2OBqp2GEsKqmxuGqwdMYryau9EIS9gS2Rz1lsBKHu5CUQ==
X-Received: by 2002:adf:fe43:: with SMTP id m3mr2359812wrs.290.1547547732423;
        Tue, 15 Jan 2019 02:22:12 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id 129sm51490125wmd.18.2019.01.15.02.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 02:22:11 -0800 (PST)
Message-ID: <5c3db453.1c69fb81.da3dd.d180@mx.google.com>
Date:   Tue, 15 Jan 2019 02:22:11 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Tree: next
X-Kernelci-Branch: pending-fixes
X-Kernelci-Kernel: v5.0-rc2-361-g08b435ee366b
Subject: next/pending-fixes boot bisection: v5.0-rc2-361-g08b435ee366b on
 sun8i-h3-libretech-all-h3-cc
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

next/pending-fixes boot bisection: v5.0-rc2-361-g08b435ee366b on sun8i-h3-l=
ibretech-all-h3-cc

Summary:
  Start:      08b435ee366b Merge remote-tracking branch 'drm-misc-fixes/for=
-linux-next-fixes'
  Details:    https://kernelci.org/boot/id/5c3d795559b51455d36edd69
  Plain log:  https://storage.kernelci.org//next/pending-fixes/v5.0-rc2-361=
-g08b435ee366b/arm/sunxi_defconfig/lab-baylibre/boot-sun8i-h3-libretech-all=
-h3-cc.txt
  HTML log:   https://storage.kernelci.org//next/pending-fixes/v5.0-rc2-361=
-g08b435ee366b/arm/sunxi_defconfig/lab-baylibre/boot-sun8i-h3-libretech-all=
-h3-cc.html
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
  Target:     sun8i-h3-libretech-all-h3-cc
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
