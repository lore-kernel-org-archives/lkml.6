Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97684C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676EC217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 11:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSpzDX//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbeLSLsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 06:48:55 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45737 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbeLSLsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 06:48:54 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so14783603lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 03:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35VZZG35RO495H27ntqOGSwQT1ulFcFFBu0P8TNtB0A=;
        b=cSpzDX//+H32BfNrExM5GWeEic+FGa26SXTepVrvNbt7jRkDa9L7O3GgTlm88tMjJN
         FLa8y8T/KcmUSnZxD85hjQTIMLlnND53t4tM4RUnbO2FxmkBC5xrUb+eagVtC+J8wCbF
         GiWWABe2em3odhxEARw5JjcWeQkR4/x1OfT4sr6+XbEGSoyzR2EJnd6ONk2M6Mp5++Q8
         hIFYhw7jDEmVuAPb942CTxntwbtdN3l4T7CGJ7p/4LazMBdgYTe2MuOdncei19+3zbBN
         3JW6nSSqDyopvdquUu+CQm6BcFMsceOLXunv28n9nGHj1usJZf803LR/nC9huc7PnIRS
         sy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35VZZG35RO495H27ntqOGSwQT1ulFcFFBu0P8TNtB0A=;
        b=LE3V7R85NfjiHuHXQ6fDnkPdyOHCkOYkj/ZJZdNpaHA9P1cZ5z87L5ptKFUMhhNMwY
         qWq8HniK2iyukylpKrKNGyzbQkSThIjLvA86kmVKtsL4T9KAvgg5X8bJMvjJYVns4yuT
         dGunO6mmCTWqRQUEQCWAHi5lzs5MtUnBf+roC7nHFvFuCsepSuHp4SQOnfmmLRZUK37z
         h1s5JFgC8/2MrMIS6GjzfKiIw0eUAkCNm0yMM7OrZSWMKkTBe+mJ8nJo1pv9TocRqqdQ
         0tb9iL9p5NgDW4geNiMd/60gsZjMvhARIqkxHdgKLYFJh8AeQ7kGce5op/6VlY05F+J+
         fLuA==
X-Gm-Message-State: AA+aEWb5f/b9oLmFwke6eMVhmr865pxhgecBMoQzhKAsckUuRPzWzZNd
        yJGhk9kd4NVPZATQRmBgny0YbqNzkCrKkZ/NQgw=
X-Google-Smtp-Source: AFSGD/U4C02g1bBnw3jyz6tMasoju3G0V9z/LvkcFQi6SjGVo9T9CNszu+3pNjkiUMdr4A2owxtPE2IYE9tSz3t4GuU=
X-Received: by 2002:a19:24c6:: with SMTP id k189mr12899359lfk.77.1545220132718;
 Wed, 19 Dec 2018 03:48:52 -0800 (PST)
MIME-Version: 1.0
References: <20181219075713.GA2259@hp-pavilion-15-notebook-pc-brajeswar>
In-Reply-To: <20181219075713.GA2259@hp-pavilion-15-notebook-pc-brajeswar>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 19 Dec 2018 17:18:40 +0530
Message-ID: <CAFqt6zZ6f3wiHWR1jyLBr+8cOwjkQy-8V2zYZx0T1gE7=8Rj7Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove duplicate header
To:     Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, airlied@linux.ie,
        Tony.Cheng@amd.com, Dmytro.Laktyushkin@amd.com,
        yongqiang.sun@amd.com, eric.bernstein@amd.com, Eric.Yang2@amd.com,
        Anthony.Koo@amd.com, nikola.cornij@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 1:27 PM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove custom_float.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> ---
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>

>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index 193184affefb..3e21c2d26998 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -40,7 +40,6 @@
>  #include "ipp.h"
>  #include "mpc.h"
>  #include "reg_helper.h"
> -#include "custom_float.h"
>  #include "dcn10_hubp.h"
>  #include "dcn10_hubbub.h"
>  #include "dcn10_cm_common.h"
> --
> 2.17.1
>
