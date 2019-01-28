Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED862C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB0682184D
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mEalu1Nb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfA1T3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:29:25 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36822 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfA1T3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:29:24 -0500
Received: by mail-yb1-f196.google.com with SMTP id 64so2675769ybf.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qs77uciUloAwV2eYcIE7foyipDchuSN8Ovvux8TXo00=;
        b=mEalu1NbEH5RS9eCAZyXen6icvvJZ6sPeUucjhW0IK/ori/uE0ttojehVJYnx2bsN3
         byBDxTunRdvNJo4AZGqKfPV5XYLdPis/9MmNyXWGDglcGl6NTU0KCuMg9oes5wLK84jV
         xvi3hxloPircfBnsPEpZy9cDz6PpvaH1m8LKIDYhySRkXPOxxMEI/MOO0ft65q1StVWV
         r+MqT7pPtqeWw829TVRG9GWdPF9YhlOUghFBdcPBlzbI+nF/4zLmzouqGKCqnc2rBBDI
         f8pBeQ6T1YAVc1NneaLD1UG8kKjKxUGe+8AD8PH+uv6GYNuyZNIF/BfPET+uB59/Uu/V
         yCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qs77uciUloAwV2eYcIE7foyipDchuSN8Ovvux8TXo00=;
        b=eNarzi4S7Omi2ZrOekqEY8Ot9zoi6nJg91eWBUi1OW1sS1yAeZeHr1A80dhnc5219w
         9ULp0+HbOoehKqP0T8WlZF4aE+JNd/Cj65vmzNLYQs/GbFl5EV/G3LmRM3t9n0HBtXrG
         2Y5qQw4g/8wyp4qxYCCN97xyPfSejQtoYAoJ8+bgmEbQCCgeJgoOKIBgyw9Qk54tjzhI
         TJxao5Gf5paOQC8jmPag4qT/+mEwknlQI/BLM2/qoxg/9l/OgBKuJYGfDEenVJYqz3QF
         7k1TRAb4/huwu+BvrqZnfR0qC5bKJeB1dhL7pk5DzDJ7s/Cqjne3iB7azYTNKcJkxFpl
         bwFw==
X-Gm-Message-State: AJcUukfsKf8moVlTtVeFD3NjIvbK9czt0lsCdYw469NQ0lfLl7BAcQOg
        K7IyVLhux3t7AqptZSr+rVKr4Zl/BYAXYskdqO1+yw==
X-Google-Smtp-Source: ALg8bN674Ik5b0oywpDOMmayV8aWo7iV8jWq4QYtyY7JqXfPUgQ9LezDZHPuCVsFlVcfMei4n66SS1ob2W2gLL+MrWc=
X-Received: by 2002:a25:1006:: with SMTP id 6mr21273061ybq.151.1548703763518;
 Mon, 28 Jan 2019 11:29:23 -0800 (PST)
MIME-Version: 1.0
References: <20190126095131.4756-1-enric.balletbo@collabora.com> <20190126095131.4756-4-enric.balletbo@collabora.com>
In-Reply-To: <20190126095131.4756-4-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 28 Jan 2019 11:29:12 -0800
Message-ID: <CABXOdTdJtVpnt88FNHCGspASOLv0sxNkyS3VqVZXcUBNC+wfng@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] platform/chrome: cros_ec_lightbar: switch to
 SPDX identifier
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
>  drivers/platform/chrome/cros_ec_lightbar.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
> index c3e4e6e5211d..37689ad79544 100644
> --- a/drivers/platform/chrome/cros_ec_lightbar.c
> +++ b/drivers/platform/chrome/cros_ec_lightbar.c
> @@ -1,21 +1,7 @@
> -/*
> - * cros_ec_lightbar - expose the Chromebook Pixel lightbar to userspace
> - *
> - * Copyright (C) 2014 Google, Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program. If not, see <http://www.gnu.org/licenses/>.
> - */
> +// SPDX-License-Identifier: GPL-2.0+
> +// Expose the Chromebook Pixel lightbar to userspace
> +//
> +// Copyright (C) 2014 Google, Inc.
>
>  #define pr_fmt(fmt) "cros_ec_lightbar: " fmt
>
> --
> 2.20.1
>
