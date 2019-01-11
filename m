Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1DD1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748142146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547199705;
	bh=7TGE3evPZLQePyLo3TSVKssHkb9tgorZJiv28AxUe1k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sUNQZBhZISjxO1wSZ3UheZ1Kh/eKcVByz7wk9M3xnrEIKn/SsOTQMksuUPepQk3pv
	 MS70OPeM1ki9mNckcLBhFSmKmkG1r8EJf7iiMh0ly8dHR8t2sTKA0IH9TkBQg2QrhY
	 mNWe3g1ivQUByxP4N9+qXdkJVvgJI48J3OU0jeuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbfAKJlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:41:44 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46970 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729792AbfAKJln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:41:43 -0500
Received: by mail-oi1-f196.google.com with SMTP id x202so11688631oif.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 01:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lq5kxItlnpnFbfKz4N5S5DXe16Fa09lPVZ+gHUIVQH4=;
        b=qLN0HEc/SR38h7wnPvU7nzRK4hD3dXA8+4fX9Hr6An1C0G/Z0FrMAY0020gRbpzbST
         yUwOV3Kj5dJQXpCW0xxic387fxfRDVWoMVFa062VzLTFxAlW6T/ThBR0+dUeliugRaDN
         w1n0gpGNv2cxxzxW4qQ9rCUA3z0FRk5RzZJXNLj0SEo7WJl1zHm/AZ9G8GKKrS5Oamit
         JkzGbH2G+hRWswcWheEHRnHuYWO7vYDAcpmI7gXHkVlDuK0cj2UVd907VKOipZxopLSh
         jr/ntrHb9eaPxVkpZHs9uv9VDGGpI77qpwQlk1TtGLwe0nsE8W6fwsBSUN0XNXGBZ/lI
         vQgQ==
X-Gm-Message-State: AJcUukfbapboeWszevYElZUjcbENQHr0CZEAaMKX7+1nrarMdQL5ncN4
        mwO4RvLmoWC9sBANpEY3IbB6pgwj9s4b8cCm+oPasw==
X-Google-Smtp-Source: ALg8bN7WN6InQu+GEgdjDknIBEwAQMOcMxBtRyBgo8GHQNnxyS0fIoCurmwPZLHW2hLaR++Vt2UPA44PmCBsqW2Jf5Q=
X-Received: by 2002:aca:6c8b:: with SMTP id h133mr8866617oic.33.1547199702255;
 Fri, 11 Jan 2019 01:41:42 -0800 (PST)
MIME-Version: 1.0
References: <20181221162341.9847-1-jbrunet@baylibre.com>
In-Reply-To: <20181221162341.9847-1-jbrunet@baylibre.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 11 Jan 2019 10:41:30 +0100
Message-ID: <CAJZ5v0jaGwxcLf81R0eeLmoaJbUpPr9g6OzN38hWPfyX4C_6Dw@mail.gmail.com>
Subject: Re: [PATCH] driver core: silence device link messages unless debugging
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 5:23 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On platforms making a fair use of regulators, the dev_info() messages
> coming from the device link function are a bit too verbose. The amount
> of message will increase further with the clock framework joining the
> device link party.
>
> These messages looks valuable for people debugging device link related
> issues, so dev_dbg() looks more appropriate than dev_info().
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/base/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 04bbcd779e11..8d330f921ad7 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -301,7 +301,7 @@ struct device_link *device_link_add(struct device *consumer,
>         list_add_tail_rcu(&link->s_node, &supplier->links.consumers);
>         list_add_tail_rcu(&link->c_node, &consumer->links.suppliers);
>
> -       dev_info(consumer, "Linked as a consumer to %s\n", dev_name(supplier));
> +       dev_dbg(consumer, "Linked as a consumer to %s\n", dev_name(supplier));
>
>   out:
>         device_pm_unlock();
> @@ -327,8 +327,8 @@ static void __device_link_del(struct kref *kref)
>  {
>         struct device_link *link = container_of(kref, struct device_link, kref);
>
> -       dev_info(link->consumer, "Dropping the link to %s\n",
> -                dev_name(link->supplier));
> +       dev_dbg(link->consumer, "Dropping the link to %s\n",
> +               dev_name(link->supplier));
>
>         if (link->flags & DL_FLAG_PM_RUNTIME)
>                 pm_runtime_drop_link(link->consumer);
> --
> 2.19.2
>
