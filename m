Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338C3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76422147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGV93vXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfBSTc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:32:56 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34286 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfBSTc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 14:32:56 -0500
Received: by mail-qt1-f193.google.com with SMTP id w4so24589329qtc.1;
        Tue, 19 Feb 2019 11:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Pa5SyLYvT8lSMiPEf74ApKPdq55Rw/H7rCnoXk1VjGE=;
        b=FGV93vXC03JU3RHhdkUbmQeg8cjTSjibnfT3NBJqXa1WDjTuXQffTPvVGAS35ZoTZJ
         ue/13Y8V7AMAfkM0W71EnXUH0jV/SwbOlr7iESfE4njVyVs/AwFEP2JZZId98pi2CC7H
         vJTiSTB5D+1mdK3egbVphe9z0EuGI6IYgz0QESuCoJqtbnmM0XqDUeGDaTP8UHJLUHpz
         f7fKg+hW9MMRmB0Z4g6fyvW+oHv5DHKX6hnnKo31/t+qrgCY3+xLDw1qgiVGlBrr9bF3
         xH/QByjWYefWNlkpoZGofD9RYOXn2DUDRZgldogqZgfBjxT+mSHbh7NQqcw1KkpuAVFH
         3DlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Pa5SyLYvT8lSMiPEf74ApKPdq55Rw/H7rCnoXk1VjGE=;
        b=CRNLLucg3baEr9WF6OJy6uSMPMMyvoeaHFu/UeZEOuHGsT9/kIA8V2TnAeu0I2ZPUd
         vkn1c+E9+AWkfPx45wtkoKfa0zRgnMc6RzCvcQ3nWvvAphsN3kY6HA/ED8AdBcJB9RCb
         eFa60sfukfA+ezZzveBwzcEdXpuB5gEeIdClpBfE5ybz7yq85+X3DcIuyDxYMcaNekHh
         68ZV8KqkMn9AkB/HdwjI1vX/XsL5W0wzZOQvx93bcix9t0Pt21bguumga1qxXTRlvWhR
         tqcLHXBUdql6XG7HojhbIXni47YOYjx8Q8nmvcckR04McoJ3vwNs0qfGVB9qXDKLNMFO
         KGAg==
X-Gm-Message-State: AHQUAuYbhzppuGGemTDxBpKM1OpdqxjPrA2oirC3c8q8Q5cJAnzdXKWp
        KdnsYTuBxwDyhHFLFPIlLOhAO2aUwRlsmrP13KA=
X-Google-Smtp-Source: AHgI3IaVSJQd6qEMElh1aCrtIMTgZy22KzUpcbVajlKu041Mai/6oZg3rDufKBK/IxXYevRJT/A+tPzg8ivdjZ0bzYI=
X-Received: by 2002:a0c:b590:: with SMTP id g16mr6268620qve.146.1550604774754;
 Tue, 19 Feb 2019 11:32:54 -0800 (PST)
MIME-Version: 1.0
References: <CAKgEEwsOHqV-PtJnc-5nXAuH3BVitXWt80eoENJa3wZ6vGZDpw@mail.gmail.com>
 <20190219193027.13882-1-jbroadus@gmail.com>
In-Reply-To: <20190219193027.13882-1-jbroadus@gmail.com>
From:   Jim Broadus <jbroadus@gmail.com>
Date:   Tue, 19 Feb 2019 11:32:43 -0800
Message-ID: <CAKgEEwtTJWTAdYF1FAZC_zMXaPu_fJTqaAiLHQK6_6K63VHEkg@mail.gmail.com>
Subject: Re: [PATCH] i2c: Allow recovery of the initial IRQ by an I2C client device.
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, wsa@the-dreams.de,
        linux-i2c@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies.. This should have been marked v2.

On Tue, Feb 19, 2019 at 11:30 AM Jim Broadus <jbroadus@gmail.com> wrote:
>
> A previous change allowed I2C client devices to discover new IRQs upon
> reprobe by clearing the IRQ in i2c_device_remove. However, if an IRQ was
> assigned in i2c_new_device, that information is lost.
>
> For example, the touchscreen and trackpad devices on a Dell Inspiron laptop
> are I2C devices whose IRQs are defined by ACPI extended IRQ types. The
> client device structures are initialized during an ACPI walk. After
> removing the i2c_hid device, modprobe fails.
>
> This change caches the initial IRQ value in i2c_new_device and then resets
> the client device IRQ to the initial value in i2c_device_remove.
>
> Fixes: 6f108dd70d30 ("i2c: Clear client->irq in i2c_device_remove")
> Signed-off-by: Jim Broadus <jbroadus@gmail.com>
> ---
>  drivers/i2c/i2c-core-base.c | 9 +++++----
>  include/linux/i2c.h         | 1 +
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 28460f6a60cc..af87a16ac3a5 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -430,7 +430,7 @@ static int i2c_device_remove(struct device *dev)
>         dev_pm_clear_wake_irq(&client->dev);
>         device_init_wakeup(&client->dev, false);
>
> -       client->irq = 0;
> +       client->irq = client->init_irq;
>
>         return status;
>  }
> @@ -741,10 +741,11 @@ i2c_new_device(struct i2c_adapter *adap, struct i2c_board_info const *info)
>         client->flags = info->flags;
>         client->addr = info->addr;
>
> -       client->irq = info->irq;
> -       if (!client->irq)
> -               client->irq = i2c_dev_irq_from_resources(info->resources,
> +       client->init_irq = info->irq;
> +       if (!client->init_irq)
> +               client->init_irq = i2c_dev_irq_from_resources(info->resources,
>                                                          info->num_resources);
> +       client->irq = client->init_irq;
>
>         strlcpy(client->name, info->type, sizeof(client->name));
>
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 65b4eaed1d96..7e748648c7d3 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -333,6 +333,7 @@ struct i2c_client {
>         char name[I2C_NAME_SIZE];
>         struct i2c_adapter *adapter;    /* the adapter we sit on        */
>         struct device dev;              /* the device structure         */
> +       int init_irq;                   /* irq set at initialization    */
>         int irq;                        /* irq issued by device         */
>         struct list_head detected;
>  #if IS_ENABLED(CONFIG_I2C_SLAVE)
> --
> 2.20.1
>
