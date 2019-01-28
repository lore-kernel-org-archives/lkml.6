Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8691C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FE821736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6XloYzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfA1JqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:46:12 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36080 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfA1JqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:46:11 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so7768453pfc.3;
        Mon, 28 Jan 2019 01:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7NsdGuhfpzjivgF6iCPjOnhzyLEtHlCsXtj3lRqcdaw=;
        b=L6XloYzY/KJ4U0OzScGBiuExNUvV9axfN0DviSqHzx1cZvsOojCa8hvfD+yWaFxQ8j
         k4i9cHdDL9oxBT4rfaCw7MLW8v+rYQPKD8lKV6APmffRawGdwYPn5us22xpJL0P6jQqe
         CYI9jxJscAfg5OqAeOpMlsEn71A4FT5IuVPzbI8AfqGauQVvt/GThP1jl57eWBxG//pc
         dieJkd5LtOawm5tLiKyVPbXPJYp4h2D2EHmvwynAt3FJ97eijpmnfmQQNEt9t6vlUbQx
         knjtI4GAAa1/WkH+BfWcyF8LsRvoczPRUEp5lvLdRmQ25MK4R/c3h8C6Ry5Qqp1XenrM
         sf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7NsdGuhfpzjivgF6iCPjOnhzyLEtHlCsXtj3lRqcdaw=;
        b=VVzGQ66TE7kn8rUiKfeHjzAfJD7I02HQ85rKvtaO2yw88iOalwdKki+XjpAicvHJV/
         aKIC8ZPSaToa8iWZhTCk3Bafp34nao141SgEcY0094Nue5lQWbXoB91w+b+Vl2jNcbUe
         PN14/YTtee7gVzMAiRVzlULl9XGRTJ2+JF04RQdyvtGNB5PQCJaC/lub4FbdzkiPiGj3
         w2gco6MEG8FKh8qR1Zh80EficmOQtnecv+kzdtSO1n2GIgwwAIHRhDU/3Zyzd2SnvU96
         849LPeQru6aymNB/eBqvSTKA7G1C+KgLecLxBWq7kJPbRe9NVHNSUBY099K/VAFnmoVp
         Zvsw==
X-Gm-Message-State: AJcUukdch19AHe8bohayI2SiXqSupuxQ0Vvjk+DIUhxE+WZJHHxG2jZh
        KKWrTVwYVhK80tSdepEa+7DAF/uuP04cH4sIiZI=
X-Google-Smtp-Source: ALg8bN5/Pf2empEFShb3yMI/3UpPUw2UBKVAVsT5lMX6c+Jirc6RykWRdMWtn6uUFI87Ofr5Ez8byIjJuX60xO1rs5g=
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr19059867pgh.265.1548668770570;
 Mon, 28 Jan 2019 01:46:10 -0800 (PST)
MIME-Version: 1.0
References: <20190125131519.88416-1-heikki.krogerus@linux.intel.com> <20190125131519.88416-2-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190125131519.88416-2-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Jan 2019 11:45:59 +0200
Message-ID: <CAHp75Vf1w6fOUp968S=5=-3jsG6x6JAcwR=uxzk9eMjXc7H_ZQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] platform/x86: intel_cht_int33fe: Remove connection
 for the alt mode mux
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

On Fri, Jan 25, 2019 at 3:17 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Driver for fusb302 does not support alternate modes, so the
> connection is not really needed for now. Removing that
> connection description allows us to improve the USB Type-C
> mux API.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
supposed to go via USB tree.

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/platform/x86/intel_cht_int33fe.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index 02bc74608cf3..fbd24daa7f8d 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -32,7 +32,7 @@ struct cht_int33fe_data {
>         struct i2c_client *fusb302;
>         struct i2c_client *pi3usb30532;
>         /* Contain a list-head must be per device */
> -       struct device_connection connections[5];
> +       struct device_connection connections[4];
>  };
>
>  /*
> @@ -178,12 +178,9 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>         data->connections[1].endpoint[0] = "port0";
>         data->connections[1].endpoint[1] = "i2c-pi3usb30532";
>         data->connections[1].id = "typec-mux";
> -       data->connections[2].endpoint[0] = "port0";
> -       data->connections[2].endpoint[1] = "i2c-pi3usb30532";
> -       data->connections[2].id = "idff01m01";
> -       data->connections[3].endpoint[0] = "i2c-fusb302";
> -       data->connections[3].endpoint[1] = "intel_xhci_usb_sw-role-switch";
> -       data->connections[3].id = "usb-role-switch";
> +       data->connections[2].endpoint[0] = "i2c-fusb302";
> +       data->connections[2].endpoint[1] = "intel_xhci_usb_sw-role-switch";
> +       data->connections[2].id = "usb-role-switch";
>
>         device_connections_add(data->connections);
>
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
