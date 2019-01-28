Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E6EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1972171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 19:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZYGJi95T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfA1Tdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 14:33:42 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42558 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbfA1Tdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 14:33:42 -0500
Received: by mail-yw1-f66.google.com with SMTP id x2so7198703ywc.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 11:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZfxxxME69onaNjPMDOsr5DadUmPAnbbhCDiGa/b/0qU=;
        b=ZYGJi95TsfruNFlSt2vp0dn6T0ippRYsjJzCkWpsY4ED/+0N00AnGETUj3Bm4FV/zd
         2oSwzR5ICPv2qLZ5927RiJw2FPQXkIVk6ZbZDXorb2CwVm9fMmwm9UT3dAYcROtwdaCV
         niupjOcHKBU7qkvnJtxzQAkoEjtrP0vLTzNMv5/IaV8TpwaHZv6r3A114FM9kKlB0bhc
         FHu38MIKEqvn2G09btK6a+MGw8urNIPlwgNiXDvhXcj4xbafjV5drTT6fzuprlTV45dK
         klNQtffAp7x29asuasJ1RQxtOt4gNPC0oUX1XA7Gd1p+txrn2MN7agGm1Hwcfz9oDrGm
         63vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZfxxxME69onaNjPMDOsr5DadUmPAnbbhCDiGa/b/0qU=;
        b=b7voK4rV6FHTGhVD+nizEQmhZAHociGviRA1yPPPZdce2KkOo/ypPYQogxDKEVf4Oh
         drnCDvvsWqIkDlQ65QECAea0ScixtefxVvLWcg9OtqYGD2z6znVriHLG9qbq8dN+61ux
         AxoycsOZnw5nwwmAK96McVOZzae6VssRRK8ows0yxL+OoSHRgYM0mzblhAAYCjFr2qQJ
         d4xLL12Gx7VrsYJGL6OAYosKPMJ88BU3tU7mCv4thQSl7OuTosuBntMBKPKVl/+kMmKd
         2mHPPVaASoOj1L1/J7EDeAatDZZFsYtDOcc1vCIF+Qe+zk7dj9mwt9Q8lvv9qXy4OHfd
         4UaQ==
X-Gm-Message-State: AJcUukckbMAVIumKsZjxjCsKKEZnzoFRrFKMFgLuRSOWQplfN20eGiM3
        5/ZyHcbjrefr+2RF4QeXEJNDWCOQyhnayW0ApEw8fg==
X-Google-Smtp-Source: ALg8bN5/OIexs0JXgwzMxUOjyW77LOum4N3UuFDOAHT7slnds4roGBozq14VpgMK32fMFwfQheDXZ9ECvqK88Gc13ao=
X-Received: by 2002:a81:210b:: with SMTP id h11mr14103154ywh.299.1548704020612;
 Mon, 28 Jan 2019 11:33:40 -0800 (PST)
MIME-Version: 1.0
References: <20190126095131.4756-1-enric.balletbo@collabora.com> <20190126095131.4756-8-enric.balletbo@collabora.com>
In-Reply-To: <20190126095131.4756-8-enric.balletbo@collabora.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 28 Jan 2019 11:33:29 -0800
Message-ID: <CABXOdTfUAsHttpy5RL861OEmjP-Cxhs_jJ_DbjssN17tbJ0Nzg@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] platform/chrome: cros_ec_lpc: switch to SPDX identifier
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
> management. Also remove the license boiler-plate and redundant driver
> description.
>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>
> Changes in v2: None
>
>  drivers/platform/chrome/cros_ec_lpc.c     | 34 ++++++++---------------
>  drivers/platform/chrome/cros_ec_lpc_mec.c | 26 +++--------------
>  drivers/platform/chrome/cros_ec_lpc_mec.h | 20 ++-----------
>  drivers/platform/chrome/cros_ec_lpc_reg.c | 26 +++--------------
>  drivers/platform/chrome/cros_ec_lpc_reg.h | 20 ++-----------
>  5 files changed, 24 insertions(+), 102 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
> index 14684a56e40f..c9c240fbe7c6 100644
> --- a/drivers/platform/chrome/cros_ec_lpc.c
> +++ b/drivers/platform/chrome/cros_ec_lpc.c
> @@ -1,25 +1,15 @@
> -/*
> - * cros_ec_lpc - LPC access to the Chrome OS Embedded Controller
> - *
> - * Copyright (C) 2012-2015 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * This driver uses the Chrome OS EC byte-level message-based protocol for
> - * communicating the keyboard state (which keys are pressed) from a keyboard EC
> - * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
> - * but everything else (including deghosting) is done here.  The main
> - * motivation for this is to keep the EC firmware as simple as possible, since
> - * it cannot be easily upgraded and EC flash/IRAM space is relatively
> - * expensive.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// LPC interface for ChromeOS Embedded Controller
> +//
> +// Copyright (C) 2012-2015 Google, Inc
> +//
> +// This driver uses the ChromeOS EC byte-level message-based protocol for
> +// communicating the keyboard state (which keys are pressed) from a keyboard EC
> +// to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
> +// but everything else (including deghosting) is done here.  The main
> +// motivation for this is to keep the EC firmware as simple as possible, since
> +// it cannot be easily upgraded and EC flash/IRAM space is relatively
> +// expensive.
>
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
> diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.c b/drivers/platform/chrome/cros_ec_lpc_mec.c
> index c4edfa83e493..296554a82b83 100644
> --- a/drivers/platform/chrome/cros_ec_lpc_mec.c
> +++ b/drivers/platform/chrome/cros_ec_lpc_mec.c
> @@ -1,25 +1,7 @@
> -/*
> - * cros_ec_lpc_mec - LPC variant I/O for Microchip EC
> - *
> - * Copyright (C) 2016 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * This driver uses the Chrome OS EC byte-level message-based protocol for
> - * communicating the keyboard state (which keys are pressed) from a keyboard EC
> - * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
> - * but everything else (including deghosting) is done here.  The main
> - * motivation for this is to keep the EC firmware as simple as possible, since
> - * it cannot be easily upgraded and EC flash/IRAM space is relatively
> - * expensive.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// LPC variant I/O for Microchip EC
> +//
> +// Copyright (C) 2016 Google, Inc
>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> diff --git a/drivers/platform/chrome/cros_ec_lpc_mec.h b/drivers/platform/chrome/cros_ec_lpc_mec.h
> index 105068c0e919..68b381f2eb50 100644
> --- a/drivers/platform/chrome/cros_ec_lpc_mec.h
> +++ b/drivers/platform/chrome/cros_ec_lpc_mec.h
> @@ -1,24 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * cros_ec_lpc_mec - LPC variant I/O for Microchip EC
> + * LPC variant I/O for Microchip EC
>   *
>   * Copyright (C) 2016 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * This driver uses the Chrome OS EC byte-level message-based protocol for
> - * communicating the keyboard state (which keys are pressed) from a keyboard EC
> - * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
> - * but everything else (including deghosting) is done here.  The main
> - * motivation for this is to keep the EC firmware as simple as possible, since
> - * it cannot be easily upgraded and EC flash/IRAM space is relatively
> - * expensive.
>   */
>
>  #ifndef __CROS_EC_LPC_MEC_H
> diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.c b/drivers/platform/chrome/cros_ec_lpc_reg.c
> index fc23d535c404..72fc3f6bff90 100644
> --- a/drivers/platform/chrome/cros_ec_lpc_reg.c
> +++ b/drivers/platform/chrome/cros_ec_lpc_reg.c
> @@ -1,25 +1,7 @@
> -/*
> - * cros_ec_lpc_reg - LPC access to the Chrome OS Embedded Controller
> - *
> - * Copyright (C) 2016 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * This driver uses the Chrome OS EC byte-level message-based protocol for
> - * communicating the keyboard state (which keys are pressed) from a keyboard EC
> - * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
> - * but everything else (including deghosting) is done here.  The main
> - * motivation for this is to keep the EC firmware as simple as possible, since
> - * it cannot be easily upgraded and EC flash/IRAM space is relatively
> - * expensive.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +// LPC interface for ChromeOS Embedded Controller
> +//
> +// Copyright (C) 2016 Google, Inc
>
>  #include <linux/io.h>
>  #include <linux/mfd/cros_ec.h>
> diff --git a/drivers/platform/chrome/cros_ec_lpc_reg.h b/drivers/platform/chrome/cros_ec_lpc_reg.h
> index 1c12c38b306a..416fd2572182 100644
> --- a/drivers/platform/chrome/cros_ec_lpc_reg.h
> +++ b/drivers/platform/chrome/cros_ec_lpc_reg.h
> @@ -1,24 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * cros_ec_lpc_reg - LPC access to the Chrome OS Embedded Controller
> + * LPC interface for ChromeOS Embedded Controller
>   *
>   * Copyright (C) 2016 Google, Inc
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * This driver uses the Chrome OS EC byte-level message-based protocol for
> - * communicating the keyboard state (which keys are pressed) from a keyboard EC
> - * to the AP over some bus (such as i2c, lpc, spi).  The EC does debouncing,
> - * but everything else (including deghosting) is done here.  The main
> - * motivation for this is to keep the EC firmware as simple as possible, since
> - * it cannot be easily upgraded and EC flash/IRAM space is relatively
> - * expensive.
>   */
>
>  #ifndef __CROS_EC_LPC_REG_H
> --
> 2.20.1
>
