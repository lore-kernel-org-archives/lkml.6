Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F46C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948B823EB5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 12:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KWSVLdft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948B823EB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753161AbeGDMzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 08:55:38 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40827 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752997AbeGDMze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 08:55:34 -0400
Received: by mail-it0-f65.google.com with SMTP id 188-v6so7901777ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 05:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Y2Ah1pAPm4B+Ec96OwWTCyiQLsC9zWodTu52JACTjlY=;
        b=KWSVLdft8x8eRhIkUWJx7hZOiNpI3xydSuLmXJ4/9LcKi637fxWFTeZYJcTmrsX5N2
         W0mH4ZULLm4n0x8wNP1Wye9dW/eUOpWDZMdB0kVP6nwpy1R+cIidsSlFE7+ZIbCwvQty
         drD3kByzPCD3pVBOBKbnW7fCIz6rGkRoXbgz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Y2Ah1pAPm4B+Ec96OwWTCyiQLsC9zWodTu52JACTjlY=;
        b=RoTVuzcmLpjrBWNXd17fxx0JVu7NKsBDK8WKsKAbiUoao8vdAwwTX+yBll73A2Rh7O
         rlBMsFqv7UB9ttRwSCTJhb8/7xk7kmgt+1eFVAnf0+bT7/LuYohWDRlntq+H+tf8iY2W
         GRK8rjflg1woidnFx4BYQFO7cEevJpwMHavD64YmI8qUb1NOkBUEyGg8+SJqj3fuQgZ7
         jfCtWJ0IFHHcTSQKQ7HgeMNLVssvLjmq9986ZIrh6624LbnajB3mBh+ZG2C3CZdlY272
         VPJJ+DRcDjqPdoyix9B9r6E5Uq/LUEb6VcgPYzFj87CMS+icGoUtCQc3zAKH/UXL6ZeN
         juMw==
X-Gm-Message-State: APt69E1zRKf6p2ZGQRIfDSJodGp0r1+I0BiFBVdi7utMwO8lvarg4c8y
        4wxCiyJ5FJKiUbWwLfr76NuDDa4KpmH5Zz/DzXrhYw==
X-Google-Smtp-Source: AAOMgpfunlyeYps12mxr8XOGgy4ZDecmYgjJ3IHMmN7eHgTTrQZ5EWec9MuuEjHYwdF/EFyTQ72vVnTVXWRBh1tVLjk=
X-Received: by 2002:a02:579a:: with SMTP id b26-v6mr1466695jad.107.1530708933571;
 Wed, 04 Jul 2018 05:55:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:818f:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 05:55:33 -0700 (PDT)
In-Reply-To: <20180627125056.12851-2-vivek.gautam@codeaurora.org>
References: <20180627125056.12851-1-vivek.gautam@codeaurora.org> <20180627125056.12851-2-vivek.gautam@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Jul 2018 14:55:33 +0200
Message-ID: <CAPDyKFoXOJA85fr-80inQoORAFW5mDy1QktkVLey6Vs4QERH8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] device core: Add flag to autoremove device link on
 supplier unbind
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 14:50, Vivek Gautam <vivek.gautam@codeaurora.org> wrote:
> Add a flag to autoremove the device links on supplier driver
> unbind. This obviates the need to explicitly delete the link
> in the remove path.
> We remove these links only when the supplier's link to its
> consumers has gone to DL_STATE_SUPPLIER_UNBIND state.
>
> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: linux-doc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-arm-msm@vger.kernel.org

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  Documentation/driver-api/device_link.rst |  4 ++++
>  drivers/base/core.c                      | 10 ++++++++++
>  include/linux/device.h                   |  2 ++
>  3 files changed, 16 insertions(+)
>
> diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
> index a005b904a264..d6763272e747 100644
> --- a/Documentation/driver-api/device_link.rst
> +++ b/Documentation/driver-api/device_link.rst
> @@ -86,6 +86,10 @@ automatically purged when the consumer fails to probe or later unbinds.
>  This obviates the need to explicitly delete the link in the ``->remove``
>  callback or in the error path of the ``->probe`` callback.
>
> +Similarly, when the device link is added from supplier's ``->probe`` callback,
> +``DL_FLAG_AUTOREMOVE_SUPPLIER`` causes the device link to be automatically
> +purged when the supplier fails to probe or later unbinds.
> +
>  Limitations
>  ===========
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 14c1e3151e08..e721218bf352 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -518,6 +518,16 @@ void device_links_driver_cleanup(struct device *dev)
>
>                 WARN_ON(link->flags & DL_FLAG_AUTOREMOVE_CONSUMER);
>                 WARN_ON(link->status != DL_STATE_SUPPLIER_UNBIND);
> +
> +               /*
> +                * autoremove the links between this @dev and its consumer
> +                * devices that are not active, i.e. where the link state
> +                * has moved to DL_STATE_SUPPLIER_UNBIND.
> +                */
> +               if (link->status == DL_STATE_SUPPLIER_UNBIND &&
> +                   link->flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
> +                       kref_put(&link->kref, __device_link_del);
> +
>                 WRITE_ONCE(link->status, DL_STATE_DORMANT);
>         }
>
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 3929805cdd59..e80920452b49 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -787,11 +787,13 @@ enum device_link_state {
>   * AUTOREMOVE_CONSUMER: Remove the link automatically on consumer driver unbind.
>   * PM_RUNTIME: If set, the runtime PM framework will use this link.
>   * RPM_ACTIVE: Run pm_runtime_get_sync() on the supplier during link creation.
> + * AUTOREMOVE_SUPPLIER: Remove the link automatically on supplier driver unbind.
>   */
>  #define DL_FLAG_STATELESS              BIT(0)
>  #define DL_FLAG_AUTOREMOVE_CONSUMER    BIT(1)
>  #define DL_FLAG_PM_RUNTIME             BIT(2)
>  #define DL_FLAG_RPM_ACTIVE             BIT(3)
> +#define DL_FLAG_AUTOREMOVE_SUPPLIER    BIT(4)
>
>  /**
>   * struct device_link - Device link representation.
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
