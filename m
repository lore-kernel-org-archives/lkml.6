Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-121884-1518786665-2-4013806641452736957
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518786665; b=D328B4N476IJUXj9lsGwwJpqdvrmN9LPrTgxxD7Mt05+8DQ
    n0MHDtMSSEGQfS+YY4atWrEp/md88vYDKym4F1tGl0bB0KgRow+hBMq9qgPmwUIO
    Hj7KZTUePm031VCCNhqgZbL5uqALeu6iL2omh7cxuFuuUxhqcBLH3GoAjmNu0W24
    QZzRWEL0pI//fVKuKw5b6ScLZCCkPMbpepwtNVNdI/DwsdhOO+D1/YQQ1x4p94gC
    10roPq7jpksubPpq289z8qqe8Qj7WI3aRAmws+wxAwV8TALFXyWNdjDtFP7pAqk4
    sGlmxH1G+ZGuOjj9kvgEJTCazh4aKZiPr+/5J4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518786665; bh=2FF0VP9dZGzpp5JX00rXg91/CZ7xun48sK9d+C
    q0dus=; b=GWGIDqbrGZ01S3mS9Sb6fTcAOvT4OBOhr8Rhe/qoRpt7yaixCCdsZu
    6jfJSGnKJ+A4nQUkMcYjFP/84EVZqfyVyaZMN+hnIXwb9LlUxPWPGLrrMBKEZQq+
    wLasSSwGqa2wSzU+j32rQ4bsdOVeKEFzgGOpCGyjxXC+3LtZpA/EL995Q0RmTIN1
    dpHHLi3iRfSi0oM0UN4e7T0UbTcja3d+/IXw0HbZYQciooe5NSZrgMbFqlM2tgE8
    NGe29vddwJEJ5/Sk0BlRhlllya1phiFWmwBewsY8mqU3pnp9AX17jqepicwFoKI/
    R7cusPtJh03A3KGoagfIGDQk4asVF6vA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JacrNMLg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KdZcF8Ja;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JacrNMLg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KdZcF8Ja;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030241AbeBPNK4 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 08:10:56 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:40340 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968084AbeBPNKy (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Feb 2018 08:10:54 -0500
X-Google-Smtp-Source: AH8x2268AmSdr/xYKRg7jTOmkHYH4gcAKmh8Dx/uxM+esFkp2uB2xMAAiWvSCfY+MmbmQ3CnisHt0nAvMlQfa3VuIR0=
MIME-Version: 1.0
In-Reply-To: <20180216104751.8371-12-hdegoede@redhat.com>
References: <20180216104751.8371-1-hdegoede@redhat.com> <20180216104751.8371-12-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 15:10:52 +0200
Message-ID: <CAHp75Vf6h_4UxMSN4fzwALWyt__nUgwr472yZ6x1a4GrupA27g@mail.gmail.com>
Subject: Re: [PATCH 11/12] platform/x86: intel_cht_int33fe: Add device
 connections for the Type-C port
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 12:47 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> We need to add device-connections for the TYPE-C mux/switch and usb-role
> code to be able to find the PI3USB30532 Type-C cross-switch and the
> device/host switch integrated in the CHT SoC.
>

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/platform/x86/intel_cht_int33fe.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index 380ef7ec094f..a3f8674f14da 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -21,6 +21,7 @@
>   */
>
>  #include <linux/acpi.h>
> +#include <linux/connection.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> @@ -33,6 +34,8 @@ struct cht_int33fe_data {
>         struct i2c_client *max17047;
>         struct i2c_client *fusb302;
>         struct i2c_client *pi3usb30532;
> +       /* Contain a list-head must be per device */
> +       struct devcon connections[3];
>  };
>
>  /*
> @@ -172,6 +175,20 @@ static int cht_int33fe_probe(struct i2c_client *client)
>                         return -EPROBE_DEFER; /* Wait for i2c-adapter to load */
>         }
>
> +       data->connections[0].endpoint[0] = "i2c-fusb302";
> +       data->connections[0].endpoint[1] = "i2c-pi3usb30532";
> +       data->connections[0].id = "typec-switch";
> +       data->connections[1].endpoint[0] = "i2c-fusb302";
> +       data->connections[1].endpoint[1] = "i2c-pi3usb30532";
> +       data->connections[1].id = "typec-mux";
> +       data->connections[2].endpoint[0] = "i2c-fusb302";
> +       data->connections[2].endpoint[1] = "intel_xhci_usb_sw-role-switch";
> +       data->connections[2].id = "usb-role-switch";
> +
> +       add_device_connection(&data->connections[0]);
> +       add_device_connection(&data->connections[1]);
> +       add_device_connection(&data->connections[2]);
> +
>         memset(&board_info, 0, sizeof(board_info));
>         strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
>         board_info.dev_name = "fusb302";
> @@ -201,6 +218,10 @@ static int cht_int33fe_probe(struct i2c_client *client)
>         if (data->max17047)
>                 i2c_unregister_device(data->max17047);
>
> +       remove_device_connection(&data->connections[2]);
> +       remove_device_connection(&data->connections[1]);
> +       remove_device_connection(&data->connections[0]);
> +
>         return -EPROBE_DEFER; /* Wait for the i2c-adapter to load */
>  }
>
> @@ -213,6 +234,10 @@ static int cht_int33fe_remove(struct i2c_client *i2c)
>         if (data->max17047)
>                 i2c_unregister_device(data->max17047);
>
> +       remove_device_connection(&data->connections[2]);
> +       remove_device_connection(&data->connections[1]);
> +       remove_device_connection(&data->connections[0]);
> +
>         return 0;
>  }
>
> --
> 2.14.3
>



-- 
With Best Regards,
Andy Shevchenko
