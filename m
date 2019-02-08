Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E22C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1197420869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 14:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tcd-ie.20150623.gappssmtp.com header.i=@tcd-ie.20150623.gappssmtp.com header.b="wWNoWpO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfBHObV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 09:31:21 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43624 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfBHObV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 09:31:21 -0500
Received: by mail-vs1-f66.google.com with SMTP id x1so2172492vsc.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 06:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tcd-ie.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mZuN2u2zzGAtJZskiqQ/KxA1Zjk9pelWPlcNL3+VHC4=;
        b=wWNoWpO599fqsth6IN66fjNwn0+sKletXX4WH5wqV4U/F5MwLW7Piu2djiT5JA4r3s
         s8PiImwWW2CS4hRbrQlEctNkPVF4aDJ/F3aLLM/4EiWdpejw3XywE3bbZLhE1Z5EMTkE
         RFgWhULbHta55FoUx5pIQ3ZlBBMBLV1Bm1NG6xlVPZa1Eip1Ico6ffqLtnHTYC0gRp/p
         a2xSSJRsZkSWLs2wCul18WxKRfqxZVEY3tlusHx2KiTS3Elqx+f+zY6r2yXqbdbkB7XC
         V2GM0s7sCfWdQGFAqVeJD62NSyyTmuS3f8M0LZ1A2Gk9970jqpyxpRGuaEHzHw1TtVuH
         tPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mZuN2u2zzGAtJZskiqQ/KxA1Zjk9pelWPlcNL3+VHC4=;
        b=N8k1/Z//U3YYp9U46E1JGXzpoFGy3LaPzr9Yp5WxGloUrrc+PPdIftZMnxjCDxEMfH
         Fgku92TMVPBrsePQZVjnEk6FL/7mmg8TlyMfvP2XB3PU9aPu+p/x38XXyXcKElWUzjl9
         NZlvXxK45xVeond6KK6HL/RBdiuN5j2RLN24MZSYRxF4YV/WiyfZzv/dOfk+PlOOPBO3
         u+rgTBaKMm2llXw6cT2fNpqiHTwsHPrF2f6CYNLBYfe4vgX18Bh4go++Zc8pQ3ZIVCtG
         9mf91lXr09Z61OE0LjgLSyx4daOfbKP0XDYzTRI/+MNH+afsT3imyo5/rBWHGdhix5mt
         1lRw==
X-Gm-Message-State: AHQUAuZ3pUZRqSDGmV1vaRdlLRqOFPyBwZXnhDOfq2o1f4/jPNBT1uTz
        77xl1dj+NsjrPb4/95jC6kAqPOjV99OdSJlVYnLz/16NpSPpyw==
X-Google-Smtp-Source: AHgI3IZyiwRbRB/4EQhuWyJ6+nkoiQOwAMf4XZ8enHN+7xlRntlxWPG7DFjWXXU628++2S7CeFwyFU538gdoKUfnpks=
X-Received: by 2002:a67:f603:: with SMTP id k3mr1923180vso.65.1549636279760;
 Fri, 08 Feb 2019 06:31:19 -0800 (PST)
MIME-Version: 1.0
References: <20181127103312.19368-1-murphyt7@tcd.ie> <CAMuHMdWX=5CE=vhazBSOEbzJYyAwiK2PSDryCrA67yXRVb0m3w@mail.gmail.com>
In-Reply-To: <CAMuHMdWX=5CE=vhazBSOEbzJYyAwiK2PSDryCrA67yXRVb0m3w@mail.gmail.com>
From:   Tom Murphy <murphyt7@tcd.ie>
Date:   Fri, 8 Feb 2019 14:31:07 +0000
Message-ID: <CALQxJusnECzqS+Hn-TgfJnXKw--MbfB8DizrjYanejfDdA=gRA@mail.gmail.com>
Subject: Re: [PATCH] fix dma-buf/udmabuf selftest
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> However, we need <linux/fcntl.h> for F_ADD_SEALS, F_SEAL_SHRINK.
>
> Including both leads to lots of redefinition warnings.
>
> Can we fix that?

I still haven't looked at this and probably won't get a chance anytime soon=
.
linux/tools/testing/selftests/memfd/fuse_test.c also suffers from this
(it needs the F_ADD_SEALS too) so that should also be fixed if anyone
gets a chance




On Wed, 9 Jan 2019 at 10:44, Geert Uytterhoeven <geert@linux-m68k.org> wrot=
e:
>
> Hi Tom,
>
> On Tue, Nov 27, 2018 at 7:53 PM Tom Murphy <murphyt7@tcd.ie> wrote:
> > This patch fixes the udmabuf selftest. Currently the selftest is broken=
.
> > I fixed the selftest by setting the F_SEAL_SHRINK seal on the memfd
> > file descriptor which is required by udmabuf and added the test to
> > the selftest Makefile.
> >
> > Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
>
> This is now commit 6edf2e3710f4ef25 ("fix dma-buf/udmabuf selftest").
>
> > --- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> > +++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
> > @@ -4,7 +4,7 @@
> >  #include <unistd.h>
> >  #include <string.h>
> >  #include <errno.h>
> > -#include <fcntl.h>
> > +#include <linux/fcntl.h>
>
> Not including <fcntl.h> means we get
>
> udmabuf.c:30:10: warning: implicit declaration of function =E2=80=98open=
=E2=80=99; did
> you mean =E2=80=98popen=E2=80=99? [-Wimplicit-function-declaration]
>   devfd =3D open("/dev/udmabuf", O_RDWR);
> udmabuf.c:42:8: warning: implicit declaration of function =E2=80=98fcntl=
=E2=80=99; did
> you mean =E2=80=98fcvt=E2=80=99? [-Wimplicit-function-declaration]
>    ret =3D fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK);
>
> However, we need <linux/fcntl.h> for F_ADD_SEALS, F_SEAL_SHRINK.
>
> Including both leads to lots of redefinition warnings.
>
> Can we fix that?
>
> >  #include <malloc.h>
> >
> >  #include <sys/ioctl.h>
> > @@ -33,12 +33,19 @@ int main(int argc, char *argv[])
> >                 exit(77);
> >         }
> >
> > -       memfd =3D memfd_create("udmabuf-test", MFD_CLOEXEC);
> > +       memfd =3D memfd_create("udmabuf-test", MFD_ALLOW_SEALING);
> >         if (memfd < 0) {
> >                 printf("%s: [skip,no-memfd]\n", TEST_PREFIX);
> >                 exit(77);
> >         }
> >
> > +       ret =3D fcntl(memfd, F_ADD_SEALS, F_SEAL_SHRINK);
> > +       if (ret < 0) {
> > +               printf("%s: [skip,fcntl-add-seals]\n", TEST_PREFIX);
> > +               exit(77);
> > +       }
> > +
> > +
> >         size =3D getpagesize() * NUM_PAGES;
> >         ret =3D ftruncate(memfd, size);
> >         if (ret =3D=3D -1) {
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
