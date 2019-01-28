Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90AEC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 778C92171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YZVp1RN1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfA1Teg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:34:36 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44825 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfA1Tef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:34:35 -0500
Received: by mail-yw1-f65.google.com with SMTP id b63so7196207ywc.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KImGpQagXr4eXwj3i5r3DrsaL0UreCfC7cFMiNGO4QI=;
        b=YZVp1RN1u+27m26mjRaX8gk6swF7ky1hIh1kj0EydWw1eVLjyQQHWsKL0i9/h/cE3V
         ZztC1HRPEgaxP1Fj7ZiSyZZOnNKB24lWF9+n7kjZCzzPYzs2um+9GaVu7WCh1ieG1e76
         roatM5JeFAe0IRD+nRV7napszI75JmCOozPSeFcxrR5aqrGf23aQBGKbBy8rQAI6f6fe
         Qr2Jdi45Lt9uDXPSqSmN7hdlfCaDy2w6BziTFC5t981kZlc3etyfOMe7nP10o39LLttd
         CenrVJwYtjbhbuxu/I5UKerWOQpFI6EfRbu8G0vSU9LgwJWeoyl0oRUhWNdCGe0cZH2f
         C3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KImGpQagXr4eXwj3i5r3DrsaL0UreCfC7cFMiNGO4QI=;
        b=lv1z5pLxyRL5ZNZ9TCWtl7tDrixPr/nFfkBZNZlrcCB3yrHwpdGmNL1LeIt43+eNEk
         uhu6ii1LV5YRReyZxJKY8xG4Uk7G96e24+v+QKgei897Qp7zQqLWS5Aitn327tozrxpQ
         cCf9ja6BT1r9K7DZwvKqeBZyfMe+NEPaktjOqscZVBTN9e4eT6OXOo/yMlq7YKJjg7nw
         HGMTxykl9TXZPI4fNGp+OCTISD6BVxZAi2MEQg11o8Ikw4PlzcH7R5CthRBJ6Lj4gl/P
         bQsfsGzpV3pMaTBPOeEkbph+1ndefE+1UCwsdzl/rhYOijMOTloDCaOY470CoaaMgGAo
         vVAg==
X-Gm-Message-State: AJcUukeIVTGQ5b63e5iTNlQxv14fg/GcqQcn5vL44GC3SmuflkhAIOi5
        GJibps/4rzuwwQCYpVLWKCLWAe8ok/5/wCwRBpNjmQ==
X-Google-Smtp-Source: ALg8bN7qKEXLMEtTnJp6Fifc8273AiKf/QSW47sGyf95lkhKDxCuZK0K1Ts8As7H3DpWb4iNTKRXIRf5hvidGdt3QtE=
X-Received: by 2002:a81:af58:: with SMTP id x24mr22888921ywj.362.1548704074481;
 Mon, 28 Jan 2019 11:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20190126095131.4756-1-enric.balletbo@collabora.com> <20190126095131.4756-10-enric.balletbo@collabora.com>
In-Reply-To: <20190126095131.4756-10-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 28 Jan 2019 11:34:23 -0800
Message-ID: <CABXOdTf7Pn8MMu8JY7RF30EJLHsXCH1q1dYPLXGNTiCGMgqy-w@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] platform/chrome: cros_ec_spi: switch to SPDX identifier
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
> management. Also change the description for one more appropriate.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v2: None
>
>  drivers/platform/chrome/cros_ec_spi.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index 2be41e8afa47..b20fc4040396 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -1,17 +1,7 @@
> -/*
> - * ChromeOS EC multi-function device (SPI)
> - *
> - * Copyright (C) 2012 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0+

GPL-2.0

> +// SPI interface for ChromeOS Embedded Controller
> +//
> +// Copyright (C) 2012 Google, Inc
>
>  #include <linux/delay.h>
>  #include <linux/kernel.h>
> @@ -730,4 +720,4 @@ static struct spi_driver cros_ec_driver_spi = {
>  module_spi_driver(cros_ec_driver_spi);
>
>  MODULE_LICENSE("GPL v2");
> -MODULE_DESCRIPTION("ChromeOS EC multi function device (SPI)");
> +MODULE_DESCRIPTION("SPI interface for ChromeOS Embedded Controller");
> --
> 2.20.1
>
