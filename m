Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E1FC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675A02085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CVPrfMik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675A02085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbeJIBZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:25:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43327 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbeJIBZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:25:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id 80-v6so8173130pgh.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 11:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SKwgs8tPCitfGq4BZQNjNCY4NETlWIq/kzgxU9sjoS8=;
        b=CVPrfMikIBUIWhVNKeQr4BHm0aArVcQIaKliigyJUqeF9nOp42+NfJfWvHZvht39ah
         tM8L7ZsYM7z5WLwXg1iv5bEm6/JBZPqsx9E5KpV1upULvPSRL3TEefQcKOIry1/kP2CH
         ZRPcVOR/7ptyK8WBQmU4yFgn0PmiJ3KyOET1XxabToW51Mg8pkFIDyUkRz9H1QZr3ZZ+
         LbabXMvcv7VFzPhyvkuZmM5wbT483hrDNmT/jinUVh0LYnIgZo0x2bE2WJeSksk7C9Pa
         QJKvkkwCFfy+qVdHmZSsQVfLoCeZq/mrewfYSOOVua9LKmIkDWiVNW6gr9q4Cz03W7jN
         A6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SKwgs8tPCitfGq4BZQNjNCY4NETlWIq/kzgxU9sjoS8=;
        b=VkpCAJJde+D6sIckh6gnHUiGypP0JuD6jo6TOtE+6ugOXDJjkYV/Lo3/QzMPWQBYUu
         YetrDOBf+zGA1bb4XVeuXKGFlRazDVzELiZrTNr44oMTVxOvlpTv3R/xMJ5YqT4mGuuJ
         +u6kB7MJfSt7e00kNz5E034yrf3Ym9HUhJKt5Xg0fpl7gZKcwK8ygnjLoLAQS9bU0KrT
         xFhDOB7tA0k8S9nNioSW5sCL8VQdC5qL7LtXqMTai1qD826QvvwkPKAIaFr0AyUY+fmK
         RqghNubbNe1t0YBWttKqeiih9WBct/QQKrkGwCGOhtEsSyUnSMbJzlMQMhxhCRtUBwYJ
         kMCA==
X-Gm-Message-State: ABuFfohXeyG7T4pqSpfcGhfDcuSLsRQkz/fvcStiGjJuEwJ7nxGJuert
        z+Pp5YrMJldBr+kyTpHgX/9MKhDhSG8t1XXEg7Dvkg==
X-Google-Smtp-Source: ACcGV62c5cqYG0yHevrC0bmfWu9nWXgHqTv3zZcobn81APfe54xcHpZK0LjYddaq/qH2yAmRVtsuJhFKt/F3oiEmXPM=
X-Received: by 2002:a63:a047:: with SMTP id u7-v6mr22336634pgn.145.1539022372215;
 Mon, 08 Oct 2018 11:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20181004183047.GA1885@flashbox> <1538678069.230807.6.camel@acm.org>
 <20181004184540.GA17513@flashbox> <CAKwvOd=FrGZ-oh5Q9RGQD2GNORZrqwAZUzNYN+hTKkp5wrfrqw@mail.gmail.com>
 <20181005065754.GA18637@flashbox>
In-Reply-To: <20181005065754.GA18637@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 8 Oct 2018 11:12:40 -0700
Message-ID: <CAKwvOdm8+zF48Osasi_7TrJAz51Zt+m2-7qMASLhT+M0NG4WjA@mail.gmail.com>
Subject: Re: -Wswitch Clang warnings in drivers/scsi
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     bvanassche@acm.org,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 11:57 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Oct 04, 2018 at 02:16:49PM -0700, Nick Desaulniers wrote:
> > On Thu, Oct 4, 2018 at 11:45 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > On Thu, Oct 04, 2018 at 11:34:29AM -0700, Bart Van Assche wrote:
> > > > On Thu, 2018-10-04 at 11:30 -0700, Nathan Chancellor wrote:
> > > > > Hi SCSI folks,
> > > > >
> > > > > In an effort to get the kernel building warning free with Clang, we've
> > > > > come across an interesting occurrence in a few scsi drivers:
> > > > >
> > > > > drivers/scsi/hpsa.c:6533:7: warning: overflow converting case value to switch condition type (2148024833 to 18446744071562609153) [-Wswitch]
> > > > >         case CCISS_GETPCIINFO:
> > > > >              ^
> > > > > ./include/uapi/linux/cciss_ioctl.h:65:26: note: expanded from macro 'CCISS_GETPCIINFO'
> > > > > #define CCISS_GETPCIINFO _IOR(CCISS_IOC_MAGIC, 1, cciss_pci_info_struct)
> > > > >                          ^
> > > > > ./include/uapi/asm-generic/ioctl.h:86:28: note: expanded from macro '_IOR'
> > > > > #define _IOR(type,nr,size)      _IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
> > > > >                                 ^
> > > > > ./include/uapi/asm-generic/ioctl.h:70:2: note: expanded from macro '_IOC'
> > > > >         (((dir)  << _IOC_DIRSHIFT) | \
> > > > >         ^
> > > > >
> > > > > I see this warning in drivers/scsi/hpsa.c and drivers/scsi/smartpqi/smartpqi_init.c
> > > > > on an arm64 allyesconfig build and it has also been reported in a couple of files in
> > > > > drivers/scsi/cxlflash.
> > > > >
> > > > > As the warning states, there is an overflow because the switch statement's value is of
> > > > > type int but the switch value is greater than INT_MAX. I did a brief sweep of the tree
> > > > > and it seems that all uses of _IOC in switch statement values either are small enough
> > > > > to fit into size int or the value is of size unsigned int.
> > > > >
> > > > > I am unsure of the implications of using a smaller _IOC value or converting all ioctls
> > > > > to expect a cmd of type unsigned int (especially since that has userspace implications)
> > > > > but I didn't see any negative ioctl commands. Some clarity and insight would be
> > > > > appreciated.
> > > >
> > > > Have you verified how gcc compiles these switch statements? Maybe gcc supports
> > > > switch / case statements on integral types that are larger than an int?
> >
> > GCC just doesn't warn when the case expression is greater than the
> > maximal representable value and thus would wrap (or appears to, this
> > is probably undefined behavior).  Using an unsigned int here is no
> > functional change:
> > https://godbolt.org/z/1IyYV4
> >
> > GCC and Clang do effectively the same thing as each other, and in the
> > cases of switching on an unsigned int vs signed int.
> >
>
> Regardless of how the overflow is handled within the switch statement,
> the overflow is also happening when passing in these values to the ioctl,
> right? I mean these case values are defined in the uapi files so that
> userspace can easily pass them in to the ioctl, meaning those values are
> being passed in as a signed integer and I would assume subsequently
> overflowing unless I'm just missing something here.

The kernel compiles its code with -fno-strict-overflow, which sets
-fwrapv, which makes signed integer overflow defined to wrap (the
default by the C standard is that signed integer overflow is undefined
behavior).  So while the kernel might be safe from undefined behavior,
the wrapped value being provided to userspace might be a problem.  If
userspace tries to use these definitions, I suspect they will likely
trigger the overflow at runtime.

>
> Nathan
>
> > > >
> > > > Bart.
> > >
> > > Hi Bart,
> > >
> > > That is entirely possible, I will do some research. I did build with GCC
> > > to see if there was any warning and there isn't so I'll be curious to
> > > see what is happening at a lower level.
> > >
> > > Thanks for the comment!
> > > Nathan
> >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
