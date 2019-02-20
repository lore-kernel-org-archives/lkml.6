Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41784C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1245C2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 15:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mV6Rb6ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfBTPze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 10:55:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41992 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbfBTPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 10:55:33 -0500
Received: by mail-pg1-f195.google.com with SMTP id b2so6330887pgl.9;
        Wed, 20 Feb 2019 07:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uhag2rwNKK70aMLN2VRSNw9sWHXiG/SkFqYLW8IOrws=;
        b=mV6Rb6ngVmbSCb3mrN43OFqczcc+bKJulcyUzLWHGXr6MBfmHSh/nHCgAmH7Apq4P7
         dI405dZUu1nQkEpPLpPrhmBYnkUH6hxyBtV0tq54y1ZMNwB86S2IpWMgNRbA2aKLUsO8
         RrY6hNzXu9wKpI1MxYG//sZmO6YWuKLiC1H6+HHNMYEeyhH/ZhvbaR9npG+q9DXYmSjE
         dDtZhuCOV7be/YUmUOpufMVZRL2dFVJyA7DWp/wF5jOaWdGrT2QaJkzH44o6FtPOcaEa
         0y6Uw2qRZugkvVEabJSudVmW3j642YNs65rbwnGFp4IHM757WvOTE6Q3YYnR5hzDLUgO
         e3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uhag2rwNKK70aMLN2VRSNw9sWHXiG/SkFqYLW8IOrws=;
        b=VpK1BYpxs3TFxCX+/w0hfqA92qSWc9dy3jJaAjyfnyi7I4cXe+IIJca5hr13RTn3YM
         zQWvsaixiEvyvcXfe8FhGKmU9o5plHkBo8zOnU3cOaHSbyfM7IHpdq3JCvldAfjTpiQq
         LWB6gfJQaIB1w6NY3HXvCoee1PqWise1ic8OSQZ+Y2quuam/KIPst4VZyCWs0pBdaGaK
         rNfHmcFSnvWFvanBPE8rPiKMgjJgBmX3FN/FbSpIjiVFS48WcnCag5yvQBqafNWcmh90
         Cs8VvoCW8OhGybql5/JfxvdcM+OPDTdiliAJJIej9MJZuUE1aNJ69pDn4dbyFvoqQg6k
         xJiA==
X-Gm-Message-State: AHQUAuaLkvOIxbbuAXfu14tiP/QxgEz1zTs0SndbZaa5UiePOzIla6Kb
        Lu4ncPAhg53I46fgo5L07Rt4wGsqsX8h76Qih+I=
X-Google-Smtp-Source: AHgI3IaVwLd5l7QyqECs9wTsAn7AlH5iwFgCx6vWEbQ520mdDCA+EWlWpFDUgfpOLmpv0nDUeab7uXpApgmgumI1TMU=
X-Received: by 2002:aa7:82d5:: with SMTP id f21mr35468186pfn.50.1550678133060;
 Wed, 20 Feb 2019 07:55:33 -0800 (PST)
MIME-Version: 1.0
References: <20190219115959.55553-1-heikki.krogerus@linux.intel.com> <20190219115959.55553-2-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190219115959.55553-2-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 Feb 2019 17:55:21 +0200
Message-ID: <CAHp75VcoqwP5VrOW60XtQHLAO1KOmc_Kyn-KQsZC-tsiwpQq3A@mail.gmail.com>
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

Sounds like a candidate for
devm_fwnode_create_software_node()

> +               return PTR_ERR(data->port_node);
> +       }

-- 
With Best Regards,
Andy Shevchenko
