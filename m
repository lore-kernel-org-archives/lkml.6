Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D58C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A24420878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3DbY89j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A24420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbeGKJ5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:57:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44753 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbeGKJ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:57:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id q127-v6so18308388ljq.11
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 02:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7Myr2lozbjviJOtiRVXMO466rrfKAMlNJOsPXt1mcGk=;
        b=W3DbY89jF6eecFIpuhjFRo26Pu8oQkr2jLq/tO2kSYjk9+uv/c4yCaMVX0rirXb8ph
         BqDbt6SMbFqHl8IHX2eps7opO1sgdoFEILQza/HhjfCk9O+ieW6BTjUlnImvRAMCBLWc
         zOmMORdXHsauyYvLlXad2mMpd7Aj5bWhuyyV1PW/U2pcEkKX2JfFFFSmtwujWlzSs0OP
         TJQQ5ancCPs2bqRWWKjZHEaoCaen9z3GvON6Vp1ThkPerOggRN1V1COKhQ6/eVrTVZDH
         5fxX2Wp/P6hGjUPPpo937aPRtABEZwmkXIHXfi6sX1IJehgtRqeaWkBPj9nhYYUbQTnG
         GETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=7Myr2lozbjviJOtiRVXMO466rrfKAMlNJOsPXt1mcGk=;
        b=gzptsIYvDjcFvzYku6Ugoc0ZngtnGRPK3lMRH0vWUiEx4o8GaH9mEeLeJYelngFyau
         iyL0YU4A/iCvZpjy23G6ajwKXkYL/a0I4kkbFoaf5hfKli2eS3EX4EcZlTxDHTqaKKrL
         UiSeoDNAXgRP3zwR6YuxjEDwMDUvIFUBrhuf5p1U89HIAOpkYa0XFnj/qterxDTZjQzS
         +fE/l08bM3IJ9CcDHQmZFhSJ8rkXsQkg5s8LD6JW5k1NN4F7s1tcZiw2gbDLTPzDtwHN
         RgjsMNHv39kJvlOsAKdxm2TchZw9fwhxMUl+auhrLyel940PHz5V8BbVmhv1ofwve719
         fYqw==
X-Gm-Message-State: APt69E2W8MaMlc9JiiFy0kPzO47ghHWo/RBzhIuMIwsuPjVYlUoDAD+n
        aPKdE1mJLrJWUCMlOnpOm8Kwr9HCLfcdddXide8=
X-Google-Smtp-Source: AAOMgpfb8aX61QCMtnLNp3nLELDZvvdgKYUQvtricYgFTSULqjB6183Pe1X9fXsi5Ys7KOhGW40YZfwLovrfFEyStuA=
X-Received: by 2002:a2e:40c6:: with SMTP id r67-v6mr18132105lje.41.1531302857241;
 Wed, 11 Jul 2018 02:54:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:41c1:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 02:54:16
 -0700 (PDT)
In-Reply-To: <20180707054247.19802-6-deepa.kernel@gmail.com>
References: <20180707054247.19802-1-deepa.kernel@gmail.com> <20180707054247.19802-6-deepa.kernel@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 11 Jul 2018 11:54:16 +0200
X-Google-Sender-Auth: 9_Wh8856tLdoKRrUDH8ZGMXWbY8
Message-ID: <CAK8P3a2iYKnccdFqd7DsaGvK8Q_pJ1bfJr09uJaO7b=LRX8RaQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] time: Add struct __kernel_timex
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 7:42 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> struct timex uses struct timeval internally.
> struct timeval is not y2038 safe.
> Introduce a new UAPI type struct __kernel_timex
> that is y2038 safe.
>
> struct __kernel_timex uses a timeval type that is
> similar to struct __kernel_timespec which preserves the
> same structure size across 32 bit and 64 bit ABIs.
> struct __kernel_timex also restructures other members of the
> structure to make the structure the same on 64 bit and 32 bit
> architectures.
> Note that struct __kernel_timex is the same as struct timex
> on a 64 bit architecture.
>
> The above solution is similar to other new y2038 syscalls
> that are being introduced: both 32 bit and 64 bit ABIs
> have a common entry, and the compat entry supports the old 32 bit
> syscall interface.
>
> Alternatives considered were:
> 1. Add new time type to struct timex that makes use of padded
>    bits. This time type could be based on the struct __kernel_timespec.
>    modes will use a flag to notify which time structure should be
>    used internally.
>    This needs some application level changes on both 64 bit and 32 bit
>    architectures. Although 64 bit machines could continue to use the
>    older timeval structure without any changes.
>
> 2. Add a new u8 type to struct timex that makes use of padded bits. This
>    can be used to save higher order tv_sec bits. modes will use a flag to
>    notify presence of such a type.
>    This will need some application level changes on 32 bit architectures.
>
> 3. Add a new compat_timex structure that differs in only the size of the
>    time type; keep rest of struct timex the same.
>    This requires extra syscalls to manage all 3 cases on 64 bit
>    architectures. This will not need any application level changes but will
>    add more complexity from kernel side.

Hi Deepa,

sorry for taking so long with my reply

I've done a similar patch for the itimerval and the rusuage structures
that have the same basic problem of embedding a timeval, and after
a lot of back-and-forth on my end, I came to the same conclusion with
the structure layout: using a single binary layout that is shared between
32-bit and 64-bit ABIs is better than any of the other approaches that
one of us tried.

However, I'm still undecided about how to exactly put that in the uapi
headers.

>  #define ADJ_ADJTIME            0x8000  /* switch between adjtime/adjtimex modes */
> diff --git a/include/uapi/linux/timex.h b/include/uapi/linux/timex.h
> index 92685d826444..a1c6b73016a5 100644
> --- a/include/uapi/linux/timex.h
> +++ b/include/uapi/linux/timex.h
> @@ -92,6 +92,47 @@ struct timex {
>         int  :32; int  :32; int  :32;
>  };
>
> +struct __kernel_timex_timeval {
> +       __kernel_time64_t       tv_sec;
> +       long long               tv_usec;
> +};
> +
> +#ifndef __kernel_timex
> +struct __kernel_timex {
> +       unsigned int modes;     /* mode selector */
> +       int :32;            /* pad */
> +       long long offset;       /* time offset (usec) */
> +       long long freq; /* frequency offset (scaled ppm) */

The main disadvantage here is that a a typical ntp daemon that
includes this header will now call the new system call, but still see
the old structure definition that no longer matches, unless one
modifies it to use __kernel_timex.

I checked the most important libc implementations to see how
they pass this structure to user space:

glibc, musl, uclibc:
   sys/timex.h contains a private version of this structure, the kernel
   header is not included

bionic:
   sys/timex.h includes linux/timex.h, which is shipped with the libc
   and generated from kernel headers

klibc:
   there is no sys/timex.h, but also no adjtimex()/clock_adjtime() syscall

In short, this probably only really matters for bionic, and of course only
if they choose to even support 64-bit time_t (which in turn requires
other changes to the libc)

I can see two possible ways to define 'struct timex' in the kernel in a
way that always matches the respective adjtimex.

a) rename the old timex to __kernel_old_timex, and add a snippet that
    will #define one of the two to be called 'struct timex' again:

#ifdef __USE_TIME_BITS64
#define __kernel_old_timex timex
#define __kernel_old_timex_timeval timeval
#else
#define __kernel_timex timex
#define __kernel_timex_timeval timeval
#endif

b) use only one definition in the header file, but use configuration
dependent types, don't rename timex to __kernel_timex, and
only use compat_timex for the old 32-bit version inside of the
kernel:

/* for fields that are the same size as time_t */
#ifdef __KERNEL__
typedef __s64 timex_long_t;
#else
typedef time_t timex_long_t;
#endif

struct timex {
        unsigned int modes;             /* mode selector */
        char __pad1[sizeof(timex_long_t) - sizeof(int);
       __timex_long_t offset;         /* time offset (usec) */
        __timex_long_t freq;           /* frequency offset (scaled ppm) */
        __timex_long_t maxerror;       /* maximum error (usec) */
        __timex_long_t esterror;       /* estimated error (usec) */
        int status;                     /* clock command/status */
        char __pad1[sizeof(timex_long_t) - sizeof(int);
       __timex_long_t constant;       /* pll time constant */
       ...
};

Both a) and b) should work fine with bionic and any application
that includes linux/timex.h instead of sys/timex.h

        Arnd
