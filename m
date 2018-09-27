Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A843FC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAB5216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KEpWZuwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAB5216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeI1C2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:28:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39078 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbeI1C2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:28:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85-v6so2729632pge.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 13:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9zFjnZrkb/q0XfH/RiWLt0RCHrXb5GGGNjulli5tuI=;
        b=KEpWZuwpqws2ds8JE5PD1a0JWYZFBYDDLgCRh0xw/dul9aIr2ELH4rW5T5q2+QTSmu
         wUSW90OFUnJMNT6wO7Jfnj83J4L0efrMZP1EeDqpgHVs7uszngz4WucGtZGWRTze5U4A
         7gVcHYZOoIWG74bs4H6KyYE1Ce872tnuOlafNb26N+dwR1mIc6QNNP8PWBxDZI8+ZPj6
         FKQaLIBy2nhU3u5dDM5w62NuSl2FTjEphu2B73rM3eFr/O4ojc0ACN39wI/VP122oXLo
         aC9NZhBQyQdlrCpqRZUjn26UPNNE86wragblTyKRI8QrtH7BGQ9XWUv1OIiv0ZMKeI8t
         em6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9zFjnZrkb/q0XfH/RiWLt0RCHrXb5GGGNjulli5tuI=;
        b=b/cg5HivIny4hk0B9F1qu+Qj4cCQJKTkf48Z7UT/SuPTzva4XTFUlET7G8um9KUL8v
         X7EmEdxNq5tt/1S+oNvWZrr2uld+rFlY2GrZx444tPK2QkClyAjjgE7RYCW59mrGO7cY
         N/5T2s69BNFTjv19BzoLb941i56czMtsGzTq7QjU6vg5mhaNfz4eV7ISkzkmivTHNg5v
         1k8WrqAtpIfGgOUXol3c7kGye7BeCJ1lgWIxXUMP8YLxDlzF7gf8r24kSWLE5GAv5I1j
         xCJSED7ZAddyTO6S0Hw/NdiwmhaE8pPuXDuBCs4hNNHH14POmMeDf7nViNmZAJU8NRjn
         t3SA==
X-Gm-Message-State: ABuFfoilwTOQCVxJAqIqAFAOXy1t5co4CT9PsZ+GFHwEB+1lqG6Mnp+U
        Mfcrtua1T7OnhtSLokswsHhvIRMELFgxextRp0tvYJ8a
X-Google-Smtp-Source: ACcGV61s+/PmeKKjGtC8UyeXaHXkWuF4vBtVxFS0g4rgPL9j3zfwaR5dgOaf+yxo1jpEGP3is7cLN0P+cph8okVi/Wg=
X-Received: by 2002:a62:4b14:: with SMTP id y20-v6mr13116520pfa.93.1538078924379;
 Thu, 27 Sep 2018 13:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180926232055.31951-1-natechancellor@gmail.com>
 <20180927051634.GA32508@kroah.com> <CAKwvOdm3Au2V159PtripyZReZf167TtL5o7P9uYY-okr+n4xPw@mail.gmail.com>
In-Reply-To: <CAKwvOdm3Au2V159PtripyZReZf167TtL5o7P9uYY-okr+n4xPw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 27 Sep 2018 13:08:33 -0700
Message-ID: <CAKwvOd=NkgAWVGCS4Mb=Mgs5iu-uX1Kp=fjYSHhXAnh4gAQ-8w@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Mark ACPI table declaration as used
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 1:05 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Sep 26, 2018 at 10:16 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Sep 26, 2018 at 04:20:55PM -0700, Nathan Chancellor wrote:
> > > Clang emits the following warning:
> > >
> > > drivers/staging/rtl8723bs/os_dep/sdio_intf.c:25:36: warning: variable
> > > 'acpi_ids' is not needed and will not be emitted
> > > [-Wunneeded-internal-declaration]
> > > static const struct acpi_device_id acpi_ids[] = {
> > >                                    ^
> > > 1 warning generated.
> > >
> > > Mark acpi_ids with the attribute __used, which makes it clear to Clang
> > > that we don't want this warning while not inhibiting Clang's dead code
> > > elimination from removing the unreferenced internal symbol when moving
> > > the data to the globally available symbol with MODULE_DEVICE_TABLE.
> > >
> > > $ nm -S drivers/staging/rtl8723bs/os_dep/sdio_intf.o | grep acpi
> > > 0000000000000000 0000000000000040 R __mod_acpi__acpi_ids_device_table
> > >
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/169
> > > Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > ---
> > >  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > > index 6d02904de63f..7c03b69b8ed3 100644
> > > --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > > +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > > @@ -22,7 +22,7 @@ static const struct sdio_device_id sdio_ids[] =
> > >       { SDIO_DEVICE(0x024c, 0xb723), },
> > >       { /* end: all zeroes */                         },
> > >  };
> > > -static const struct acpi_device_id acpi_ids[] = {
> > > +static const struct acpi_device_id acpi_ids[] __used = {
> >
> > Can't we put __used somewhere in the MODULE_DEVICE_TABLE() macro so we
> > don't have to go adding it to all individual entries?
>
> Maybe; I'm still trying to think of what we could do in that macro to
> make its arg appear to be used while still being no functional change.

Sorry, I meant to say:
No, the __used needs to go on the declaration of the struct array, not
the alias being created within MODULE_DEVICE_TABLE().  I'm still
trying to think of what we can do *in* MODULE_DEVICE_TABLE() to
prevent this problem tree-wide, without having to modify any call
sites.

>
> This is not a million-little-commits problem; more like 2 drivers in
> the whole tree have this problem.
>
> Note that this change that Nathan has DOES NOT need to applied to
> every driver that uses MODULE_DEVICE_TABLE.  Only when the struct has
> no other references other than JUST being passed to
> MODULE_DEVICE_TABLE() is this a problem.  For an allyesconfig, I only
> see 2 instances of this case in the whole tree:
>
> https://github.com/ClangBuiltLinux/linux/issues/169 <- this patch is addressing
> https://github.com/ClangBuiltLinux/linux/issues/178 <- waiting on the
> results of this patch
>
> If you're ok with this change to two drivers, then:
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
