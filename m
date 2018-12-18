Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A77C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35809218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545168801;
	bh=P9oMgeu9n5/cYmdNrunXb5EEmsfk0YzWtp5kCVwKQds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pNy+6u0OKyNgOOxyZgGACTtdICy/F6IzkI4dwh21Edx5Clvt3HrpyG/BMBIatAuWz
	 5Bqe0f18X9L2h6o7vbUJXAEt+7rNA+5XOHMb0NveI544ixrVwgVVWdUacup3qV5RVi
	 9A3WfplCb8iHWJsNTYBDYLMlOYXzghwCp6G6kLs0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeLRVdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:33:20 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33341 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbeLRVdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:33:19 -0500
Received: by mail-oi1-f194.google.com with SMTP id c206so3238404oib.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1PVUKBSx+41x0MLs9xRWN1kVnsNC9z1AXHKjYqElhak=;
        b=SJ/fh2T9BUSibwEQX0ts9UsRLgB49SNoZrQdmS7YqCbONFtqJO+qHxbHO9v9uqHmhv
         1ty9BIJYWjiHACVjLxaUivInR55WaFRNbzbdgoJsuRbhprTmlJMILmww9Jz3/V8xo5+y
         l49qkrLAn53UeQMfpny99QXT/T2Z7C9WbtgYPvtc8oPIDnJ8NWPlfoXxDRKnLbK9pqzE
         R5WAgVNTV7+a2dwzQeN/IA0A0yCBvipsMKYULmPEOFL+jzpPPKl2KDJHtG3N6gmjXiy+
         VDbZGhyyKYrM2vHVRsSNWiL6Q0KgZJpG9g5EswvXzl0TnMN2/HyWxY7QjOqL2TX9f1O+
         WqtQ==
X-Gm-Message-State: AA+aEWaYT64C9wNfb9yxdRKiRduAmDls+oOxwo9RC+bKOPh35taFefsr
        qQHU1zwwCzM9dGQKNmZ66Ajioevt+A6XcwBQnsI+Kw==
X-Google-Smtp-Source: AFSGD/Wzn2VIoPR74BBzyTF8YNjbeL17/EVqLFOS+aiF1/9yl6+47XiLT5xEFGJRauVDVKFHb0XwlRThOfaqmwnzIIw=
X-Received: by 2002:aca:6c8b:: with SMTP id h133mr9005966oic.33.1545168798712;
 Tue, 18 Dec 2018 13:33:18 -0800 (PST)
MIME-Version: 1.0
References: <20181218155239.3643-1-m.felsch@pengutronix.de>
In-Reply-To: <20181218155239.3643-1-m.felsch@pengutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 18 Dec 2018 22:33:07 +0100
Message-ID: <CAJZ5v0j-yi3jSQM64zc4uQte0UToH-KWhxAtDjq5SoOimeyX1g@mail.gmail.com>
Subject: Re: [PATCH] device property: fix fwnode_graph_get_next_endpoint documentation
To:     m.felsch@pengutronix.de
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 4:52 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Sync documentation with code.
>
> Fixes: 07bb80d40b0e ("device property: Add support for remote endpoints")
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

I'll pick up this one if that's fine by everyone.

> ---
>  drivers/base/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 240ab5230ff6..e5a58614f8e0 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -1341,7 +1341,7 @@ int fwnode_irq_get(struct fwnode_handle *fwnode, unsigned int index)
>  EXPORT_SYMBOL(fwnode_irq_get);
>
>  /**
> - * device_graph_get_next_endpoint - Get next endpoint firmware node
> + * fwnode_graph_get_next_endpoint - Get next endpoint firmware node
>   * @fwnode: Pointer to the parent firmware node
>   * @prev: Previous endpoint node or %NULL to get the first
>   *
> --
> 2.19.1
>
