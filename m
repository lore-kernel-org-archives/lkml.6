Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD801C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697BB2152F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YFrzy+j1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697BB2152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeI0AnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:43:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43037 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeI0AnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:43:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so13869516pfi.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hWu9mVY9V3jJ7QKbmZMGD1mEpNowSEacKM/NpaVX9n4=;
        b=YFrzy+j1z+dr+JndJ4bBNz5W1XJq2l3moobuxzPZjU5x0rnO6KnwAgL/ishlgV1jc8
         nN5+/Xbj66CRcHdLIozIQT3VKkDPbGokrgoT+52Jp3Ko03ifTmi/8n79HqcIIsmKISUg
         g0BKIPLJbEguEkuhoYMq7FPywxA4a+GEQi+WAr3SBu0EnfuAZa/s+WqlwPAToImOEUwU
         pLsg2IBfN3R27RP2vTkkTcc+4p4zITHO7cs+9PgzDhoyjt14unx+9Ph8xA/ctUcnMKcg
         Ww0i9E2cBNGKaCLuPLK3ScQVhlLdjdl7IvUjDaAROAtI9n8GMrcvRjkrhg42PjVELVCD
         JLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWu9mVY9V3jJ7QKbmZMGD1mEpNowSEacKM/NpaVX9n4=;
        b=ttlfcwmBZ61H4sw4ITc14XBmBBEHjBGv1Jvly+3Rp70lGsSQZkzi1L20WoxkuHcnkH
         PkbvxtcaGlnRi0BX3CwUM9AUqsmj+X1gcmG0lzMefcXxVbCu2rne/LceV0lECDmXBEdT
         rpWnpnvuF9bJOcCxe2hN7sY9rjfnYQa7Oa2ysZGDHcaxk1hs0yPkAAqIIV1y0chPyn3e
         OACda2bGEi7fsh1gJo1ft86Qyhv0od0yfLYtf1KjMZsF14AJlSl3DyqyIg5fDlhlN38f
         N6jQ0CjK9NJJJ0lNrKabZOpkER7lznKR7rmo2zIy+UXajOo5gtX7MOuykDmUk+fDvPX1
         D4yw==
X-Gm-Message-State: ABuFfojcfo/rAkI/Az/Go8skxCoEA2vFNkbJyEr/VWYlLyhC1suHN2ol
        T+qVmWABPnVW+K1iVUibGKLgORSGrNGAdhQRGN0BWg==
X-Google-Smtp-Source: ACcGV635s5Tpu1pcsRYz4SHhskHx3S0q336mvnq/Y+4vMdEbsXtJTDECF9R4Bn180kvluD1VVoHOGAQD1qI9DhWNyh0=
X-Received: by 2002:a63:a047:: with SMTP id u7-v6mr6889127pgn.145.1537986537974;
 Wed, 26 Sep 2018 11:28:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180926070208.16924-1-natechancellor@gmail.com>
 <20180926071359.GA22855@kroah.com> <20180926074114.GA4966@flashbox> <CAKwvOdkkaCAmizfOr8Bj8QLTN161KqwXRCbuKbiNDoo5RonrpQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkkaCAmizfOr8Bj8QLTN161KqwXRCbuKbiNDoo5RonrpQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Sep 2018 11:28:46 -0700
Message-ID: <CAKwvOd=HEpvswt_L0nEsimjbcPO9R=z6EJOOpcCfcFVC6P8sNw@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Mark ACPI table declaration as maybe unused
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        Pirama Arumuga Nainar <pirama@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 10:55 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Wed, Sep 26, 2018 at 12:41 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Wed, Sep 26, 2018 at 09:13:59AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Sep 26, 2018 at 12:02:09AM -0700, Nathan Chancellor wrote:
> > > > Clang emits the following warning:
> > > >
> > > > drivers/staging/rtl8723bs/os_dep/sdio_intf.c:25:36: warning: variable
> > > > 'acpi_ids' is not needed and will not be emitted
> > > > [-Wunneeded-internal-declaration]
> > > > static const struct acpi_device_id acpi_ids[] = {
> > > >                                    ^
> > > > 1 warning generated.
> > > >
> > > > Mark the declaration as maybe unused like a few other instances of this
> > > > construct in the kernel.
> > > >
> > > > Link: https://github.com/ClangBuiltLinux/linux/issues/169
> > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > ---
> > > >  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > > > index 6d02904de63f..3285bf36291b 100644
> > > > --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > > > +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > > > @@ -22,7 +22,7 @@ static const struct sdio_device_id sdio_ids[] =
> > > >     { SDIO_DEVICE(0x024c, 0xb723), },
> > > >     { /* end: all zeroes */                         },
> > > >  };
> > > > -static const struct acpi_device_id acpi_ids[] = {
> > > > +static const struct acpi_device_id acpi_ids[] __maybe_unused = {
> > >
> > > But it is used.  No "maybe" at all here.  The MODULE_DEVICE_TABLE()
> > > macro does a functional thing.  Why is gcc not reporting an issue with
> > > this and clang is?
>
> Looks like GCC and Clang handle __attribute__((alias)) differently
> when optimizations are enabled.  Clang has
> -Wunneeded-internal-declaration (GCC doesn't have that specific flag,
> which is why GCC doesn't report, but its behavior is also different),
> as part of -Wall, which warns that it thinks the static var is dead,
> then removes it from -O1 and up.
>
> https://godbolt.org/z/Dpxnbp
>
> I consider this a bug in Clang: https://bugs.llvm.org/show_bug.cgi?id=39088
>
> As Nathan notes in this comment in V1:
> https://lore.kernel.org/lkml/20180926064437.GA29417@flashbox/ having
> additional references to the static array is enough to keep it around.
> When there are no other references, then it should not be marked
> static, in order to still be emitted.
>
> We can work around this by removing `static` from struct definitions
> that no other references than being passed to the MODULE_DEVICE_TABLE
> macro.  GCC and Clang will then both emit references to both
> identifiers.

Sorry, after thinking more about this and discussing more with a
coworker, I think Clang is doing the right thing, and that `static`
should be removed from declarations passed to MODULE_DEVICE_TABLE
without other references.  Clang's Dead Code Elimination (DCE) here
seems to be more aggressive, but it still looks correct to me.

int foo [] = { 42, 0xDEAD }; // extern
extern typeof(foo) bar __attribute__((unused, alias("foo")));

GCC and Clang at -O2 both produce references to foo and bar.

Adding `static` to foo, then GCC produces both references, while Clang
moves the data to bar and removes foo.  This is safe because foo has
no other references, and bar is what file2alias.c cares about in this
case.

-- 
Thanks,
~Nick Desaulniers
