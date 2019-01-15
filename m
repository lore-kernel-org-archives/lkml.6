Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC8AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4DB20859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 05:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQO7fUXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbfAOF7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 00:59:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45781 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfAOF7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 00:59:02 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so754253plm.12;
        Mon, 14 Jan 2019 21:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3UrjDHelBHaaMvBs/owwVhy+lgqL2K3OkVfU7gYeAc=;
        b=iQO7fUXCClRzB45mjizrg3VVcKB75/BcsGzgPorrS0jlGtT5qmBQ74NnwwuKHdelQ0
         XgpsCJwuq3XVBRR7DLHnvV4fPkj2RIoGxn2eJlYXOiKnC1oSlRchHNoQo5+QpudDm8k6
         OAY6x2AFF7yGvu2obuH4hZPJDPvRbpjkOYiVY166lPzHJ9gt/puQlbi32p0YQrF5kAET
         yACAshgfoFrzNMZBWxjDeTEKmr/gBc3XQthWVUd+9EHJsEgT6Xe0MTHzaq8aKH/4SfTA
         e57kR10d/RAbrkMIMjTW47AwPOVKqNgM/3tMRNzO1EGwTowfvKxJWOi77silwf4Xhcob
         enpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3UrjDHelBHaaMvBs/owwVhy+lgqL2K3OkVfU7gYeAc=;
        b=GGLJZhhCTU20L0dWhrDU2ssAS2C3Mg7CApVzOiiTod1dr1mcukXSU4Pe+OPAwoqf8/
         aGJCem9LErNUlAeYwdJaSqCQAPHswFaJtPmjYrsYv+l+BkY+vZgNPqH8QHAY4q1bcKmL
         6GFRZQT6F9H6EnK49k0ddVGikTJWE+YHJZBgEfRQtIVlS0YH78apPzEbmklEjNIc/XZ7
         w8YutG06x2aQZMb1TdOEdyDPDof+ruRV5dpgqAioVTKMCsTVJTJLC7W+JcUmiLhUo5Rw
         7M1Vv8j1rtEeumT+9dphkvuCjmr3798RxmnIcCIY3VnE+yoBPlaFl23xqv6zx4iHpHPw
         ebVA==
X-Gm-Message-State: AJcUukfJM6Q3JFLviRh3sJ7lWov1GbjXj6gZl6io92RRgfYd6GTEX1YS
        LfTF0WnuPnaN9RmH4W0/lrcIRyiVcXYoKs7d0IY=
X-Google-Smtp-Source: ALg8bN5BonErptGqouAW4+ZAcTeyBNfy5XmYsjhEIqRnMkf80j4YEfZBARDeXt6XnNyw/r26KD8/nXYej8taEGeQipY=
X-Received: by 2002:a17:902:e28e:: with SMTP id cf14mr2381523plb.311.1547531941842;
 Mon, 14 Jan 2019 21:59:01 -0800 (PST)
MIME-Version: 1.0
References: <a15008d9dcde1653c22393e64eb83a07d4750caa.1547353746.git.dvhart@infradead.org>
In-Reply-To: <a15008d9dcde1653c22393e64eb83a07d4750caa.1547353746.git.dvhart@infradead.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 15 Jan 2019 07:58:49 +0200
Message-ID: <CAHp75Vf+ThbNZ10EB9Sx4tmm_sHJ5zqNF6mTB45tzJQOcD_68w@mail.gmail.com>
Subject: Re: [PATCH] Documentation/ABI: Correct mlxreg-io KernelVersion for 5.0
To:     "Darren Hart (VMware)" <dvhart@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Vadim Pasternak <vadimp@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 6:32 AM Darren Hart (VMware)
<dvhart@infradead.org> wrote:
>
> The mlxreg-io for the merge window assumed 4.21 as the next kernel
> version. Replace 4.21 with 5.0.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
> ---
>  Documentation/ABI/stable/sysfs-driver-mlxreg-io | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-driver-mlxreg-io b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> index 9b642669cb16..169fe08a649b 100644
> --- a/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> +++ b/Documentation/ABI/stable/sysfs-driver-mlxreg-io
> @@ -24,7 +24,7 @@ What:         /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
>                                                         cpld3_version
>
>  Date:          November 2018
> -KernelVersion: 4.21
> +KernelVersion: 5.0
>  Contact:       Vadim Pasternak <vadimpmellanox.com>
>  Description:   These files show with which CPLD versions have been burned
>                 on LED board.
> @@ -35,7 +35,7 @@ What:         /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
>                                                         jtag_enable
>
>  Date:          November 2018
> -KernelVersion: 4.21
> +KernelVersion: 5.0
>  Contact:       Vadim Pasternak <vadimpmellanox.com>
>  Description:   These files enable and disable the access to the JTAG domain.
>                 By default access to the JTAG domain is disabled.
> @@ -105,7 +105,7 @@ What:               /sys/devices/platform/mlxplat/mlxreg-io/hwmon/hwmon*/
>                                                 reset_voltmon_upgrade_fail
>
>  Date:          November 2018
> -KernelVersion: 4.21
> +KernelVersion: 5.0
>  Contact:       Vadim Pasternak <vadimpmellanox.com>
>  Description:   These files show the system reset cause, as following: ComEx
>                 power fail, reset from ComEx, system platform reset, reset
> --
> 2.17.2
>
>
> --
> Darren Hart
> VMware Open Source Technology Center



-- 
With Best Regards,
Andy Shevchenko
