Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79211C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458F5222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 08:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QaAkq8dV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391291AbfBOIZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 03:25:51 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51136 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389067AbfBOIZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 03:25:51 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so22317396iti.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 00:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=juG0MViCZiAT+zDsXZ8fm+sEnVYZs4zVtkSGvneF++Y=;
        b=QaAkq8dV0igXFlPYuqnLjGUX/mZjdfP+Xscr5xuHA8biE2RPGNjZXDDQrqjA0E7V3s
         8Tcl3x3Vqe4fDAIr3KKF/AsUMesa+/TN2RK3ap46JMZprjhi2S7oEzceR1F+bEFOqGZk
         Tdolm+TompptSuMMpd4lTpGLSfXHxW9gMr+Q9QpAoU66GXK/uGE3sMzLO0pX4y7mmkxE
         BB6ZoM6ZTUyR/aHFAmAZKLvAWwZVcWj+wah4xbjzkVH6RplWTd0GFMm19gTM7SjwTa6J
         buoD9Y5lhcvnsJxztRm4RjkGhD3MaJusYWdx2EeCRbZ/hb1SN+eXktVj+cCS1gKc5awG
         57ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=juG0MViCZiAT+zDsXZ8fm+sEnVYZs4zVtkSGvneF++Y=;
        b=cMnylY9bcYyATj5Z3UyKhUxxn3jer8aNPEIg0Neo7oAFNFH8y/K57MqcPYTwvZ6wlp
         XBnzQexoiejGFLhnUvalUJ66vWk2zVqXzSMw2FAxXPGL9TNEMNnmWoIyLKpNO+UxGa34
         Z8qnp0kLDwgxHVfd8/V8qkVmn0cjjhZriXA3hENee5NUUwNbTdVHMEoW7YrKajOaaVhh
         SBoe1j+7/0/lHL7Cb+db3C9eqUGJ2ljyo4VvMMiBByGHE09PKrdhEubodEtrLOiBrBdp
         /GpDZMMVS7yEobKM1YxtstXnJZk31OB1YLp/xVox/aLAE7zhzUW4qsewsjYAjBBkEMTE
         Rc8g==
X-Gm-Message-State: AHQUAub24wdi6pLV68XfB4jWBmZpc0bCXRo9dM8VIO35Oco9vaUYNSjz
        rW0ogHMA5bUkwvPw6RZ1v0oA3LZfhvp5XHIDazmNug==
X-Google-Smtp-Source: AHgI3IYrJaPN4UsWQoBsCdmaP9C1toLRwpm5eM4gHXrPouGeJ60/nnjKE5Fmn7F+2JrrOUUgs3vY228KqysO1q0yRlI=
X-Received: by 2002:a24:1947:: with SMTP id b68mr17514itb.121.1550219149888;
 Fri, 15 Feb 2019 00:25:49 -0800 (PST)
MIME-Version: 1.0
References: <1549943095-10956-1-git-send-email-yamada.masahiro@socionext.com>
 <CAKv+Gu8yLY+c6jNmHYkvP3n=xiojF7dcKBHmeGibUW2FUrEczA@mail.gmail.com> <CAK7LNASoyeFW=j9R=M2vaoLK_Gms1Z6hA_yKLyVSY=g5ALUi8A@mail.gmail.com>
In-Reply-To: <CAK7LNASoyeFW=j9R=M2vaoLK_Gms1Z6hA_yKLyVSY=g5ALUi8A@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 15 Feb 2019 09:25:38 +0100
Message-ID: <CAKv+Gu8k63Fj2aPbQPLLvBXvJrdcu5NrODXuZKkb2n21AUM70Q@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub: refactor cmd_stubcopy
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alistair Strachan <astrachan@google.com>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 at 06:49, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Tue, Feb 12, 2019 at 4:26 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> >
> > On Tue, 12 Feb 2019 at 04:45, Masahiro Yamada
> > <yamada.masahiro@socionext.com> wrote:
> > >
> > > It took me a while to understand what is going on in the nested
> > > if-blocks.
> > >
> > > Simplify it by removing unneeded code.
> > >
> > >   - if_changed automatically adds 'set -e', so any failure in the
> > >     series of commands makes it immediately fail as a whole.
> > >     So, the outer if block is entirely redundant.
> > >
> > >   - Since commit 9c2af1c7377a ("kbuild: add .DELETE_ON_ERROR special
> > >     target"), GNU Make automatically deletes the target on any failure
> > >     in its recipe. The explicit 'rm -f $@' is redundant.
> > >
> > >   - surrounding commands with ( ) will spawn a subshell to execute them
> > >     in it, but it is rarely useful to do so.
> > >
> > > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> > Assuming that it still works as expected:
> >
> > Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >
> > You can test this by adding a statically initialized global function
> > pointer to any of the libstub source files that get built for ARM.
> >
> > Thanks!
>
>
> I tried that, and it failed as expected.
>

Great, thanks for double checking.

Are you taking this directly, or do you want me to take it via the EFI
tree? Either is fine with me


>
> $ git diff
> diff --git a/drivers/firmware/efi/libstub/arm32-stub.c
> b/drivers/firmware/efi/libstub/arm32-stub.c
> index becbda4..5ad7bbd 100644
> --- a/drivers/firmware/efi/libstub/arm32-stub.c
> +++ b/drivers/firmware/efi/libstub/arm32-stub.c
> @@ -28,6 +28,8 @@ efi_status_t
> check_platform_features(efi_system_table_t *sys_table_arg)
>         return EFI_SUCCESS;
>  }
>
> +void * foo = (void *)check_platform_features;
> +
>  static efi_guid_t screen_info_guid = LINUX_EFI_ARM_SCREEN_INFO_TABLE_GUID;
>
>  struct screen_info *alloc_screen_info(efi_system_table_t *sys_table_arg)
> $ make ARCH=arm  CROSS_COMPILE=arm-linux-gnueabihf- defconfig
> drivers/firmware/efi/libstub/
> *** Default configuration is based on 'multi_v7_defconfig'
> #
> # configuration written to .config
> #
> scripts/kconfig/conf  --syncconfig Kconfig
>   CALL    scripts/checksyscalls.sh
>   CC      drivers/firmware/efi/libstub/arm32-stub.o
>   STUBCPY drivers/firmware/efi/libstub/arm32-stub.stub.o
> 00000000 R_ARM_ABS32       check_platform_features
> drivers/firmware/efi/libstub/arm32-stub.stub.o: absolute symbol
> references not allowed in the EFI stub
> drivers/firmware/efi/libstub/Makefile:80: recipe for target
> 'drivers/firmware/efi/libstub/arm32-stub.stub.o' failed
> make[3]: *** [drivers/firmware/efi/libstub/arm32-stub.stub.o] Error 1
> make[3]: *** Deleting file 'drivers/firmware/efi/libstub/arm32-stub.stub.o'
> Makefile:1705: recipe for target 'drivers/firmware/efi/libstub/' failed
> make[2]: *** [drivers/firmware/efi/libstub/] Error 2
> /home/masahiro/workspace/bsp/linux/Makefile:300: recipe for target
> '__build_one_by_one' failed
> make[1]: *** [__build_one_by_one] Error 2
> Makefile:160: recipe for target 'sub-make' failed
> make: *** [sub-make] Error 2
>
>
>
>
>
> --
> Best Regards
> Masahiro Yamada
