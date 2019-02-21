Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B548DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 170702080F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOBDnzI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfBUNq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:46:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46306 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfBUNq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:46:59 -0500
Received: by mail-pf1-f193.google.com with SMTP id g6so13848047pfh.13;
        Thu, 21 Feb 2019 05:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7rZPa7VPAO7Y3XmtQfQ6RmqrcVYHNlGP9UUpl6tca+Y=;
        b=qOBDnzI2EwLhPIV4fYyeVcN5jFRzYsOQFc/etfahqb0mwk5AGe2jEuaoked72WuPbg
         oJaxr9R0ImS7nj4UJ2rw+DzkhMqchuf6cOzWoakzhSeQMF/MD1hrjK62rSPoOkK4xec7
         rAOrgUU3ZX1Oys1lPdvSzbx12nRAUC25I+DvZuv6azGZjWmUWZUk4brtV0NlvwW9pO3A
         eQ41sZCzVHWFTh6LGsAX8drIQ71ZecZ654BsHXzgRa20ppMyp1TynmbfU7NPNU2E+zHR
         Fj+GnAAqhi2t6YgYcdEz8hofXO4oWfHoYn/7KXsfEEytM44wVAiqBn/xdAvbOTLqx4ep
         +3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rZPa7VPAO7Y3XmtQfQ6RmqrcVYHNlGP9UUpl6tca+Y=;
        b=K2G+GAj8GKrvSuHEY3918XN5/fNeuwyEA/wiR6R48PFvVc50w2FXqZnB8Qz8z195wq
         wj2oNNxzkgtiv8SE0M4q04NkDHyYbJiggH0vnE+D6O87ja81PdM18Gtn8cxMdkC8JwFV
         7DoOHBxUuxVvdIHrDdnDXj4EBFxI9yuRzbcL1b4wrepJLxSZWWSjRGSPS0/cNjF9BQyF
         If2Pm4ELZREwzkpDTbWVW6w1z2j30Zq4s0DrIW1M8pvli4SPBnRvGMsGL9qDizTXFs6C
         qIFUcWmeSuFMcN6YtkhepaZJEHYvsieKfnREaU4u7oOLMrMaGWLxuiQVT0ShyhM4erIV
         otZw==
X-Gm-Message-State: AHQUAuZ5bsTtGXS5iMazv9oIAIQa/FRToshIbOVMTNv4/5lePd6pC259
        IR3IE9V5fSZaAuu2E0Pxk0Bm0bNN6YEiuM6se8O8kszi
X-Google-Smtp-Source: AHgI3IZMnSTOxhBamiAwPGMh0HRKARUK6VVpBmwQRpJ/YGhskDKBqdSlYwpHfctkv2Zgk4rqjEbscfBCuYbGyJjbPEs=
X-Received: by 2002:a63:1c42:: with SMTP id c2mr34244031pgm.265.1550756818096;
 Thu, 21 Feb 2019 05:46:58 -0800 (PST)
MIME-Version: 1.0
References: <20190219115959.55553-1-heikki.krogerus@linux.intel.com> <20190219115959.55553-2-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190219115959.55553-2-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Feb 2019 15:46:46 +0200
Message-ID: <CAHp75Vca+yNuNJaAuB_2_5Vgq8+0FvrBWS1VbvqhAr0nq1UYPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] platform/x86: intel_cht_int33fe: Provide fwnode for
 the USB connector
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 2:00 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> In ACPI, and now also in DT, the USB connectors usually have
> their own device nodes. In case of USB Type-C, those
> connector (port) nodes are child nodes of the controller or
> PHY device, in our case the fusb302. The software fwnodes
> allow us to create a similar child node for fusb302 that
> represents the connector also on Intel CHT.
>
> This makes it possible replace the fusb302 specific device
> properties which were deprecated with the common USB
> connector properties that tcpm.c is able to use directly.
>

This doesn't apply to our for-next branch.

> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/platform/x86/intel_cht_int33fe.c | 48 ++++++++++++++++++++++--
>  1 file changed, 44 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/intel_cht_int33fe.c b/drivers/platform/x86/intel_cht_int33fe.c
> index 6fa3cced6f8e..4857a57cfff5 100644
> --- a/drivers/platform/x86/intel_cht_int33fe.c
> +++ b/drivers/platform/x86/intel_cht_int33fe.c
> @@ -24,6 +24,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> +#include <linux/usb/pd.h>
>
>  #define EXPECTED_PTYPE         4
>
> @@ -31,6 +32,8 @@ struct cht_int33fe_data {
>         struct i2c_client *max17047;
>         struct i2c_client *fusb302;
>         struct i2c_client *pi3usb30532;
> +       struct fwnode_handle *port_node;
> +       struct fwnode_handle *fusb302_node;
>         /* Contain a list-head must be per device */
>         struct device_connection connections[4];
>  };
> @@ -80,9 +83,29 @@ static const struct property_entry max17047_props[] = {
>
>  static const struct property_entry fusb302_props[] = {
>         PROPERTY_ENTRY_STRING("linux,extcon-name", "cht_wcove_pwrsrc"),
> -       PROPERTY_ENTRY_U32("fcs,max-sink-microvolt", 12000000),
> -       PROPERTY_ENTRY_U32("fcs,max-sink-microamp",   3000000),
> -       PROPERTY_ENTRY_U32("fcs,max-sink-microwatt", 36000000),
> +       { }
> +};
> +
> +#define PDO_FIXED_FLAGS \
> +       (PDO_FIXED_DUAL_ROLE | PDO_FIXED_DATA_SWAP | PDO_FIXED_USB_COMM)
> +
> +static const u32 src_pdo[] = {
> +       PDO_FIXED(5000, 1500, PDO_FIXED_FLAGS),
> +};
> +
> +static const u32 snk_pdo[] = {
> +       PDO_FIXED(5000, 400, PDO_FIXED_FLAGS),
> +       PDO_VAR(5000, 12000, 3000),
> +};
> +
> +static const struct property_entry usb_connector_props[] = {
> +       PROPERTY_ENTRY_STRING("name", "connector"),
> +       PROPERTY_ENTRY_STRING("data-role", "dual"),
> +       PROPERTY_ENTRY_STRING("power-role", "dual"),
> +       PROPERTY_ENTRY_STRING("try-power-role", "sink"),
> +       PROPERTY_ENTRY_U32_ARRAY("source-pdos", src_pdo),
> +       PROPERTY_ENTRY_U32_ARRAY("sink-pdos", snk_pdo),
> +       PROPERTY_ENTRY_U32("op-sink-microwatt", 36000000),
>         { }
>  };
>
> @@ -151,6 +174,19 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>         if (!data)
>                 return -ENOMEM;
>
> +       /* Node for the FUSB302 controller */
> +       data->fusb302_node = fwnode_create_software_node(fusb302_props, NULL);
> +       if (IS_ERR(data->fusb302_node))
> +               return PTR_ERR(data->fusb302_node);
> +
> +       /* Node for the connector (FUSB302 is the parent) */
> +       data->port_node = fwnode_create_software_node(usb_connector_props,
> +                                                     data->fusb302_node);
> +       if (IS_ERR(data->port_node)) {
> +               fwnode_remove_software_node(data->fusb302_node);
> +               return PTR_ERR(data->port_node);
> +       }
> +
>         /* Work around BIOS bug, see comment on cht_int33fe_find_max17047 */
>         max17047 = cht_int33fe_find_max17047();
>         if (max17047) {
> @@ -187,7 +223,7 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>         memset(&board_info, 0, sizeof(board_info));
>         strlcpy(board_info.type, "typec_fusb302", I2C_NAME_SIZE);
>         board_info.dev_name = "fusb302";
> -       board_info.properties = fusb302_props;
> +       board_info.fwnode = data->fusb302_node;
>         board_info.irq = fusb302_irq;
>
>         data->fusb302 = i2c_acpi_new_device(dev, 2, &board_info);
> @@ -217,6 +253,8 @@ static int cht_int33fe_probe(struct platform_device *pdev)
>         i2c_unregister_device(data->max17047);
>
>         device_connections_remove(data->connections);
> +       fwnode_remove_software_node(data->port_node);
> +       fwnode_remove_software_node(data->fusb302_node);
>
>         return ret;
>  }
> @@ -230,6 +268,8 @@ static int cht_int33fe_remove(struct platform_device *pdev)
>         i2c_unregister_device(data->max17047);
>
>         device_connections_remove(data->connections);
> +       fwnode_remove_software_node(data->port_node);
> +       fwnode_remove_software_node(data->fusb302_node);
>
>         return 0;
>  }
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
