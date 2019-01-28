Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6D4C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 474B62171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BdaWFSuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfA1Tg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:36:59 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35814 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbfA1Tg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:36:58 -0500
Received: by mail-yw1-f66.google.com with SMTP id h32so7231794ywk.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7rO5313fdBvQN+kGAw2Y0koWyXo5zp8fUDFfSbKuQI=;
        b=BdaWFSuol+OYQ62bvfcliSqWxWwNqNH9MRdNEBpdYbNkkXuE+xSl5mNNBoVKpQkSys
         oTKohdN5zzmCc52nxmskHN9bfjzUgcQRfm/TolOfRjhkxG+dGkHnid/qq44q9YbANJtO
         9p8o05tNBQAqJzOAvXThk/Ir3OjNcqDq3GeB8aeuPkwq8J8XLjBc35D1vrgK/KFhNU0G
         U/mXZCT4N9zzjWk3mUdOSiaksdqurqp0yJi6z/n5xxBaTcSfCmsmMRntDte3N820BOgZ
         wstAQmePQKdlbH+RHIpN3eyOAAwlBhDKQJORpCzWHtRPe1kamKZw5Kw+cWRJDdGglEDI
         zJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7rO5313fdBvQN+kGAw2Y0koWyXo5zp8fUDFfSbKuQI=;
        b=hrpoYbbS8Zf9xFuJYSsGtstVI9BJSEMWt7goUu9JW3eIjnr8gAO81w45VnCwT733VW
         rbLTZCJvwP6AztdbGRXLP1QmVi3jm+wWSZQhLEoE+NaVfigouZZhbO+0ymahOmMKcaZT
         9+yPZXymHQXBKSuqVxLr2L9gyK4ElbhvIjXRazYd5j6JnyLfWt2a+ck8J/Gbsg/njwLT
         v1AYj8ESQgd4RZiNrxyWmsywt8yGwX+fifPvLzbXO9QXC6qDb/IPuuy9/QeMJVRvW2JZ
         0OLlS1E/oFq1+1/onxX1d2jjPmcVCrWNNaQye5CCxOkUaVO7pOitCSs3bDUNgWff6W9F
         rgJA==
X-Gm-Message-State: AJcUukdU1RCAhWsg4VEpITWXWEHrESQB9jp+Th2paFKBKv8QRNeIXfLo
        anbEVPYDOZho/7WhRHhSrOui5xtgKOFKTA3h6T21kA==
X-Google-Smtp-Source: ALg8bN6D327QCHlXantt6u70ySO7JYPsPlophEX3VUym5mUyA5eOXNP68po2dJWAYlr5lO7o16t1HgcHHFojLkG7hFc=
X-Received: by 2002:a81:210b:: with SMTP id h11mr14112736ywh.299.1548704217934;
 Mon, 28 Jan 2019 11:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20190126095131.4756-1-enric.balletbo@collabora.com> <20190126095131.4756-13-enric.balletbo@collabora.com>
In-Reply-To: <20190126095131.4756-13-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 28 Jan 2019 11:36:47 -0800
Message-ID: <CABXOdTfb=HMMOu5t9urwwjpT9OPVrA3noZUAyysJ-nWNK2Lnrw@mail.gmail.com>
Subject: Re: [PATCH v2 12/12] platform/chrome: cros_ec_sysfs: remove pr_fmt() define
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
> This driver no longer has any pr_{level} messages. Remove the pr_fmt().
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v2: None
>
>  drivers/platform/chrome/cros_ec_sysfs.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
> index 01c420727ee1..fe0b7614ae1b 100644
> --- a/drivers/platform/chrome/cros_ec_sysfs.c
> +++ b/drivers/platform/chrome/cros_ec_sysfs.c
> @@ -3,8 +3,6 @@
>  //
>  // Copyright (C) 2014 Google, Inc.
>
> -#define pr_fmt(fmt) "cros_ec_sysfs: " fmt
> -
>  #include <linux/ctype.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> --
> 2.20.1
>
