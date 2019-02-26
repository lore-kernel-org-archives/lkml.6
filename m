Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20670C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D453E2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 20:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAEjpb/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbfBZU7i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 15:59:38 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41414 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfBZU7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 15:59:37 -0500
Received: by mail-ua1-f67.google.com with SMTP id z24so13206853ual.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 12:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oMHmMyFY0Tm3ivCeDY+fwoqoTcoDOh1xYLe9r4UFL1I=;
        b=MAEjpb/PC7qUdEBW9crF37FsrEb7Ip60ffA7gSgl34NpimvBYe1s5km6apf35tFiua
         RxmXSxpU5p0GP+5KpYvay8Uv549Ana7pImqAucZ1xnY1YscBpkLBz+OWpwZmT9ch6va7
         DOVAC1NFvvUn6PyiSXmpwA5GRH6NTpWAxZNech2NsbAhVI5SE45mytIheE6fe5k7D1y2
         y3D6Pk4ClbAmqU3K8B4v5Aqxesavi20jELh5l+pDPD3/vyxh00RmuuEuBRZ8Ecv4R1GL
         XzvdVLXGTjktmkg46K/PK4BdR5pQRF+xM+zIePG0ei3SHojMvLD6PKcjTz1YZnsQe/SZ
         8NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oMHmMyFY0Tm3ivCeDY+fwoqoTcoDOh1xYLe9r4UFL1I=;
        b=azsu2rYcu5Esbkoc4MA6sji88uT2PG4EAgVfvn+kgkM1u1mzFp5SvhQSApMWR5IHjr
         S//3WDJMOawzhDCqZWkMxCbC7rx5+kI8O4Slq0F6FuiVKIK/3gIfa+mKKuDEC7+NGg5C
         JZCzMD2UrrXrNlrhtuFZeiCI2zxBQKekAixyeF6F9C8iMCTzhqsZLOjS6ast2aJLeJoB
         yp1akUUhD/qi4MvpmgGF6ryg+O57AMV7J2Pu+7JsZiiVDlfpIrL1BZFFCSMpjYd5Rx12
         vT9L3vK4j6JD3zvKXvvfpiRCqssHq6k0fMmEK1M99ICDojhRSwZTEqhglAbP+QFY1ASK
         QDIQ==
X-Gm-Message-State: AHQUAuYK6VCW00JPuhrYzZ3FNftSyoobGWY3jXbUtMV7jX13/7/vUndx
        eXpob4gpzx6LxDHVpcCNz7EcP6z/aMhsAT1qv+Q=
X-Google-Smtp-Source: AHgI3IYOjiVUyfS/1rqR+CdSOz9+1d0hLy/net29+bp/pyaMH4on7hfkXq1gKEaKoYCbBT0DtcmPunNKLSyXf7MF9Jg=
X-Received: by 2002:a67:ea18:: with SMTP id g24mr4909979vso.228.1551214776816;
 Tue, 26 Feb 2019 12:59:36 -0800 (PST)
MIME-Version: 1.0
References: <75aefec9-9906-60e9-2e67-8c60e7f4d970@infradead.org>
In-Reply-To: <75aefec9-9906-60e9-2e67-8c60e7f4d970@infradead.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Tue, 26 Feb 2019 22:59:11 +0200
Message-ID: <CAFCwf12b_mR7yCgv7j9s87dLsDLD4cshLj84mdHJH-TNRQPu4w@mail.gmail.com>
Subject: Re: [PATCH -next] misc/habanalabs: adjust Kconfig to fix build errors
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 6:42 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Several places in the habanalabs driver use gen_alloc functions,
> so select GENERIC_ALLOCATOR to make those functions available.
>
> Fixes these build errors:
>
> ERROR: "gen_pool_alloc" [drivers/misc/habanalabs/habanalabs.ko] undefined!
> ERROR: "gen_pool_add_virt" [drivers/misc/habanalabs/habanalabs.ko] undefined!
> ERROR: "gen_pool_destroy" [drivers/misc/habanalabs/habanalabs.ko] undefined!
> ERROR: "gen_pool_create" [drivers/misc/habanalabs/habanalabs.ko] undefined!
> ERROR: "gen_pool_free" [drivers/misc/habanalabs/habanalabs.ko] undefined!
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Oded Gabbay <oded.gabbay@gmail.com>
> ---
>  drivers/misc/habanalabs/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> --- linux-next-20190226.orig/drivers/misc/habanalabs/Kconfig
> +++ linux-next-20190226/drivers/misc/habanalabs/Kconfig
> @@ -6,6 +6,7 @@ config HABANA_AI
>         tristate "HabanaAI accelerators (habanalabs)"
>         depends on PCI
>         select FRAME_VECTOR
> +       select GENERIC_ALLOCATOR
>         help
>           Enables PCIe card driver for Habana's AI Processors (AIP) that are
>           designed to accelerate Deep Learning inference and training workloads.
>
>

Thanks for catching that.
This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
