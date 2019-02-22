Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B38C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B8B20700
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 09:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550827007;
	bh=qjp6pLhbrrqtdwFb78ntb7BeJ8y+eaqljJzsQ7S6ox8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wRNKNfWvAkXTJzxCHGPkFGcx5HPmPBaEANPidm5jH4g5QAq+QVHhegCuM3nN7Mj5M
	 hS5oNKFVqBlEkrcG4wa+6UFqqOQCY81zkk8A2e6+IkH8AIp8H8tPtWx4kepu+sxDDF
	 6D+IKGKs2WHV2/KJnUeTjUSZKadnS9J7zp7v6zP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfBVJQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 04:16:45 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34185 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfBVJQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 04:16:45 -0500
Received: by mail-oi1-f196.google.com with SMTP id g16so1224491oib.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 01:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwpUJzhLwrVzzQh+kgla924qRoAmj/YR1lE+2lMHZhk=;
        b=VE/qsZnbOUxiopTDKX3HDpOWtj3UqQZXjLVaUcITE99TsqAXa5XwOy0maotVTLLzar
         opk2Y1N0IcjiXrOJ9U4MUYQXiD6332q0/+DSTezzVO6eDoaRrDYsPi5wB3sIWmVciE3E
         iA7gYFK1bfB3/D2/GvqzDAvp4KtGX8X0eADIVUvA8ffVJVcGxmh3Lr1kYE2hOz1fogBy
         +wzx+YPr/XLb9hfpsAIIP4D8TnXohjjVCqQ+s3V77tUVhvHdbq2GikLj45lps0VgcYoD
         p6/J9Yh8m2NnBfa0TL9BwPRsc7PJvab79L3xBRqAeKGlb3WZXUsxRH/eKFSAPlv3GB5q
         FVHg==
X-Gm-Message-State: AHQUAuY4CO7+Zkqwet8qocIT7GSe6GGnJcD36iTXPpXBWPq07OFaOqgu
        o44ZEKfpBzQnFVkQ+7RiH6YYGzZxooMTq7fLG0jOSsxX
X-Google-Smtp-Source: AHgI3IYsHkpNnLRft0+UDwScKQxfDusoDGdrKfNvSaYreEFVBb5DLfDAsEhJi4P+6tabl034GOL5OFL+XmaNZM3AjJo=
X-Received: by 2002:aca:f4d3:: with SMTP id s202mr1935757oih.178.1550827004137;
 Fri, 22 Feb 2019 01:16:44 -0800 (PST)
MIME-Version: 1.0
References: <20190221112935.4538-1-mans@mansr.com>
In-Reply-To: <20190221112935.4538-1-mans@mansr.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Feb 2019 10:16:33 +0100
Message-ID: <CAJZ5v0h+nEQ8VyBUS5qc=UCX_mDdwioJPfmCT++mGsJyHqO0_Q@mail.gmail.com>
Subject: Re: [PATCH v3] platform: set of_node in platform_device_register_full()
To:     Mans Rullgard <mans@mansr.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 12:29 PM Mans Rullgard <mans@mansr.com> wrote:
>
> If the provided fwnode is an OF node, set dev.of_node as well.
>
> Also add an of_node_reused flag to struct platform_device_info and copy
> this to the new device.  This is needed to avoid pinctrl settings being
> requested twice.  See 4e75e1d7dac9 ("driver core: add helper to reuse a
> device-tree node") for a longer explanation.
>
> Some drivers are just shims that create extra "glue" devices with the
> DT device as parent and have the real driver bind to these.  In these
> cases, the glue device needs to get a reference to the original DT node
> in order for the main driver to access properties and child nodes.
>
> For example, the sunxi-musb driver creates such a glue device using
> platform_device_register_full().  Consequently, devices attached to
> this USB interface don't get associated with DT nodes, if present,
> the way they do with EHCI.
>
> This change will allow sunxi-musb and similar drivers to easily
> propagate the DT node to child devices as required.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Generally

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

but I'm a bit concerned about the existing users of
platform_device_register_full() who may pass a valid DT fwnode to it
and not expect of_node to be set.  Arguably, they should expect it to
be set, but then there may be some fallout resulting from this change.

> ---
> Changes in v3:
> - handle of_node_reused
> ---
>  drivers/base/platform.c         | 2 ++
>  include/linux/platform_device.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index dff82a3c2caa..7058ecea779a 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -512,6 +512,8 @@ struct platform_device *platform_device_register_full(
>
>         pdev->dev.parent = pdevinfo->parent;
>         pdev->dev.fwnode = pdevinfo->fwnode;
> +       pdev->dev.of_node = of_node_get(to_of_node(pdev->dev.fwnode));
> +       pdev->dev.of_node_reused = pdevinfo->of_node_reused;
>
>         if (pdevinfo->dma_mask) {
>                 /*
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 1a9f38f27f65..4a29fdf16806 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -62,6 +62,7 @@ extern int platform_add_devices(struct platform_device **, int);
>  struct platform_device_info {
>                 struct device *parent;
>                 struct fwnode_handle *fwnode;
> +               bool of_node_reused;
>
>                 const char *name;
>                 int id;
> --
> 2.20.1
>
