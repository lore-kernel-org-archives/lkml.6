Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C624C3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF0222434
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="D7xU/ErZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CgiDnIKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF0222434
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753844AbeGCCSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:18:30 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:34844 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753797AbeGCCS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:18:28 -0400
Received: by mail-yb0-f196.google.com with SMTP id x15-v6so147037ybm.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 19:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KhP4eVN/XGoWQMWYKM3pyVoMECaDszl1ty5eVUZ5U0U=;
        b=D7xU/ErZT4hhytDW8EMBf6MutZ00vatrz6K9UqgLgtD+14CyxGycZLN/YkU3+8AdM0
         LiIATUqiRFmEgV9y6BBk1V4fFh1DKAhg2oAC7XHidftHiykAk7ahhdOhLzqW2r+JrxX6
         8XQ7aSBmN8I68DDusvOIbfUKa/uVY8xMyZVrJI5DBDzqfFBbMexJ/0SzwPbgapEgU3VI
         guD3M7Wr2cnYt1qpvGllO9OaRR445p5+hkPRjNCj10oNhzBIzfgi+JBVZPRGDI0JHb3o
         14gJ16q18pjsn6Lt+Q9Es+DKM8VrJtgOrMNt2B7svjpweVolrdlO3Lygiyyu0R4k1eWL
         rPUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KhP4eVN/XGoWQMWYKM3pyVoMECaDszl1ty5eVUZ5U0U=;
        b=CgiDnIKygQjEAly3waYaChegAPAUKhtERCzbApEEBsE5nML8Z595wjm9g5synvk/I7
         KRZLh2rqvKancZj+aXokwngigGhbJUjR86YhRsClgHqOp24BPZVMHA4SYJN3k7vDTFkt
         JTlPLES1nauoB2cj8X3dtO+UMWhC6nuKWM2c8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KhP4eVN/XGoWQMWYKM3pyVoMECaDszl1ty5eVUZ5U0U=;
        b=ikOqRXSALQyeWKfYMc9sgnJfAsAHyVit1RuNeZXzOFIZR7a1b6WqFZ4SrM16JywCZ6
         Dhv+a61sO+0CmqgROTjZddCk4B2D/jWUVrLwy+xt4N7Pu80KP9/7Wzs4wKvFdYkGjp1u
         nSuDfSWPHU5PMALhdy/1DlSKNSmhML+KVX608zyd4pOm3R2XQfX3M4bYKzWREF/UrulB
         f40IWUVlZdsQ7N8v53HvAE6XIPG1Ts80hllf7FrW8YWrWzpFlUWQ4tTfX4kACmcfUrp8
         NiWHPweAmTansIyykis1uaRn1rnT+1NAlVGp74PPwoFvDBBEomWg11UgN9fIn48PhmgZ
         SVJw==
X-Gm-Message-State: APt69E2YkPsfYbUIb6a41sTbwwH4FSNJRPBoCYM/RW3s4YAkBhUnZ4e5
        rt9daU2/CCc1lDENjlTjWVwkpLKyUCGNtfOVHhWnmdVR
X-Google-Smtp-Source: ADUXVKI8CCGaS1SQn7RXabsrsQW4QFUEvfO+PlH52THMMr0ASfJxZI6NqpuiITcVUXrMxlTn6TyetbXi31U2Q8SixB0=
X-Received: by 2002:a25:b219:: with SMTP id i25-v6mr15071861ybj.112.1530584307486;
 Mon, 02 Jul 2018 19:18:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f51:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 19:18:26 -0700 (PDT)
In-Reply-To: <1530578352-18613-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530578352-18613-1-git-send-email-yamada.masahiro@socionext.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 2 Jul 2018 19:18:26 -0700
X-Google-Sender-Auth: _qv6qtGxtBxB4H7AJs1pA8VZbSg
Message-ID: <CAGXu5jKcWjm-56VRj=0kKU0Fb1ZrGgJ8WgesD0cN2x9WHTGwDw@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: remove unused GCC_PLUGIN_SUBDIR
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Emese Revfy <re.emese@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 5:39 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> GCC_PLUGIN_SUBDIR has never been used.  If you really need this in
> the future, please re-add it then.
>
> For now, the code is unused. Remove.
>
> 'export HOSTLIBS' is not necessary either.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Kees Cook <keescook@chromium.org>

Is this going via your tree, or should I take it via the gcc-plugins tree?

Thanks!

-Kees

> ---
>
>  scripts/Makefile.gcc-plugins | 3 +--
>  scripts/gcc-plugins/Makefile | 5 -----
>  2 files changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
> index c961b9a..f9942d9 100644
> --- a/scripts/Makefile.gcc-plugins
> +++ b/scripts/Makefile.gcc-plugins
> @@ -19,7 +19,7 @@ gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT_PERFORMANCE) += -fplugin-arg-ra
>
>  GCC_PLUGINS_CFLAGS := $(strip $(addprefix -fplugin=$(objtree)/scripts/gcc-plugins/, $(gcc-plugin-y)) $(gcc-plugin-cflags-y))
>
> -export GCC_PLUGINS_CFLAGS GCC_PLUGIN GCC_PLUGIN_SUBDIR
> +export GCC_PLUGINS_CFLAGS GCC_PLUGIN
>  export DISABLE_LATENT_ENTROPY_PLUGIN
>
>  # sancov_plugin.so can be only in CFLAGS_KCOV because avoid duplication.
> @@ -27,7 +27,6 @@ GCC_PLUGINS_CFLAGS := $(filter-out %/sancov_plugin.so, $(GCC_PLUGINS_CFLAGS))
>
>  KBUILD_CFLAGS += $(GCC_PLUGINS_CFLAGS)
>  GCC_PLUGIN := $(gcc-plugin-y)
> -GCC_PLUGIN_SUBDIR := $(gcc-plugin-subdir-y)
>
>  # Actually do the build, if requested.
>  PHONY += gcc-plugins
> diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
> index 3262546..aa0d0ec 100644
> --- a/scripts/gcc-plugins/Makefile
> +++ b/scripts/gcc-plugins/Makefile
> @@ -14,8 +14,6 @@ else
>    export HOST_EXTRACXXFLAGS
>  endif
>
> -export HOSTLIBS
> -
>  $(obj)/randomize_layout_plugin.o: $(objtree)/$(obj)/randomize_layout_seed.h
>  quiet_cmd_create_randomize_layout_seed = GENSEED $@
>  cmd_create_randomize_layout_seed = \
> @@ -29,7 +27,4 @@ always := $($(HOSTLIBS)-y)
>
>  $(foreach p,$($(HOSTLIBS)-y:%.so=%),$(eval $(p)-objs := $(p).o))
>
> -subdir-y := $(GCC_PLUGIN_SUBDIR)
> -subdir-  += $(GCC_PLUGIN_SUBDIR)
> -
>  clean-files += *.so
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
