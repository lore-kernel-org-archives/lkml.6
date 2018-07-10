Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BB2C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587D720849
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qfLUAqxL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587D720849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754645AbeGJA3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:29:52 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44912 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeGJA3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:29:49 -0400
Received: by mail-oi0-f66.google.com with SMTP id s198-v6so39332842oih.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 17:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=daDKxgiwcbzt90FlX96tJY1XOvHT9kfh9jCTEXLPark=;
        b=qfLUAqxLylLlGSLp8bvTbr5LYJQySX2s9v961yU8ISlIP5z+qjNQDWB+eXd3i6AzUx
         R4bcVD/hx2yu5DT7PzutuQjQzYQorZ2qaA3p5TZQCITuCez9Cp/8BDSZab/dpUnCy85g
         TqCfjq8mV6Hh5fo3SDrR/hltA9vaWayzUZFuw96xKSH/g50WKrNSpIg5fdP/i9H3CFK6
         R+m5EAz7+e9SwhZQhUpusTGbGGBrNItTr5uFweC8PKVNpBS+oDm606V3FPRt8RjeBZCk
         QahVfF9Yp63Erk5dudbOkbwqpPfjHH6h3jVsWxeDEXiegdFyhGfKM5aWJaPMPu9ykhdC
         sy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=daDKxgiwcbzt90FlX96tJY1XOvHT9kfh9jCTEXLPark=;
        b=cOfvR0wBSmYS6fhf+VBn2OUkM7dNOqg/hKTjw9njwmiIcNLk3UIHoG+lOIZU/tNwAo
         aLLv4xE5gkK3hdgCfJIUvUrDONWT/RbcNjxK4SpuW/8Zzyg9RgJ/oEBiBs/Kuyn2bIrn
         Gvwr8u5tZyJv3ou455V9xXtxP9TIdn4PvJzm4gtnabr7IXyttEvTm4ROnZKS2o+Q0ZV/
         8ppDO64NSUeDcwpIVo1cRwplO8H37kLNWgo5YHOgn663a/mF3PuLS6dq5YaNllHRlMNS
         i4kgFThv1W1870vewL8+IuijloN6LsZj5b7m3tDH3PcyYrQPBuTXcv+lhm1cvdJg70Kj
         4P5Q==
X-Gm-Message-State: AOUpUlFMr0TpaZJ46b4EHlp6qnBncQMiiEFAlEvcOrE7d5CMP48YVZjl
        1tuhQxTb3e2mGgLCGUqUSoqBUYbSzCIw9dXS14ZWFQ==
X-Google-Smtp-Source: AAOMgpfTSaCy9oeyyPezv+rroEkroQdoDg7QvxCpr1PVevv5/gUXvTtxi/qVwKKmjqQwNBc93/qWZhq6Aen17kQ9dd8=
X-Received: by 2002:aca:6749:: with SMTP id b9-v6mr1651868oiy.247.1531182588212;
 Mon, 09 Jul 2018 17:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180709200956.31158-1-labbott@redhat.com> <aadf9529-1236-ea8f-3110-f41b318fb60a@redhat.com>
In-Reply-To: <aadf9529-1236-ea8f-3110-f41b318fb60a@redhat.com>
From:   Kevin Hilman <khilman@baylibre.com>
Date:   Mon, 9 Jul 2018 17:29:37 -0700
Message-ID: <CAOi56cWmfq4YvhfLzCt+R2vsxGW+bgSyxPcOOaCHUcBJmo65kQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "arm64: Use aarch64elf and aarch64elfb emulation
 mode variants"
To:     labbott@redhat.com
Cc:     Will Deacon <will.deacon@arm.com>, contact@paulk.fr,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 4:24 PM Laura Abbott <labbott@redhat.com> wrote:
>
> On 07/09/2018 01:09 PM, Laura Abbott wrote:
> > This reverts commit 38fc4248677552ce35efc09902fdcb06b61d7ef9.
> >
> > This breaks compilation with Fedora gcc-8 tool chains:
> >
> >    CHK     include/generated/compile.h
> >    LD [M]  arch/arm64/crypto/sha512-ce.o
> > aarch64-linux-gnu-ld: cannot open linker script file ldscripts/aarch64elf.xr: No such file or directory
> > make[1]: *** [scripts/Makefile.build:530: arch/arm64/crypto/sha512-ce.o] Error 1
> > make: *** [Makefile:1029: arch/arm64/crypto] Error 2
> >
> > Fixes: 38fc42486775 ("arm64: Use aarch64elf and aarch64elfb emulation mode variants")
> > Signed-off-by: Laura Abbott <labbott@redhat.com>
> > ---
> > A bit rushed and I'm still debugging but I wanted to send this out
> > before anyone else gets hit since it is -rc4. Seeing this on both native
> > and cross compiles.
>
> The answer appears to be that Fedora binutils does not package the assembly
> scripts. The logic behind this is not immediately obvious but it's been
> removed since 2004. Obviously this is a packaging issue on Fedora's side
> but I'd still like to revert since it is a build breakage and fixing
> this might require some coordination. I'll send a v2 with clarified
> commit text if there's agreement.

Tested-by: Kevin Hilman <khilman@baylibre.com>

FWIW, the build is broken with debian packaged toolchain also.  I
noticed it on stretch[1], and this patch gets things building again.

Kevin

[1]
$ aarch64-linux-gnu-gcc -v
Using built-in specs.
COLLECT_GCC=aarch64-linux-gnu-gcc
COLLECT_LTO_WRAPPER=/usr/lib/gcc-cross/aarch64-linux-gnu/6/lto-wrapper
Target: aarch64-linux-gnu
Configured with: ../src/configure -v --with-pkgversion='Debian
6.3.0-18' --with-bugurl=file:///usr/share/doc/gcc-6/README.Bugs
--enable-languages=c,ada,c++,java,go,d,fortran,objc,obj-c++
--prefix=/usr --program-suffix=-6 --enable-shared
--enable-linker-build-id --libexecdir=/usr/lib
--without-included-gettext --enable-threads=posix --libdir=/usr/lib
--enable-nls --with-sysroot=/ --enable-clocale=gnu
--enable-libstdcxx-debug --enable-libstdcxx-time=yes
--with-default-libstdcxx-abi=new --enable-gnu-unique-object
--disable-libquadmath --enable-plugin --enable-default-pie
--with-system-zlib --disable-browser-plugin --enable-java-awt=gtk
--enable-gtk-cairo
--with-java-home=/usr/lib/jvm/java-1.5.0-gcj-6-arm64-cross/jre
--enable-java-home
--with-jvm-root-dir=/usr/lib/jvm/java-1.5.0-gcj-6-arm64-cross
--with-jvm-jar-dir=/usr/lib/jvm-exports/java-1.5.0-gcj-6-arm64-cross
--with-arch-directory=aarch64
--with-ecj-jar=/usr/share/java/eclipse-ecj.jar --disable-libgcj
--enable-multiarch --enable-fix-cortex-a53-843419
--enable-checking=release --build=x86_64-linux-gnu
--host=x86_64-linux-gnu --target=aarch64-linux-gnu
--program-prefix=aarch64-linux-gnu-
--includedir=/usr/aarch64-linux-gnu/include
Thread model: posix
gcc version 6.3.0 20170516 (Debian 6.3.0-18)
