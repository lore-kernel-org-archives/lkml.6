Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2DCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF44D20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="D/znuH38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfANNOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:14:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37372 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbfANNOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:14:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id s12so22801830wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 05:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=4BlWf+oE0v3vn+Udzow7GeCcIpcUX+2BJfw6o2hkcKA=;
        b=D/znuH38fpee18FZ5BV7ueyutgroJDnDgle1n8VzsU1f2N8RYqx1KbxNhpWqFQMVYP
         2TiI2Yd1PjCza8P0fsGKx7NRLx9qx185Ytja8N9gX1PRyvZMUOOofKV6T54skpm5h6zK
         NH389G6fvuk2XSgCFP1NhleVV0bO8pVaqh5cIX2Mz32mlN0DUU0mlX9GgQ2dRJX4hG2B
         A5RcMCtyNX5aukz7Kjn6sjhUyy5EZ6BcmWZD9s4xYbn4ZAxOX/FnmXzalWMee9Z0mEmb
         OI86tfGq7zQs9yXmFR5V7CDFq98ovBYT/vGdxPCoJG+sXCPSESy9CTsfgHEncNHRsbCn
         h83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=4BlWf+oE0v3vn+Udzow7GeCcIpcUX+2BJfw6o2hkcKA=;
        b=s4HBeH96mVY7d4iub9fjZAsiwB8E0VovWEe7PrkgRY8B9RRbERIX25hedFlsZQtGJS
         xBiE4plVgWXl6DkMjR41QQasbL82/JN68yvDSgJh5stI4PaNWdVFfETnpBc/pgvGdhC8
         H/d4ahIp2wPBVVs8fYVBlq9JQ2s4528d8+Hp+C5jPC5qCdJz/x+piRmuJsJOLpMwdRei
         muwBbZqNrZsCWzE31+M95+5Xj+XLMLLQlzgtsqkx0MCpgaG0NRZ2mgSjjCv/fKyOrA4W
         H+4+0/ZM2xcsu012WEBH8pwi/eSMtSt/1JVv6y/ORYvVPx0i/9Wl/ypAGorkR5sHkIO8
         HF9w==
X-Gm-Message-State: AJcUuke3ldwim151O+aEWzQgpIwC4S0YG45dG1D2WcNfg8+qCFUINIOe
        033pl1NmRM7j21c1jcpOyroxCQ==
X-Google-Smtp-Source: ALg8bN7NIartSrkzcJ1rfk02cwbB+uDIjTyfYfTnotkwx/gYT4Id5VtGP8TGjlF/4by8aLkErufwDg==
X-Received: by 2002:adf:9205:: with SMTP id 5mr24271840wrj.189.1547471655904;
        Mon, 14 Jan 2019 05:14:15 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id p12sm35146338wmi.5.2019.01.14.05.14.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 05:14:15 -0800 (PST)
Message-ID: <5c3c8b27.1c69fb81.76f1f.6e38@mx.google.com>
Date:   Mon, 14 Jan 2019 05:14:15 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Tree: next
X-Kernelci-Branch: master
X-Kernelci-Kernel: next-20190114
Subject: next/master boot bisection: next-20190114 on
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

next/master boot bisection: next-20190114 on sun8i-h3-libretech-all-h3-cc

Summary:
  Start:      8ce4d582f564 Add linux-next specific files for 20190114
  Details:    https://kernelci.org/boot/id/5c3c41ac59b5145b496edd2a
  Plain log:  https://storage.kernelci.org//next/master/next-20190114/arm/s=
unxi_defconfig/lab-baylibre/boot-sun8i-h3-libretech-all-h3-cc.txt
  HTML log:   https://storage.kernelci.org//next/master/next-20190114/arm/s=
unxi_defconfig/lab-baylibre/boot-sun8i-h3-libretech-all-h3-cc.html
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
# bad: [8ce4d582f5647052b86f364a070aa26268810d7e] Add linux-next specific f=
iles for 20190114
git bisect bad 8ce4d582f5647052b86f364a070aa26268810d7e
# bad: [bb937d2e6697b49f6e3fa55ec09951ebbc8717ac] Merge remote-tracking bra=
nch 'crypto/master'
git bisect bad bb937d2e6697b49f6e3fa55ec09951ebbc8717ac
# bad: [04bab95e799a00ffe1b2980e1c786ac9a94f8026] Merge remote-tracking bra=
nch 'renesas/next'
git bisect bad 04bab95e799a00ffe1b2980e1c786ac9a94f8026
# bad: [5726796d7b631fe9af2202c1ce66232a79984a19] Merge remote-tracking bra=
nch 'devicetree-fixes/dt/linus'
git bisect bad 5726796d7b631fe9af2202c1ce66232a79984a19
# good: [34aea5d2c46b2581ddf0b78a6119f85c1b3a8d1d] Merge remote-tracking br=
anch 'net/master'
git bisect good 34aea5d2c46b2581ddf0b78a6119f85c1b3a8d1d
# bad: [e1faf5c97ee3194c3f3e0b5dc86b3e1490c323d9] Merge remote-tracking bra=
nch 'usb-serial-fixes/usb-linus'
git bisect bad e1faf5c97ee3194c3f3e0b5dc86b3e1490c323d9
# good: [49ff71f99a8826eda5cee76b69f15600d1cbf4b2] Merge remote-tracking br=
anch 'rdma-fixes/for-rc'
git bisect good 49ff71f99a8826eda5cee76b69f15600d1cbf4b2
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
