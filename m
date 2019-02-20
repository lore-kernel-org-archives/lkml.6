Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEEE3C10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB8BE21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIIKbwrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbfBTGoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:44:16 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38372 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbfBTGoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:44:15 -0500
Received: by mail-it1-f194.google.com with SMTP id l66so13015346itg.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 22:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HLS63h4TrNfAqG+nGDB8waFurXViTBz03UP/mAXHk3A=;
        b=LIIKbwrBukjgBVt3K8pRF01xjEzpmoi0tc+7Crv5egys0r39YW3i8Oy3bn32KKKh2Q
         LtSyrrsrg3CUdZcWdK3rpsAPYqGljti8Bxr9M1bnLYv4G6yOQz38MvYVHK5/2s1wIt4j
         y1HKQLmvf9PZfRT7+e8NZr8swMO16rt0XOOGGRR8kEGklixQMbiPrfMTHW2Zgqk6p51t
         GK48pRgfIMLg23RdWuJ1P6tLXLl2Z4VtwASjjFw7k3/zU2lAeHw6ZyHaPekqBc7afw6o
         lNv3JLZAZ+qTDN7n9rbJFpP8pbYIZu4tQItzMTqKn2WuouXqJtq+lZ+X8phqL5FSLW1l
         c7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HLS63h4TrNfAqG+nGDB8waFurXViTBz03UP/mAXHk3A=;
        b=nN+G85l6Tx02AmmNGqqJojBvfIbYmz8M8FR/aCgFF6Xx3semahiCc21Quz5NWYN3Ix
         lEjITBLwceGafSgC3oehFn1rRWXCfPEjvt6XqGMFNw+fLmKzNiSs3tr8NbJWdvRLAjT0
         40vvQdYVKa9Pq6dcw0no6LJh0OYn+G1knSjfsxhYf1yJu1M8Pl+ZjoPN0ShwnidA+nhT
         Q/BTVZSKG3qULNBMTdaYiacvUD6tUhgoi262sIHNeYQZe/2LQGZyOptJIOAsELC9bF0r
         jB3GTaLSi9kzZh+H0bHpTpCqQdZv9mQFAWemNjM5/0VM/lJjiiMFS0byVZD4lds7axWa
         N4yw==
X-Gm-Message-State: AHQUAuZw0TGzn5vMzVTbPle4fQChEzZ+PONFM/mVKsWQKGIHf6SA00Sb
        43ao9acKP3bui8oahiBk8eye4FBVhLPaUQ+X0ZRA5Q==
X-Google-Smtp-Source: AHgI3IbWMmRXi7UB7YkhoSO5k2+TLjdZr4wgCtMItk2dkwv6JJnkfhPC1aZ07rsx8JAXh1s6pS5DAUQuF+0dc0v62jI=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr16685706ioc.282.1550645054065;
 Tue, 19 Feb 2019 22:44:14 -0800 (PST)
MIME-Version: 1.0
References: <20190219214940.391081-1-arnd@arndb.de> <1550614664.6911.45.camel@lca.pw>
 <CAKwvOdn+MJxYc+ykvyf-WhEzzDn0zEusjpQuksknnf8bPb=Q6g@mail.gmail.com> <CAN=P9pgC8EzawtxMzp6d3AsMPkSpTd0Ry6j+Jn+YgC_XP2Fd_w@mail.gmail.com>
In-Reply-To: <CAN=P9pgC8EzawtxMzp6d3AsMPkSpTd0Ry6j+Jn+YgC_XP2Fd_w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 20 Feb 2019 07:44:02 +0100
Message-ID: <CACT4Y+ZxCs57qkO7n5tYU4v-J6E9MZsT_FLbXwbQ=B5btHTmwQ@mail.gmail.com>
Subject: Re: [PATCH] kasan: turn off asan-stack for clang-8 and earlier
To:     Kostya Serebryany <kcc@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, Qian Cai <cai@lca.pw>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 1:34 AM Kostya Serebryany <kcc@google.com> wrote:
>
> On Tue, Feb 19, 2019 at 2:43 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > + Evgenii, Kostya for KASAN
> >
> > On Tue, Feb 19, 2019 at 2:17 PM Qian Cai <cai@lca.pw> wrote:
> > >
> > > On Tue, 2019-02-19 at 22:49 +0100, Arnd Bergmann wrote:
> > > > Building an arm64 allmodconfig kernel with clang results in over 14=
0 warnings
> > > > about overly large stack frames, the worst ones being:
> > > >
> > > > drivers/gpu/drm/panel/panel-sitronix-st7789v.c:196:12: error: stack=
 frame size
> > > > of 20224 bytes in function 'st7789v_prepare'
> > > > drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c:19=
6:12:
> > > > error: stack frame size of 13120 bytes in function 'td028ttec1_pane=
l_enable'
> > > > drivers/usb/host/max3421-hcd.c:1395:1: error: stack frame size of 1=
0048 bytes
> > > > in function 'max3421_spi_thread'
> > > > drivers/net/wan/slic_ds26522.c:209:12: error: stack frame size of 9=
664 bytes
> > > > in function 'slic_ds26522_probe'
> > > > drivers/crypto/ccp/ccp-ops.c:2434:5: error: stack frame size of 883=
2 bytes in
> > > > function 'ccp_run_cmd'
> > > > drivers/media/dvb-frontends/stv0367.c:1005:12: error: stack frame s=
ize of 7840
> > > > bytes in function 'stv0367ter_algo'
> > > >
> > > > None of these happen with gcc today, and almost all of these are th=
e result
> > > > of a single known bug in llvm.  Hopefully it will eventually get fi=
xed with
> > > > the
> > > > clang-9 release.
>
> I am not confident we can fix this in clang.
> The difference between gcc and clang, AFAICT, is not in the asan
> instrumentation, but in inining.
> Looking at the reproducer from https://bugs.llvm.org/show_bug.cgi?id=3D38=
809#c4,
> if I change ltv350qv_write_reg to always inline, gcc also produces a
> huge 10K stack frame,
> and making it noinline fixes the stack frame for both gcc and clang.

Does your gcc have fix for https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D8=
1715 ?

For me gcc rejects to inline it:

gcc version 7.3.0 (Debian 7.3.0-5)

$ gcc /tmp/test.c -Wframe-larger-than=3D128 -c -fsanitize=3Dkernel-address
-O2 --param asan-stack=3D1
/tmp/test.c:23:13: warning: always_inline function might not be
inlinable [-Wattributes]
 static void ltv350qv_write_reg(void) {
             ^~~~~~~~~~~~~~~~~~
/tmp/test.c: In function =E2=80=98ltv350qv_power_on=E2=80=99:
/tmp/test.c:57:1: warning: the frame size of 416 bytes is larger than
128 bytes [-Wframe-larger-than=3D]
 }
 ^
