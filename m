Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC90C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D972070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eos2TEKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbfAHRQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:16:42 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38883 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfAHRQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:16:42 -0500
Received: by mail-yw1-f66.google.com with SMTP id d190so1833764ywb.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O3cxKFcsZ7Aia1to+6l/k0BtvfmTcgpFYAEMfuEti+s=;
        b=Eos2TEKWPnZgj2WETxoQUQ7BxQ0jHy8uuT9rcrfgcL7jSNXF/m0zd96qmubsO2lxpj
         fQnCb05A2WonrUFbhFnxV1OraNDP8w1jWCtKuqUQwPaNxDWf5SL348o6VY9p4Rtz4Llt
         hMHxNdEDlSynpYuI37u/Q19TsnPNMIAwMY/3KnBl3BWAoqOB1UU8Muj4tLM9WKLFfqqZ
         X5YU6zB5uuy+OdaYzMyVLyHweGoYVrs69oOpc/AW7dbzTEy5grPYL7qKsyw3XpiDNtk6
         h4pfTD7SK2AMN9qv+OEVsI1l6TzmwlPuNF4DwRh3iV1yPT0ICH7TapDrfOVekvZcI/Tt
         m7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3cxKFcsZ7Aia1to+6l/k0BtvfmTcgpFYAEMfuEti+s=;
        b=KJiGUKGrStyYGkSv0Os21wzC3LrEzo8U+MXwsmH+jnxA5GyhZ5B/DF9RuqHpXhBnKc
         syeRYAmvmQrodM/ezHFQmHxABB5v3aAauUt/McGvtAYNaHO5yEFVyOqwCETYSzZ151cJ
         yDb7ZL2/skOEVtpTYs4IgKGq9S6WqdJrJvw+Pb3DwmVBOjS93DckzUcU2IdfoIdt6Q9V
         fDof6vGcbQJt9rVgwkt9Qjx2u0XjwIOO3+gN+qo14JiQMM/7lwAa0RlAa3KFjjK/O+8P
         l5rFDLHW/MoSGNMdEJ14alBexVGtlf4lHnTW33N6yEEn3tD97wRbV2KP+SZ3pY4druia
         k7oQ==
X-Gm-Message-State: AJcUukdR+46WHb+fp7vothLwmrekq4Fj1zrdnhW0x7HfHq4tpWtIeWDv
        /Qb5IA30ugxgPYo5gZe6pWpwlEex6JlEOAJEC4XY9g==
X-Google-Smtp-Source: ALg8bN6l2URd5HHzySXgChs72GaH4+pHFZoZsTeq5nxA3kXQuG5nPR7MqAQJsQXI7rN/GEmH+0peK91MxbbL2clTb0A=
X-Received: by 2002:a81:ec12:: with SMTP id j18mr2459544ywm.17.1546967800980;
 Tue, 08 Jan 2019 09:16:40 -0800 (PST)
MIME-Version: 1.0
References: <20190108161016.12361-1-enric.balletbo@collabora.com> <20190108161016.12361-5-enric.balletbo@collabora.com>
In-Reply-To: <20190108161016.12361-5-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 8 Jan 2019 09:16:29 -0800
Message-ID: <CABXOdTdbzr0GW0NPf7SQRW-ra1-GCeWNDk=vPF-w-8gZuSvqoA@mail.gmail.com>
Subject: Re: [PATCH 04/10] platform/chrome: cros_ec_vbc: remove unused includes
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

On Tue, Jan 8, 2019 at 8:10 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> None of these are required at the moment.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
>  drivers/platform/chrome/cros_ec_vbc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_vbc.c b/drivers/platform/chrome/cros_ec_vbc.c
> index af9bfe6f385c..86903bc31b27 100644
> --- a/drivers/platform/chrome/cros_ec_vbc.c
> +++ b/drivers/platform/chrome/cros_ec_vbc.c
> @@ -18,10 +18,8 @@
>   * GNU General Public License for more details.
>   */
>
> -#include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/mfd/cros_ec.h>
> -#include <linux/mfd/cros_ec_commands.h>

It is customary to not rely on secondary includes. Yet, with this
removal, the code will rely on cros_ec.h including cros_ec_commands.h,
for the definition of EC_VBNV_CONTEXT_OP_READ. Does this really make
sense ?

[ I didn't check the other patches, but I suspect the same applies
there as well ]

Guenter

>  #include <linux/module.h>
>  #include <linux/slab.h>
>
> --
> 2.20.1
>
