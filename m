Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C440C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F0420896
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="bV6sVqCX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AkIiyhDk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F0420896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936488AbeFOXR1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 19:17:27 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:44388 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936464AbeFOXR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 19:17:26 -0400
Received: by mail-yb0-f193.google.com with SMTP id w74-v6so4070798ybe.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 16:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vM96b5r0J0IApYjn1EvuJFm6EVn6uI3jLkc4p3gDkXE=;
        b=bV6sVqCXZ9Atnmwn0KeP/SDUZmduutsteBPWe0JhHkTBMMeCvnKDM1jyNLjQzU4/Ok
         whm7ZoaGVnUjagadkRszT3iL9nz97d90bA/wqlrg+iUSK4k8LKwJdpPIE28VgnnocWXm
         PbG7RZXvMV+iwR3wsghkBBqN1Ms6z2pnWPgHrVOk2dXOVPJZ6TYB0SopfLkpKhfi8g9x
         7j9tsaqo+tIePVwNxxA/aORcRHqwPZZIonUwt2kEx1MmO2iknYS/go8/LtwVuUnoA4bw
         2TEHPmXReOuIIaQtONBNXxHFFaTuUufchntFqdonrzdUVniIHGdup/HGt+PcAobH8OVj
         XLVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=vM96b5r0J0IApYjn1EvuJFm6EVn6uI3jLkc4p3gDkXE=;
        b=AkIiyhDkJV5FNXx0buLfh6bxU0QmKz0ZtfWcaE0bOfafvWJaY3tG2jdUKDvCeoUPE3
         /c+ycxlGw9dmszg9yL7PoVp1EV7f99dpxnPpeE9gWnV42pz5iugS+NL46hJeWyHWlWLJ
         W2k1TBXDEuCIrdHTWu52qOBl//Ogss9mmz6+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=vM96b5r0J0IApYjn1EvuJFm6EVn6uI3jLkc4p3gDkXE=;
        b=PIptO4nvn+w+K78kDgLDOCAu/kYlS0zTVK0JH3UKzQMmZVhdi/z3MzbvmSC5n6ar7h
         JvDK27wwAFiSZXh/MiHkeJcqq0fVEr+zOj5UTDz1j5eNdHCO41u8ru6pEZKQPY1rkQ9A
         kRg4Aa1kO2mQyEsivDJf5foMfWb/ARZ9hRs0dUkf5RDsNNOc/b3uzrQKI8AaMMjqZsPH
         xPrXqvJ/WAhZmmL3iczS5K+INrV1Hya1bHy2Rirvu2qTcmiIGuYYysTJ+b9m4CilKikF
         oGqwph60Wymitr7U6szvNV/C8ItYrvuwx07DVbW+/ssuIpMJJ8bRgVFcG3HAnh1Pd41a
         Eq5Q==
X-Gm-Message-State: APt69E14vOOuo9MtMbxig9MX9YzHimbiU1dcFm5WU/Nxdz08pthlTPWR
        vXEGxRQAD+fTvChJY0l0qn/AD/Z2f5NQ/3tCochI/Q==
X-Google-Smtp-Source: ADUXVKIp+oSbBfcf7Rprpt48Hbe8pWdJVKRFlSGHEHwPpwyRZ16wEkTxTX2CTF4BRIV0UzDsUjvDh2LVr5uJwwBxKs0=
X-Received: by 2002:a25:f81e:: with SMTP id u30-v6mr439348ybd.343.1529104645434;
 Fri, 15 Jun 2018 16:17:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 16:17:24
 -0700 (PDT)
In-Reply-To: <1529083699-59319-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528705874-34845-1-git-send-email-jiazhouyang09@gmail.com> <1529083699-59319-1-git-send-email-jiazhouyang09@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Fri, 15 Jun 2018 16:17:24 -0700
X-Google-Sender-Auth: sN-HkOLDOCBbuNZdSPs-UbP0b4o
Message-ID: <CAGXu5jJDk+w7yW-gg9MqeTfmBTPNWcLBYGZ1GmpBP073Hu4GMw@mail.gmail.com>
Subject: Re: [PATCH v3] staging: rtl8192u: add error handling for usb_alloc_urb
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Colin Ian King <colin.king@canonical.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 10:28 AM, Zhouyang Jia <jiazhouyang09@gmail.com> wrote:
> When usb_alloc_urb fails, the lack of error-handling code may
> cause unexpected results.
>
> This patch adds error-handling code after calling usb_alloc_urb.
>
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
> v1->v2:
> - Fix memory leak.
> v2->v3:
> - Release memory in error path.
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index 7a0dbc0..1c980e9 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -1649,12 +1649,12 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
>         for (i = 0; i < (MAX_RX_URB + 1); i++) {
>                 priv->rx_urb[i] = usb_alloc_urb(0, GFP_KERNEL);
>                 if (!priv->rx_urb[i])
> -                       return -ENOMEM;
> +                       goto out_release_mem;

You need to use kcalloc() above here for priv->rx_urb, otherwise you
may free random garbage. :)

-Kees

>
>                 priv->rx_urb[i]->transfer_buffer =
>                         kmalloc(RX_URB_SIZE, GFP_KERNEL);
>                 if (!priv->rx_urb[i]->transfer_buffer)
> -                       return -ENOMEM;
> +                       goto out_release_mem;
>
>                 priv->rx_urb[i]->transfer_buffer_length = RX_URB_SIZE;
>         }
> @@ -1666,9 +1666,13 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
>                 void *oldaddr, *newaddr;
>
>                 priv->rx_urb[16] = usb_alloc_urb(0, GFP_KERNEL);
> +               if (!priv->rx_urb[16])
> +                       goto out_release_mem;
> +
>                 priv->oldaddr = kmalloc(16, GFP_KERNEL);
>                 if (!priv->oldaddr)
> -                       return -ENOMEM;
> +                       goto out_release_mem;
> +
>                 oldaddr = priv->oldaddr;
>                 align = ((long)oldaddr) & 3;
>                 if (align) {
> @@ -1686,17 +1690,19 @@ static short rtl8192_usb_initendpoints(struct net_device *dev)
>         priv->pp_rxskb = kcalloc(MAX_RX_URB, sizeof(struct sk_buff *),
>                                  GFP_KERNEL);
>         if (!priv->pp_rxskb) {
> -               kfree(priv->rx_urb);
> -
> -               priv->pp_rxskb = NULL;
> -               priv->rx_urb = NULL;
> -
>                 DMESGE("Endpoint Alloc Failure");
> -               return -ENOMEM;
> +               goto out_release_mem;
>         }
>
>         netdev_dbg(dev, "End of initendpoints\n");
>         return 0;
> +
> +out_release_mem:
> +       for (i = 0; i < (MAX_RX_URB + 1); i++)
> +               kfree(priv->rx_urb[i]);
> +       kfree(priv->rx_urb);
> +       priv->rx_urb = NULL;
> +       return -ENOMEM;
>  }
>
>  #ifdef THOMAS_BEACON
> --
> 2.7.4
>



-- 
Kees Cook
Pixel Security
