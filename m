Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B13C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF5E20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 14:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="NVmlTkWT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfANOHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 09:07:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36502 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfANOHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 09:07:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id p6so8964900wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 06:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=aWHcwWxelo0aqe1OeHdnDVGKaYSOEfh/QUGkRbMTzjM=;
        b=NVmlTkWTUWVaPlp7yGhIp6FjIKXewf2Lwiq+1GAcootbNNWCP8sXqWBmz5DvkPVOts
         I+yvZGzMArBWVWnsdGy8fP5xPBcDRQt85NyKecGRSi46v5gvqQ4QWU1lYfFB4d8ycneo
         ONYfUiGkV2IeBn9lbQHpLfynxJOTTjw1f7MWwVb67OLhLB08Hh5B0lAAy+L/v+0isiXk
         JTAsumgw2hVoc/XCR4so4a/MF1tU5dFGQPCqhZ8tcvrgmvE/iGTfKjql6UbJKG89Muuz
         FYAZxwThuzHIgP+lCFqGHRETroPLhkz5JEXwwxL8YhxzR35KAH6ObMRVOG1xnKxWY+CQ
         uscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=aWHcwWxelo0aqe1OeHdnDVGKaYSOEfh/QUGkRbMTzjM=;
        b=H7jhoLoobXIPYEjwQjJ53G1+VVjTXol9Xa4IrfZB9qBMw+PLjUykuNXdcoVllcx2Kv
         VxxS9zWK/bc9dCela6zBPk6ckKeIBxYCwhq9TXYT2SyFa6tOhXfkXaAKbrp/CQRWKtTK
         rJEsko86SkRcS03IoCnI40VLiZTpQIDQNLZBGw7kwWFQaJ7kKc+v2nJkrH0Tep+dJ8s+
         4NlIS8+HD5z1baNNC90tk/8eaHHouUExoc44o2wTA/LWk8wgWAdu0TqIewGHgj3y2urs
         BRVSsvZ8K4fcrxZvILqScAypb7mFHHPMZKVXo+fnSAtoYHPuY9MXPLJ99lf/QV6aOAtt
         503g==
X-Gm-Message-State: AJcUukdB0BuFxsNhGDOo+72ShwqT/56RhYED8B6OjMBLO65X2L92ceWM
        9jV92KWtZd49lw4xlQqTjSHHYg==
X-Google-Smtp-Source: ALg8bN4d5jEMtv56kATw3DUT+IOtq+RQsmG/qrm+UxlLXn8ols+DzNsR2xMAqaWxxQ+zptgbTeIljg==
X-Received: by 2002:a1c:b70b:: with SMTP id h11mr12389208wmf.72.1547474829437;
        Mon, 14 Jan 2019 06:07:09 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id n127sm32634196wmd.20.2019.01.14.06.07.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 06:07:08 -0800 (PST)
Message-ID: <5c3c978c.1c69fb81.6e329.1da7@mx.google.com>
Date:   Mon, 14 Jan 2019 06:07:08 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Tree: next
X-Kernelci-Branch: pending-fixes
X-Kernelci-Kernel: v5.0-rc1-535-g727b373740d1
Subject: next/pending-fixes boot bisection: v5.0-rc1-535-g727b373740d1 on
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

next/pending-fixes boot bisection: v5.0-rc1-535-g727b373740d1 on sun8i-h3-l=
ibretech-all-h3-cc

Summary:
  Start:      727b373740d1 Merge remote-tracking branch 'drm-misc-fixes/for=
-linux-next-fixes'
  Details:    https://kernelci.org/boot/id/5c3c423359b5145dde6edd37
  Plain log:  https://storage.kernelci.org//next/pending-fixes/v5.0-rc1-535=
-g727b373740d1/arm/sunxi_defconfig/lab-baylibre/boot-sun8i-h3-libretech-all=
-h3-cc.txt
  HTML log:   https://storage.kernelci.org//next/pending-fixes/v5.0-rc1-535=
-g727b373740d1/arm/sunxi_defconfig/lab-baylibre/boot-sun8i-h3-libretech-all=
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
