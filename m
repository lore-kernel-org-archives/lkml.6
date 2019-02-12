Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFB5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CAD620818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 10:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVh/iEVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfBLKn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 05:43:29 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33545 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfBLKn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 05:43:29 -0500
Received: by mail-pl1-f193.google.com with SMTP id y10so1129147plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 02:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d8P5exSs3twRu8zJ2gtuZfvW2NKZTCWFQj3xG9H1nIU=;
        b=UVh/iEVPwNezCaXex4J5FZNwyI6kKR3cyRbivC5V5yUzSTdLaTzQN7uiqvfjBoOJ4P
         bf1ZET5GbfjdADM+YQNaHIcTDhJirWlEzcW65t51d2QeTlx3fEl2sP2h5IBwZpzIgmp2
         6/nBGoh61HssAOOikewx9TUaUmaoyFpP4tGrWZJkSdnE0pVqOhRM7+NWdvWgtx/2QpDW
         SohtYbrMfsx/OLw+hRoiNurMsRdrpv1diznijsU7R3FnPNrecWaJMqrDWXbMQEf2mUqV
         9p/dQAyQfh+SUYo7+aiCZiLzsTMqN0uix1P7stosVhTVW488eQ4V2hwFsC25Ge5boFnZ
         +MRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d8P5exSs3twRu8zJ2gtuZfvW2NKZTCWFQj3xG9H1nIU=;
        b=sD7pdF51YvblaCjapOMBM0etZWpb5UMDUZBf8YhsUbYf2rgVnhPlooZWl3qtPkEhKH
         wGicdmZz/YkEASJn9kMFlM2kgQ3OLs49zqngiRSt0DogmCnHC3KfAq0y2oH+MaKyOEhZ
         j7XhBEm/EsnTbsfuYzs55CWZEdr9/7K0aK7pyinXTFzO1p89leVrgOMszeRT3TUKEej3
         w5nhF36NC0KzzPcHt4rB5LgsHh0BiSX6WIxV00bofhmBiDgpgQaK2uyUndZEUUhG1Qfk
         ARhrvGxjyxABhi8EzjUVVzULrMFaMXUp9Sq//m/WbXratwZWt7iHLX6JLJaoHRA+mm3U
         ztoA==
X-Gm-Message-State: AHQUAub9WcCFJshV77cXL+nxfRIZ/csDMQtU6V7nrk8XvNErim+r6CrF
        CUUV4xLwNk6lUvPIlh4a3Xb3+9Cb8bXfqYVF+Q/4Cvv6
X-Google-Smtp-Source: AHgI3Ib73jcFdXQ4+VCOnbFk9UHIcuYvTUO/cEiyS6+/fZ3UPcJ+mHUxpnN6saVt9H4w3p2ma/ztmblV9FcIInqgOv4=
X-Received: by 2002:a17:902:bc88:: with SMTP id bb8mr3416368plb.12.1549968208706;
 Tue, 12 Feb 2019 02:43:28 -0800 (PST)
MIME-Version: 1.0
References: <20181022134048.19693-1-david.engraf@sysgo.com>
 <20181030151805.5519-1-david.engraf@sysgo.com> <CAHp75VdOSC8j_1G3z-UO01_JYN20M-YMGOC2JkFDhi8njNZAvA@mail.gmail.com>
 <20190208140810.76ef6c25825a5644d9625f0a@linux-foundation.org>
 <CAHp75VdWyGv2QyuwE+4-oFJt8St2UmeuaHhveeLAFPPPuN5=tg@mail.gmail.com>
 <744e7bcb-9315-0283-67c5-c2cb2d094251@sysgo.com> <28139206-7fed-e00e-8f52-47e68655963d@sysgo.com>
 <CAHp75VfPBD-9_ddGMNX2jVCynWLS61GLZVva7sM5aj2Sp==vzQ@mail.gmail.com> <84d387a3-0519-d50b-2c5d-98c10f694376@sysgo.com>
In-Reply-To: <84d387a3-0519-d50b-2c5d-98c10f694376@sysgo.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Feb 2019 12:43:17 +0200
Message-ID: <CAHp75VcNY3ZX9XF10mmOGgRq=-Soa+a0y=iFC0c+S=gzJ0+2RQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] initramfs: cleanup incomplete rootfs
To:     David Engraf <david.engraf@sysgo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 2:40 PM David Engraf <david.engraf@sysgo.com> wrote:
> On 11.02.19 at 12:40, Andy Shevchenko wrote:
> > On Mon, Feb 11, 2019 at 10:49 AM David Engraf <david.engraf@sysgo.com> wrote:
> >> On 11.02.19 at 08:56, David Engraf wrote:
> >>> On 09.02.19 at 11:35, Andy Shevchenko wrote:
> >>>> On Sat, Feb 9, 2019 at 12:08 AM Andrew Morton
> >>>> <akpm@linux-foundation.org> wrote:
> >>>>> On Fri, 8 Feb 2019 21:45:21 +0200 Andy Shevchenko
> >>>>> <andy.shevchenko@gmail.com> wrote:
> >>>>>> On Tue, Oct 30, 2018 at 5:22 PM David Engraf
> >>>>>> <david.engraf@sysgo.com> wrote:

> >>>> In my case I have got "Junk in compressed archive". I don't know (I
> >>>> would check if needed) which exact condition I got  since there are
> >>>> three places with this message. The file itself smaller than the size
> >>>> passed through bootparam. So, when decomression is finished
> >>>> (successfully!) we still have a garbarge in the memory which is not
> >>>> related to archive. Message per se is okay to have, though I consider
> >>>> this non-fatal.
> >>>
> >>> I can reproduce this special case. The unpacking decompresses the whole
> >>> size instead of checking the archive size. I will have a look how to get
> >>> the real archive size.
> >>
> >> I did some checks and manually increased the initramfs size but I always
> >> get the following kernel panic:
> >
> > We need to be on the same page here.
> > There are two sizes of initramfs compressed archive:
> >   1) actual file size;
> >   2) what is declared by boot loader and provided via boot parameters.
> >
> > In my case I have the 2) bigger than the actual file size.
> > Kernel decompresses the initramfs, prints an error that there is junk,
> > which is understandable and continues to run init, etc.
>
> Ok got it. When the memory behind the actual file size is clear (0x0)
> the decompression doesn't complain and just ignores the padding. Any
> other data will be interpreted as a new archive and thus you'll see the
> error message.

Correct.

> Is it possible for you to fill the padding after the actual file size
> with 0x00 ?

Not sure. This is boot loader realm. Even if I patch U-Boot, not every
boot loader will guarantee this.
So, it's fragile to rely on data being 0x00 after actual archive.

-- 
With Best Regards,
Andy Shevchenko
