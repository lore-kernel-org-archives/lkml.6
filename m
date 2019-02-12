Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B34C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CE2218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:23:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oATYhGTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfBLHXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:23:50 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:51979 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfBLHXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:23:50 -0500
Received: by mail-it1-f193.google.com with SMTP id y184so4865923itc.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 23:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=63dAt1mG4/HWaTy/t2pxUgenU7jQXTj2WJTze3+hB8E=;
        b=oATYhGTYPZ0gYl4MsmxlExsQOeTc9vtSWC97bTFrstRxYGkuVMGI9tLi6HWV+dL8ME
         XmG0e89am4Ftqa224qho6RNVcvZNzS/5z073cVN9nWbHP52F5TH3JdFQcwhq4KQsPAVR
         dN8XGDnoA81Ch/kfbnEcYP3zBAvpcmdOjEAHkl6OCSI1pxrFdWAGDXSAZ9YgUvDwtIxB
         WQUg4jse6Rc2x+UodS138U4ObYLJE/yYEEnxowqurHP/dxCtBEvnZQ1vcB3xqbAS3WJy
         tZbCYMdjmh2w4YYn0ojck7xpsQ7sFUtQZ/nOpW5dL30wpdzuhXBLsDhcQmoED5AAQBI9
         UyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=63dAt1mG4/HWaTy/t2pxUgenU7jQXTj2WJTze3+hB8E=;
        b=qdZNhl1L1wSfnWevETotR1Kc1R1RTNB4CUP/ocP/axZBDXow42Ow43hEy2nx1ApmSy
         OhplMqiTKTteUsXFa9NdexiL/fqVRxdI9yw3fiuPoGfEXZJclpM7rK45fT4rwY/on+jX
         mbZ4cbugXU33hBWn6Va7FuqAQGirkTk1r3dsq97J8NEELKxAbrzMbWiCGrD8tTFaC7/x
         SLbPaJzuilsw3kBUXyrt2DZyC/uV9BByiYn0LEj7vIOcJyKBLtWHSNyHEagdFPtR7tuw
         cvfyRGD2UgICTdGYDZQy/9+2hRKlAEzcZks0XrtqDHOFXlQFDFcJcgZNC4m7LSbaiAxG
         NBaw==
X-Gm-Message-State: AHQUAuY7XXgF/dgQr0jcrTLcFNZwmJE5fp4OpAkhX7QJW39v1CpGtw7k
        t59dQLLWM9y6KU7IWWnFX1EglQEWUMfZY49c4cZxsA==
X-Google-Smtp-Source: AHgI3IbLz5FrQszBJi8qTpJSA+zSsNz8EvDpOIe10Pou2JPfrDHDUHNi4UANI0tRyG+mEtXkFo7dLJdcs9T+CL70O9c=
X-Received: by 2002:a24:710:: with SMTP id f16mr991596itf.121.1549956229160;
 Mon, 11 Feb 2019 23:23:49 -0800 (PST)
MIME-Version: 1.0
References: <1549943095-10956-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1549943095-10956-1-git-send-email-yamada.masahiro@socionext.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 12 Feb 2019 08:23:37 +0100
Message-ID: <CAKv+Gu8yLY+c6jNmHYkvP3n=xiojF7dcKBHmeGibUW2FUrEczA@mail.gmail.com>
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

On Tue, 12 Feb 2019 at 04:45, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> It took me a while to understand what is going on in the nested
> if-blocks.
>
> Simplify it by removing unneeded code.
>
>   - if_changed automatically adds 'set -e', so any failure in the
>     series of commands makes it immediately fail as a whole.
>     So, the outer if block is entirely redundant.
>
>   - Since commit 9c2af1c7377a ("kbuild: add .DELETE_ON_ERROR special
>     target"), GNU Make automatically deletes the target on any failure
>     in its recipe. The explicit 'rm -f $@' is redundant.
>
>   - surrounding commands with ( ) will spawn a subshell to execute them
>     in it, but it is rarely useful to do so.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Assuming that it still works as expected:

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

You can test this by adding a statically initialized global function
pointer to any of the libstub source files that get built for ARM.

Thanks!

> ---
>
>  drivers/firmware/efi/libstub/Makefile | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index d984509..7788e8a 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -86,12 +86,13 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
>  # this time, use objcopy and leave all sections in place.
>  #
>  quiet_cmd_stubcopy = STUBCPY $@
> -      cmd_stubcopy = if $(STRIP) --strip-debug $(STUBCOPY_RM-y) -o $@ $<; \
> -                    then if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); \
> -                    then (echo >&2 "$@: absolute symbol references not allowed in the EFI stub"; \
> -                          rm -f $@; /bin/false);                         \
> -                    else $(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@; fi        \
> -                    else /bin/false; fi
> +      cmd_stubcopy =                                                   \
> +       $(STRIP) --strip-debug $(STUBCOPY_RM-y) -o $@ $<;               \
> +       if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); then            \
> +               echo "$@: absolute symbol references not allowed in the EFI stub" >&2; \
> +               /bin/false;                                             \
> +       fi;                                                             \
> +       $(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@
>
>  #
>  # ARM discards the .data section because it disallows r/w data in the
> --
> 2.7.4
>
