Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D48C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC40D20861
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="ubFyxT+K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfAOKRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:17:46 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:37966 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfAOKRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:17:45 -0500
Received: by mail-wr1-f45.google.com with SMTP id v13so2276262wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 02:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=QNW+GjPlXptCp6Uvj/E9K9G/cPE3wmXz//yM8WTYjMU=;
        b=ubFyxT+KXZ5a8RR4+3BLI0r7EaDT3Cs+IF1VHRhDZ5+qUWY/srGNkm6Zjg3KS15ihX
         WV5fZRtXUhvV/RT9C5WCfqGe+U63FTL0lLm5TxooFRYm8Po4JiUfIcPdiZvJfD/2oQUN
         vXQfBVOC9dCQ4yuuf9DWDXXnE5qSDCdZ2LbLHBk6R2etPwMwc3HXDmWfExk3R7ylAOm4
         bs7hIreBvZ4NRS7xXqvkalhFm2EuwOpTwRfB6ys5hwSKmrZtgTkrfqmXYb/KjYyqaHMY
         +ypgeYJMKWN7Zmi+ik+o7ClREiE2OkWlq77uSoXKY1RK/4UEQZYWcf4PiQoP/cCKVxVx
         RfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=QNW+GjPlXptCp6Uvj/E9K9G/cPE3wmXz//yM8WTYjMU=;
        b=Nk08nirgszVJw5bYpWkue0tVPt2h/8c7Mh+PTwE2a+DBI74rtTDOnIwUfaT8s7MJh3
         zDWAnpOYoYMj5mQdKozJzHKrGQjbahA0T/dwIHPd+zbBqzcPB3AGx6wpVlaimGrByNkd
         foqUfT1yrF0+TH/Nos+bUUgPgsMT2nr6vky+RHND4jKIQGfQ7KBhLb0L98gDJXYT6lKy
         Vy+3kwxudKSwCcXTWXMYgMLNTyZJ+c113MsoJr9GDpk1dKdd2g34/wf4n8FtxdGLWoZx
         4U7P1B6X42wBkeBpswdrQGxRkeGDlDFpJVi9n/VFTkZhI3YlPgWqR4tfkc8EogRL9tZd
         nYqQ==
X-Gm-Message-State: AJcUuken7Ojj9p5gZMENhc7svhq+/33LN/HoKR4x/gK9T+6AK9jLLD4G
        hyZsirEwT+6k1VpWT35H5XXazQ==
X-Google-Smtp-Source: ALg8bN75yGudLgI7FIcxTzn2E2nU7zJd3DKToR3U6HMq87dL22myqlgBiw4FqEVgA8kMJ98iDZ1Wgw==
X-Received: by 2002:adf:b783:: with SMTP id s3mr2554110wre.274.1547547462679;
        Tue, 15 Jan 2019 02:17:42 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id c12sm72396904wrs.82.2019.01.15.02.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 02:17:41 -0800 (PST)
Message-ID: <5c3db345.1c69fb81.49892.a0b3@mx.google.com>
Date:   Tue, 15 Jan 2019 02:17:41 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Tree: next
X-Kernelci-Branch: master
X-Kernelci-Kernel: next-20190115
Subject: next/master boot bisection: next-20190115 on
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

next/master boot bisection: next-20190115 on sun8i-h2-plus-libretech-all-h3=
-cc

Summary:
  Start:      5aa6589e17bd Add linux-next specific files for 20190115
  Details:    https://kernelci.org/boot/id/5c3d783659b51451106edd6c
  Plain log:  https://storage.kernelci.org//next/master/next-20190115/arm/s=
unxi_defconfig/lab-baylibre/boot-sun8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:   https://storage.kernelci.org//next/master/next-20190115/arm/s=
unxi_defconfig/lab-baylibre/boot-sun8i-h2-plus-libretech-all-h3-cc.html
  Result:     8780cf1142a5 ASoC: soc-core: defer card probe until all compo=
nent is added to list

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       next
  URL:        http://git.kernel.org/pub/scm/linux/kernel/git/next/linux-nex=
t.git
  Branch:     master
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
# good: [3719876809e745b9db5293d418600c194bbf5c23] sbitmap: Protect swap_lo=
ck from softirqs
git bisect good 3719876809e745b9db5293d418600c194bbf5c23
# bad: [5aa6589e17bd4dbc1856e37281f00a290d733ab0] Add linux-next specific f=
iles for 20190115
git bisect bad 5aa6589e17bd4dbc1856e37281f00a290d733ab0
# bad: [f2dd4e3054741e22c4c97c8a0fa05faa7239d60a] Merge remote-tracking bra=
nch 'crypto/master'
git bisect bad f2dd4e3054741e22c4c97c8a0fa05faa7239d60a
# bad: [3ba858cbc004b32f8767d295b9b566eb0381da0c] Merge remote-tracking bra=
nch 'qcom/for-next'
git bisect bad 3ba858cbc004b32f8767d295b9b566eb0381da0c
# bad: [4cc2339ea8900debf88333934fa9b1dbc96ee2aa] Merge remote-tracking bra=
nch 'btrfs-fixes/next-fixes'
git bisect bad 4cc2339ea8900debf88333934fa9b1dbc96ee2aa
# good: [259764fd4e5b47aedd6317d2edf5d813333909c5] Merge remote-tracking br=
anch 'net/master'
git bisect good 259764fd4e5b47aedd6317d2edf5d813333909c5
# bad: [29568b4049ff4ef23ce0a2dd46cbaed94b589c78] Merge remote-tracking bra=
nch 'usb-serial-fixes/usb-linus'
git bisect bad 29568b4049ff4ef23ce0a2dd46cbaed94b589c78
# good: [798729dc036d5bb384e24bb48af5c9ea6554d945] Merge remote-tracking br=
anch 'sound-current/for-linus'
git bisect good 798729dc036d5bb384e24bb48af5c9ea6554d945
# bad: [d9c51542207a29b7b06c11f1085a1e3b8eb24f07] Merge branch 'asoc-5.0' i=
nto asoc-linus
git bisect bad d9c51542207a29b7b06c11f1085a1e3b8eb24f07
# good: [678e2b44c8e3fec3afc7202f1996a4500a50be93] ALSA: compress: prevent =
potential divide by zero bugs
git bisect good 678e2b44c8e3fec3afc7202f1996a4500a50be93
# good: [667e9334fa64da2273e36ce131b05ac9e47c5769] ASoC: tlv320aic32x4: Ker=
nel OOPS while entering DAPM standby mode
git bisect good 667e9334fa64da2273e36ce131b05ac9e47c5769
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
