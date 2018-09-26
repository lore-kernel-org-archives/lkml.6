Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF384C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDAC2154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mJUJoP00"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDAC2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbeI0Eg0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:36:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35443 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbeI0Eg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:36:26 -0400
Received: by mail-pf1-f193.google.com with SMTP id p12-v6so354068pfh.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 15:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UKekVuvL2s6pChED38ZlJHaMHUu0iJKM70VpXbeg/FQ=;
        b=mJUJoP00epFtu7hDlipIPGgCDoXnO1yngdqFDEoASfSr/fJUKy2GGkTg+KP9uESefq
         04e1jqUks3sotS3XQLfpWkjRbCQF7CHNfuiQA1tPLO3Rz/klBknxghU/mF/6YltWdNQL
         TwZzg5XIa7TNY9kxV1fALEm4XcQQfUkK0HNi8pRUk//exLYK7UIYc1L+b84XxFM0YSzX
         JXRn88qMbqbhXorATwqtB/N+n+W5rLL9duZxeksQtkxiN9NCTwPspaPCtljTWpNqTG23
         r4owIZD8U5IuDBul20oNxd0PUV4LszwGkehGEbvk+/bt61HP7vJQHVYj6/PHYBxu25P4
         Jegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UKekVuvL2s6pChED38ZlJHaMHUu0iJKM70VpXbeg/FQ=;
        b=VOyggvUG95RvSm6kMiCObUWl7hxHbML1k7aCpCpJp3HK0NqPXWiC16cWjVvNqWAxUh
         CBS3lgoXqLZT1xrR82cInTZH7pLz8aP9hH+Ao3AaF9ml6KKIcC/dpOunP6sY34PlODLC
         w2XveKCajP8O5MgkmbO8uo5rDeL2/H+vE4oqg/EePTE7/pCpyO+dPhtcrwVkk2YbEm98
         TMiPXrkzesKzCjuyKJeySDrFatSVHnW+HqPdMRJ1DEWTP7/9YIIoLuxwsk/fPDJ1Hwz8
         xZNKfHymvpnn436PoCi4Yq6Mg+O+ESrMOJQzbcjv+gU1dfS8871+Qa4fwNlYoPk6J0l7
         ar6g==
X-Gm-Message-State: ABuFfoi8uH20Bu3wpf17gz/o0Lhz1qBEjyodKbYGAkCOnAcDpChSFEmW
        /oFoVh2GZi72g0KksIy30yq+T//lUREMAm8ldYFJqA==
X-Google-Smtp-Source: ACcGV63PDj0jQF9g0CnCSSviurgxL5uYG6w6R5qUgAvTeIZ6gOIltp6MhbFqC/NbHQLyNrl310XOeXmQELZrCM72+ds=
X-Received: by 2002:a62:1895:: with SMTP id 143-v6mr8086900pfy.227.1538000478954;
 Wed, 26 Sep 2018 15:21:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180926070208.16924-1-natechancellor@gmail.com>
 <20180926071359.GA22855@kroah.com> <20180926074114.GA4966@flashbox>
 <CAKwvOdkkaCAmizfOr8Bj8QLTN161KqwXRCbuKbiNDoo5RonrpQ@mail.gmail.com>
 <CAKwvOd=HEpvswt_L0nEsimjbcPO9R=z6EJOOpcCfcFVC6P8sNw@mail.gmail.com> <20180926183918.GA14797@kroah.com>
In-Reply-To: <20180926183918.GA14797@kroah.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Sep 2018 15:21:07 -0700
Message-ID: <CAKwvOd=eXkYX6VEEy=UZmocC0SbMbUWUp7jaD3YHzCOVK=ObPw@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Mark ACPI table declaration as maybe unused
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        Pirama Arumuga Nainar <pirama@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 11:39 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 26, 2018 at 11:28:46AM -0700, Nick Desaulniers wrote:
> > On Wed, Sep 26, 2018 at 10:55 AM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Wed, Sep 26, 2018 at 12:41 AM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > On Wed, Sep 26, 2018 at 09:13:59AM +0200, Greg Kroah-Hartman wrote:
> > > > > On Wed, Sep 26, 2018 at 12:02:09AM -0700, Nathan Chancellor wrote:
> > > > > > Clang emits the following warning:
> > > > > >
> > > > > > drivers/staging/rtl8723bs/os_dep/sdio_intf.c:25:36: warning: variable
> > > > > > 'acpi_ids' is not needed and will not be emitted
> > > > > > [-Wunneeded-internal-declaration]
> > > > > > static const struct acpi_device_id acpi_ids[] = {
> > > > > >                                    ^
> > > > > > 1 warning generated.
> > > > > >
> > > > > > Mark the declaration as maybe unused like a few other instances of this
> > > > > > construct in the kernel.
> > > > > >
> > > > > > Link: https://github.com/ClangBuiltLinux/linux/issues/169
> > > > > > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > > > > > ---
> > > > > >  drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > > > > > index 6d02904de63f..3285bf36291b 100644
> > > > > > --- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > > > > > +++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
> > > > > > @@ -22,7 +22,7 @@ static const struct sdio_device_id sdio_ids[] =
> > > > > >     { SDIO_DEVICE(0x024c, 0xb723), },
> > > > > >     { /* end: all zeroes */                         },
> > > > > >  };
> > > > > > -static const struct acpi_device_id acpi_ids[] = {
> > > > > > +static const struct acpi_device_id acpi_ids[] __maybe_unused = {
> > > > >
> > > > > But it is used.  No "maybe" at all here.  The MODULE_DEVICE_TABLE()
> > > > > macro does a functional thing.  Why is gcc not reporting an issue with
> > > > > this and clang is?
> > >
> > > Looks like GCC and Clang handle __attribute__((alias)) differently
> > > when optimizations are enabled.  Clang has
> > > -Wunneeded-internal-declaration (GCC doesn't have that specific flag,
> > > which is why GCC doesn't report, but its behavior is also different),
> > > as part of -Wall, which warns that it thinks the static var is dead,
> > > then removes it from -O1 and up.
> > >
> > > https://godbolt.org/z/Dpxnbp
> > >
> > > I consider this a bug in Clang: https://bugs.llvm.org/show_bug.cgi?id=39088
> > >
> > > As Nathan notes in this comment in V1:
> > > https://lore.kernel.org/lkml/20180926064437.GA29417@flashbox/ having
> > > additional references to the static array is enough to keep it around.
> > > When there are no other references, then it should not be marked
> > > static, in order to still be emitted.
> > >
> > > We can work around this by removing `static` from struct definitions
> > > that no other references than being passed to the MODULE_DEVICE_TABLE
> > > macro.  GCC and Clang will then both emit references to both
> > > identifiers.
> >
> > Sorry, after thinking more about this and discussing more with a
> > coworker, I think Clang is doing the right thing, and that `static`
> > should be removed from declarations passed to MODULE_DEVICE_TABLE
> > without other references.  Clang's Dead Code Elimination (DCE) here
> > seems to be more aggressive, but it still looks correct to me.
> >
> > int foo [] = { 42, 0xDEAD }; // extern
> > extern typeof(foo) bar __attribute__((unused, alias("foo")));
> >
> > GCC and Clang at -O2 both produce references to foo and bar.
> >
> > Adding `static` to foo, then GCC produces both references, while Clang
> > moves the data to bar and removes foo.  This is safe because foo has
> > no other references, and bar is what file2alias.c cares about in this
> > case.
>
> But we want the variable to be static, and not part of any namespace
> outside of this file.  If we start changing them all, we will start
> running into namespace collisions.

That's a fair point.  `__attribute__((used))` (in the kernel, we use
the macro `__used`) will silence this warning in Clang for this
particular instance while being no functional change for GCC or Clang.

Nathan's v2 solution was very close!  Either attribute silences the
warning, but __used makes it clearer that we don't want the warning,
without inhibiting dead code elimination from pruning the unreferenced
internal symbol while moving its data to the external/globally
reference-able symbol.

Exploring more of what GCC is doing (feel free to skip this, as it's minutia):
GCC emits BOTH symbols foo and bar (from my above simplified case,
when foo is static), but only bar (the alias) is in the global
namespace (extern linkage).  I missed in the disassembly that only bar
had the `.globl` assembler directive and assumed labels were by
default globl (their not, I've discovered from testing. Today I
learned).

More concretely, looking at the symbols of the translation unit in
question (rather than my simplified toy):
$ nm -S drivers/staging/rtl8723bs/os_dep/sdio_intf.o | grep acpi
00000000000000e0 0000000000000040 r acpi_ids
00000000000000e0 0000000000000040 R __mod_acpi__acpi_ids_device_tabl

Shows that both symbols are created, `man nm` says about the
capitalization and r vs R:
"if uppercase, the symbol is global (external)."
           "R"
           "r" The symbol is in a read only data section.

The disassembler only shows the reference to
__mod_acpi__acpi_ids_device_tabl at file offset 0x15a0:
$ objdump -DF drivers/staging/rtl8723bs/os_dep/sdio_intf.o |less
00000000000000e0 <__mod_acpi__acpi_ids_device_table> (File Offset: 0x15a0):

And a dump of the binary shows the data from acpi_ids at that offset:
$ hexdump -C drivers/staging/rtl8723bs/os_dep/sdio_intf.o| less
000015a0  4f 42 44 41 38 37 32 33  00 00 00 00 00 00 00 00  |OBDA8723........|

                             ^ should look familiar based on the
declaration in question.

The same can be verified with Clang, which wont produce the internal
only symbol (that has zero references) acpi_ids, and will place
__mod_acpi__acpi_ids_device_tabl at file offset 0x1610 for that
translation unit.

>
> These go into a separate part of the linker table,
> shouldn't that be
> enough to ensure that the compiler keeps it around?  Or is that after
> the compiler processes things?
>
> Anything we can do to add to the MODULE_DEVICE_TABLE() macro instead?

-- 
Thanks,
~Nick Desaulniers
