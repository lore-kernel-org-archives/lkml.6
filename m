Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A101C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CBC20855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNkhBSS5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CBC20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeK0Haj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:30:39 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39824 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeK0Haj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:30:39 -0500
Received: by mail-wm1-f68.google.com with SMTP id n133so3173498wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 12:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JdQwd/6tUFbRwUXBuEBzsIL50CZglzlLZ+ycg+W8+50=;
        b=cNkhBSS5yN2NEc4hbtB24hW9819WZyqp4kht/fOQWfeTubO6nt6yg/ZBa9TUG6gmhs
         hShtpjL9kbcQJMI75cL9DA24qSm54jB/NwbjGBtWjWzsWGMf/5q+QDy9ZrU3nR4ZuKY7
         yYNDkejtgwE6x0hb5svclLTRay9rx0hDAZxMbs5Nczm4yaWjV7VCyZsBFWtMBTkhRcxb
         3kRKxCWVitPVS4GRrUyKxcjLaiVogIoe0tNb248qhfIyKfwhW/MJfG93rIlQ4tz3sOYq
         1Ocni4r6+UkXi63ZFcKW25TfUZLgluhhPhLq4H2NPMJU5Z7gRlqDGw20j0VdSMAqAEXU
         qt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JdQwd/6tUFbRwUXBuEBzsIL50CZglzlLZ+ycg+W8+50=;
        b=cYGTxUI3sjrwKQUr1RDlN5Ml89uRX8ujtUpG+GXbEU/PTrZir4Wy9n6dU+tXIB5TUf
         iYlzxYdbex1I2UURYx7WxY4u/9u9gQ7GzOAB4DdTOBduAHVgw8mXGDGMa9pQMtrbFS5u
         MhxV4TNbJe0P7D38tGDYk7/Mdl65NnAqeHAOnJg6Set4Kn7NDrDg6m79p0K79LLYRFcl
         MSzcvyxSkNJy6e6xDYmP+iWYJEx5Vs6jo/Xxj9LJmnTPedXyNFIXZsmXAoq49VDcsXYO
         s8NWA9f424rdCOr5wsMaRfcR7EKlN2lkXuT0xcYZXoPEu9+3lBkNW/3+rjYSSTP8m4Ph
         JKmQ==
X-Gm-Message-State: AGRZ1gKZ9UDBR5jRyj/J4hIsedoA01Oe+DHUvuUMNVE6T0mEsJAl/BFW
        o3pkHZuGz3vEHtTzw9FNpE9GTXGzJpJ1XA4wQb0=
X-Google-Smtp-Source: AJdET5cPepKEYKqTIQML60vJb6GeQBm9LTgRv/CmovaeObAkKZ2GK5UvAPbXV+tHH+m6L8r6Yz08NWjGYqJB0nLYIVI=
X-Received: by 2002:a1c:9d97:: with SMTP id g145mr24322308wme.121.1543264519169;
 Mon, 26 Nov 2018 12:35:19 -0800 (PST)
MIME-Version: 1.0
References: <20181122140126.GA3124@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181122140126.GA3124@hp-pavilion-15-notebook-pc-brajeswar>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 26 Nov 2018 15:35:06 -0500
Message-ID: <CADnq5_NyW=w84HkHoL_M1=9M+e6dGLb3TYxZjTLZ9_O+5hS8bg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove duplicate header
To:     brajeswar.linux@gmail.com
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        "Cheng, Tony" <Tony.Cheng@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        David Francis <David.Francis@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2018 at 2:43 AM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove dce/dce_mem_input.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> index d68f951f9869..c41408c3eaf1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
> @@ -40,7 +40,6 @@
>  #include "dce/dce_mem_input.h"
>  #include "dce/dce_link_encoder.h"
>  #include "dce/dce_stream_encoder.h"
> -#include "dce/dce_mem_input.h"
>  #include "dce/dce_ipp.h"
>  #include "dce/dce_transform.h"
>  #include "dce/dce_opp.h"
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
