Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563C0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137DB2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 13:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+oDOV0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfBUNXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 08:23:18 -0500
Received: from mail-pl1-f179.google.com ([209.85.214.179]:46587 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfBUNXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 08:23:18 -0500
Received: by mail-pl1-f179.google.com with SMTP id o6so14173328pls.13;
        Thu, 21 Feb 2019 05:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0h6YK9AEn/TMH0UjwXVhFZS6qxdIQiKwyw5VI7s2gi8=;
        b=p+oDOV0/Wp1ftSYh77rNBU3td0lHBESaxJziBRq0E5hFO8UJxs5M8xydiC+nX9b7WQ
         p6tdDxOl5HR9wxIsKb21nONmWb0ZK4ZCcDQDD39MZjgwTd9JZojNwaDbhy/JLDaVRfsG
         JvKB+YXAZYOwNYX8diPwoM358DzYcN3AXHdAQCHuDpfbMnFgOmtPq0aYWi3pgNwm+UFE
         9TWVBAlgvWfLORkCW5Idvb/EbjsIf44OmSi3CaWdmqvQxe3S30GsO4RacIPn82MHOunP
         X2VYuEVGE6uf8SprI5yChyY8fwSgZcXPgwUD+w6cpj1kG7lJBicNu3RSlyVwhfRAFE2r
         I+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0h6YK9AEn/TMH0UjwXVhFZS6qxdIQiKwyw5VI7s2gi8=;
        b=tdRyS42hcxfYHV2ect/72PufdXexPMVaO3m3416BzYotjlnqwX1LoHndTFkZbc/kyx
         KGHKcYFta/Y6Vqh9mXxcNqnJpVqKfUtkzRIRTdxR+sb2GMgbJLYTjEW6Oz8Sadke0cmg
         Q7lYc358BbTCU+0bbk/11Tq/rjpV9NFi1kT763bMIGf+dpoi9yLM8W2sby86ULsaZ8jM
         MxooWqHWPrOiwyZ0Fj4J0pIvR7bmGgOfXbuhmLXdCgq/TlgxaGW0fDpQxJ8PJdxbhbwp
         3lBRyT5osGUEX486briQZUtC8cCQmd5/2HkGEbZ3FB/DNUJq8h803XbkEP2MKQLlcvyE
         cmeg==
X-Gm-Message-State: AHQUAuYyk8/8Qd5D8kdmGjnyJdieQ+bt4+CkXzMCl7z0k4d5/ZiYiOmt
        Wrvl8M0/2yG8BvSDnGSDWkU0QeWCnhMYLvfc9HI=
X-Google-Smtp-Source: AHgI3IZYW+J+EDDQLwSxV/39dKOVQFY2GVWh3+Oo/WgbHNjxRHlwjHTO5EuS16VIU9AE54/qNhEwfNUra4HlKaEjKq0=
X-Received: by 2002:a17:902:2468:: with SMTP id m37mr42696672plg.314.1550755397585;
 Thu, 21 Feb 2019 05:23:17 -0800 (PST)
MIME-Version: 1.0
References: <20190219115959.55553-1-heikki.krogerus@linux.intel.com>
 <20190219115959.55553-2-heikki.krogerus@linux.intel.com> <CAHp75VcoqwP5VrOW60XtQHLAO1KOmc_Kyn-KQsZC-tsiwpQq3A@mail.gmail.com>
 <20190221093508.GF5054@kuha.fi.intel.com>
In-Reply-To: <20190221093508.GF5054@kuha.fi.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Feb 2019 15:23:05 +0200
Message-ID: <CAHp75Vd5uxVEyv3Wx-Xcv58UHXaS8um6dPDELPz5AdG1nbpFHg@mail.gmail.com>
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

On Thu, Feb 21, 2019 at 11:35 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Wed, Feb 20, 2019 at 05:55:21PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 19, 2019 at 2:00 PM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > In ACPI, and now also in DT, the USB connectors usually have
> > > their own device nodes. In case of USB Type-C, those
> > > connector (port) nodes are child nodes of the controller or
> > > PHY device, in our case the fusb302. The software fwnodes
> > > allow us to create a similar child node for fusb302 that
> > > represents the connector also on Intel CHT.
> > >
> > > This makes it possible replace the fusb302 specific device
> > > properties which were deprecated with the common USB
> > > connector properties that tcpm.c is able to use directly.
> >
> > > +       /* Node for the FUSB302 controller */
> > > +       data->fusb302_node = fwnode_create_software_node(fusb302_props, NULL);
> > > +       if (IS_ERR(data->fusb302_node))
> > > +               return PTR_ERR(data->fusb302_node);
> > > +
> > > +       /* Node for the connector (FUSB302 is the parent) */
> > > +       data->port_node = fwnode_create_software_node(usb_connector_props,
> > > +                                                     data->fusb302_node);
> > > +       if (IS_ERR(data->port_node)) {
> >
> > > +               fwnode_remove_software_node(data->fusb302_node);
> >
> > Sounds like a candidate for
> > devm_fwnode_create_software_node()
>
> If you don't mind, let's think about that later.

Sure.

>
> I'm not comfortable at all with the idea of introducing
> devm_fwnode_create_software_node(). I would like to talk about that
> separately. It's not going to be a problem to change this driver later
> even if we decide to add the function.

-- 
With Best Regards,
Andy Shevchenko
