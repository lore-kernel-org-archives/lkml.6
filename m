Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6E0C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0BD20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 15:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWp4paCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfAQPwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:52:21 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38774 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfAQPwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 10:52:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id c19-v6so8995902lja.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 07:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sqsld4V4XR2vKyhxivJg3LLQvTYEDVLRRpb/TGR1BD0=;
        b=VWp4paCyZBEp/e4r1LY7eYvuAsD5OG/00vlQydLs//A/sVAQo7zN1FttelIxRcNwCN
         79KMcIkWPaeqmx46a28juubuT7zIWxrLNA9fVpOZJPzA6EJUzxThhZTlfkQgfwFf614M
         9afpTmMlTtNt/ab/0YQJbq4IPG2kLcCB8pAXXXMDyiEDzjrzX/hIRPISBIaEyTx/qAUv
         n9He5wQLBg7TIjQKBSt9Nrh1zzFYdE37pRDxhCkqXLvtO8aEB6V3yVNRkHnYFBN4QByu
         gjp5xsvQNj5ekg8hFXS3+EtWgEwVoq2YTONXvvysafd8jiky6Sx+MbB/uJiwvO81izQm
         irrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sqsld4V4XR2vKyhxivJg3LLQvTYEDVLRRpb/TGR1BD0=;
        b=qR/SPCGZVV6O/tPq9vuStNmdT2GVvaE79vzHWRHSjFT+SCKPYvlso1xcNwTxzVzE9M
         mCzDwqNg8nfnvaUo+YcAv1I9Yyc4dkegVxLZthvyFoOjjDJLvriI83gh3g1j9x8Vfid2
         7Q4XedkBxWtqSVD69cAqglryaCWw1EytQwiA6Kga3ykBJG9eE8BEH+J9RrHD3CiwZIMG
         8AEmmsALTwXEx3FxAxvnPmEyRnXZpBleWVKIxuYNo2k/fIqYZ0wDvDjZngN1SWuIcz9l
         2KJ0C7DgoWob9hXD7mu9duGJpOMbe4n0FDhxBCHpc6nHF6O80bYCINzpzAXgsNlcH3xf
         tJgg==
X-Gm-Message-State: AJcUukflK3hXykO24On99njG1A/Kaki+d6IgUD0x34A9rqwzbSkf+r0s
        7+0ptMThYyJNPh3aGJbUJbS0//ZkPf2NiRJWZ6w=
X-Google-Smtp-Source: ALg8bN6vbUvpEe0QRJNZpcOUdSliUuC39A/88BlWrz67PxmLUE/EnKHsGmPvZ7h4IRJY48mEOLTJasIbOTG7+1piI3M=
X-Received: by 2002:a2e:630a:: with SMTP id x10-v6mr9663484ljb.11.1547740338630;
 Thu, 17 Jan 2019 07:52:18 -0800 (PST)
MIME-Version: 1.0
References: <20190117143004.GA2916@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20190117143004.GA2916@hp-pavilion-15-notebook-pc-brajeswar>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 17 Jan 2019 21:22:06 +0530
Message-ID: <CAFqt6zaB7RUfORRpdVO_-FRg-Mc8SVBttm76J2MLpaR3AvD=QA@mail.gmail.com>
Subject: Re: [PATCH] csky/kernel/entry: Remove duplicate heade
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     ren_guo@c-sky.com, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 8:00 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove duplicate headers which are included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  arch/csky/kernel/entry.S | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
> index 79f92b8606c8..f2081ddcc398 100644
> --- a/arch/csky/kernel/entry.S
> +++ b/arch/csky/kernel/entry.S
> @@ -9,7 +9,6 @@
>  #include <asm/unistd.h>
>  #include <asm/asm-offsets.h>
>  #include <linux/threads.h>
> -#include <asm/setup.h>
>  #include <asm/page.h>
>  #include <asm/thread_info.h>
>
> --
> 2.17.1
>
