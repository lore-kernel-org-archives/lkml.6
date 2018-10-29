Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C708C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE682084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 07:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhfVxrsu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE682084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbeJ2QAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 12:00:39 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:42031 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbeJ2QAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 12:00:38 -0400
Received: by mail-lj1-f176.google.com with SMTP id f3-v6so6711506ljk.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 00:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jKfSkwrnB9yYAkWPhXJkbm+2TXBevDpflWT7Ro76ZOI=;
        b=RhfVxrsuExP3o70RvFtEZdF0uPhHwL2Ek9rpDCyxfU0W3dubkkwZ+OsDGagGDz1rRb
         XjVt6dK2qAbbBCTLbnsmgwwDxNHnj83g0C/cbrdfMlImiyoNBokXpNrEDL5wEBuIUYUa
         3J9jylR4PusN12nZeE+5lYq4YZRZgWS+6TvuRNGeTTBgmkIHTUhW0RBelkNh3RqLo+uL
         t2GGx47rus6uNp0nZlSWpP/KRBVjtBphdIheh5JTzTij+eZDuABKjSilqQqGNTcr0ru8
         QG50+vPXDIlvB8B5Pv8s2lklQsSI3rLHcWo4xLm2hWjToV12ZlVNoiSF70oz3866B5me
         VO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jKfSkwrnB9yYAkWPhXJkbm+2TXBevDpflWT7Ro76ZOI=;
        b=P5mysoyGuaCJbMjVydsHXG/kCmK0GLgCroHMcZrov/wn31aToOGo5IjO9mjYO5xHxN
         xEIg7vy+FENHw9QdXupllu5ddiTPZvOxR/nKorAYDAgJxES+wOJ6gb4oag2QmeQc8Rec
         lVlF/rhpZbY3Trp0lr/GsX3nHOqCXD1oPovg0zopR1Uhscep6tQY/XqMlWdhBSKDUpHb
         Y89Zy2pS9lbW42eMHAeqNS0FQNtUC5xJQ1et4r8HYKa5IYOeXb9hPzVNUiJshGj+sRod
         4AIasnAEjTWVSqnXo71QdsudBzqc1Ygw1Jepa26bb66BLhpH7vZSZT3O2xs8ZNdIrz3v
         qkug==
X-Gm-Message-State: AGRZ1gJBYhKMmSIyeCzxls6HVETvjrs7jY2YUbOQhuEsi4evSrsJ04ph
        lbJE0Huy1Ufl6Bb7Gf4t7RZKP2NSkrWit1qtRjc=
X-Google-Smtp-Source: AJdET5c750IcQ1EJLUU9pLqKAFN8VYQcdj1XOR81s5gb9f+C+lHWuDmxdg4KDMEaGTsEbjgqR7OJWAONCdsbYZg2l3M=
X-Received: by 2002:a2e:b017:: with SMTP id y23-v6mr8017648ljk.82.1540797193847;
 Mon, 29 Oct 2018 00:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAE5jQCdhWVVqf8en9S-3mbDBwuxk481S+hi-uvQSw6Gf6jKujQ@mail.gmail.com>
 <nycvar.YSQ.7.76.1810282336440.1498@knanqh.ubzr>
In-Reply-To: <nycvar.YSQ.7.76.1810282336440.1498@knanqh.ubzr>
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Mon, 29 Oct 2018 10:13:02 +0300
Message-ID: <CAE5jQCeN6xsyUsi0RhyDobGqMXO5JA-LtFEV=E=gVZLXSo4Akw@mail.gmail.com>
Subject: Re: Cramfs: "unable to handle kernel paging request" when reading a
 file from a fuzzed FS image
To:     nicolas.pitre@linaro.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> How do I populate /vtmp? Mine is empty at this point. I imagine I should
put the cramfs image somewhere on the host, but I'm not that familiar
withkvm.

Oops, forgot to say, it is the /tmp/kvm-xfstests-$USER directory on
the host (it will be created when you first launch kvm-xfstests and it
is "live", i.e. like NFS, not like "pack to ext4 image then boot and
mount").

> Hmmm... It doesn't show up on my test system.

Mounted it on my host Ubuntu 18.10 amd64, executed `cat /mnt/xyz` and
it was "Killed". Maybe it is something freshly added or
arch-dependent...

# uname -a
Linux trosinenko-pc 4.18.0-10-generic #11-Ubuntu SMP Thu Oct 11
15:13:55 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux

Best regards
Anatoly
=D0=BF=D0=BD, 29 =D0=BE=D0=BA=D1=82. 2018 =D0=B3. =D0=B2 6:43, Nicolas Pitr=
e <nicolas.pitre@linaro.org>:
>
> On Sun, 28 Oct 2018, Anatoly Trosinenko wrote:
>
> > Hello,
> >
> > When reading a file from a fuzzed cramfs image, unhandled kernel
> > paging request occurs.
>
> Hmmm... It doesn't show up on my test system.
>
> > How to reproduce with kvm-xfstests:
> > 1) Checkout the v4.19 tag, copy x86_64-config-4.14 to .config, perform
> > `make olddefconfig`
> > 2) Enable Cramfs in the config, then compile
> > 3) In the `kvm-xfstests shell` perform:
> >
> > root@kvm-xfstests:~# mount /vtmp
> > root@kvm-xfstests:~# mount /vtmp/cramfs.img /mnt
>
> How do I populate /vtmp? Mine is empty at this point. I imagine I should
> put the cramfs image somewhere on the host, but I'm not that familiar
> withkvm.
>
>
> Nicolas
