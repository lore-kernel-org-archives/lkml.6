Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744A7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362E421546
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 362E421546
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728429AbeI0Axj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:53:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46872 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725733AbeI0Axi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:53:38 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B38F01048;
        Wed, 26 Sep 2018 18:39:21 +0000 (UTC)
Date:   Wed, 26 Sep 2018 20:39:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        Pirama Arumuga Nainar <pirama@google.com>
Subject: Re: [PATCH] staging: rtl8723bs: Mark ACPI table declaration as maybe
 unused
Message-ID: <20180926183918.GA14797@kroah.com>
References: <20180926070208.16924-1-natechancellor@gmail.com>
 <20180926071359.GA22855@kroah.com>
 <20180926074114.GA4966@flashbox>
 <CAKwvOdkkaCAmizfOr8Bj8QLTN161KqwXRCbuKbiNDoo5RonrpQ@mail.gmail.com>
 <CAKwvOd=HEpvswt_L0nEsimjbcPO9R=z6EJOOpcCfcFVC6P8sNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=HEpvswt_L0nEsimjbcPO9R=z6EJOOpcCfcFVC6P8sNw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 11:28:46AM -0700, Nick Desaulniers wrote:
> On Wed, Sep 26, 2018 at 10:55 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Wed, Sep 26, 2018 at 12:41 AM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > On Wed, Sep 26, 2018 at 09:13:59AM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Sep 26, 2018 at 12:02:09AM -0700, Nathan Chancellor wrote:
> > > > > Clang emits the following warning:
> > > > >
> > > > > drivers/staging/rtl8723bs/os_dep/sdio_intf.c:25:36: warning: variable
> > > > > 'acpi_ids' is not needed and will not be emitted
> > > > > [-Wunneeded-internal-declaration]
> > > > > static const struct acpi_device_id acpi_ids[] = {
> > > > >                                    ^
> > > > > 1 warning generated.
> > > > >
> > > > > Mark the declaration as maybe unused like a few other instances of this
> > > > > construct in the kernel.
> > > > >
> > > > > Link: https://github.com/ClangBuiltLinux/linux/issues/169
> > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > > ---
> > > > >  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > > > > index 6d02904de63f..3285bf36291b 100644
> > > > > --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > > > > +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > > > > @@ -22,7 +22,7 @@ static const struct sdio_device_id sdio_ids[] =
> > > > >     { SDIO_DEVICE(0x024c, 0xb723), },
> > > > >     { /* end: all zeroes */                         },
> > > > >  };
> > > > > -static const struct acpi_device_id acpi_ids[] = {
> > > > > +static const struct acpi_device_id acpi_ids[] __maybe_unused = {
> > > >
> > > > But it is used.  No "maybe" at all here.  The MODULE_DEVICE_TABLE()
> > > > macro does a functional thing.  Why is gcc not reporting an issue with
> > > > this and clang is?
> >
> > Looks like GCC and Clang handle __attribute__((alias)) differently
> > when optimizations are enabled.  Clang has
> > -Wunneeded-internal-declaration (GCC doesn't have that specific flag,
> > which is why GCC doesn't report, but its behavior is also different),
> > as part of -Wall, which warns that it thinks the static var is dead,
> > then removes it from -O1 and up.
> >
> > https://godbolt.org/z/Dpxnbp
> >
> > I consider this a bug in Clang: https://bugs.llvm.org/show_bug.cgi?id=39088
> >
> > As Nathan notes in this comment in V1:
> > https://lore.kernel.org/lkml/20180926064437.GA29417@flashbox/ having
> > additional references to the static array is enough to keep it around.
> > When there are no other references, then it should not be marked
> > static, in order to still be emitted.
> >
> > We can work around this by removing `static` from struct definitions
> > that no other references than being passed to the MODULE_DEVICE_TABLE
> > macro.  GCC and Clang will then both emit references to both
> > identifiers.
> 
> Sorry, after thinking more about this and discussing more with a
> coworker, I think Clang is doing the right thing, and that `static`
> should be removed from declarations passed to MODULE_DEVICE_TABLE
> without other references.  Clang's Dead Code Elimination (DCE) here
> seems to be more aggressive, but it still looks correct to me.
> 
> int foo [] = { 42, 0xDEAD }; // extern
> extern typeof(foo) bar __attribute__((unused, alias("foo")));
> 
> GCC and Clang at -O2 both produce references to foo and bar.
> 
> Adding `static` to foo, then GCC produces both references, while Clang
> moves the data to bar and removes foo.  This is safe because foo has
> no other references, and bar is what file2alias.c cares about in this
> case.

But we want the variable to be static, and not part of any namespace
outside of this file.  If we start changing them all, we will start
running into namespace collisions.

These go into a separate part of the linker table, shouldn't that be
enough to ensure that the compiler keeps it around?  Or is that after
the compiler processes things?

Anything we can do to add to the MODULE_DEVICE_TABLE() macro instead?

thanks,

greg k-h
