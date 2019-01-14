Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A021EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6568320657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="ZCz6nZ0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfANNLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 08:11:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40746 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfANNLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 08:11:09 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so22775256wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 05:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=aiJZgjFuhEeEAJe9jipyklsUeZ6nNSDnpDh4zndsUP4=;
        b=ZCz6nZ0TtlThJqx6btt92wc90AhXULkLrmM7jAqKF3EoKijRZyqsKUx0FwaxAI0mG0
         +e9EFsG5OIYUun1cP8x/samoaAFzp8rVmbIGfVVqZqWxIPw99Mq/IcbbdYcjiwTu+pm3
         Mu6SKUJ7Fy184Pytlys54YjYTBTBqP+XZJ9O1NGssO8qO+q36L+iJuF91RNP+F+B1lrZ
         Vm2aW+AhpYchMb5IlMtFLmnEAQcmdz0F+WVJcWMvUQL42BySSJCp9ttWbciC+z/+O/kD
         l8EmYfa2U7+7kkjokr0Oxj2XFlM5jODwuP33FpvUBRj5t72WXM/SxvmPUnERnxLYc+i+
         1KRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=aiJZgjFuhEeEAJe9jipyklsUeZ6nNSDnpDh4zndsUP4=;
        b=A293S1zxkOLaiTO/POGhKlNlAOJeMX7eZbdtDSYYFSufK1KkIVCPgsDm2TnUU4GCUK
         5+Y0ShBHDv7wcx1TqdVcrzrtWRahSVxgx0HPC26WAXd0JxVvQXkKfuz2W3AA48vMi6wE
         Xsp5ZlCMUmG0Gb8cnlOEa22qw9AelrrDxujp879V1Jd4MEulP/s627YVCY0oMFnWB8D2
         E78dz+B7Lzk80XOU1uq3kJ+738/ATt+RziZjSbXFmAZHK+n4yX3P+1i4S+DqFe8gt3ED
         BCaNftU8imU1Ld6QJvqt1S3XrBUxu4afuZm1w9Z77FQuPDVKoHfO7kLVvn5tdVBPDcJh
         i/MQ==
X-Gm-Message-State: AJcUukeLjSOSa6xowDjAxlUBXr1x2dJ6o7Lv4lSgxMEpBdNanWMWhrCS
        qiEehJcN4hbXHLbhbPE0wJUl0w==
X-Google-Smtp-Source: ALg8bN5bKCAZv5DbzgE9YVNowQU68PwREy5J/JK41UrE9RNwTTI2tYKY5ZidA4yo7thBOi0TfYRqSg==
X-Received: by 2002:adf:b6a1:: with SMTP id j33mr24225845wre.55.1547471466712;
        Mon, 14 Jan 2019 05:11:06 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id x3sm63695442wrd.19.2019.01.14.05.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 05:11:05 -0800 (PST)
Message-ID: <5c3c8a69.1c69fb81.668ce.4227@mx.google.com>
Date:   Mon, 14 Jan 2019 05:11:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: bisect
X-Kernelci-Lab-Name: lab-baylibre
X-Kernelci-Tree: next
X-Kernelci-Branch: master
X-Kernelci-Kernel: next-20190114
Subject: next/master boot bisection: next-20190114 on
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

next/master boot bisection: next-20190114 on sun8i-h2-plus-libretech-all-h3=
-cc

Summary:
  Start:      8ce4d582f564 Add linux-next specific files for 20190114
  Details:    https://kernelci.org/boot/id/5c3c411659b51457a76edd34
  Plain log:  https://storage.kernelci.org//next/master/next-20190114/arm/s=
unxi_defconfig/lab-baylibre/boot-sun8i-h2-plus-libretech-all-h3-cc.txt
  HTML log:   https://storage.kernelci.org//next/master/next-20190114/arm/s=
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
