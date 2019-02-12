Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0A6C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9032080A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 13:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzyfoVGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfBLNuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 08:50:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36049 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfBLNuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 08:50:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id r124so1294543pgr.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 05:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hgulp4v1JuygJijQmY0syiHwA3rSjpoyiSS8vn/dFyo=;
        b=qzyfoVGPZDW+TzMUi9dsu/z8F3Phu6kjUB1Ey5dEJVIfYgWlpcTzEd1NHYjAXYRvSW
         CmlzYVqB5XSv71Q70onzLgtKqefCERaD1H/4l6qzeSPDUmqDMgdrPG/6e7L7BK7uhEsi
         UfU9sg7pzoNMlsvUiBZttnfxCA/vwzlV2E5gqDyDIYfOonahm1wLeRa/hFR3ehy+q6Xp
         B1+ii5Q93b+PMxzhNrOgVIFfnrbAuOxRWJUUUFLsLNRt6NnACEtEJX0IDuvlIhwhzf5O
         9nIHrHsTNslBK9AakFUZPNt0Rfci5s2JAgvxVx5XPVR5JkBMmzXnac2lXHKvA/Dq6bdC
         VXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgulp4v1JuygJijQmY0syiHwA3rSjpoyiSS8vn/dFyo=;
        b=LOeEytIa68NwZTa1hsasm0VmpeetMK15gfnUramk/vGSAk0qq6Tpqz4Hwmuya71buq
         kgIrfd96q81Mbp4YBBCjWUHKiyfWuJfjMlkWdAnv7t+QrM9UpuXoMHj2RJvYS2++CtkG
         abtq9icPbhz9Nl3vqftQ4PxgIkO0fIsCNQnPsNLSlTlcubtX4Fik6Q+mMRxHeu5WGTyI
         z4OAYRKpaT7iyqRB6MfLexCC3tyxb/RH+ZlBNMDB+2Tm/BMueByOuylpwnf5+skeUuhA
         N+e25NFUorwbHD1OjrZHjy0YuzKxlCIoPFIWcDE5v0yxPViZjlUUSiW+gbdMGnmjaQp6
         Rcxw==
X-Gm-Message-State: AHQUAuZmIR4O3lNj4l6rD75IUw067//0cZpuSQZGsZbJ2xLMXttyqWW3
        AJvJmQ/P51aW5tKlHJReXnsxDbupt8jARt57C9j7hWLa
X-Google-Smtp-Source: AHgI3IZ017Yf2nUmSPQxCSWPpfKUkEvFDE50Fny7AnAssBxXoe80M9YKYXbdHrKCxALdGXdXFLgdQa0NddPY5S4Rf+g=
X-Received: by 2002:a63:4a21:: with SMTP id x33mr3838490pga.428.1549979414014;
 Tue, 12 Feb 2019 05:50:14 -0800 (PST)
MIME-Version: 1.0
References: <20181022134048.19693-1-david.engraf@sysgo.com>
 <20181030151805.5519-1-david.engraf@sysgo.com> <CAHp75VdOSC8j_1G3z-UO01_JYN20M-YMGOC2JkFDhi8njNZAvA@mail.gmail.com>
 <20190208140810.76ef6c25825a5644d9625f0a@linux-foundation.org>
 <CAHp75VdWyGv2QyuwE+4-oFJt8St2UmeuaHhveeLAFPPPuN5=tg@mail.gmail.com>
 <744e7bcb-9315-0283-67c5-c2cb2d094251@sysgo.com> <28139206-7fed-e00e-8f52-47e68655963d@sysgo.com>
 <CAHp75VfPBD-9_ddGMNX2jVCynWLS61GLZVva7sM5aj2Sp==vzQ@mail.gmail.com>
 <84d387a3-0519-d50b-2c5d-98c10f694376@sysgo.com> <CAHp75VcNY3ZX9XF10mmOGgRq=-Soa+a0y=iFC0c+S=gzJ0+2RQ@mail.gmail.com>
 <b40bc54f-9fcc-91d4-0e25-231acf34d992@sysgo.com>
In-Reply-To: <b40bc54f-9fcc-91d4-0e25-231acf34d992@sysgo.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Feb 2019 15:50:03 +0200
Message-ID: <CAHp75Vf0_1=TLJ9px08yrzf3RjgfdFQYd06erkhOKhy07Gb=GQ@mail.gmail.com>
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

On Tue, Feb 12, 2019 at 2:12 PM David Engraf <david.engraf@sysgo.com> wrote:
> On 12.02.19 at 11:43, Andy Shevchenko wrote:
> > On Mon, Feb 11, 2019 at 2:40 PM David Engraf <david.engraf@sysgo.com> wrote:
> >> On 11.02.19 at 12:40, Andy Shevchenko wrote:

> >> Ok got it. When the memory behind the actual file size is clear (0x0)
> >> the decompression doesn't complain and just ignores the padding. Any
> >> other data will be interpreted as a new archive and thus you'll see the
> >> error message.
> >
> > Correct.
> >
> >> Is it possible for you to fill the padding after the actual file size
> >> with 0x00 ?
> >
> > Not sure. This is boot loader realm. Even if I patch U-Boot, not every
> > boot loader will guarantee this.
> > So, it's fragile to rely on data being 0x00 after actual archive.
>
> The problem is that the kernel expects another archive if there are data
> left. If these data do not contain a valid magic the kernel prints an
> error message which is correct.

Agree.

> I could make this error not critical and keep the rootfs, but it's still
> an error and unexpected.

I would rather call it a warning and continue.

Perhaps something like

static void warning(const char *msg)
{
  ...print warning...
  return without assigning return value.
}

> You're using a modified bootloader which
> reports a size larger than the file itself.

This is not true. The size supplied by whatever user input through it
command line or configuration.

> Other bootloader will use
> the file size and report the correct size to the kernel.

This follows and thus not true either. It depends on boot loader completely.

> So this
> workaround is required by your setup only.

So this is not true.

> @Andrew: What do you think about that? Shall I create a workaround for
> the special case?
--
With Best Regards,
Andy Shevchenko
