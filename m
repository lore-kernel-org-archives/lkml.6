Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45422C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DFB25C80
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 10:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DFB25C80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030336AbeGBKfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 06:35:19 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44728 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965467AbeGBKfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 06:35:17 -0400
Received: by mail-oi0-f66.google.com with SMTP id s198-v6so11568761oih.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 03:35:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=evua5Z4l3ryXBHcNwSdemEPnzM2540/rq3smKiWoMek=;
        b=kgNSDX2oAhPQ25OlEn/E0xDCc9AbKXqw/mxfthjWdO4HUrEjLG7uDz7wBwdQ/zFLeS
         0V7l+eCoYEkGPgP3faeCwV30/tatGiDy9uFKI+Kbm8YtEFzwAMTdnH/LDeA8BzyltIVQ
         MOd8fcam6LJpx4ROxLj3pzhqM6JycttK05iCoC6MqkJtUFeFW07Pv9LqV3rLdXhdy1f7
         x5qe7TgYl2YqYmYmjpHfNCxORJVpyag6m+HywfBnriy/04DFxObOqVRAOFWr5XNCO/JE
         BcFKLwc7PvGOq9c5s/59pQ28TDVhiI/E5vydFDYgDHZXwY04/pV13K+dR/R1Ip8aj1S0
         8GzA==
X-Gm-Message-State: APt69E33xibHaAFwqC/TJe/C6VU2LsDbwhyNP1XOHkNExkd6gpkrinwt
        o/6S9NKR6Ts6JasOV46xwq9a2OfsDFxPxXtA1uA=
X-Google-Smtp-Source: AAOMgpcvez7lPxIAJPJRaGls0Ad/Dwf49J246IZ6ArJljXs9deD9It7WYR5FzSHGL9TxTqTbB/bA5xQX3Dp9HQkS69k=
X-Received: by 2002:aca:45d5:: with SMTP id s204-v6mr14312197oia.289.1530527716897;
 Mon, 02 Jul 2018 03:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1530519301.git.fthain@telegraphics.com.au> <720e9899186bed184fb9b5cce070e2dc519f9665.1530519301.git.fthain@telegraphics.com.au>
In-Reply-To: <720e9899186bed184fb9b5cce070e2dc519f9665.1530519301.git.fthain@telegraphics.com.au>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Mon, 2 Jul 2018 12:35:04 +0200
Message-ID: <CA+7wUsyfkC3FvbFyt9JRdBas3s+52tp7OH8h2jiJM9z+ynoyyw@mail.gmail.com>
Subject: Re: [PATCH v4 01/11] macintosh/via-pmu: Fix section mismatch warning
To:     fthain@telegraphics.com.au
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 10:25 AM Finn Thain <fthain@telegraphics.com.au> wrote:
>
> The pmu_init() function has the __init qualifier, but the ops struct
> that holds a pointer to it does not. This causes a build warning.
> The driver works fine because the pointer is only dereferenced early.
>
> The function is so small that there's negligible benefit from using
> the __init qualifier. Remove it to fix the warning, consistent with
> the other ADB drivers.

Would you mind copy/pasting the warning you are seeing.

Make sure you have:

58935176ad17 powerpc/via-pmu: Fix section mismatch warning

Thanks

> Tested-by: Stan Johnson <userm57@yahoo.com>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/macintosh/via-pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
> index 25c1ce811053..f8a2c917201f 100644
> --- a/drivers/macintosh/via-pmu.c
> +++ b/drivers/macintosh/via-pmu.c
> @@ -378,7 +378,7 @@ static int pmu_probe(void)
>         return vias == NULL? -ENODEV: 0;
>  }
>
> -static int __init pmu_init(void)
> +static int pmu_init(void)
>  {
>         if (vias == NULL)
>                 return -ENODEV;
> --
> 2.16.4
>
