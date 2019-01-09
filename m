Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BFEC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 747B3217F9
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PctgyBnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbfAILkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:40:23 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42881 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730777AbfAILkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:40:23 -0500
Received: by mail-ot1-f66.google.com with SMTP id v23so6381877otk.9;
        Wed, 09 Jan 2019 03:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uuKGwm3dSdRruh6ezWlijk4urMC7xHSFkdmF3oXurjc=;
        b=PctgyBnvvbPvLhNXJoYK898VUCwg+K2zqY5LoAas4Kw0EPCTZgYHF8id7JJCAh01YW
         A4XgYxRZAVMW9kWPDEi5aw6a8up0rgzTa6ElkjrEQSreO/5sbHRpM1wXIsm0g2QiiG7c
         8aVre9eBviz3s7Z0EJYMySXJNt8RWDFzk/BJhheXkQIu7k56fs8n9AsC8qj+k87ONaos
         IbqIWdkcnl+fKrlYRVyhMWW+6n5W5ZsvU+TnC3JSDGrQdH0JnrdLtQsV7JFZ5jUuL7ZW
         F4eBPaYsv+cf9Fo4QPY+2K2zaEjl3xTVFfeiOI2prhWVrjkIfTOba44jLFxQQnnqbVea
         RmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uuKGwm3dSdRruh6ezWlijk4urMC7xHSFkdmF3oXurjc=;
        b=a3dEvZlJcvKDxuy3cu6rwaw+qf4b1deHN+FRf8hMFFD2JEclbR4Fhb7JETryVEUsmZ
         waKvu2saRk3C9Fd+ZJjpC56KJ9rRVkwWWWXOIugh7IPhigmKsq8Gm8RfyF7PZCtOW7B9
         60gfIVJKkipgaYLYrTpebB2CWuXD/3h4zK0+CztOVru/7ZLIrwWzAZMN0bv658u5Nyt1
         jvjBPLNPjScyLd21tFYLdXTMF5XdAHu62fqzjGHG1E9pMYQ3BJXxdscSI4Yl+UwXfNJ2
         nx+ZqNzM4lB616/juBMxcR8fLy4+r59P/ecZU/ZymbuTP68SuA6TFJSlM7PBnhWpRZU+
         Qg5Q==
X-Gm-Message-State: AJcUukfmv0Qzs5p36vegrPsPuw9OzoyMtdvDs8spsfwEFDNKwW3mx6Tk
        cUF7FOC/QeTFcdBtsDlTbHAV4bbTJrFBj/hY6HM=
X-Google-Smtp-Source: ALg8bN5fNrGXqcQcHk36/vUQwIArD33bzEZycxuIIAwCKAn1v/3bfuiwdu9vytwPjk/AYV2ZQNGUZaXh4Ov7PdbmYlM=
X-Received: by 2002:a05:6830:1204:: with SMTP id r4mr4111549otp.101.1547034022237;
 Wed, 09 Jan 2019 03:40:22 -0800 (PST)
MIME-Version: 1.0
References: <20190107105330.372621917@linuxfoundation.org> <d86ef960-dd47-b282-5432-4ecbdd4e0daf@roeck-us.net>
 <20190108122542.GA4801@kroah.com>
In-Reply-To: <20190108122542.GA4801@kroah.com>
From:   Jinpu Wang <jinpuwang@gmail.com>
Date:   Wed, 9 Jan 2019 12:40:11 +0100
Message-ID: <CAD9gYJ+P6SFzDVDUMJRESUEYFNC1GhP+C76__rj2w1HzXPEtDw@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/101] 4.14.92-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        "v3.14+, only the raid10 part" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> =E4=BA=8E2019=E5=B9=B41=E6=
=9C=888=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=881:28=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Mon, Jan 07, 2019 at 08:59:12PM -0800, Guenter Roeck wrote:
>
> Should all now be fixed up.
>
> I hope, this set of releases has been a pain...
>
> greg k-h

I had build failure below, looks related to 0fe69354b888 ("crypto:
testmgr - add AES-CFB tests")
In file included from crypto/testmgr.c:54:0:
crypto/testmgr.h:16039:3: error: unknown field 'ptext' specified in initial=
izer
   .ptext =3D "\x6b\xc1\xbe\xe2\x2e\x40\x9f\x96"
   ^
crypto/testmgr.h:16047:3: error: unknown field 'ctext' specified in initial=
izer
   .ctext =3D "\x3b\x3f\xd9\x2e\xb7\x2d\xad\x20"
   ^
crypto/testmgr.h:16055:3: error: unknown field 'len' specified in initializ=
er
   .len =3D 64,
   ^
crypto/testmgr.h:16055:3: warning: initialization makes pointer from
integer without a cast
crypto/testmgr.h:16055:3: warning: (near initialization for
'aes_cfb_tv_template[0].result')
crypto/testmgr.h:16063:3: error: unknown field 'ptext' specified in initial=
izer
   .ptext =3D "\x6b\xc1\xbe\xe2\x2e\x40\x9f\x96"
   ^
crypto/testmgr.h:16071:3: error: unknown field 'ctext' specified in initial=
izer
   .ctext =3D "\xcd\xc8\x0d\x6f\xdd\xf1\x8c\xab"
   ^
crypto/testmgr.h:16079:3: error: unknown field 'len' specified in initializ=
er
   .len =3D 64,
   ^
crypto/testmgr.h:16079:3: warning: initialization makes pointer from
integer without a cast
crypto/testmgr.h:16079:3: warning: (near initialization for
'aes_cfb_tv_template[1].result')
crypto/testmgr.h:16088:3: error: unknown field 'ptext' specified in initial=
izer
   .ptext =3D "\x6b\xc1\xbe\xe2\x2e\x40\x9f\x96"
   ^
crypto/testmgr.h:16096:3: error: unknown field 'ctext' specified in initial=
izer
   .ctext =3D "\xdc\x7e\x84\xbf\xda\x79\x16\x4b"
   ^
crypto/testmgr.h:16104:3: error: unknown field 'len' specified in initializ=
er
   .len =3D 64,
   ^
crypto/testmgr.h:16104:3: warning: initialization makes pointer from
integer without a cast
crypto/testmgr.h:16104:3: warning: (near initialization for
'aes_cfb_tv_template[2].result')
  CC [M]  drivers/infiniband/sw/rxe/rxe_hw_counters.o
  CC      drivers/pci/pcie/portdrv_bus.o
  CC      lib/devres.o
crypto/testmgr.c:2633:4: error: unknown field 'vecs' specified in initializ=
er
    .cipher =3D __VECS(aes_cfb_tv_template)
    ^
crypto/testmgr.c:2633:4: warning: missing braces around initializer
[-Wmissing-braces]
crypto/testmgr.c:2633:4: warning: (near initialization for
'alg_test_descs[36].suite.cipher.enc') [-Wmissing-braces]
crypto/testmgr.c:2633:4: error: unknown field 'count' specified in initiali=
zer
In file included from ./include/linux/kernel.h:15:0,
                 from ./include/linux/crypto.h:21,
                 from ./include/crypto/aead.h:16,
                 from crypto/testmgr.c:23:
./include/linux/build_bug.h:30:45: warning: initialization makes
pointer from integer without a cast
 #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
                                             ^
./include/linux/compiler-gcc.h:65:28: note: in expansion of macro
'BUILD_BUG_ON_ZERO'
 #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                            ^
./include/linux/kernel.h:71:59: note: in expansion of macro '__must_be_arra=
y'
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(=
arr))
                                                           ^
crypto/testmgr.c:2347:43: note: in expansion of macro 'ARRAY_SIZE'
 #define __VECS(tv) { .vecs =3D tv, .count =3D ARRAY_SIZE(tv) }
                                           ^
crypto/testmgr.c:2633:14: note: in expansion of macro '__VECS'
    .cipher =3D __VECS(aes_cfb_tv_template)
              ^
./include/linux/build_bug.h:30:45: warning: (near initialization for
'alg_test_descs[36].suite.cipher.dec.vecs')
 #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
                                             ^
./include/linux/compiler-gcc.h:65:28: note: in expansion of macro
'BUILD_BUG_ON_ZERO'
 #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                            ^
./include/linux/kernel.h:71:59: note: in expansion of macro '__must_be_arra=
y'
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(=
arr))
                                                           ^
crypto/testmgr.c:2347:43: note: in expansion of macro 'ARRAY_SIZE'
 #define __VECS(tv) { .vecs =3D tv, .count =3D ARRAY_SIZE(tv) }
                                           ^
crypto/testmgr.c:2633:14: note: in expansion of macro '__VECS'
    .cipher =3D __VECS(aes_cfb_tv_template)
              ^
  CC [M]  drivers/md/dm-snap.o
scripts/Makefile.build:326: recipe for target 'crypto/testmgr.o' failed
make[4]: *** [crypto/testmgr.o] Error 1
Makefile:1045: recipe for target 'crypto' failed
make[3]: *** [crypto] Error 2
