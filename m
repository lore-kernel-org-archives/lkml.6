Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CluwKd7vGFtxCgAAmS7hNA
	; Thu, 07 Jun 2018 08:43:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4117D608C9; Thu,  7 Jun 2018 08:43:18 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1P1d4vo"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7D1BA608C8;
	Thu,  7 Jun 2018 08:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7D1BA608C8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753635AbeFGInA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:43:00 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34232 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753484AbeFGImz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:42:55 -0400
Received: by mail-vk0-f65.google.com with SMTP id q135-v6so5548124vkh.1;
        Thu, 07 Jun 2018 01:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=yoQiG0YjeRbttnXRDdtKOnySUrLa7Eejk0NpmNksoXY=;
        b=U1P1d4voyuX9IBr80nc60IvOqdhHZqZiwFR5c2nGQHNHJq9ctWrJ2oNupRGL8PNvRD
         xpZgnqDiDVq7qCcwIN9mz4oPKBKrp8BSGjqDmSFQhJRhEkp5AKpf4pnv2lNkcEvedqB4
         j9gMpbcpUXY8e4axfewbUoc/W5mCiaDtOrhVFij34W+eHWCNpAjOk4/WaObbAl67dvFK
         J2jmlKP8ZIuGjlYcIA1/7sScQVj6kw1y+S6G2XgNV5jULj27gDmqtEWW2c0grxj8/yGY
         h6Hixy0I8ObAPjUSUFdzNi1mdqsnm86+/zSlukU/mi2t5zgwLckHU9hZBLQ8zUAg2jcx
         B0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=yoQiG0YjeRbttnXRDdtKOnySUrLa7Eejk0NpmNksoXY=;
        b=hyiKatoRwShjdl45op6wMlKNQ7PTnH4D8Qc6klJkFCcJI8D89cEbtQNluhs9MF84xG
         pzEefsSFNoB2xENnU1Rl/AYW9Ul1EwhVZCh1wvcSyPjgioRmPFfJjKYg8bxk32iBbL5/
         dKVib+OToXQakHaVzVcGSPg9YzQ8m46DGlUAT8G3uC3ZdoaXpJY2lA/TYdTD7LDHrH2N
         i5H1YHoPP01mhjYzyJJkL7Q7vOUzd9JjCPm0AjZzeK96OzwM05fdUHGK2h3k9SkI0bqn
         Yc/SOcFG1g8OtCxaOJe06bFai6nx8mm79JftriFvyyV6Scz1hGZtX/ptR5tDct6fWqqf
         AEJQ==
X-Gm-Message-State: APt69E1Xmxs7LpCBKOUC/cv+l9f+H5HpC7fDxmj71VMSQGROA02ue1ji
        77gq2Y7suFvBrH4TbRkG0gK0eDZJbU/zA4k79D8=
X-Google-Smtp-Source: ADUXVKItkrOc4PD9SRGeTSYNbMKGDvnhjovl4oz3Z27DHfE5iAWCCxao/2WGbLXdgB5jx2iKHW612UXge/9BmGz3gn0=
X-Received: by 2002:a1f:644:: with SMTP id 65-v6mr523801vkg.159.1528360974465;
 Thu, 07 Jun 2018 01:42:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8596:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 01:42:53 -0700 (PDT)
In-Reply-To: <1527499328-13213-22-git-send-email-yamada.masahiro@socionext.com>
References: <1527499328-13213-1-git-send-email-yamada.masahiro@socionext.com> <1527499328-13213-22-git-send-email-yamada.masahiro@socionext.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 7 Jun 2018 10:42:53 +0200
X-Google-Sender-Auth: WrEfLwxw-BWjGp7CaLMHQcisEiA
Message-ID: <CAMuHMdUDCtnyqydZan9Q-+hOQacWGJrrMbw4LshjYSjn2=yBjw@mail.gmail.com>
Subject: Re: [PATCH v5 21/31] kconfig: show compiler version text in the top comment
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ulf Magnusson <ulfalizer@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

On Mon, May 28, 2018 at 11:21 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> The kernel configuration phase is now tightly coupled with the compiler
> in use.  It will be nice to show the compiler information in Kconfig.
>
> The compiler information will be displayed like this:
>
>   $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- config
>   scripts/kconfig/conf  --oldaskconfig Kconfig
>   *
>   * Linux/arm64 4.16.0-rc1 Kernel Configuration
>   *
>   *
>   * Compiler: aarch64-linux-gnu-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011
>   *
>   *
>   * General setup
>   *
>   Compile also drivers which will not load (COMPILE_TEST) [N/y/?]
>
> If you use GUI methods such as menuconfig, it will be displayed in the
> top menu.
>
> This is simply implemented by using the 'comment' statement.  So, it
> will be saved into the .config file as well.
>
> This commit has a very important meaning.  If the compiler is upgraded,
> Kconfig must be re-run since different compilers have different sets
> of supported options.
>
> All referenced environments are written to include/config/auto.conf.cmd
> so that any environment change triggers syncconfig, and prompt the user
> to input new values if needed.
>
> With this commit, something like follows will be added to
> include/config/auto.conf.cmd
>
>   ifneq "$(CC_VERSION_TEXT)" "aarch64-linux-gnu-gcc (Linaro GCC 7.2-2017.11) 7.2.1 20171011"
>   include/config/auto.conf: FORCE
>   endif
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>

This is now commit 21c54b774744719c ("kconfig: show compiler version text
in the top comment") upstream.

This commit broke cross-compilation for me:

    $ make ARCH=m68k
    scripts/kconfig/conf  --syncconfig Kconfig
    scripts/kconfig/conf  --syncconfig Kconfig
    scripts/kconfig/conf  --syncconfig Kconfig
    scripts/kconfig/conf  --syncconfig Kconfig
    ...

with O=:

      GEN     ./Makefile
     scripts/kconfig/conf  --syncconfig Kconfig
      GEN     ./Makefile
    scripts/kconfig/conf  --syncconfig Kconfig
      GEN     ./Makefile
    scripts/kconfig/conf  --syncconfig Kconfig
      GEN     ./Makefile
    ...

.config gained (both with/without O=):

    #
    # Compiler: gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
    #

which is definitely wrong when cross-compiling for m68k.

Reverting the commit, and fixing up the conflicts, fixes the issue for me

Do you have a clue?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
