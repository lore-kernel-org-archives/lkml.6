Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046F5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7E920659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bE4ZQvxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfANIEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:04:12 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40820 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfANIEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:04:11 -0500
Received: by mail-lj1-f195.google.com with SMTP id n18-v6so18135514lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 00:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LyJAFTjH0Gh6YiemiSF/u5wGWpjb8cwC5yZocT1TfSk=;
        b=bE4ZQvxTlwAcR9YmyQ+rkaPSJnEfhZaC7KIARXbt2QpaHQwlEOBOdJpRaCPY96gyOA
         P/88zANxvcUl9nz6CPxe3dCUMzVNb1Q6sBGQCNwaA+dy5DwXYQ4drIP4huhtjlwRRba0
         1MmxrnG5lNBKdF36KfCRzb/NUd//SsnyKHle+q14HAkQNo/G3q84O6JqeyZ1T1ahUV0x
         KIAlZ4O0lps69Hpn7x6bhe4YEXNXFy97cawBi5F3X0zFEQHL5fLLp6PsCaQn2iREhojm
         8Ny7+6wcUN6NUGxnEgI4R20WVjLKjrXSbMvjpjv7DzWElwwrtt/aXsEupj1SQb7ggDIs
         x1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LyJAFTjH0Gh6YiemiSF/u5wGWpjb8cwC5yZocT1TfSk=;
        b=bIv9p7AORzsrm7rQYrsuEEPvogdhEQxkWFVgKSIuBsxcuNqbVN8d6Ldgm8wKuH3B+3
         nb6YhvDqhfAfTPx/5CHCrCodVOBg8qlwrUA/oZ+0NjB7hqmb3+RP5IYvxWL0y6stIthI
         1JrhUbwRKO5dN+Cv7eQz4Uw4GybeC7DlsFDLtQBctyS6WXUs4nOYpLUOa6VoD+JW/qY7
         DmgDY8YlZlKUBAMiQTB0Rp8mAb5vuupJ8U+ackIvGhux3rpv2Y4rdbiZhtRhMxQ8ocQY
         k8gK+YzB5lvstk0FHEnB0894vfpNxgVv3HhrRIEAQym4VhqhXkA6wxnsnfu6qYk6sQWA
         0BXw==
X-Gm-Message-State: AJcUukdcXUkUMQpcZ7vFy97tMzhVG80k+CYm/HnpcFDsZyx8Cuiuinx9
        7uznSNu6lnPdlNepQUdrSE1L6eJVdFmL/L/zYfM=
X-Google-Smtp-Source: ALg8bN7RhK2jKa/FnvS5qDgCx/gnUjGThIllmZu0lOwYZf52Kv3Wy2cRa/cRQCeNdl0FE5kgSoQPsucfgtUCsoIw4BA=
X-Received: by 2002:a2e:9181:: with SMTP id f1-v6mr2633365ljg.64.1547453049606;
 Mon, 14 Jan 2019 00:04:09 -0800 (PST)
MIME-Version: 1.0
References: <5c383af0.1c69fb81.c393d.125c@mx.google.com>
In-Reply-To: <5c383af0.1c69fb81.c393d.125c@mx.google.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 14 Jan 2019 13:33:57 +0530
Message-ID: <CAFqt6zZnc_XauKefVavwana2cMLF4arEkiqjmfd25h-MWfsuJw@mail.gmail.com>
Subject: Re: [PATCH] fs/cachefiles/namei.c: Remove duplicate header
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 12:12 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Remove linux/xattr.h which is included more than once
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  fs/cachefiles/namei.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index 95983c7..edecb7f 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -20,7 +20,6 @@
>  #include <linux/namei.h>
>  #include <linux/security.h>
>  #include <linux/slab.h>
> -#include <linux/xattr.h>
>  #include "internal.h"
>
>  #define CACHEFILES_KEYBUF_SIZE 512
> --
> 2.7.4
>
