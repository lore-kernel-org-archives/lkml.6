Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6A8C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC6120825
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xco74WU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC6120825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387986AbeKFHGg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:06:36 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34475 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387580AbeKFHGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:06:36 -0500
Received: by mail-yw1-f67.google.com with SMTP id v199-v6so4324806ywg.1;
        Mon, 05 Nov 2018 13:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dg3CM5nHGrKAtCE4EJBmrcn+B3XQaQmBjEl2eL55lEI=;
        b=Xco74WU8IKx0ww44HGAdZiHsSHuSKM9kNlkRnB2NiyRwl+aNS77lnpaCCXZyz7m75L
         PEftyY86NR+XS8uvKNtr+dzBD5i/WdFK4iGe9HFne8/2a41FBWh6zQn6RbNiFjsef6kq
         7RJdKFISxUBebefC4rzuK2bqBHIhlj73FjUgFuOYKL7uwHK6MRQPqRnrFoJu7unK0x+5
         cYsZP9RKrqF8boWbuk/qWzUO48ATam3imCBXcpgEpjdbtADSsjpyc+ySHiopnsky7qkN
         ZLW/sxS8iHIjJ9aA6IBnl4MUVewE2i8AF9TIw7T+nXOLGQus68FkwQCxWiZwmXWasisa
         UHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dg3CM5nHGrKAtCE4EJBmrcn+B3XQaQmBjEl2eL55lEI=;
        b=kL2bPg8yRp3PMGVpiwra+H+tm1zvqJ7Hcn3jiV3c2byDFm9UE4FMF0GhbUGn+IEQ4s
         vFySvNcf945ICyFc2ixg6jzx/+SXJ7IhhfMhmpSmzNvSu0UeRatXOjg2byqL5Ranplqx
         ve7tyUKLxhBVs/3NBIDSOQrpiBTZdHgsXoH2EWPH2hR5aWLtG8KLFy/W6zL4AQMhs0Ya
         2T9pfAgDWE4ap+ZjJojlgnIxEx3uEe6vuha9lWTdSuBD7x5VpjTBxYGbp0OPOmmFTp7W
         yPBysPp1z0PxdfO+mm8XpARWIVpLMakbwHCBfAVAKIvI7n98L+DzdJiZgP5AlPcU4s6T
         n7+Q==
X-Gm-Message-State: AGRZ1gJ29sgZdTdb6JfCM5KxbGED17NC3pLk9qV7yBowhBa7cqMesBJ0
        TZj5pyY1p+SaZswd6JAiqK11UAWzooFO+y3W8dg=
X-Google-Smtp-Source: AJdET5foNUteCB3ZFcB9SB/Mo+O1oID5TGYPB2e8m8CNUay03PhtgTqEpq+POj/2Im3mM5CR7zkFZSglAUtO6g6G8mo=
X-Received: by 2002:a81:5ec6:: with SMTP id s189-v6mr3818178ywb.126.1541454290853;
 Mon, 05 Nov 2018 13:44:50 -0800 (PST)
MIME-Version: 1.0
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org> <1541080581-4072-5-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1541080581-4072-5-git-send-email-firoz.khan@linaro.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 5 Nov 2018 13:44:39 -0800
Message-ID: <CAMo8BfKaSUTMT0h2jRg2ysRnc2yvVT-3=-gq6pH-XpKm1iydQQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] xtensa: generate uapi header and syscall table
 header files
To:     firoz.khan@linaro.org
Cc:     Chris Zankel <chris@zankel.net>, linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038@lists.linaro.org, LKML <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 6:57 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
> System call table generation script must be run to gener-
> ate unistd_32.h and syscall_table.h files. This patch will
> have changes which will invokes the script.
>
> This patch will generate unistd_32.h and syscall_table.h
> files by the syscall table generation script invoked by
> xtensa/Makefile and the generated files against the removed
> files must be identical.
>
> The generated uapi header file will be included in uapi/-
> asm/unistd.h and generated system call table header file
> will be included by kernel/syscall.c file.
>
> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
> ---
>  arch/xtensa/Makefile                  |   3 +
>  arch/xtensa/include/asm/Kbuild        |   1 +
>  arch/xtensa/include/uapi/asm/Kbuild   |   1 +
>  arch/xtensa/include/uapi/asm/unistd.h | 782 +---------------------------------
>  arch/xtensa/kernel/syscall.c          |   5 +-
>  5 files changed, 10 insertions(+), 782 deletions(-)
>
> diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
> index d67e30fa..1e7b179 100644
> --- a/arch/xtensa/Makefile
> +++ b/arch/xtensa/Makefile
> @@ -99,6 +99,9 @@ all Image zImage uImage: vmlinux
>  dtbs: scripts
>         $(Q)$(MAKE) $(build)=$(boot)/dts
>
> +archheaders:
> +       $(Q)$(MAKE) $(build)=arch/xtensa/kernel/syscalls all
> +
>  define archhelp
>    @echo '* Image       - Kernel ELF image with reset vector'
>    @echo '* zImage      - Compressed kernel image (arch/xtensa/boot/images/zImage.*)'
> diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
> index 82c75643..b35d2e6 100644
> --- a/arch/xtensa/include/asm/Kbuild
> +++ b/arch/xtensa/include/asm/Kbuild
> @@ -28,3 +28,4 @@ generic-y += topology.h
>  generic-y += trace_clock.h
>  generic-y += word-at-a-time.h
>  generic-y += xor.h
> +generic-y += syscall_table.h

This doesn't look right: syscall_table.h is not asm-generic header.

> diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
> index 837d4dd..f826d52 100644
> --- a/arch/xtensa/include/uapi/asm/Kbuild
> +++ b/arch/xtensa/include/uapi/asm/Kbuild
> @@ -11,3 +11,4 @@ generic-y += resource.h
>  generic-y += siginfo.h
>  generic-y += statfs.h
>  generic-y += termios.h
> +generic-y += unistd_32.h

Ditto: unistd32_.h is not asm-generic header.

-- 
Thanks.
-- Max
