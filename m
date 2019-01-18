Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A1DAC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB8520850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHIzpgdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfARQaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:30:25 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:41631 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727490AbfARQaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:30:24 -0500
Received: by mail-vk1-f194.google.com with SMTP id t127so3193717vke.8;
        Fri, 18 Jan 2019 08:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f65MArzmJU0qkiDNGEa6uWblqhHifD4FZOoEhv0gxyQ=;
        b=YHIzpgdVyJgHEQVmqDTpgWWF7BKvcgZmGezY0dwEBbGcjWcLAeSXi84OJUTeFQ0QSG
         UUuHHKbgEH01+R182RzKhfcM04EGTW5TACaHFilYgo0MJFXndlVPfUhSXXC+jJE+LvAY
         qed/fe+c/P/OuVMWingA70DKF6GfyYObsYkvhl3WMkwLVEASTgFOkaLyz51oBN9r4XO+
         RXcDVsk3SVe9mltfoKAAEvnrq/ukpK7f5C/IuScSWqbeaTloN5+3ZuL6UUpv2kWFIWQa
         bLCwcCjWY7wNrTT6M+WsKj9ACJloX0v6xnrT2fu/wRvio+TsGf6oUuKjamCokheAWGhy
         dTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f65MArzmJU0qkiDNGEa6uWblqhHifD4FZOoEhv0gxyQ=;
        b=K3myADAC7sxaHmgkfXX4SJBLcYPepGDtWdgM4iYs9K9o3VeAwf7291Mcv5Mjl/iHPo
         gyJglqWG1kPFt4caToYMmyHRJU/4R44+OCOQMwQYjsFwOVZ102cnS5ROkQZAN3tPAMjv
         vPbBRdpe/mVAA0lCQZaE3qxcw9YbrdiQRufUqRQz7tpFv3cn9jsdQS9e/gywol8JlnG9
         21Oi4tq5TpfoC2i04hOD8wMpF2C0Yu7m8cjwoo02WTfTiaOzIuD7+Y7Hv9gX2MPzmuow
         sZw5/cd8gERURsiP3eJCENrNQNFNrN9kQ2Dm1HHrtjAUiYZOcjcUzwFGfHAvGO8u59Eg
         e2Dw==
X-Gm-Message-State: AJcUukcezI2wa0tdICxodTvz0gmhF9cumxEjQ8zHxu7PFUFZ9Re5TSkE
        KJ/QTR4mSeq07Y885WOu3jtstwr90YgSmcC4hcI=
X-Google-Smtp-Source: ALg8bN6GT54lpdo7t3h5zVmhQ+pRlUbtcjKWILHMm48422T3/Gq9T87+LFb0pcEdubQ7b45M4+oBBKy5o523SUtjFsA=
X-Received: by 2002:a1f:4245:: with SMTP id p66mr7513800vka.48.1547829022987;
 Fri, 18 Jan 2019 08:30:22 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1901181147160.1647@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1901181147160.1647@nanos.tec.linutronix.de>
From:   Shannon Nelson <shannon.lee.nelson@gmail.com>
Date:   Fri, 18 Jan 2019 08:30:12 -0800
Message-ID: <CAP-MU4M4FzAvgFodk1gm2dERJcuoJLCdX3QFFJMNDjFGvfGptw@mail.gmail.com>
Subject: Re: [PATCH] net: sun: cassini: Cleanup license conflict
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Shannon Nelson <shannon.nelson@oracle.com>,
        Zhu Yanjun <yanjun.zhu@oracle.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 2:51 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The recent addition of SPDX license identifiers to the files in
> drivers/net/ethernet/sun created a licensing conflict.
>
> The cassini driver files contain a proper license notice:
>
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License as
>   * published by the Free Software Foundation; either version 2 of the
>   * License, or (at your option) any later version.
>
> but the SPDX change added:
>
>    SPDX-License-Identifier: GPL-2.0
>
> So the file got tagged GPL v2 only while in fact it is licensed under GPL
> v2 or later.
>
> It's nice that people care about the SPDX tags, but they need to be more
> careful about it. Not everything under (the) sun belongs to ...
>
> Fix up the SPDX identifier and remove the boiler plate text as it is
> redundant.
>
> Fixes: c861ef83d771 ("sun: Add SPDX license tags to Sun network drivers")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Shannon Nelson <shannon.nelson@oracle.com>
> Cc: Zhu Yanjun <yanjun.zhu@oracle.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Cc: stable@vger.kernel.org

Thanks, Thomas.

Acked-by: Shannon Nelson <shannon.lee.nelson@gmail.com>

> ---
>  drivers/net/ethernet/sun/cassini.c |   15 +--------------
>  drivers/net/ethernet/sun/cassini.h |   15 +--------------
>  2 files changed, 2 insertions(+), 28 deletions(-)
>
> --- a/drivers/net/ethernet/sun/cassini.c
> +++ b/drivers/net/ethernet/sun/cassini.c
> @@ -1,22 +1,9 @@
> -// SPDX-License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0+
>  /* cassini.c: Sun Microsystems Cassini(+) ethernet driver.
>   *
>   * Copyright (C) 2004 Sun Microsystems Inc.
>   * Copyright (C) 2003 Adrian Sun (asun@darksunrising.com)
>   *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of the
> - * License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, see <http://www.gnu.org/licenses/>.
> - *
>   * This driver uses the sungem driver (c) David Miller
>   * (davem@redhat.com) as its basis.
>   *
> --- a/drivers/net/ethernet/sun/cassini.h
> +++ b/drivers/net/ethernet/sun/cassini.h
> @@ -1,23 +1,10 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0+ */
>  /* $Id: cassini.h,v 1.16 2004/08/17 21:15:16 zaumen Exp $
>   * cassini.h: Definitions for Sun Microsystems Cassini(+) ethernet driver.
>   *
>   * Copyright (C) 2004 Sun Microsystems Inc.
>   * Copyright (c) 2003 Adrian Sun (asun@darksunrising.com)
>   *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of the
> - * License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, see <http://www.gnu.org/licenses/>.
> - *
>   * vendor id: 0x108E (Sun Microsystems, Inc.)
>   * device id: 0xabba (Cassini)
>   * revision ids: 0x01 = Cassini



-- 
==============================================
Mr. Shannon Nelson         Parents can't afford to be squeamish.
