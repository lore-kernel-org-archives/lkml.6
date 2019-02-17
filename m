Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28834C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CC021855
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550439394;
	bh=7k5xWKw5uPb1C40u79ARJL+v806fz87+uiNytPCChDU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wv8uBDoa9raYoq0Fwdg3jbWvdtLCVkViKWfjO4zA0Hd6tqliYl/gfMy2LcB80p4za
	 Ydzk8tUJoYUMBsehxUFJ4V/+eMAaQBjYsHlaqquRv5J1HyLkGq0rF7s2lYmz3k3a7J
	 vnkFtbJC8kTMNuX0nOIxrCKHfepVnfY5vgbuJ7l8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfBQVgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 16:36:32 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36926 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfBQVgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 16:36:32 -0500
Received: by mail-ot1-f68.google.com with SMTP id b3so25154645otp.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 13:36:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2XGiLemBzCutdHAXWWgcJ6ut+S1aa8QmHoKiTqNeBY=;
        b=WUu6lbgTEqIaucdyItURr2T3eKDyV/RKQeYvBby35IyrSxPEPnJclHrfnrtnfppRDU
         sG0ovIRFctHeQp/Wd5wAXHB8tNZbZful4z+s/Z6XTY2XPZMkRCNdiSqybVs4ybc5GkYG
         11TN/AicqOESuKmYR7foyRV7KRCxwiXpNEe4ONQEEQSVAfUKQs3JVik8pfu0sgomRkqb
         zVPE1sWYCXJolDYwsua5N6+Ag8VmfpPygdDhPfsFX5iqxox7ZMTuS2AmC2Hk2WjzkK50
         3dhwJq8LiMLEe7g9PU3W0HEylV8l1y0K5cmev8bIBoMv3yRYeVmssNNuDEiHwj+dDUoq
         elyA==
X-Gm-Message-State: AHQUAuYVnNkHYFtc4fL51d0w4BWWjWbnmmNuHHMlFqQCbWqaacZDzHOO
        BxnxGk4c11P6FHyk6GHXQWSlIDUR8x5AMx81Y9hImhbr
X-Google-Smtp-Source: AHgI3IapuMAExCGuinRW+vKhIAEWQF7TRYe14CauVWO/8LvKajR8TvBuuRt64JxUQWXlSt5FahMnNLbr9Pv1Li3pFp4=
X-Received: by 2002:a9d:5a0b:: with SMTP id v11mr11617078oth.124.1550439390219;
 Sun, 17 Feb 2019 13:36:30 -0800 (PST)
MIME-Version: 1.0
References: <20190216164512.9525-1-mans@mansr.com>
In-Reply-To: <20190216164512.9525-1-mans@mansr.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 17 Feb 2019 22:36:19 +0100
Message-ID: <CAJZ5v0iZHfU=mE3JGcKqbswGGert7CvpKPkVE1s+-X1zXKJiEw@mail.gmail.com>
Subject: Re: [PATCH] platform: set of_node in platform_device_register_full()
To:     Mans Rullgard <mans@mansr.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 5:50 PM Mans Rullgard <mans@mansr.com> wrote:
>
> If the provided fwnode is an OF node, set dev.of_node as well.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  drivers/base/platform.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index dff82a3c2caa..853a1d0e5845 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -512,6 +512,7 @@ struct platform_device *platform_device_register_full(
>
>         pdev->dev.parent = pdevinfo->parent;
>         pdev->dev.fwnode = pdevinfo->fwnode;
> +       pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));

of_node_get() generally does a kobject_get() on the node's kobject, so
when is that reference dropped?  Or if it doesn't need to be dropped
at all, why is this the case?

>
>         if (pdevinfo->dma_mask) {
>                 /*
> --
> 2.20.1
>
