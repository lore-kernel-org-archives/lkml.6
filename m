Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39F9ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F50121522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MjM8zYft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F50121522
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391455AbeIVCWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:22:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41222 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391279AbeIVCWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:22:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id b12-v6so6433625plr.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 13:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rlfmL3v4zMM0JptUg6QODZyirUCL2nG0gpoHsyY18fU=;
        b=MjM8zYft4xvhoRxeavD1fRDEcj80rug6ZCTEViX8wtdUzHL2Y54165l2lnCSO0ile2
         6FsuhmMxNHCG/5O2BlEIAj4zYEBM8Oak2UWt9WYHfrBYQwUXcyqRV5WSUsOYJVQUCWEt
         V8qK28spJWSZpt8vqnb54rliDbT0DaAuCFoNb5Y8sXmZJ7RveSffofeC524YGTOeg30+
         pWBcIJbtyoIBbVkHvA6TolUIoA5ZyDib7A+WmEc/1qHJjhkWRyjFEL8MXnWGl677TKBv
         mMGP5jbs4iwiTWz0e34RBEPROhbyOoUVFdQkQ1F+6BwKtnHSl6AUiKjpq+VhXfMpZVUr
         SCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlfmL3v4zMM0JptUg6QODZyirUCL2nG0gpoHsyY18fU=;
        b=nvp3aZd7KkFSN9pFe+YzqIOV2UTvr2br1YQiLSOeFFnmjum2xv7lh3T2AF5PwSpAKD
         m3arWUPUH16WNYZ6zdLujxK7ATIa+oarDCGfJH5fsYHoAfIBAodHRFg0LnT9rWZodYuW
         ifyaZBA453gmJuLhmkTd7V2fl1n6lPdRppqdOlC676ECkPOmCe3uv3TywS3OCg3o4Pj5
         CpswjZ4MeY8ZQf4eK9xpSLd/tuj4KweDm3AGUkFXBTfQcRwS0JzMM8iaCFfBMVBWPQ7/
         OcNdzgH+rWHkBVEKC2nVHOknW7wvoT+evkzjfiv6LCj8rY6Fce+u9dXmzHtyZQbBKlgL
         AWSg==
X-Gm-Message-State: APzg51ClQyCHpcF7h1x2bZGp4/c8HiD2aSta6BCz0vYn8YNKd96TjPi4
        9qudXOjS5WyS93Hv9vpee3y9W3Iszh2xRFOrtdcKFQ==
X-Google-Smtp-Source: ANB0VdZQy9axGHJIaNVd0dyPmHG+g5VSrhk1JUOQi9lCtGnF2dbkRWv16JS5qzr0TJ8YlTjkVESrqpWZgTP2K103zUA=
X-Received: by 2002:a17:902:561:: with SMTP id 88-v6mr45604959plf.320.1537561908726;
 Fri, 21 Sep 2018 13:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20180921195736.7977-1-natechancellor@gmail.com>
In-Reply-To: <20180921195736.7977-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Sep 2018 13:31:37 -0700
Message-ID: <CAKwvOdk-w04qavrzeOg_yCH6gYRE4UEX49TJBEb8wMjRssPDdQ@mail.gmail.com>
Subject: Re: [PATCH] media: cx18: Don't check for address of video_dev
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     awalls@md.metrocast.net,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 1:03 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns that the address of a pointer will always evaluated as true
> in a boolean context.
>
> drivers/media/pci/cx18/cx18-driver.c:1255:23: warning: address of
> 'cx->streams[i].video_dev' will always evaluate to 'true'
> [-Wpointer-bool-conversion]
>                 if (&cx->streams[i].video_dev)
>                 ~~   ~~~~~~~~~~~~~~~^~~~~~~~~
> 1 warning generated.
>
> Presumably, the contents of video_dev should have been checked, not the
> address. This check has been present since 2009, introduced by commit
> 21a278b85d3c ("V4L/DVB (11619): cx18: Simplify the work handler for
> outgoing mailbox commands")
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> Alternatively, this if statement could just be removed since it has
> evaluated to true since 2009 and I assume some issue with this would
> have been discovered by now.
>
>  drivers/media/pci/cx18/cx18-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
> index 56763c4ea1a7..753a37c7100a 100644
> --- a/drivers/media/pci/cx18/cx18-driver.c
> +++ b/drivers/media/pci/cx18/cx18-driver.c
> @@ -1252,7 +1252,7 @@ static void cx18_cancel_out_work_orders(struct cx18 *cx)
>  {
>         int i;
>         for (i = 0; i < CX18_MAX_STREAMS; i++)
> -               if (&cx->streams[i].video_dev)
> +               if (cx->streams[i].video_dev)

cx->streams[i].video_dev has the type `struct video_device video_dev`.
So wouldn't this change always be true as well, since the struct is
embedded?

>                         cancel_work_sync(&cx->streams[i].out_work_order);
>  }
>
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
