Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C61EBC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75AE520825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 11:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dHEh9EHK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AE520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbeKEUZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 15:25:43 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39870 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbeKEUZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 15:25:43 -0500
Received: by mail-it1-f195.google.com with SMTP id m15so11945589itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 03:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C1iDX4P5APX4JX+xRaeBi8uxJkv3065/iwh0re09L5U=;
        b=dHEh9EHKxkyqDJROMdqmcZOCGzXDH+KAAgmCpDeI3Yzf1CFw9+NDr0CzteLIyHU9Fd
         0E7kVj7/IFSMp1i8i9DGMGMCyUAcriZDpIxx6S+/nNDBSOv/KcXUZgRMs+BDdW+gualS
         PseYY9GkKf2eEYlRji4QW2R+Kw0NaXgIcXSgc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C1iDX4P5APX4JX+xRaeBi8uxJkv3065/iwh0re09L5U=;
        b=n/qqyS+F0DMOlK4UUxPecWvTlTfxllYaHn21X+zNV3B7CUEqxsX/55kA9qnm2aAg3n
         hjUy7AuIl/qGeKImxsylTTlPykyuqzm/RKjHnaGu7esXbcvFpMAXpl0x4P4ssMBk3GAy
         TN65tkNnQ5k6MXdpo4dF/UI7CMXjlZ7EL/200ramIXbsobX05QDKkBtY8lxPMfsMp9ZW
         9KlePbn8BSEBTDvRd+cc9yIXiqW6r8Mo6Xy8HS63EDZjSunlXyOi4A54nBhYVDASK4Lz
         dkNAT2WfmVL2rcET5vzMHgoy3+tqaK1UP2xRiDZPKstD7aQA3JgkDjrXlTJxoAwa+PAB
         nXrw==
X-Gm-Message-State: AGRZ1gLqLrPvgKMM43CKfWk94yJrrwqKbIPBcC7Vq3ivfBVhsGCiS6lt
        qVIeqedOXOhru9byzi9SULoeEgLm7eWdiTYF3EYz0w==
X-Google-Smtp-Source: AJdET5dWQd6VEtK2yveNNiaiYwa3ImO55QFC7bEGdCJkg0MLejUT+KR+P8ERPvs6cQt9NUn45NxGkym9ymYqFX5dOZs=
X-Received: by 2002:a02:8449:: with SMTP id l9-v6mr7173578jah.130.1541415992885;
 Mon, 05 Nov 2018 03:06:32 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 03:06:32 -0800 (PST)
In-Reply-To: <1541404354-30331-1-git-send-email-yamada.masahiro@socionext.com>
References: <1541404354-30331-1-git-send-email-yamada.masahiro@socionext.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 5 Nov 2018 12:06:32 +0100
Message-ID: <CAKv+Gu9wH0DwyuXa6ev+omrmRu09f_N88mcz443oky=ha76Z-A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: deb-pkg: fix bindeb-pkg breakage when O= is used
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 November 2018 at 08:52, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Ard Biesheuvel reports bindeb-pkg with O= option is broken in the
> following way:
>
>   ...
>     LD [M]  sound/soc/rockchip/snd-soc-rk3399-gru-sound.ko
>     LD [M]  sound/soc/rockchip/snd-soc-rockchip-pcm.ko
>     LD [M]  sound/soc/rockchip/snd-soc-rockchip-rt5645.ko
>     LD [M]  sound/soc/rockchip/snd-soc-rockchip-spdif.ko
>     LD [M]  sound/soc/sh/rcar/snd-soc-rcar.ko
>    fakeroot -u debian/rules binary
>   make KERNELRELEASE=4.19.0-12677-g19beffaf7a99-dirty ARCH=arm64 KBUILD_SRC= intdeb-pkg
>   /bin/bash /home/ard/linux/scripts/package/builddeb
>   Makefile:600: include/config/auto.conf: No such file or directory
>   ***
>   *** Configuration file ".config" not found!
>   ***
>   *** Please run some configurator (e.g. "make oldconfig" or
>   *** "make menuconfig" or "make xconfig").
>   ***
>   make[12]: *** [syncconfig] Error 1
>   make[11]: *** [syncconfig] Error 2
>   make[10]: *** [include/config/auto.conf] Error 2
>   make[9]: *** [__sub-make] Error 2
>   ...
>
> Prior to commit 80463f1b7bf9 ("kbuild: add --include-dir flag only
> for out-of-tree build"), both objtree and srctree were added to
> --include-dir, and the wrong code '$MAKE image_name' was working
> relying on that. Now, the potential issue that had previously been
> hidden just showed up.
>
> '$MAKE image_name' recurses to the generated $(objtree)/Makefile and
> ends up with running in srctree, which is incorrect. It should be
> invoked with '-f $srctree/Makefile' (or KBUILD_SRC=) to be executed
> in objtree.
>
> Fixes: 80463f1b7bf9 ("kbuild: add --include-dir flag only for out-of-tree build")
> Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

This fixes the issue I was seeing

Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks.

> ---
>
>  scripts/package/builddeb | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index 90c9a8a..0b31f4f 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -81,7 +81,7 @@ else
>         cp System.map "$tmpdir/boot/System.map-$version"
>         cp $KCONFIG_CONFIG "$tmpdir/boot/config-$version"
>  fi
> -cp "$($MAKE -s image_name)" "$tmpdir/$installed_image_path"
> +cp "$($MAKE -s -f $srctree/Makefile image_name)" "$tmpdir/$installed_image_path"
>
>  if grep -q "^CONFIG_OF=y" $KCONFIG_CONFIG ; then
>         # Only some architectures with OF support have this target
> --
> 2.7.4
>
