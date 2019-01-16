Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FFFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA5AC20859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qabd+m9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392792AbfAPMbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:31:40 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36854 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390199AbfAPMbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:31:39 -0500
Received: by mail-lf1-f68.google.com with SMTP id a16so4741357lfg.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 04:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ok8cupwBDGGgfQcEKBeR0Iw0HERb6oBP5uNh5QaougQ=;
        b=qabd+m9bvuK7Y4la3dlRbmQOdhf/evPctJzTXZ+/Ajsx7kP/Nxve6b189ISRI6KKvK
         bwlm2QPJhuP5oM1C/SG/GuvgekA1/7r3rwneuJuriDtb3nJg6oiB2Ex2M5eKGyEYsAxD
         mL4pYBam0FGliV1qGQHbtMDwGbf/zhCHTBvi67sQWGmd9awdFqcAGe9ryVfZulQxNT/c
         CTosiE1p8vzfFpgizyLTAk0YMplSPO+B3TfbSm6TfbrMpY7fcjZ1aOfxr33tBa8fjxSx
         RhMpp6h6GHJihH2kEksCS1Vvi4mjNbduBMwcd9NQRqKsR+hXtdlNwWPh5dyrVl1//qO+
         BZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ok8cupwBDGGgfQcEKBeR0Iw0HERb6oBP5uNh5QaougQ=;
        b=Dq8YlzbIhwet1XZKkkGnQpgHnYC1JhMka85fMH6d5qjfLE+AejFs6/CzM6UTYGOR07
         eT3FxAnoFkQ9T2PUW0F9nDik5rj425Z4t3uJqiN6gJr4Z7+T8QyS7du8lapFGFPuzc39
         X2QbEd+Ufv0OuPo81kXW9XppkXHLt4ZpJ7qZ9qUmreWMQ40CPaYa3x2tOR56RAvjmSwh
         uKpaxYRPQUyMmXFB8uQtx6IbSuEXYYkx/r8Wo4xdQd+H4MflJHAdjwMDFzTzGBvRVAx2
         uPvEYv/tLxyNXj94DOHfLm6ucXHJKTV6c1epy78BYUcBpFcVeIMCmWHw7d78iOPXQwRW
         KeEQ==
X-Gm-Message-State: AJcUukfWpMHQ+yXxMuAlJB+uIswz+edVKobgs5cF1JzWTaQpoWwDFaJV
        iQVa9gFCmILCNxrLJT2w1yKzMbD7AJQ3qx5JlXiJEA==
X-Google-Smtp-Source: ALg8bN5JTjX42ux0ZsHZFeZHSN7Bglm/d5HO5yz/AtR+QM5vNSEldiErnGJMkaKq2+xmstEMAen4FyxoxSlkKbSSciI=
X-Received: by 2002:a19:c396:: with SMTP id t144mr6575207lff.110.1547641896857;
 Wed, 16 Jan 2019 04:31:36 -0800 (PST)
MIME-Version: 1.0
References: <20190107171908.GA5246@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190107171908.GA5246@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 16 Jan 2019 18:01:24 +0530
Message-ID: <CAFqt6zZfTTW+MnRbxQf3F8qZE=MRstcxzrbYeq_YKOtam1F2Tg@mail.gmail.com>
Subject: Re: [PATCH] arm/mach-sa1100/simpad.c: Remove duplicate header
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        mchehab+samsung@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>, wsa@the-dreams.de
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 10:45 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Remove linux/gpio/machine.h which is included more than once.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any comment for this patch ?

> ---
>  arch/arm/mach-sa1100/simpad.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/mach-sa1100/simpad.c b/arch/arm/mach-sa1100/simpad.c
> index 406487e..c7fb9a7 100644
> --- a/arch/arm/mach-sa1100/simpad.c
> +++ b/arch/arm/mach-sa1100/simpad.c
> @@ -18,7 +18,6 @@
>  #include <linux/mtd/partitions.h>
>  #include <linux/io.h>
>  #include <linux/gpio/driver.h>
> -#include <linux/gpio/machine.h>
>
>  #include <mach/hardware.h>
>  #include <asm/setup.h>
> --
> 1.9.1
>
