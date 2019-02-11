Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F5EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9EF21B18
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y5mJE4Hl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbfBKSDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:03:18 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34540 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbfBKSDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:03:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id d9so5303827pgl.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VN9lMObigACayjQrnw+MxyNXVTrGHWEO023JUJZyDtw=;
        b=Y5mJE4Hlvmlo7ZrYp9pIIKiVimHuvDGDVYBEhL/mpTIvBlW9tNh1OwsvsKWUlkjUs3
         IhUkbPeEVsiO0oUrIVrysnrn/w0zqh5DkNSCeBBwkZygEkivT29VQpGWsHT+pYLmcX7T
         7UhxY5Du61zbL5Wpkea5Sa+VUexIe5qpS12wC9fJLq8Lz2B164Fm+Hs9LSR9zbw9XDVD
         51A+n2MJ8CW8uZxo0oFXwNB4yi+OpK1RJWLtxRxG074VYzSyoGj+63IoT82/S45hD3IG
         hoPQcuiaemqiHngdl0OuthYWoGeAsc9gNFlft499bmKBHnq43fqKS5LkSM6GFyDW++r6
         YR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VN9lMObigACayjQrnw+MxyNXVTrGHWEO023JUJZyDtw=;
        b=eF/RqeuQ4PL4OR5xGZQuOQm+PCF1Tz5298OqvDpe6qBtGUxEE3ARr9un2FipywzFBY
         BZrM/5Ogx6sakDxzeG5oix4f+/5Vg92MI59TVIVwfldj61ezMLHXCUEblQZhzJ7aBbwb
         HoyhlWY3AQZ+40VU6NTUiVLwdA32Lk3IrBo05ijja1lz2+WOZtA7h4IvUhZLuqTIZtl8
         MRtBVVwV/dG06Q3ImS5pfjgxAnusE+HfEKVBg+nuwvDHcWS0PKRVd/fpJMcsxXxuxwYs
         noGbBJ+JifRtIIww7ky/6GxJ80V1rWQQ+sNcfEyk35S4gTDHFOS1kRj5uHc7MNpQDMko
         rDuA==
X-Gm-Message-State: AHQUAuaisrza8wt9Pku6RaII7PzqyaV2IRAtezwNMlhcHhzt91HbP0wt
        DupSy8K2KP4/IwARt+Hd706Fs0g4NxmndcRYORjwBQ==
X-Google-Smtp-Source: AHgI3IZ8teRC3nkNZG6nK2xKOxvdQ/41PAYVhPH+IbTMvhTd1LJH8ZExzvTnGSN54AXYbllQgmmtblPijGVl42G6mJQ=
X-Received: by 2002:a62:2c81:: with SMTP id s123mr37497384pfs.174.1549908196720;
 Mon, 11 Feb 2019 10:03:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549753425.git.stefan@agner.ch> <668a4c10c2731ddb572e8ddd3f0816904436d7ae.1549753425.git.stefan@agner.ch>
In-Reply-To: <668a4c10c2731ddb572e8ddd3f0816904436d7ae.1549753425.git.stefan@agner.ch>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 Feb 2019 10:03:05 -0800
Message-ID: <CAKwvOdmqj449m6jTKrbdd3GHwE+uTzfkXV_8-5sUtRcL7+f2qg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ARM: warn if divided syntax assembler is used
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Will Deacon <will.deacon@arm.com>, julien.thierry@arm.com,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 9, 2019 at 3:09 PM Stefan Agner <stefan@agner.ch> wrote:
>
> Remove the -mno-warn-deprecated assembler flag to make sure the GNU
> assembler warns in case non-unified syntax is used.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Changes in v2:
> - Remove AFLAGS_NOWARN from CFLAGS_ISA

Thanks for making this requested change.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>  arch/arm/Makefile | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/Makefile b/arch/arm/Makefile
> index a0d08a3c9d33..9561325c5201 100644
> --- a/arch/arm/Makefile
> +++ b/arch/arm/Makefile
> @@ -112,19 +112,16 @@ ifeq ($(CONFIG_ARM_UNWIND),y)
>  CFLAGS_ABI     +=-funwind-tables
>  endif
>
> -# Accept old syntax despite ".syntax unified"
> -AFLAGS_NOWARN  :=$(call as-option,-Wa$(comma)-mno-warn-deprecated,-Wa$(comma)-W)
> -
>  ifeq ($(CONFIG_THUMB2_KERNEL),y)
>  AFLAGS_AUTOIT  :=$(call as-option,-Wa$(comma)-mimplicit-it=always,-Wa$(comma)-mauto-it)
> -CFLAGS_ISA     :=-mthumb $(AFLAGS_AUTOIT) $(AFLAGS_NOWARN)
> +CFLAGS_ISA     :=-mthumb $(AFLAGS_AUTOIT)
>  AFLAGS_ISA     :=$(CFLAGS_ISA) -Wa$(comma)-mthumb
>  # Work around buggy relocation from gas if requested:
>  ifeq ($(CONFIG_THUMB2_AVOID_R_ARM_THM_JUMP11),y)
>  KBUILD_CFLAGS_MODULE   +=-fno-optimize-sibling-calls
>  endif
>  else
> -CFLAGS_ISA     :=$(call cc-option,-marm,) $(AFLAGS_NOWARN)
> +CFLAGS_ISA     :=$(call cc-option,-marm,)
>  AFLAGS_ISA     :=$(CFLAGS_ISA)
>  endif
>
> --
> 2.20.1
>


-- 
Thanks,
~Nick Desaulniers
