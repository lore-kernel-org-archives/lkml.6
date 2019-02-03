Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6305C282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 02:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A249C20870
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 02:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdTP3ifq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfBCCre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 21:47:34 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:56207 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbfBCCrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 21:47:33 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so15601904ith.5;
        Sat, 02 Feb 2019 18:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZMYtRmKOONVnZU74jVMCYosr4pKhEho8RsInAYHkIrU=;
        b=KdTP3ifqajYxvYkJWRnrvGBZSyEmIgYA39UHfnYk43VDQd72q/DV+y/VS2iwKEvIkD
         mRWvndEEKv+NBrz/qbRD85E925sBQ+IdLiJtyf/bxgXkDN+2I4U/UbTP3ge/SkftkHvi
         GGUUf6ZdBiWJsU2bA6GkH0nb4DRfPa+pYyD98P75tcaruSBdAeaHiVtmv6LUWquk0sOv
         XzMaN1E0rPVqGlR/n3j6dgNpYZCtUWuTmavMClfuH1J0jVhRwgSzMOLwALcUqNtOBph7
         t1pfsH7SLZ1Gu0xrDf7kQL91744p180NWBVbA7IAICl1QNu57omX10tU5p7iajd7hCz1
         2EHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZMYtRmKOONVnZU74jVMCYosr4pKhEho8RsInAYHkIrU=;
        b=It0anNRW9lg6qUEkUu8yMgiAqPFk+lcdoUrFtkP7bg4gmWeb6FVE/lmlhhr97x93uM
         SkoOGAmdh8+zgDAA5PSeJSekjXWctZqi89DTiQAxaEKgQfy8TNYxSGSTIl3RmWYotYp1
         HIUiWoCr5TvvZK5sYKrIDD3sPyP7CrTDG7x1H7MzpTCUEHpHPqRW67/WrZOwM7z2BmYF
         8rbTAWIAlaGVE65lnOcavWeG1NgD6/gGAGSBcXaWE/E8c5A9cbmI4Dug8G3tTGbfEskA
         P3+sGr4T4BuLcXRVV20F6F1P1tBqzkmCcBZUBCqLo4mQyPDFTAR5aLYszCiNUumexWZ1
         k9Ug==
X-Gm-Message-State: AHQUAuY6g2eCLtJ4Be+vktu3Bw0hUNOSvvmSj+NGEH83GqrAe0mFGTfM
        u8XBS0OAZFDsPyU9m2Le09X/N9lKRLWDO8cz0G0=
X-Google-Smtp-Source: AHgI3IYS2NBXv2myRee69tHGYtSoIzUX3ZpjIGORvAD+gSqnvHnb8wwPrS8ntV2W3anTchzcRl2E0ikoXcP4hPviPoE=
X-Received: by 2002:a24:3dd1:: with SMTP id n200mr5846603itn.61.1549162051879;
 Sat, 02 Feb 2019 18:47:31 -0800 (PST)
MIME-Version: 1.0
References: <20190202153454.7121-1-deepa.kernel@gmail.com> <20190202153454.7121-13-deepa.kernel@gmail.com>
 <0fad3f4d-4c0e-d9f2-1af0-7890d40c19c0@hartkopp.net>
In-Reply-To: <0fad3f4d-4c0e-d9f2-1af0-7890d40c19c0@hartkopp.net>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 2 Feb 2019 18:47:20 -0800
Message-ID: <CABeXuvrf_s_LzwYy5p_gqw+PU70OnFAntdtyazN+CBAbyS07TA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 12/12] sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
To:     Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        ccaulfie@redhat.com, Helge Deller <deller@gmx.de>,
        Paul Mackerras <paulus@samba.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Richard Henderson <rth@twiddle.net>,
        cluster-devel <cluster-devel@redhat.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-alpha@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        Parisc List <linux-parisc@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 2, 2019 at 9:15 AM Oliver Hartkopp <socketcan@hartkopp.net> wro=
te:
>
> Hi all,
>
> On 02.02.19 16:34, Deepa Dinamani wrote:
> > Add new socket timeout options that are y2038 safe.
> (..)
> >
> > diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/=
uapi/asm/socket.h
> > index 9826d1db71d0..0d0fddb7e738 100644
> > --- a/arch/alpha/include/uapi/asm/socket.h
> > +++ b/arch/alpha/include/uapi/asm/socket.h
> > @@ -119,19 +119,25 @@
> >   #define SO_TIMESTAMPNS_NEW      64
> >   #define SO_TIMESTAMPING_NEW     65
> >
> > -#if !defined(__KERNEL__)
> > +#define SO_RCVTIMEO_NEW         66
> > +#define SO_SNDTIMEO_NEW         67
> >
> > -#define      SO_RCVTIMEO SO_RCVTIMEO_OLD
> > -#define      SO_SNDTIMEO SO_SNDTIMEO_OLD
> > +#if !defined(__KERNEL__)
> >
> >   #if __BITS_PER_LONG =3D=3D 64
> >   #define SO_TIMESTAMP                SO_TIMESTAMP_OLD
> >   #define SO_TIMESTAMPNS              SO_TIMESTAMPNS_OLD
> >   #define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
> > +
> > +#define SO_RCVTIMEO          SO_RCVTIMEO_OLD
> > +#define SO_SNDTIMEO          SO_SNDTIMEO_OLD
>
> Maybe I'm a bit late in this discussion as you are already in v5 ...
>
> I can see patches making the transition in different steps where it
> might be helpful to name them *_OLD and *_NEW to understand the patches.
>
> But in the end the naming stays in the kernel for a very long time and I
> remember myself (in early years) to name things 'new', 'new2', 'new3'.
>
> In fact SO_TIMESTAMP_OLD should be named SO_TIMESTAMP32 and
> SO_TIMESTAMP_NEW should be named SO_TIMESTAMP64.

Hmm. SO_TIMESTAMP_OLD uses 64-bit time_t on a 64 bit machine. In fact,
there is no difference between the two options on a 64 bit machine. So
using  SO_TIMESTAMP_32 is just wrong.

Likewise, SO_TIMESTAMP_64 naming somehow indicates that the existing
one was not, and that is also not true on a 64-bit machine.

Further, userspace will still continue to use SO_TIMESTAMP and the
macros take care of which option to select internally.

Moreover, these macros have been there for more than ten years
(introduced before 2.4) and there has been no change. I doubt you will
ever have NEW2.
I think this argument is similar to saying don=E2=80=99t name these macros
SO_TIMESTAMP because there might be SO_TIMESTAMP1 some day. There is
never a perfect name. SO_TIMESTAMPING is also not really descriptive.

> Especially as it tells you what is 'inside', the naming of these new intr=
oduced constants should be replaced with *32 and *64 names.
> The documentation and the other comments still fit perfectly then.

I would prefer not to do this, for reasons mentioned above. Since you
point out that it is easier to use this naming for intermediate steps,
I suggest that we leave the series as it is.
If you feel strongly to post a follow-on renaming patch, you could
discuss it with the subsystem maintainers, if you think there is a
correct but more descriptive naming.

-Deepa

> Regards,
> Oliver
