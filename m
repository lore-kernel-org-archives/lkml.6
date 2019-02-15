Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA91C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D82222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 20:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVTghLHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390569AbfBOUNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 15:13:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43313 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBOUNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 15:13:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id f90so5457837plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 12:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVmXqXUagzoMwzSSvfCScBloUdLgpwgEtiapdMdvKRU=;
        b=SVTghLHniM7zRQI/Ixi0GcXvweyz+p68dpqPNkLT3LFD+AJl3B5ozptT9pOYuZH3pK
         h0sBOhCaAw8926/R7EvnKiNDxY964b+cCCtio43pyrK5bUuxufPvoKD9fVzclykw2fPJ
         Squ4m0Rct5NS0n76eNpLTJzmL2/+xVGRwyHkeZx2M/AEWm2+D9BO361JJyyeR791lPAN
         p/Jiwgyx1rXvXf3/Ra1Ouv7yj3EHWN7WiY/Ez8fjkkOXpTXcxp60dTepU+v4L82Tdoec
         q8CMQ1g/pK0jVdU+94gUNJN8EtcJQYQ8WUnMvwFDi88m0Gh/GNUnYk8F4+9QH0+wBljs
         A9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PVmXqXUagzoMwzSSvfCScBloUdLgpwgEtiapdMdvKRU=;
        b=rrh6WcEsc7sGU2dd/Xwy0NlCtMYiwb4VEX6gfwQxFhNO5qdWo3CJwBEn9v0ZpjpI17
         NDtm7NtXMj16TQwqoHSUmePcmJHlV4KPChh8HqiHBE9XbamOW2fBT9EiFmXwP7Fc8288
         cslngJqnVcVK33t/3/tpSaCkILriIiMoEBHtx3XAWmzxdJkOaTXw7SyKknmP2NhALaUx
         PhI4qU1ychQg7d2inzSpbaJLrp5iuPoCU45NLjMr/eFcblK+J7XNJUc6Yo+BB56EHvSO
         L9kwlRTan3eCPE6HfiNjg2BKtyDXX8oGHwwxX60if4AVuzvBJWQgEZO1EltuMM/xiBXU
         SSqQ==
X-Gm-Message-State: AHQUAuYzZF7v5LlkoudhMCKNoFLkj/4EQGr8usvPXRZWiwrjSQOroP91
        Dw7YTFInMisFBE/Aah7/KV/zNM2whUTyb7uzguo=
X-Google-Smtp-Source: AHgI3IYYl4OYCuu+dF4jlFvv6M0478TsIidYJaPBrmlnTax+u1sbFGEri189E/A8m6VZsj1FqUsjbo10cgkBDTGID3Q=
X-Received: by 2002:a17:902:1a2:: with SMTP id b31mr12113454plb.87.1550261596640;
 Fri, 15 Feb 2019 12:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20181022134048.19693-1-david.engraf@sysgo.com>
 <20181030151805.5519-1-david.engraf@sysgo.com> <CAHp75VdOSC8j_1G3z-UO01_JYN20M-YMGOC2JkFDhi8njNZAvA@mail.gmail.com>
 <20190208140810.76ef6c25825a5644d9625f0a@linux-foundation.org>
 <CAHp75VdWyGv2QyuwE+4-oFJt8St2UmeuaHhveeLAFPPPuN5=tg@mail.gmail.com>
 <744e7bcb-9315-0283-67c5-c2cb2d094251@sysgo.com> <28139206-7fed-e00e-8f52-47e68655963d@sysgo.com>
 <CAHp75VfPBD-9_ddGMNX2jVCynWLS61GLZVva7sM5aj2Sp==vzQ@mail.gmail.com>
 <84d387a3-0519-d50b-2c5d-98c10f694376@sysgo.com> <CAHp75VcNY3ZX9XF10mmOGgRq=-Soa+a0y=iFC0c+S=gzJ0+2RQ@mail.gmail.com>
 <b40bc54f-9fcc-91d4-0e25-231acf34d992@sysgo.com> <CAHp75Vf0_1=TLJ9px08yrzf3RjgfdFQYd06erkhOKhy07Gb=GQ@mail.gmail.com>
In-Reply-To: <CAHp75Vf0_1=TLJ9px08yrzf3RjgfdFQYd06erkhOKhy07Gb=GQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Feb 2019 22:13:05 +0200
Message-ID: <CAHp75VcAqi-P6LF34XhYrwXH+Ejt_ZCYPMUG8VsTMD8q6w-AdA@mail.gmail.com>
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

On Tue, Feb 12, 2019 at 3:50 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Feb 12, 2019 at 2:12 PM David Engraf <david.engraf@sysgo.com> wrote:
> > On 12.02.19 at 11:43, Andy Shevchenko wrote:
> > > On Mon, Feb 11, 2019 at 2:40 PM David Engraf <david.engraf@sysgo.com> wrote:
> > >> On 11.02.19 at 12:40, Andy Shevchenko wrote:
>
> > >> Ok got it. When the memory behind the actual file size is clear (0x0)
> > >> the decompression doesn't complain and just ignores the padding. Any
> > >> other data will be interpreted as a new archive and thus you'll see the
> > >> error message.
> > >
> > > Correct.
> > >
> > >> Is it possible for you to fill the padding after the actual file size
> > >> with 0x00 ?
> > >
> > > Not sure. This is boot loader realm. Even if I patch U-Boot, not every
> > > boot loader will guarantee this.
> > > So, it's fragile to rely on data being 0x00 after actual archive.
> >
> > The problem is that the kernel expects another archive if there are data
> > left. If these data do not contain a valid magic the kernel prints an
> > error message which is correct.
>
> Agree.

JFYI: I had tested your another patch and it prints me the following

[   20.672873] Initramfs unpacking failed: invalid magic at start of
compressed archive

Nevertheless, I can use the system (since revert of this patch).

> > I could make this error not critical and keep the rootfs, but it's still
> > an error and unexpected.
>
> I would rather call it a warning and continue.
>
> Perhaps something like
>
> static void warning(const char *msg)
> {
>   ...print warning...
>   return without assigning return value.
> }


-- 
With Best Regards,
Andy Shevchenko
