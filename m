Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C2CC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D342080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="gU7Jiyzj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D342080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=umn.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbeJ3F0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 01:26:52 -0400
Received: from mta-p2.oit.umn.edu ([134.84.196.202]:59368 "EHLO
        mta-p2.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbeJ3F0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 01:26:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by mta-p2.oit.umn.edu (Postfix) with ESMTP id 1B21B238;
        Mon, 29 Oct 2018 20:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umn.edu; h=
        content-type:content-type:subject:subject:message-id:date:date
        :from:from:in-reply-to:references:mime-version:received:received
        :received; s=20160920; t=1540845391; x=1542659792; bh=Kt4ncB21bL
        rvWMclY2gefgrpEzuKWPMDRq9XkJg9+KY=; b=gU7Jiyzj+h/0OUCUSL8TE8YShH
        t4/IQ88kpkTLxyEJPrukJchpFx57mLrBwBHnEo9f8MKfxGV3FWRT8GLtZPoVh9dL
        8bjktSRxlwRDCD0QEB1+hsCQArqcCD3ywn9UzTLOgUc2ST1oR0yiKcPnwTXVXXxT
        gd+LAEAuzHRYDBYxMgcYRPsQ5vh2G5KeBSsStJHZ1+Q0ukq90hUQtvd0Y+ErlzdI
        jZCA6NMPEBXCmwfetv5TVSaEhr2i0wy6SACQPE0FSYp4HoOVgaH39O0st94h4P1i
        8NYoaKXR0l70HIpXL3fQ6RwKyzOMEoXyE6Uy7iR6rk3PQjB7ScCf+ggq6Lgw==
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p2.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p2.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rnxK6bgqXlt9; Mon, 29 Oct 2018 15:36:31 -0500 (CDT)
Received: from mail-it1-f170.google.com (mail-it1-f170.google.com [209.85.166.170])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wang6495)
        by mta-p2.oit.umn.edu (Postfix) with ESMTPSA id E55A711F;
        Mon, 29 Oct 2018 15:36:31 -0500 (CDT)
Received: by mail-it1-f170.google.com with SMTP id t4-v6so2832597itf.1;
        Mon, 29 Oct 2018 13:36:31 -0700 (PDT)
X-Gm-Message-State: AGRZ1gIQFw1HEC7tEg3sKmB2WEo3Of1carjLIIKlzVvMQ7G9BeyQvDA9
        v9P3Ta8EUrTQvt++luR6ayyVeI7Oqsu1LEJzRU4=
X-Google-Smtp-Source: AJdET5fL+ScnNI1TL/MYY25tk1v8r7NsnhC1awruM9FIdRJa9O01B8KgMfS6zWY7qZkninKaICv1dt+XGoeD4Gtkn1o=
X-Received: by 2002:a02:142:: with SMTP id c63-v6mr11555418jad.32.1540845391708;
 Mon, 29 Oct 2018 13:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <1538668833-18372-1-git-send-email-wang6495@umn.edu>
In-Reply-To: <1538668833-18372-1-git-send-email-wang6495@umn.edu>
From:   Wenwen Wang <wang6495@umn.edu>
Date:   Mon, 29 Oct 2018 15:35:54 -0500
X-Gmail-Original-Message-ID: <CAAa=b7c6uYQARV80wxWHysHG0otD+8ZQfmq0Q2FMumUKi7BuRg@mail.gmail.com>
Message-ID: <CAAa=b7c6uYQARV80wxWHysHG0otD+8ZQfmq0Q2FMumUKi7BuRg@mail.gmail.com>
Subject: Re: [PATCH] media: davinci_vpfe: fix a NULL pointer dereference bug
To:     Wenwen Wang <wang6495@umn.edu>
Cc:     Kangjie Lu <kjlu@umn.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:STAGING - ATOMISP DRIVER" <linux-media@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Can anyone please confirm this bug and apply the patch? Thanks!

Wenwen

On Thu, Oct 4, 2018 at 11:00 AM Wenwen Wang <wang6495@umn.edu> wrote:
>
> In vpfe_isif_init(), there is a while loop to get the ISIF base address and
> linearization table0 and table1 address. In the loop body, the function
> platform_get_resource() is called to get the resource. If
> platform_get_resource() returns NULL, the loop is terminated and the
> execution goes to 'fail_nobase_res'. Suppose the loop is terminated at the
> first iteration because platform_get_resource() returns NULL and the
> execution goes to 'fail_nobase_res'. Given that there is another while loop
> at 'fail_nobase_res' and i equals to 0, one iteration of the second while
> loop will be executed. However, the second while loop does not check the
> return value of platform_get_resource(). This can cause a NULL pointer
> dereference bug if the return value is a NULL pointer.
>
> This patch avoids the above issue by adding a check in the second while
> loop after the call to platform_get_resource().
>
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/staging/media/davinci_vpfe/dm365_isif.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/media/davinci_vpfe/dm365_isif.c b/drivers/staging/media/davinci_vpfe/dm365_isif.c
> index 745e33f..b0425a6 100644
> --- a/drivers/staging/media/davinci_vpfe/dm365_isif.c
> +++ b/drivers/staging/media/davinci_vpfe/dm365_isif.c
> @@ -2080,7 +2080,8 @@ int vpfe_isif_init(struct vpfe_isif_device *isif, struct platform_device *pdev)
>
>         while (i >= 0) {
>                 res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> -               release_mem_region(res->start, res_len);
> +               if (res)
> +                       release_mem_region(res->start, res_len);
>                 i--;
>         }
>         return status;
> --
> 2.7.4
>
