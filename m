Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CECBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F8320869
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wiq26En0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbeLTGRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 01:17:00 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:33656 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbeLTGRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 01:17:00 -0500
Received: by mail-ed1-f67.google.com with SMTP id p6so752734eds.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 22:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uSH8Px44l+044lB7ulMznZksHkH6jpW/e6qzUQ/ZZ+A=;
        b=Wiq26En0qPUdxtT1NfYNP47NrXDB628RGKZkVe0FLdHadP5Nrj8p20h9L/v0+VSePc
         CE0Kx2IM4OM/G00JzADi3pGm/c2OGFBcUt5iuoFxCLCtObjWQwIYnWhIks7n/lhmRDzJ
         /pUbbPDRwN6MNtRl3/Bl77KfBUduIEWB5/0ZQPQn//eCohX1ngrEouuFSkHK7ulufZ9V
         UoxXieVjjKIYBT6cI83ztBMpY89HXxSzkHS6DAJPFpSXuzmgAHnmIxPzpOCkxvnjSke9
         YRzpg8breNAFUTUr98GrdThmklcufbdLZTHW37S1OfZdaIERyUQsghnYoRC3iloFmqjk
         /+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uSH8Px44l+044lB7ulMznZksHkH6jpW/e6qzUQ/ZZ+A=;
        b=ulwu391DsByRf9739iHY+UWjhHSgjIrufEr67qZ62HyjzuKo5Lj7xt2OI5w93jLkBg
         DR4rxpAvmygjaB7rI4HEtuzPAi3zS3X/BedqvXJQz0Ybmdw9oGcQjiAI2lckPwr5T8jG
         g7x8J+/k+Je3loGCjfMMaC1blxrTROA+6KOJ4gIF0g3ABUOsk/E5fYmg9ZuKAjiDuaEQ
         4xXk95DK8ytK8YgvFeTcSDiJ0PvHCbzx99QUytPTFrs6fucn6pSsgDI86cu0VoPwpC2i
         TzFTNSAOyqkNPkTjOgR63x+B2SqwdYWsewuZdmfFPqHPfOWDr5Z7Cu45+ustZiseJhqS
         2U/A==
X-Gm-Message-State: AA+aEWbQhuIdZzbtxZlEBhNF5Z6QqFRgw8HC69/4sAWFUx3xt8vpkPe3
        LxUQeHIO2VUMlOxrrUIoZ3Bfs+T+ATnLgUKImZg=
X-Google-Smtp-Source: AFSGD/WbfSLKlQIlGUFPt5Me8Yd9oZKphDudRGUpqogHXDXJ/3tW4ZjKVsiGWP2qOTsvjThnfPT0WYG9uyBZJCqbkCg=
X-Received: by 2002:a50:9291:: with SMTP id k17mr20863951eda.243.1545286618433;
 Wed, 19 Dec 2018 22:16:58 -0800 (PST)
MIME-Version: 1.0
References: <20181219123657.61270-1-anup@brainfault.org>
In-Reply-To: <20181219123657.61270-1-anup@brainfault.org>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Thu, 20 Dec 2018 14:16:47 +0800
Message-ID: <CAEUhbmXNmzHVnzj88T5jxDXs=Rx_kD9fgayZ4r3xvgAOYXKWjw@mail.gmail.com>
Subject: Re: [PATCH v2] RISC-V: Make BSS section as the last section in vmlinux.lds.S
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 8:37 PM Anup Patel <anup@brainfault.org> wrote:
>
> The objcopy only emits loadable sections when creating flat kernel
> Image. To have minimal possible size of flat kernel Image, we should
> have all non-loadable sections after loadable sections.
>
> Currently, execption table section (loadable section) is after BSS
> section (non-loadable section) in the RISC-V vmlinux.lds.S. This
> is not optimal for having minimal flat kernel Image size hence this
> patch makes BSS section as the last section in RISC-V vmlinux.lds.S.
>
> In addition, we make BSS section aligned to 16byte instead of PAGE
> aligned which further reduces flat kernel Image size by few KBs.
>
> The flat kernel Image size of Linux-4.20-rc4 using GCC 8.2.0 is
> 8819980 bytes with current RISC-V vmlinux.lds.S and it reduces to
> 7991740 bytes with this patch applied. In summary, this patch reduces
> Linux-4.20-rc4 flat kernel Image size by 809 KB.
>
> Signed-off-by: Anup Patel <anup@brainfault.org>
> ---
>
> Changes since v1:
>  - Introduce MAX_BYTES_PER_LONG define and use it in-place of
>    0x10 magic value
>
>  arch/riscv/kernel/vmlinux.lds.S | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
