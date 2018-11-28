Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945EFC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E542206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ymxyDDzM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E542206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbeK2Diw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:38:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728851AbeK2Div (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:38:51 -0500
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52E3B214DA;
        Wed, 28 Nov 2018 16:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543422996;
        bh=K6dvJOWnWwclndwiLaXgPxED1CnjOMJJUnJllxffuXM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ymxyDDzMznsJRNiKocnZ5Xh3VeHnn1FzAJ/+6Kf/W7i3L9vSUn031+mmEbri7EPps
         2GdIcy/a5gqZD+9v9M+vDAUQ0x2/NR+n4vzYEk7GvaSHjyRHp1o49mCpQybQVpg7ys
         2k8F+ga6Reobx8Uz1lGEdFXQHq5IxbYzPZsi7naw=
Received: by mail-qk1-f177.google.com with SMTP id y78so6394326qka.12;
        Wed, 28 Nov 2018 08:36:36 -0800 (PST)
X-Gm-Message-State: AA+aEWZZYK6DP/4Hp+V3AxHskoDgy6gl9D6WWeVxZP4ZSZGZXdmBIwbt
        mTY8lERjAPRnlyRC6S8aFhOidvUDFyAPW408Zg==
X-Google-Smtp-Source: AFSGD/V+0/aKIdHPZe/wskc7jnwZGcWO8gd65Yvwt+cvVsSOlvP4yYlo/ddN01GIzHr8onJO7dQa7GsodvHdhR8Zr/4=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr34872725qkg.147.1543422995313;
 Wed, 28 Nov 2018 08:36:35 -0800 (PST)
MIME-Version: 1.0
References: <20181121150709.6030-1-TheSven73@googlemail.com>
 <20181121150709.6030-7-TheSven73@googlemail.com> <20181126220804.GA23069@bogus>
 <CAGngYiWBBe7P80ASQJnS8woe6SKLgNUmqKxOHMeyV1fGSCpY_w@mail.gmail.com>
In-Reply-To: <CAGngYiWBBe7P80ASQJnS8woe6SKLgNUmqKxOHMeyV1fGSCpY_w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 28 Nov 2018 10:36:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK--6UE9N2je3mkoxf_0+i5fTYqYpmTF2bpzFf-KRjhaQ@mail.gmail.com>
Message-ID: <CAL_JsqK--6UE9N2je3mkoxf_0+i5fTYqYpmTF2bpzFf-KRjhaQ@mail.gmail.com>
Subject: Re: [PATCH anybus v4 6/7] dt-bindings: anybuss-host: document
 devicetree binding
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Sven Van Asbroeck <svendev@arcx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Stuart Yoder <stuyoder@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 9:38 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> Rob, thank you so much for the review !
>
> On Mon, Nov 26, 2018 at 5:08 PM Rob Herring <robh@kernel.org> wrote:
>
> > Unit-addresses are based on 'reg'. So this should either be '89' or
> > based on a definition for the bus (e.g. PCI uses dev and func).
> >
> >> +                     reg = <0x0089>;
> >
> > Is fieldbus type how one addresses a device on the bus?
>
> I'm afraid not. Anybus cards don't have an address, because only a single card
> can be connected to an anybus at a time.

Then you don't need reg as you should only have 1 child node.

> Fieldbus type defines the type/functionality of the connected card. Like pci
> device ids.

Which for PCI can be overridden in DT, but is part of reg.

> The current patchset allows devicetree nodes to be provided depending on
> the type of card connected to the bus. It identifies the card by type,
> not location.
>
> Is this not desired / allowed ?

No, 'reg' is how you address a device. You could use 'type' in the
compatible string if type implies some sort of standard class
interface.

> > I'm still not clear what a bridge vs. host is. Both examples are on WEIM
> > bus CS0?
>
> I agree that the terminology is too confusing. I'm looking to change it.
>
> Let's compare current anybus with a well-established bus architecture like pci:
>
>                                 pci                     anybus
> --------------------------------------------------------------------------------
> Common bus code (spec),         pci/pci_driver.c        fieldbus/anybuss-host.c
>   calls bus_register()                                  must be parallel bus
>                                                         subnode
>                                 no of compatible        has of compatible
> --------------------------------------------------------------------------------
> Device on bus, calls
>   XXX_client_driver_register()  hwmon/k8temp.c          fieldbus/hms-profinet.c
> --------------------------------------------------------------------------------
> Controller, silicon driver      pci/pcie-tango.c        fieldbus/anybus-bridge.c
>                                 platform_driver calls   platform_driver does not
>                                 pci_host_probe()        register with anybus
>
> I should probably rework this so it conforms more closely to the way it's done
> on pci. Would the following look any better?

Yes, this looks better.

>                                 pci                     anybus
> --------------------------------------------------------------------------------
> Common bus code (spec),         pci/pci_driver.c        anybus/anybus_driver.c

Maybe just anybus/core.c or anybus/bus.c. I'm guessing your
implementation will be *much* more simple than PCI.

>   calls bus_register()          no of compatible        no of compatible
> --------------------------------------------------------------------------------
> Device on bus, calls
>   XXX_client_driver_register()  hwmon/k8temp.c          fieldbus/hms-profinet.c
> --------------------------------------------------------------------------------
> Controller, silicon driver      pci/pcie-tango.c        anybus/arcx-controller.c
>                                 platform_driver calls   platform_driver calls
>                                 pci_host_probe()        anybus_host_probe()
>
> Of course, the analogy is not perfect, as there can only be a single card
> (device) connected to an anybus at a time.

Right, that should simplify the bus code a lot.

Rob
