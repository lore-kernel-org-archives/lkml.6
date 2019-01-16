Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182CFC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E4B20657
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 12:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0Vs1x+p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390090AbfAPMQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 07:16:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40225 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389888AbfAPMQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 07:16:24 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18-v6so5245245lji.7;
        Wed, 16 Jan 2019 04:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KqdoAGlMOv/A8ZebMmDHKIrP9OI2g1HpmkWp2Nhk8do=;
        b=Z0Vs1x+poH11SJx2yZL+wTXWolBFfh9uTJjClxEKzJ9x8HbAKRdFaqDZonJv75Xoqk
         yBNmmk0aGQhAutAtMO0PE224p1Rl0oljPPfs9cvcj4jKoBDglheucHwHjF7yzfdLW8ND
         FRGKE5s72LTaDfiSvBjmnCm2BOOfQoTzT+HIrfLxP6j2njI0qgoBZtoE3QkKLM0hmhbO
         1SH1vq7e/MauV5qIVzLn6Of+5kIbGbxuUj55awzxIdFYZkbMUdAjx4PpiXq3hocm9yrF
         7qS4t4EaDNrERBzZnF0iMVq81IOmuoZJnZxKVtryfZD5o2l+4sgtgfp2DCHmqhUIVlOt
         S8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KqdoAGlMOv/A8ZebMmDHKIrP9OI2g1HpmkWp2Nhk8do=;
        b=YBV5Qh3kKUQzjK2DhgE96WEDz9QIayDoksvYuHNg3OfV0vVPkPlf7yEFAC/vte1+D9
         afUomDImOkahpqkO/bcek9EOZVQce9XlJxjkNbZyF9YqCSN9raidQn8kE24uVhUVGBI5
         ebYvpxmImCTVNulYpErgJStl0uoMfkLFP2iinxf4OzZ6UFdC4n3q1Np7RnMhYVYFEZVt
         PpcAcH+bxXp/R780Bj5ijaNHQOzJRS505YvYKq2XewrB/c5lNyvbVjNCv8K9lQKnlyaY
         iwHtis0eJVhzP/XcFoSnO+GWwMHNEJb3ItOkYLGWIEJiX3rJo22HDF+s72MG8JFRtruA
         o7hg==
X-Gm-Message-State: AJcUukdq5ujlLUo2tlU8eQFo7bG/dfHBrz3AYkzBwsSzXUl6MHoKXkFX
        6YdykGXsHhInZGwGV5zo/jOc7eyWs9BvxpFTL/E=
X-Google-Smtp-Source: ALg8bN5B65P2J+4dbtHnVi4iKuXHAaS7qoYoejHFxt6iXlO115ojlh+HwjIajE0bEdERWzh1Gcb6osPPANNheQn0uh8=
X-Received: by 2002:a2e:3012:: with SMTP id w18-v6mr6172500ljw.75.1547640981948;
 Wed, 16 Jan 2019 04:16:21 -0800 (PST)
MIME-Version: 1.0
References: <5c3763f1.1c69fb81.f2570.4457@mx.google.com>
In-Reply-To: <5c3763f1.1c69fb81.f2570.4457@mx.google.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 16 Jan 2019 17:46:10 +0530
Message-ID: <CAFqt6zawA928gHRtSiKbBC0QcXxZs3U-rZdDF1yyaLjdTHqgFQ@mail.gmail.com>
Subject: Re: [PATCH] fs/block_dev.c: Remove duplicate header
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 8:55 PM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> Remove linux/dax.h which is included more than once.
>
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  fs/block_dev.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/block_dev.c b/fs/block_dev.c
> index cdda48f..8abcdb6 100644
> --- a/fs/block_dev.c
> +++ b/fs/block_dev.c
> @@ -29,7 +29,6 @@
>  #include <linux/namei.h>
>  #include <linux/log2.h>
>  #include <linux/cleancache.h>
> -#include <linux/dax.h>
>  #include <linux/badblocks.h>
>  #include <linux/task_io_accounting_ops.h>
>  #include <linux/falloc.h>
> --
> 2.7.4
>
