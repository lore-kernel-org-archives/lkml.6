Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1057C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9122F208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9122F208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeK3BQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:16:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46543 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbeK3BQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:16:29 -0500
Received: by mail-qk1-f193.google.com with SMTP id q1so1081675qkf.13;
        Thu, 29 Nov 2018 06:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wv38us1LrGaAtmbmo49i4wsBnN+kWL1/8/1UP+gxTYQ=;
        b=iJrgSgrcd55iTLc7xH0DmrTsXtqW3C7pScAKuReir1VkgbWTBRzooA7EnYKwN81EZ8
         7ZnOFb4D/llqF2+ZD+no2SsbeU7NKEKWmzAVTJepDEcMSll75SyAKhiESPxysyihacdj
         koo7j+u+DbRRrjdjERo88krZ2IkCcRLTIm50rCY+1csrw7yv8iIjR4Tk7h9c3kR07ytr
         IcEX71ChQ+iHeZevkHIgxEK2QgoU4h/d0F9/yX9Nm+vbO4nbcx7g+nB8umm+p0GF3gl6
         lFf8HLONtTTVmUwVhkstuaZMA9yrOolMl3+z8KHR1dLjmPn0tg0dCnWxfKtBcwVAh8eF
         pBBg==
X-Gm-Message-State: AA+aEWbMypOanyRBKBtCSrImDOyej/kcXbHjlmsaVQLTK8ULeW+ocCDZ
        xEpb3/I+n6Jn4CGxbYB/YpQEVaaIAc2TetzZKWk=
X-Google-Smtp-Source: AFSGD/VRjXbNAIpsZr4dI3CXoXFX08aFmjLRqc+nKn9Ux1anF/pD33EoUiKp/HulBbq07qB9abOPjXVoHN09EbmMkg8=
X-Received: by 2002:a37:bdc6:: with SMTP id n189mr1407839qkf.330.1543500659952;
 Thu, 29 Nov 2018 06:10:59 -0800 (PST)
MIME-Version: 1.0
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org> <1543481016-18500-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1543481016-18500-2-git-send-email-firoz.khan@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Nov 2018 15:10:42 +0100
Message-ID: <CAK8P3a1Pq=Y83p-cN9bf+m-2ZAmJdEYRaAY9FfEkVHvfSwNWNg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] mips: add __NR_syscalls along with __NR_Linux_syscalls
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 9:44 AM Firoz Khan <firoz.khan@linaro.org> wrote:

>  arch/mips/include/uapi/asm/unistd.h | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/include/uapi/asm/unistd.h b/arch/mips/include/uapi/asm/unistd.h
> index f25dd1d..6914be5 100644
> --- a/arch/mips/include/uapi/asm/unistd.h
> +++ b/arch/mips/include/uapi/asm/unistd.h
> @@ -391,11 +391,14 @@
>  #define __NR_rseq                      (__NR_Linux + 367)
>  #define __NR_io_pgetevents             (__NR_Linux + 368)
>
> +#ifdef __KERNEL__
> +#define __NR_syscalls                  368
> +#endif
>
>  /*
>   * Offset of the last Linux o32 flavoured syscall
>   */
> -#define __NR_Linux_syscalls            368
> +#define __NR_Linux_syscalls            __NR_syscalls

This seems odd: you define __NR_Linux_syscalls outside of
#ifdef __KERNEL__, but the definition only works
with __NR_syscalls being defined first, which it isn't in
user space.

Since the macros are completely unused as well as unusable
now, how about removing them together with the other
ones removed in patch 2?

      Arnd
