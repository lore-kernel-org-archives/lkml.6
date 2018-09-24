Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EFBECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B21620870
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B21620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbeIXNGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:06:22 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:36482 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbeIXNGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:06:22 -0400
Received: by mail-vs1-f66.google.com with SMTP id z19-v6so7697770vso.3;
        Mon, 24 Sep 2018 00:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BF/2BOzEwDyUlVvqYRv+51TmQ1BKOZk6vLirGrRY3Hg=;
        b=c0Q7amn/aLB8O7vSR1jPQ45BYhuRbKFA2N9cz6xfwY9dZnkmPu6+ZeIVdJnFF0erJ2
         jjNP1/sUe0dUhDeg02RoOJfGoPDaLDwrFawsSZgfFmvv5w1l2jDcpbwnkFo3Pb7bvXwb
         SVRidoQzJHKElBxHSn9i7Pln++VL9P7QujcMPLrgS5G5yXDUEji3EaIYimUazYuEdXSC
         EJhM4ha3RhpVkHCwd5OLH6Lp73vzq8L+zc0W6cxF5fvN+epc3rLJpjalTuRVh6Qlztfu
         ntQoCIHrAXORpg4KzEfMFRnMaHjuBWCxIygK4DTPerHvBXYz6h6xhKKI5CJRTe6Z9RF6
         72oA==
X-Gm-Message-State: APzg51AdLAPOwiex9WZfCbrE5DrC742Ys6sQgsCzE27Ykku7e2c++hsM
        AZN4E9pxG0wooAYjX2IZvi6CnYmiF8KZo6YMXQg=
X-Google-Smtp-Source: ANB0VdamHdkogk4oeVU+KMIkiULxWC/f96Sgonzx2SwFehIqfXFZ7MmveJpwUgxj6ag8MWabh9r/RxvLmMowpvXhIck=
X-Received: by 2002:a67:f785:: with SMTP id j5-v6mr1695786vso.96.1537772742637;
 Mon, 24 Sep 2018 00:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org> <1537455973-12468-5-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1537455973-12468-5-git-send-email-firoz.khan@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Sep 2018 09:05:31 +0200
Message-ID: <CAMuHMdWZv7eKt+2CSXQ3kgPXc-Vvm7o7zED9afXxnG8dh6+nFA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] m68k: uapi header and system call table file generation
To:     firoz.khan@linaro.org
Cc:     linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Firoz,

On Thu, Sep 20, 2018 at 5:07 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> System call table generation script must be run to generate
> unistd_32.h and syscall_table.h files. This patch will have
> changes which will invokes the script.
>
> This patch will generate unistd_32.h and syscall_table.h
> files by the syscall table generation script invoked by
> arch/m68k/Makefile and the generated files against the
> removed files will be identical.
>
> The generated uapi header file will be included in
> uapi/asm/unistd.h and generated system call table support
> file will be included by arch/m68k/kernel/syscall_table.S
> file.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>

Thanks for your patch!

> --- a/arch/m68k/include/asm/Kbuild
> +++ b/arch/m68k/include/asm/Kbuild
> @@ -24,3 +24,4 @@ generic-y += topology.h
>  generic-y += trace_clock.h
>  generic-y += word-at-a-time.h
>  generic-y += xor.h
> +generic-y += syscall_table.h
> \ No newline at end of file

Please add the missing newline.

> diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
> index c2e26a4..6d600e9 100644
> --- a/arch/m68k/include/uapi/asm/Kbuild
> +++ b/arch/m68k/include/uapi/asm/Kbuild
> @@ -21,3 +21,4 @@ generic-y += statfs.h
>  generic-y += termbits.h
>  generic-y += termios.h
>  generic-y += types.h
> +generic-y += unistd_32.h
> \ No newline at end of file

Likewise.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
