Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F2FECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06ED20664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 12:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CQJ1qnR6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06ED20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbeJaVoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 17:44:14 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46233 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728869AbeJaVoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 17:44:14 -0400
Received: by mail-qt1-f196.google.com with SMTP id c16-v6so17394822qtj.13;
        Wed, 31 Oct 2018 05:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hhuj+PVBQ3t1A+bNUbpDproSezBVyVg86+pK9jUqytY=;
        b=CQJ1qnR6P9DidwLo+WvcpcIg5pho1xQqbKyjL3CVnoc43gy5KnwZnmBoCQhBNjas+M
         cyrcnvYCWbqhXbYZy9++wR8Pkl2BxjigNcssX0LvADvGB0VJZgFCCv4enH5AWkGfaQoV
         JOmeW0ZiCfbCYCibHufoCwSDGGRVtA4Diw07kL9ldjpUDV9M9U9TnQ13VovOPXnTVkDY
         9SO5vuBg2tdIKEjFjX1Omj09K78Lu3/o7s87MpTBBKO+47im6Dui7ml4Aicy94ToJ2nH
         MYvT9vqh+Uoh00iy8V5hXjwO+SML07cmnTB/pQuLgZF/NduhQPz6or+h9JXxtI/nqdfK
         7nFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hhuj+PVBQ3t1A+bNUbpDproSezBVyVg86+pK9jUqytY=;
        b=DD/vUNTsXavHEEK5SQyiWmoDGTzrGM4KTgfQ7HHhAKhNUqfReEItsLhPGG/1IoCBzc
         EwMb78jLbnmK/Xniovi8mXT2bvyp8RrPOKfJjKXOFVNF70qCOTJJchHo2Sw37FxL8dbR
         vr3DRpxIYjwraZUqeIl40MuUAumBX2WcXSuWnNqooFn0xxHKfGOPCaoma0+gobVRPJMj
         2e7wAOmgp8EYarf/T2+c3LR6JHUuNx1qPnVKQHhWcLJ+6yVAL+RresTVO4qTzEo2P01I
         xFXFuFBvTY8+2T3Eb4PRFM8GEXqjXm1IgM3fRh/hadkXCriNH3Y/rzcQ5JTOWVLg4AVL
         kRoQ==
X-Gm-Message-State: AGRZ1gI27JDfY6xaXiWlruhVwDaQ4yQui/qV/y/u7QVKTS3Z69wyeW5V
        ZuFImyf/6vxV2NShs6loWwmpOwoZRNHyhdkDt6q8mq/1
X-Google-Smtp-Source: AJdET5clmrjUukTdgDP3lgUZCaxlhfdiNiP+kHVTPhyIoDVWp33oD5+ugy4t6Bw0n5SZ0gxnbPptHxP4H4sAZpKulb4=
X-Received: by 2002:a0c:c402:: with SMTP id r2mr2493768qvi.138.1540989981423;
 Wed, 31 Oct 2018 05:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <1540993041-25611-1-git-send-email-peng.hao2@zte.com.cn> <1540993041-25611-2-git-send-email-peng.hao2@zte.com.cn>
In-Reply-To: <1540993041-25611-2-git-send-email-peng.hao2@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 31 Oct 2018 14:46:10 +0200
Message-ID: <CAHp75VemSb=MG3z3eAks1Jv8GPx4fif7wYEDKgMUGbzssTmrAQ@mail.gmail.com>
Subject: Re: [PATCH V4 2/5] misc/pvpanic : convert to SPDX license tags
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 7:27 AM Peng Hao <peng.hao2@zte.com.cn> wrote:
>
> This patch updates license to use SPDX-License-Identifier
> instead of verbose license text.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
> ---
>  drivers/misc/pvpanic.c | 17 ++---------------
>  1 file changed, 2 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index fd86dab..9450376 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -1,21 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
> - *  pvpanic.c - pvpanic Device Support
> + *  Pvpanic Device Support
>   *
>   *  Copyright (C) 2013 Fujitsu.
> - *
> - *  This program is free software; you can redistribute it and/or modify
> - *  it under the terms of the GNU General Public License as published by
> - *  the Free Software Foundation; either version 2 of the License, or
> - *  (at your option) any later version.
> - *
> - *  This program is distributed in the hope that it will be useful,
> - *  but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *  GNU General Public License for more details.
> - *
> - *  You should have received a copy of the GNU General Public License
> - *  along with this program; if not, write to the Free Software
> - *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
>   */
>
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
