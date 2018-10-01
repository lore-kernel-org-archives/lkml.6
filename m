Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8B5C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F8C206B2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 23:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o2WEEA/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F8C206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbeJBFqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 01:46:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37417 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeJBFqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 01:46:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so38451pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 16:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bEv24gKt83wjXyr2zMNSS0g5cr0nXmzk7ZrXPslOopQ=;
        b=o2WEEA/yVXqOLPdiFP8hIFxABCYDZOvVaB7ADjHfze5OOTlNJolJ78aFVRvcd7L9pg
         5JGzmv6agB51UzehnY39+5Y+LD95FnsXu/ZgYoWGzesh51e0IiBeD7quzNvEy/WB7qwQ
         axe6RLP8Yd9RnSh2BrONRFfkhk7GLrsdFqFyQLPLvyPUggo3w6DqZVlreDqYcAMNDZFf
         15k5TwDeH2uVZ7zNCvrFhP2KxfHSCOxGo8jtigOL+AsIrVteb5+b+na9HwIEMBHIucSa
         VfrJBWOIntM1WN0RTpoz+Uq7aXL6pOBxFxatcWs/KN71wFNIuRJ69LIdkk0FKglpzRAu
         f2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bEv24gKt83wjXyr2zMNSS0g5cr0nXmzk7ZrXPslOopQ=;
        b=PXmOEmQBsQCQlO0AhFo7TUvzwqHj9dQwigGFtrtENqrp5ri9SXDhomzuSrDZE0oGXN
         Ogaiy+7CFJ5yAX9tGrdQB6i7/jkq544R4uKyJPk1uCBWlLzMDvt4sXT7cH9PYIy2NUvY
         XkOCwnivh6uEvVR792KoNhnsO82GNMcDsMrXXPcgQAkIHdqCwbU7/9XrF8NiICZAe/FH
         /4I83zeAaSEwCjD5ZnnJt5vyk77UbYTzVnrOukhSLIeNInP/ppAcTvgevom+wDneAncP
         4YgI23ibLzE7fAQ19eSNI6DJm9vRkUsJ6Xtnf0VYLzgkNGyBlzdxXR6xv4e6/q8pt82b
         6JsQ==
X-Gm-Message-State: ABuFfoiAuSZ2SVUkzSK/xjG17PgYPJ9e3cAtqSYkIUyCwfh+bA3L9fXc
        DDhiUT6N4cdSsG4UDA2XCow9dAoGJPPpPj/tDUyc4g==
X-Google-Smtp-Source: ACcGV639gC2HFtfUVuVoSP1/P1oXEFnQzmUaZ9pmv6f1uEqk5XDEjc3nT9oLVrU3IQWlsnIIf3/1B4i/PeCHE/FYl/U=
X-Received: by 2002:a62:4b09:: with SMTP id y9-v6mr6878961pfa.93.1538435168373;
 Mon, 01 Oct 2018 16:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180921195736.7977-1-natechancellor@gmail.com> <20181001152110.20780-1-natechancellor@gmail.com>
In-Reply-To: <20181001152110.20780-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 1 Oct 2018 16:05:57 -0700
Message-ID: <CAKwvOdk6Z2und-7U6SVHqKxiEk6Ahpuc8_=O7Os5axx43itp5Q@mail.gmail.com>
Subject: Re: [PATCH v2] media: cx18: Don't check for address of video_dev
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     awalls@md.metrocast.net,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        hverkuil@xs4all.nl, linux-media@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 8:22 AM Nathan Chancellor
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
> Check whether v4l2_dev is null, not the address, so that the statement
> doesn't fire all the time. This check has been present since 2009,
> introduced by commit 21a278b85d3c ("V4L/DVB (11619): cx18: Simplify the
> work handler for outgoing mailbox commands")
>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:
>
> * Fix build error and logic per review from Hans
>
>  drivers/media/pci/cx18/cx18-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/media/pci/cx18/cx18-driver.c b/drivers/media/pci/cx18/cx18-driver.c
> index 56763c4ea1a7..a6ba4ca5aa91 100644
> --- a/drivers/media/pci/cx18/cx18-driver.c
> +++ b/drivers/media/pci/cx18/cx18-driver.c
> @@ -1252,7 +1252,7 @@ static void cx18_cancel_out_work_orders(struct cx18 *cx)
>  {
>         int i;
>         for (i = 0; i < CX18_MAX_STREAMS; i++)
> -               if (&cx->streams[i].video_dev)
> +               if (cx->streams[i].video_dev.v4l2_dev)

There we go, that looks better!  Thanks for respinning this patch.  I
would've given Hans credit in a Suggested-by tag, but there's not
necessarily strict rules on that (and doesn't necessitate a v3).
Maybe the maintainer could apply that to the commit message when
applying?  Either way:

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>                         cancel_work_sync(&cx->streams[i].out_work_order);
>  }
>
> --
> 2.19.0
>


-- 
Thanks,
~Nick Desaulniers
