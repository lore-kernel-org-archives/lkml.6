Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBF6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99A0E2148E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 08:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545901191;
	bh=tbp5WkRgEWYPvdUyK+mZBYCfKSxyOJNq1sBc5+T6YrQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=K0q8UApablXs0gepuoZzm/Wdm+sMPU9yonZ6JwQInWAWArugSwvW2YxqelZYR6kdL
	 UhmjlYWJNB12xx2VfKSXsK10asRcbdavp6w0x8Mp6RJ+EezwukP1xxWfY42PwCYOTg
	 kkNMpPH3EPmGenJLcOo0G8gflDidj/MIvBHZhMto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbeL0I7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 03:59:50 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:43161 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbeL0I7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 03:59:50 -0500
Received: by mail-ot1-f49.google.com with SMTP id a11so15806072otr.10;
        Thu, 27 Dec 2018 00:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2m0WSWH+4bWPdBbyX3wrY38gJwdMr9i6YvSfFd209c=;
        b=K3z+gCsm0ISMKUsX9V0QO0y25f1x+PaHhCaNibgwYQs7xeVOC5VkoYxw6Em81Eep9k
         OFhFTnoQZ6+hnyYwF1xbwoDSM6ONmaQk4HT23vpHArusI8ieQ0pc5exe3LvyIdCY+UVM
         SyBws4Gji+9C5bhhSKxqQ02d/jOxJTuUXERgaR7vpOAVKUb1F50Oicc7OPk+1uIcyqJ4
         MuTiIjfQw6rI76syb5apZmYLrTJfuS4CkViAJfXj4PIYPdjd6SnSkYZshd5jVIVuYXLd
         q1WalvChn2IsodWApztI5YcxGzmCtXEQ0CF2M/2fGaI9ZLC29xMNbyDuABB5VYjwUjOC
         piBw==
X-Gm-Message-State: AJcUukevZqxnnE1c3YInt4+xO0H4vLKiGv9e7vYz6KR6RoWZQg49KyjW
        MZdoUKwvAT9I77Kmc1MZ+8AikmVQotk/hTIis5w=
X-Google-Smtp-Source: ALg8bN5BZFS8JJjooMza9a2ozbXDqComoxRSKNnu4pqTXCusMAqRhE6YNVSFzXR02q5RQ1tju3sMiOhzDGUmP4vLnHA=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr16175645oti.258.1545901189223;
 Thu, 27 Dec 2018 00:59:49 -0800 (PST)
MIME-Version: 1.0
References: <20181222124333.13561-1-colin.king@canonical.com>
In-Reply-To: <20181222124333.13561-1-colin.king@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Dec 2018 09:59:38 +0100
Message-ID: <CAJZ5v0iNBH3oLsQmMowdsdsK0WToZBk5tNNAhiXxAPSfdXoyLg@mail.gmail.com>
Subject: Re: [PATCH][next] drivers: base: swnode: check if swnode is null
 before dereferencing it
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

On Sat, Dec 22, 2018 at 1:43 PM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The macro to_software_mode can potentially return NULL, so also add
> a null check on the swnode before dereferencing it to avoid any null
> pointer dereferences.
>
> Detected by CoverityScan, CID#1476052 ("Explicit null dereferenced")
>
> Fixes: 59abd83672f7 ("drivers: base: Introducing software nodes to the firmware node framework")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/base/swnode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
> index 306bb93287af..204aa7d049e0 100644
> --- a/drivers/base/swnode.c
> +++ b/drivers/base/swnode.c
> @@ -477,7 +477,8 @@ software_node_get_parent(const struct fwnode_handle *fwnode)
>  {
>         struct software_node *swnode = to_software_node(fwnode);
>
> -       return swnode->parent ? &swnode->parent->fwnode : NULL;
> +       return swnode ? (swnode->parent ? &swnode->parent->fwnode : NULL) :
> +                       NULL;
>  }
>
>  struct fwnode_handle *
> --

Applied, thanks!
