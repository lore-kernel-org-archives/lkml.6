Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52874C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90BB20827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 07:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="JKZN2DIx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90BB20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbeKERQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 12:16:41 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:61253 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725737AbeKERQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 12:16:41 -0500
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id wA57vt1w022922;
        Mon, 5 Nov 2018 16:57:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com wA57vt1w022922
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541404676;
        bh=Py7d0gIdwG15aYWAbqsRWcAvHzDkAjAINfJqb8ffJb0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JKZN2DIxQ8CynMMsoLk8MWjRrKaG7mIIlBXkkRV+ma/6kPh3zpi767NMFMPlXWtP4
         wjDiXNVxJ1jXCkx8Pkxh5iI+3poBHeBpWoSzhoqE0Sg9bbkVtGtM+umbddfaV/YwqI
         xpG8dHzVOQEpTRyoto0RZAA0NvCCxnd/+QLgTOcHYqMDp3pkEAkLTXYwxyjezGuEKV
         Y4rnp9duStmk6xrf+T0FvuIFKmtml3MW7uF89Mtncy21itm5hyH666pTzE8/fojN5e
         cQF5WLJrYGCn46eegW53f9yWx5yzZiG42pgWL1ppJRta5ZtWukS0D84z3Yqm7XimXP
         iitdlk9DkPOYw==
X-Nifty-SrcIP: [209.85.222.50]
Received: by mail-ua1-f50.google.com with SMTP id d19so1546234uaq.11;
        Sun, 04 Nov 2018 23:57:56 -0800 (PST)
X-Gm-Message-State: AGRZ1gLEVrdkAUekTlNhDBe1nON2S127MHsvvSNl+2yj42fTigW8KRc9
        keFQ6j1pAFIaSSEuI18gqescB9uaWEOGPmQfPkA=
X-Google-Smtp-Source: AJdET5dKnVNEC3gkniRKqgHxYavnEW5NhU0XdozWULzSkHq50QMj1po2mfz1oWpi0GzpB3Cyl+AD1lt+C8eKzJ6Xd4w=
X-Received: by 2002:ab0:6705:: with SMTP id q5mr9734824uam.89.1541404675064;
 Sun, 04 Nov 2018 23:57:55 -0800 (PST)
MIME-Version: 1.0
References: <20181103201504.29413-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20181103201504.29413-1-ard.biesheuvel@linaro.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 5 Nov 2018 16:57:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNASzscQaUYh=ved3UHajsyOWHJwFp8fVS3aOQn_n+WBybg@mail.gmail.com>
Message-ID: <CAK7LNASzscQaUYh=ved3UHajsyOWHJwFp8fVS3aOQn_n+WBybg@mail.gmail.com>
Subject: Re: [PATCH] Revert "kbuild: add --include-dir flag only for
 out-of-tree build"
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Riku Voipio <riku.voipio@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,


On Sun, Nov 4, 2018 at 5:15 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> w=
rote:
>
> This reverts commit 80463f1b7bf9f822fd3495139bcf3ef254fdca10, because
> it breaks the bindeb-pkg build target in the following way:
>
>   ...
>     LD [M]  sound/soc/rockchip/snd-soc-rk3399-gru-sound.ko
>     LD [M]  sound/soc/rockchip/snd-soc-rockchip-pcm.ko
>     LD [M]  sound/soc/rockchip/snd-soc-rockchip-rt5645.ko
>     LD [M]  sound/soc/rockchip/snd-soc-rockchip-spdif.ko
>     LD [M]  sound/soc/sh/rcar/snd-soc-rcar.ko
>    fakeroot -u debian/rules binary
>   make KERNELRELEASE=3D4.19.0-12677-g19beffaf7a99-dirty ARCH=3Darm64 KBUI=
LD_SRC=3D intdeb-pkg
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
>   cp: cannot stat '/home/ard/linux/scripts/kconfig/Makefile:69: recipe fo=
r target '\''syncconfig'\'' failed'$'\n''/home/ard/linux/Makefile:544: reci=
pe for target '\''syncconfig'\'' failed'$'\n''Makefile:640: recipe for targ=
et '\''include/config/auto.conf'\'' failed'$'\n''Makefile:15: recipe for ta=
rget '\''__sub-make'\'' failed': No such file or directory
>   /home/ard/linux/scripts/package/Makefile:83: recipe for target 'intdeb-=
pkg' failed
>   make[8]: *** [intdeb-pkg] Error 1
>   /home/ard/linux/Makefile:1399: recipe for target 'intdeb-pkg' failed
>   make[7]: *** [intdeb-pkg] Error 2
>   Makefile:152: recipe for target 'sub-make' failed
>   make[6]: *** [sub-make] Error 2
>   Makefile:15: recipe for target '__sub-make' failed
>   make[5]: *** [__sub-make] Error 2
>   debian/rules:7: recipe for target 'binary-arch' failed
>   make[4]: *** [binary-arch] Error 2
>   dpkg-buildpackage: error: fakeroot -u debian/rules binary gave error ex=
it status 2
>   /home/ard/linux/scripts/package/Makefile:79: recipe for target 'bindeb-=
pkg' failed
>   make[3]: *** [bindeb-pkg] Error 2
>   /home/ard/linux/Makefile:1399: recipe for target 'bindeb-pkg' failed
>   make[2]: *** [bindeb-pkg] Error 2
>   Makefile:152: recipe for target 'sub-make' failed
>   make[1]: *** [sub-make] Error 2
>   Makefile:15: recipe for target '__sub-make' failed
>   make: *** [__sub-make] Error 2
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>



Sorry for the breakage, and thanks for your report.

I'd like to fix the root cause in the builddeb script
instead of the revert.

https://patchwork.kernel.org/patch/10667541/


Thanks.



--=20
Best Regards
Masahiro Yamada
