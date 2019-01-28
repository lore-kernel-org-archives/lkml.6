Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBF1C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54CA2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vGiZScbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfA1TbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:31:01 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35295 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfA1TbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:31:00 -0500
Received: by mail-yb1-f196.google.com with SMTP id 64so2767389ybs.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+c1DogXk+T7FScEktDNuwvUTFJdA6xbog2AVFLsN88=;
        b=vGiZScbYZB4o1tQEmY2iPmam1/hWxe60CqPJSFXGU3vYYFl8rOc0+WPtuCP425XWvc
         N6rXQ1YGbph1CPwi071T9KGNDkyuj5b6etxediAPMQDq40BlYZCL2NjOJwQ6+BV0zUtb
         q9yFehym24FBY2WW1cyFyYQmR7iPj7MF5Edl8dQrz7e/dWx9iDb3AvzH1BnlumuSh9U1
         Sqnjb5vJsdQihyeRoDOXyrWUHt3I1dJYPhzf9WpysXWZh9z8Vtnu8MdJdQjqVz+yq/Zh
         1dro7Xqx+KzwBR7rEpXxiama47eIg4o1C1NYK+vstEb6MuB3f1TMuIHTVQyqaI2np02t
         du+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+c1DogXk+T7FScEktDNuwvUTFJdA6xbog2AVFLsN88=;
        b=Z3+atJLzKAvI3Uy7AOyqVcWRVv/BV7fqypeMaNi66gEyikMkBrojC8m/8jeSvUJsEe
         7lY+sX1iRPiUJP5SUQ1XGEC7mvVkwUNr0v2oczDFI4W+jFBGMPC9f18QYFtisyGO80dh
         oQxzDiPDrvlyqu7S09/BuYrp3xz2MWUQZizuUpmmAp9J4l8qPnAO0MoFP1uguhSe6vEp
         VziQsQI+G9vzCtrFcPhfKfa9QBLddxBOziibW13x0voEHI66EdN5T5KoqkCeg1o2IwXb
         xW1wpZMOvudCeqd58dxsrTY6g5zdjkl0pWLlPTXbXq5032T8Zev/jhBXEHaZRWmFqIrt
         dyxw==
X-Gm-Message-State: AJcUukeupUFndkZoYnb3vniR+sd1EYstjwj+aQayXKOprcv1Ws9CJ0Kn
        uJ7+lAfmXJjoAwSRk8l+nn3+ujH5mWQ6Qvp3X5GKqQ==
X-Google-Smtp-Source: ALg8bN6r3OGxLHttI9yquLaAUD/7QrANFxf8YI32CpQtdDboNXlQAvvm6lBsZhwKGcmCdYosnGmoiYPhFIC3mdQpfMQ=
X-Received: by 2002:a25:7ec5:: with SMTP id z188mr22011871ybc.282.1548703859424;
 Mon, 28 Jan 2019 11:30:59 -0800 (PST)
MIME-Version: 1.0
References: <20190126095131.4756-1-enric.balletbo@collabora.com> <20190126095131.4756-6-enric.balletbo@collabora.com>
In-Reply-To: <20190126095131.4756-6-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 28 Jan 2019 11:30:48 -0800
Message-ID: <CABXOdTej7tTzj0khvYmtM7Y4f+FaHrDd5xMfPTLSkWJxqsnKpg@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] platform/chrome: cros_ec_vbc: switch to SPDX identifier
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>, kernel@collabora.com,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 1:51 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Adopt the SPDX license identifier headers to ease license compliance
> management.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v2: None
>
>  drivers/platform/chrome/cros_ec_vbc.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
> index af9bfe6f385c..8392a1ec33a7 100644
> --- a/drivers/platform/chrome/cros_ec_vbc.c
> +++ b/drivers/platform/chrome/cros_ec_vbc.c
> @@ -1,22 +1,8 @@
> -/*
> - * cros_ec_vbc - Expose the vboot context nvram to userspace
> - *
> - * Copyright (C) 2015 Collabora Ltd.
> - *
> - * based on vendor driver,
> - *
> - * Copyright (C) 2012 The Chromium OS Authors
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +// Expose the vboot context nvram to userspace
> +//
> +// Copyright (C) 2012 Google, Inc.
> +// Copyright (C) 2015 Collabora Ltd.
>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> --
> 2.20.1
>
