Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1EAC282CC
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9802321736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3xgZtyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfA1Juo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:50:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45655 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfA1Jun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:50:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so7487765plm.12;
        Mon, 28 Jan 2019 01:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8vqIFNWGxmEi02L7rnJUgrqlsCWbtVks6SuyByrmTAI=;
        b=o3xgZtyTKSowEuLdwHnFFO4+MKnr1gD0gn7/c8oh6KyM7YHvEphY7ObAt2uiL9hndC
         1onq2ZDM+HdcY8lLQx0GW/wL3/yn0/YqBbbp86+J8Q6d9DsHJYzHbrT+fTwmWgJnN7RA
         np7Er+etjf2gQZ0/7YbBw/1Sk6rAwUUuX+DQl8BDdp9CUKLzuEZKVxDmCGXaGpRBZq1T
         9I14nVlzsIaCR+vK5EyX0Ej6IOlY9D2+JUvYO9wxKdoeAx3w8l4oi5EX/LOdGSvy6ky+
         piq/9o58iwsGONnFEaL1+Yiqt3h6xGoLHJDRICFnQpKcc5oCyQW/avVLihGaAvzYggn0
         fsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vqIFNWGxmEi02L7rnJUgrqlsCWbtVks6SuyByrmTAI=;
        b=Km2NnLAwNJS72NuFiUlRXdMdUgqvMNLYS+Us5iNq0Leo1rH95eVNy9oNOZMIq5Tiez
         +rkllC3K3HQA0yFb/L1BxyaschmvA3xNbgXaaxidPGe8WORKNKHpH6VfXP/O0NENRy2A
         3WsJ6516YV4fR1aBO7uVl6DhxR4WmLfvDp4NPdiLrZZwblLanjoMqaNSPTsvJjuOFBy2
         foB9tIlDr/y+ZCMlRv/BnGiw59bzcODjgdQSft1OsVOcMUhawv9pfL+UcvJRnbMtVkcC
         hmLTvjJrD1ROvpdM1b3mxYCURTKuWoXeCOH475xosm+Jpc2gpOaqK53jyFKF2JZgx7Yn
         sjQA==
X-Gm-Message-State: AJcUukf4Nea0zmXi4nOzG3We1Zr04lf6TojN7RC2+zW1IrGWObA8Sz6F
        K9vLbIONUrMBa6O6lqBt8aT4Z0rg2MKx9xBfiCo=
X-Google-Smtp-Source: ALg8bN4c9YbGtJ4EAKEdu8RfHw85P3QTwVwj2kI/dvMLuuLYKWBJcNG6fCKGvJLS4Scl9DfHmJKK7RHf0KdWwjPxD44=
X-Received: by 2002:a17:902:e28e:: with SMTP id cf14mr21500664plb.311.1548669042992;
 Mon, 28 Jan 2019 01:50:42 -0800 (PST)
MIME-Version: 1.0
References: <20190125131519.88416-1-heikki.krogerus@linux.intel.com> <20190125131519.88416-3-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190125131519.88416-3-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Jan 2019 11:50:31 +0200
Message-ID: <CAHp75VctbnJcLdTrGfPju708StpNPzmzTCBb-B-gmKZzOQwteg@mail.gmail.com>
Subject: Re: [PATCH 2/8] usb: typec: Rationalize the API for the muxes
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 3:18 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> We can replace the second parameter that is passed to the
> typec_mux_get() function with alt mode description
> structure, and simply pass NULL with accessory modes.
>
> With accessory modes there is no need for additional
> identification (in practice the accessory mode can only be
> Audio Accessory if muxing is needed), only with alternate
> modes we need to identify the exact alternate mode.

> +struct typec_mux *typec_mux_get(struct device *dev,
> +                               const struct typec_altmode_desc *desc)
>  {
>         struct typec_mux *mux;
>
>         mutex_lock(&mux_lock);
> -       mux = device_connection_find_match(dev, name, NULL, typec_mux_match);
> +       mux = device_connection_find_match(dev, "typec-mux", (void *)desc,
> +                                          typec_mux_match);

Not related to this series, but shouldn't
device_connection_find_match() be improved to avoid dropping const
qualifier?

-- 
With Best Regards,
Andy Shevchenko
