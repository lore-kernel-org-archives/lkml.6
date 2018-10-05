Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D240C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435F020834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 06:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxiquX2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435F020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeJENzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 09:55:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33402 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbeJENzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 09:55:17 -0400
Received: by mail-wr1-f67.google.com with SMTP id e4-v6so12383111wrs.0;
        Thu, 04 Oct 2018 23:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vou0YaiPvFZ0KNGq50x5tpwYuQHcKsOFHQtzOdjljFg=;
        b=ZxiquX2ydUkQb0TLnmOhQrwNRbo018AgalkOL15x9rpzE66Uax7rpXFo0sdjR2oRNl
         bG2jenNKyqejKIgF61dZe8Lz/wD3HHsEVYupiY6S6CRArumxGvB5YtkI3kUfPa8mmoBq
         JJl2haUCMKE80sB+qGbFbjgJpxBDhMHteidQMGG6UiVUDJcqIN+zkflRkq1xrxI7qa4K
         jzSZtgd1EoECS4RFn+kBSIi9IvtNwS8X/KOP6y5z0fRoSWRFi3hiiBQSHJ5WMKn9TktB
         N4X7pr7Gz8qxCv5deIjxze3jKUNmayXj1wu2hdyNPK0dj+Sn9iF+4QY2nkGgRj01PYDH
         TqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vou0YaiPvFZ0KNGq50x5tpwYuQHcKsOFHQtzOdjljFg=;
        b=rp9VYNTeMtfzvkK2iaV1mlO3VD5a5xrxKtotBMclfNEHYVCh71IYIDIZoMRbhk6X7C
         DUnZVWwi8nEio6m88Efv77itFX4FD/6FwD/6o2TeBpD/XQRh8sVJEEGDahiFArQ0Rj36
         kGWziOyJra5oIEaQEXepumcQKdoMLYNSG62Xa1icTC5FWtYz0+6TPMcxCiAhtR5n5x53
         EEsQCgW9NP2BVrEm9jtq+nSPy9kbTNnMffoJhFS0p4dmAxdeplw833+7m+T4QSihEjCh
         tFPATLVonoVhRQ5D5BLTzbCKWjzGjDhPV8UNX/0L2TyKeHiW+c+ZOsA8gj6izdfD0dIp
         uVXA==
X-Gm-Message-State: ABuFfohH/YpRgnryQOmdn6Thpx73G8tawysdpeiw5F33X2eWBXdYQghB
        JW34dt55MjpbGrlRRJMaQS0=
X-Google-Smtp-Source: ACcGV61QU8etLxnZz/8QBqeTeHCAn5EJ2LOtRiUjd6mYA5+GmEg9C57Uz4TXfr/J68EVuJnuxeUPXA==
X-Received: by 2002:adf:82e3:: with SMTP id 90-v6mr6851229wrc.131.1538722677144;
        Thu, 04 Oct 2018 23:57:57 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id o13sm4353764wrx.53.2018.10.04.23.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 23:57:56 -0700 (PDT)
Date:   Thu, 4 Oct 2018 23:57:54 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     bvanassche@acm.org,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: -Wswitch Clang warnings in drivers/scsi
Message-ID: <20181005065754.GA18637@flashbox>
References: <20181004183047.GA1885@flashbox>
 <1538678069.230807.6.camel@acm.org>
 <20181004184540.GA17513@flashbox>
 <CAKwvOd=FrGZ-oh5Q9RGQD2GNORZrqwAZUzNYN+hTKkp5wrfrqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=FrGZ-oh5Q9RGQD2GNORZrqwAZUzNYN+hTKkp5wrfrqw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 02:16:49PM -0700, Nick Desaulniers wrote:
> On Thu, Oct 4, 2018 at 11:45 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Thu, Oct 04, 2018 at 11:34:29AM -0700, Bart Van Assche wrote:
> > > On Thu, 2018-10-04 at 11:30 -0700, Nathan Chancellor wrote:
> > > > Hi SCSI folks,
> > > >
> > > > In an effort to get the kernel building warning free with Clang, we've
> > > > come across an interesting occurrence in a few scsi drivers:
> > > >
> > > > drivers/scsi/hpsa.c:6533:7: warning: overflow converting case value to switch condition type (2148024833 to 18446744071562609153) [-Wswitch]
> > > >         case CCISS_GETPCIINFO:
> > > >              ^
> > > > ./include/uapi/linux/cciss_ioctl.h:65:26: note: expanded from macro 'CCISS_GETPCIINFO'
> > > > #define CCISS_GETPCIINFO _IOR(CCISS_IOC_MAGIC, 1, cciss_pci_info_struct)
> > > >                          ^
> > > > ./include/uapi/asm-generic/ioctl.h:86:28: note: expanded from macro '_IOR'
> > > > #define _IOR(type,nr,size)      _IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
> > > >                                 ^
> > > > ./include/uapi/asm-generic/ioctl.h:70:2: note: expanded from macro '_IOC'
> > > >         (((dir)  << _IOC_DIRSHIFT) | \
> > > >         ^
> > > >
> > > > I see this warning in drivers/scsi/hpsa.c and drivers/scsi/smartpqi/smartpqi_init.c
> > > > on an arm64 allyesconfig build and it has also been reported in a couple of files in
> > > > drivers/scsi/cxlflash.
> > > >
> > > > As the warning states, there is an overflow because the switch statement's value is of
> > > > type int but the switch value is greater than INT_MAX. I did a brief sweep of the tree
> > > > and it seems that all uses of _IOC in switch statement values either are small enough
> > > > to fit into size int or the value is of size unsigned int.
> > > >
> > > > I am unsure of the implications of using a smaller _IOC value or converting all ioctls
> > > > to expect a cmd of type unsigned int (especially since that has userspace implications)
> > > > but I didn't see any negative ioctl commands. Some clarity and insight would be
> > > > appreciated.
> > >
> > > Have you verified how gcc compiles these switch statements? Maybe gcc supports
> > > switch / case statements on integral types that are larger than an int?
> 
> GCC just doesn't warn when the case expression is greater than the
> maximal representable value and thus would wrap (or appears to, this
> is probably undefined behavior).  Using an unsigned int here is no
> functional change:
> https://godbolt.org/z/1IyYV4
> 
> GCC and Clang do effectively the same thing as each other, and in the
> cases of switching on an unsigned int vs signed int.
> 

Regardless of how the overflow is handled within the switch statement,
the overflow is also happening when passing in these values to the ioctl,
right? I mean these case values are defined in the uapi files so that
userspace can easily pass them in to the ioctl, meaning those values are
being passed in as a signed integer and I would assume subsequently
overflowing unless I'm just missing something here.

Nathan

> > >
> > > Bart.
> >
> > Hi Bart,
> >
> > That is entirely possible, I will do some research. I did build with GCC
> > to see if there was any warning and there isn't so I'll be curious to
> > see what is happening at a lower level.
> >
> > Thanks for the comment!
> > Nathan
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
