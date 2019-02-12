Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D261C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFD520869
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 19:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RT2Fq6Vw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbfBLTJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 14:09:09 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37686 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727677AbfBLTJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 14:09:08 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so10435895iti.2;
        Tue, 12 Feb 2019 11:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cnqr2wXipCxgDB3fFdGxUE67iCptpYk32YabGjqXilY=;
        b=RT2Fq6Vwj96574gFRSFJBCaEru8kvFDXF0AGVSe3ycoyK8BV9L3kqX6qkUw0XtITq0
         4Xv8fyKlBoWXISpATw3b5qpZ4C2lKKH3Cb9IK2FqApeALAR+TAH0DC9wWV53VWeK8YXf
         ZEHTPNoKJ4WcMBlR3DTqdwo5dyeqtSRGtX8UnKTuJ6WJpDQvDiE7TWHz0gSkeoyxuOUk
         3vuQd36veXEn1775p9QyJqxfBM63s9dnD+0i1c6L837nebwlDSfuVDvvPIfHpIIhbp5V
         oyAMRDRE1vsWoG08ScV9Y+P/TVP6rMoTjEqZ9E7ZzcfGDVtt/btCxuNaM+dt41hFrqZ2
         Yupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cnqr2wXipCxgDB3fFdGxUE67iCptpYk32YabGjqXilY=;
        b=E/xUV1c56uLdYfsVEnj0NyqirlCGnK2VN06lM2zmuTFQeZtWRKFNrd2aYXurhh1j5m
         VspL2xeaGS3E1bc7PIcE2S+UfTL+G5G/ZT+FVyA/dhL1LpZgXwESwFnK555dcUq2AS9w
         ktCIfaJKD+CIdBypYbAjB4Jr/EjU34T6MkUM2ULdo4lDnCUVlEfST5bXNyJp7IfJBnCr
         cxDDsXaQIEOVUQ6RTZykA2tA5TwKKGwidpcXFpKR5P+ckPQ66yQFzyfX/TCnHATHSdZZ
         bpP+UVc7rn5gOmLezgpKW4CMFATLqPHqUjqB72HjVexkXE/3YQ405CQkY/vMeYWOK2hR
         n6Ww==
X-Gm-Message-State: AHQUAubn4LF+ib3P8egfxxZUQJcP1WeheMYMQlR4swEyVcvuEYiE/vwx
        te0OHIksYc0VowoeGERvuXOBC2C/R1EKi9af5n8=
X-Google-Smtp-Source: AHgI3Ibg4wCNsMahNXO3PrbxJOvs/xNvt2h3NWzUDK40KnQgK+SW4cS3qYLsFmMh5P4h0XrvOxsTwmro4INfYwCE4YA=
X-Received: by 2002:a02:451d:: with SMTP id y29mr2974010jaa.85.1549998546555;
 Tue, 12 Feb 2019 11:09:06 -0800 (PST)
MIME-Version: 1.0
References: <20190202153454.7121-1-deepa.kernel@gmail.com> <20190202153454.7121-10-deepa.kernel@gmail.com>
 <AM4PR0501MB2769C4BE6CF1C5B051068D0BC56B0@AM4PR0501MB2769.eurprd05.prod.outlook.com>
 <CABeXuvqMR7T=3ORvXPihkz-WbTN+oFeHkCu9uvebEq9wTLpJuQ@mail.gmail.com>
In-Reply-To: <CABeXuvqMR7T=3ORvXPihkz-WbTN+oFeHkCu9uvebEq9wTLpJuQ@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 12 Feb 2019 11:08:52 -0800
Message-ID: <CABeXuvomXSgYQaFQgv71xQu837J_HUYR4NvMqXPyh4Z3Btnprg@mail.gmail.com>
Subject: Re: [PATCH net-next v5 09/12] socket: Add SO_TIMESTAMPING_NEW
To:     Ran Rozenstein <ranro@mellanox.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "chris@zankel.net" <chris@zankel.net>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "rth@twiddle.net" <rth@twiddle.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "ubraun@linux.ibm.com" <ubraun@linux.ibm.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 7:21 PM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> On Feb 10, 2019, at 7:43 AM, Ran Rozenstein <ranro@mellanox.com> wrote:
>
> >> Subject: [PATCH net-next v5 09/12] socket: Add SO_TIMESTAMPING_NEW
> >>
> >> Add SO_TIMESTAMPING_NEW variant of socket timestamp options.
> >> This is the y2038 safe versions of the SO_TIMESTAMPING_OLD for all
> >> architectures.
> >>
> >> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> >> Acked-by: Willem de Bruijn <willemb@google.com>
> >
> >
> > Hi,
> >
> > I have app that include:
> >    #include <linux/errqueue.h>
> >
> > It now fail with this error:
> >    In file included from timestamping.c:6:0:
> >    /usr/include/linux/errqueue.h:46:27: error: array type has incomplete element type 'struct __kernel_timespec'
> >      struct __kernel_timespec ts[3];
> >                                       ^~
> > I tried to do the trivial fix, to include time.h:
> > In include/uapi/linux/errqueue.h
> >    #include <linux/time.h>
> >    #include <linux/types.h>
> >
> > But it just add some other noises:
> >                In file included from /usr/include/linux/errqueue.h:5:0,
> >                                 from timestamping.c:6:
> >                /usr/include/linux/time.h:10:8: error: redefinition of ?struct timespec?
> >                 struct timespec {
> >                        ^~~~~~~~
> >                In file included from /usr/include/sys/select.h:39:0,
> >                                 from /usr/include/sys/types.h:197,
> >                                 from /usr/include/stdlib.h:279,
> >                                 from timestamping.c:2:
> >                /usr/include/bits/types/struct_timespec.h:8:8: note: originally defined here
> >                 struct timespec
> >                        ^~~~~~~~
> >                In file included from /usr/include/linux/errqueue.h:5:0,
> >                                 from timestamping.c:6:
> >                /usr/include/linux/time.h:16:8: error: redefinition of ?struct timeval?
> >                 struct timeval {
> >                        ^~~~~~~
> >                In file included from /usr/include/sys/select.h:37:0,
> >                                 from /usr/include/sys/types.h:197,
> >                                 from /usr/include/stdlib.h:279,
> >                                 from timestamping.c:2:
> >                /usr/include/bits/types/struct_timeval.h:8:8: note: originally defined here
> >                 struct timeval
> >                        ^~~~~~~
> >
> >
> > Can you please advise how to solve it?
> >
> > Thanks,
> > Ran
>
> The errqueue.h already had the same issue reported previously:
> https://lore.kernel.org/netdev/CAF=yD-L2ntuH54J_SwN9WcpBMgkV_v0e-Q2Pu2mrQ3+1RozGFQ@mail.gmail.com/
>
> Earlier when I tested this with kernel selftests such as
> tools/testing/selftests/networking/timestamping/rxtimestamp(the test
> was broken to begin with because of  missing include of unistd.h), I
> was using make.cross to build.
> This does not put the headers in the right place
> (obj-$ARCH/usr/include instead of usr/include). Hence, I did not
> realize that this breaks the inclusion of errqueue.h due to the
> missing __kernel_timespec definition.
> I forgot that nobody seems to be using linux/time.h.
>
> But, if I include guards( #ifndef __KERNEL__) for struct timespec,
> struct timeval etc for linux/time.h, then we can include it from
> userspace/ errqueue.h for __kernel_timespec:
>
> --- a/include/uapi/linux/errqueue.h
> +++ b/include/uapi/linux/errqueue.h
> @@ -2,7 +2,7 @@
>  #ifndef _UAPI_LINUX_ERRQUEUE_H
>  #define _UAPI_LINUX_ERRQUEUE_H
>
> -#include <linux/types.h>
> +#include <linux/time.h>
>
>  struct sock_extended_err {
>         __u32   ee_errno;
> diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
> index a6aca9aaab80..40913d9a5bc8 100644
> --- a/include/uapi/linux/time.h
> +++ b/include/uapi/linux/time.h
> @@ -5,6 +5,8 @@
>  #include <linux/types.h>
>
>
> +#ifdef __KERNEL__
> +
>  #ifndef _STRUCT_TIMESPEC
>  #define _STRUCT_TIMESPEC
>  struct timespec {
> @@ -42,6 +44,8 @@ struct itimerval {
>         struct timeval it_value;        /* current value */
>  };
>
> +#endif /* __KERNEL__ */
>
> Arnd,
>
> I forgot how we plan to include the definition for __kernel_timespec
> for libc or userspace. Does this seem right to you?
> Also these changes to errqueue.h needs to be reverted probably as this
> breaks userspace.

Arnd and I talked about this today morning.
We agreed that we could introduce a new time_types.h along the lines
of posix_types.h. We will move all the time definitions that we plan
to keep in the kernel uapi headers to this header. This header will
also not have any overlap with the sys/time.h and can be included
along with it from userspace.
I will post this patch shortly.

This should fix Ran's issue.

-Deepa
