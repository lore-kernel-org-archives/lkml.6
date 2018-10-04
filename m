Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CCE4C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA3420877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 21:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YyyDrVIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA3420877
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbeJEEMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 00:12:10 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34485 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbeJEEMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 00:12:10 -0400
Received: by mail-pl1-f194.google.com with SMTP id f18-v6so5771002plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m6+rzROd+JZAbf96mpR7TVe7LockULJI5BlTxu3+SaE=;
        b=YyyDrVIjPslOOuxd3O63eB9jfJOLMxbf/IZfuvlsgIlXqX1biw00sgWJNIfOtlYZBt
         MV1Wr4NUDzYVu+FJljFQ55tCpjYPStRjuAcb2JilIOlDRqQPTbv2LrXhicCYcvcdb3RO
         Ja5i1R5rPRi6FIvLFovvQqnFulEMqLYhUNXHJGtG9WP1MUA5CxQuap6B2Ia01m8uU8U1
         hiDZA+ZkUgqbncwv4jtbzTLqFjYIIBaC/W6VVXw0RcqZdX4Q4Iy14T5BrwywNp8kZ/T4
         auIf8M7noxtN/JawgcymyvOL9hVc+fm90HqRIWnPIa10iOcZ4t0vdS7BCD/rFtNur9Nt
         KBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6+rzROd+JZAbf96mpR7TVe7LockULJI5BlTxu3+SaE=;
        b=T5TU51jiGG/fyrJEuCKVVt4fpMgLgQ8WJVfXgVe0W9AXLidsm7TqHZChCUeVrA5FVP
         /LuD31JfvL+qMc47JhEJ1zzwKc96xMaTYu7Ph9mi4KniMueB/620pNj07GXfj6/Oc7ja
         ueTJxMRqb5CjWp1VFAgjftc+hiI7URnIbL6meHkWwBv1Qztds/lbQduh5VNkmMSExU4J
         bc20MoI7m3ULDEMF0Lv5fFtrKnA2xNxpm0+2HbpYv+7y+u9iLYKv/aFcYXF7nDKYcoAr
         q6pp2xwDC53T/P9K4mt5h6WutHaaEFbkD5p2hoTWOao7KnBmI2Uc+LyHJw9yq7R1DjYq
         YGKw==
X-Gm-Message-State: ABuFfogePJDtzE+uPcksSTTOxLWNRL2jB2ML20AIs/W2eGp+n02IBtTc
        jgL1mFidd2W8D9RfnJkpNBlRTeE3wSAH7GSbtQrTMA==
X-Google-Smtp-Source: ACcGV61tY/ReoEzLjdIjyYlbdAoZxYOC9tCd50wqx02FPy4AKWOIGOsGr4SvNvVvAp4CHWMAHbbqRpgYJcvEbO982dE=
X-Received: by 2002:a17:902:b7c2:: with SMTP id v2-v6mr8432002plz.238.1538687820458;
 Thu, 04 Oct 2018 14:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20181004183047.GA1885@flashbox> <1538678069.230807.6.camel@acm.org>
 <20181004184540.GA17513@flashbox>
In-Reply-To: <20181004184540.GA17513@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 4 Oct 2018 14:16:49 -0700
Message-ID: <CAKwvOd=FrGZ-oh5Q9RGQD2GNORZrqwAZUzNYN+hTKkp5wrfrqw@mail.gmail.com>
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

On Thu, Oct 4, 2018 at 11:45 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Oct 04, 2018 at 11:34:29AM -0700, Bart Van Assche wrote:
> > On Thu, 2018-10-04 at 11:30 -0700, Nathan Chancellor wrote:
> > > Hi SCSI folks,
> > >
> > > In an effort to get the kernel building warning free with Clang, we've
> > > come across an interesting occurrence in a few scsi drivers:
> > >
> > > drivers/scsi/hpsa.c:6533:7: warning: overflow converting case value to switch condition type (2148024833 to 18446744071562609153) [-Wswitch]
> > >         case CCISS_GETPCIINFO:
> > >              ^
> > > ./include/uapi/linux/cciss_ioctl.h:65:26: note: expanded from macro 'CCISS_GETPCIINFO'
> > > #define CCISS_GETPCIINFO _IOR(CCISS_IOC_MAGIC, 1, cciss_pci_info_struct)
> > >                          ^
> > > ./include/uapi/asm-generic/ioctl.h:86:28: note: expanded from macro '_IOR'
> > > #define _IOR(type,nr,size)      _IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
> > >                                 ^
> > > ./include/uapi/asm-generic/ioctl.h:70:2: note: expanded from macro '_IOC'
> > >         (((dir)  << _IOC_DIRSHIFT) | \
> > >         ^
> > >
> > > I see this warning in drivers/scsi/hpsa.c and drivers/scsi/smartpqi/smartpqi_init.c
> > > on an arm64 allyesconfig build and it has also been reported in a couple of files in
> > > drivers/scsi/cxlflash.
> > >
> > > As the warning states, there is an overflow because the switch statement's value is of
> > > type int but the switch value is greater than INT_MAX. I did a brief sweep of the tree
> > > and it seems that all uses of _IOC in switch statement values either are small enough
> > > to fit into size int or the value is of size unsigned int.
> > >
> > > I am unsure of the implications of using a smaller _IOC value or converting all ioctls
> > > to expect a cmd of type unsigned int (especially since that has userspace implications)
> > > but I didn't see any negative ioctl commands. Some clarity and insight would be
> > > appreciated.
> >
> > Have you verified how gcc compiles these switch statements? Maybe gcc supports
> > switch / case statements on integral types that are larger than an int?

GCC just doesn't warn when the case expression is greater than the
maximal representable value and thus would wrap (or appears to, this
is probably undefined behavior).  Using an unsigned int here is no
functional change:
https://godbolt.org/z/1IyYV4

GCC and Clang do effectively the same thing as each other, and in the
cases of switching on an unsigned int vs signed int.

> >
> > Bart.
>
> Hi Bart,
>
> That is entirely possible, I will do some research. I did build with GCC
> to see if there was any warning and there isn't so I'll be curious to
> see what is happening at a lower level.
>
> Thanks for the comment!
> Nathan



-- 
Thanks,
~Nick Desaulniers
