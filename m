Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E335C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0877E2148E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545901166;
	bh=FDSHDx97iL8Ml7t5wbTnJosUr4HcYAfnPzPDdKNBiTo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BMziJmlj2WG051T1ATnzJzaaxHZwkBiUu3/NO5rdAA/0e03kncTRr7q28VfKerA4B
	 NpECD1iRRYkS+bFDyRnW38qksDxYTZot1NQD/81V62htVHB34E7+5ewJNnFZ/8D3lG
	 FLMaHZuJrcWi5WlwwU6CGAJpTL0oZP70mNYr9qPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbeL0I7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 03:59:25 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44827 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbeL0I7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 03:59:24 -0500
Received: by mail-oi1-f193.google.com with SMTP id m6so14617047oig.11;
        Thu, 27 Dec 2018 00:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVez7zKrOVCrs5c3/TVif3Q9a4O31adFJfGWNfLqTh4=;
        b=b3MqYFiSeMOaahpHjmi0kJrSrJYGLYxx8YqsmC0M1P3efaTbJsYtYzOOed5k2yOYKK
         R/WU0tJBZy9kX7ls+4S1EUVT69JAUdZLLc5wcnlkaM9m6QO54rQZT3uZ21arTGBZz/sf
         UT9iHFTONbpE2L1yuXAV/9lYu7qTL+F8KfoYmzDqGbeh8NqZ/SocUScF9fgkweQsKseW
         6gL/UBa/r1Ruwb41m7UfXQXp91IfCScSCM/XQH+b2dULTz8MbmCb+y++51e9wHw3Yxvf
         jqICrbjdDuQUGmdfT6L2wjevRsf3XaK6wYqGx6dWRvoh9g7RASwOwwucubea1hv26wZ8
         PooQ==
X-Gm-Message-State: AJcUukf/a8wjSrjT/W/Cw3EPIXdpCchVhxMz80Bgm8eEavi3i4PoxXdV
        YKCZHyEz2lU8fesXswyfKKKaWBG6UHPWbkFNNWsX3g==
X-Google-Smtp-Source: ALg8bN5S0FO9Dqtb2ngKeUPOGIXbcR1u78d0XycRoRjy+Cz9g21x63GCK8et8lGRKP0Y3JNpOEU2MszxmaohJ+LfRyM=
X-Received: by 2002:aca:6c8b:: with SMTP id h133mr14775616oic.33.1545901163534;
 Thu, 27 Dec 2018 00:59:23 -0800 (PST)
MIME-Version: 1.0
References: <20181222124939.13744-1-colin.king@canonical.com>
In-Reply-To: <20181222124939.13744-1-colin.king@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Dec 2018 09:59:12 +0100
Message-ID: <CAJZ5v0gpDVArGPAXj_D6+qS6=RLmBsS9+h3=w4tBwWZEP5ZmdQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: base: swnode: check if pointer p is null before
 dereferencing it
To:     Colin King <colin.king@canonical.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 1:49 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer p can be potentially null macro to_software_node can return
> null.  Add null check on p before dereferencing it to avoid any null
> pointer dereferences.
>
> Detected by CoverityScan, CID#1476039 ("Explicit null dereferenced")
>
> Fixes: 59abd83672f7 ("drivers: base: Introducing software nodes to the firmware node framework")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/base/swnode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 204aa7d049e0..89ad8dee6ad5 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -488,7 +488,7 @@ software_node_get_next_child(const struct fwnode_handle *fwnode,
>         struct software_node *p = to_software_node(fwnode);
>         struct software_node *c = to_software_node(child);
>
> -       if (list_empty(&p->children) ||
> +       if (!p || list_empty(&p->children) ||
>             (c && list_is_last(&c->entry, &p->children)))
>                 return NULL;
>
> --

Applied, thanks!
