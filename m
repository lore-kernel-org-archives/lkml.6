Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126DDC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C240021019
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 15:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJUmqI6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C240021019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbeK2CkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 21:40:22 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41534 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeK2CkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 21:40:22 -0500
Received: by mail-ot1-f68.google.com with SMTP id u16so23896456otk.8;
        Wed, 28 Nov 2018 07:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qN6ptfpdkPyoq3L74JMlG53tkBwcJkpoaHzH7FJRjlM=;
        b=MJUmqI6Cd8r51hhexS/0pE2XOKp6dbp16jQAw4eDdta7UedxpAgxip9vwCKqDUE8SR
         VPtHldVisu7bMz2ayfRQ0UJ/i7dVCqoUuUSplduIXNEG+lKn8/JVzSOnkI/syje4lp+j
         HrYP2rCBdXXKybh9Gw6vRQIg26mXibKKDyrcrxcMvglQOL04h+sOZuoc9MTHWRpzXQYm
         /RFpZzDPBX3U5Sum506zfEd1exmM2/fxMgX7OBxw0IlA6JZaomd/hdQkCmdM3m6dKL/8
         VCEFI01CHhJmCsYo1GlNAskiDxz3IoGL4diEuS5+28X1a7h/HPyQdNWw0LItD69lR9b+
         zl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qN6ptfpdkPyoq3L74JMlG53tkBwcJkpoaHzH7FJRjlM=;
        b=SIvYqbwwLQJq81qt9CVqCihzIn7afmrx9qBCYk0ab/jd59vt2DGn3xhbiNFzRzgA9O
         c0P3Pj0wvF6haqOfy7hcpgdn4wISlpHdzFRL+bfsNvX97PJHd76UrkT1/Yf2idVf+LgG
         GIkNrEk6sJ0PSk/FzoVAoFHiM3ghW/ERfJpP0hZIlbUpe1T9F1OOs8bY0vBAT4+QCsqH
         xLlqPCnNpMZVzIeLnyp+9lYlqonH9VitKQhEUz1hVgYI2hvzCaJDnM8h+BHi23nJAoDC
         Znmka51Rq+Y2D+rFZHSwcrUlGdGScVarte1V7QVeVSkSUPxwfOI1yj2lKBw/PziXm0l5
         bfow==
X-Gm-Message-State: AA+aEWbc9yZnuLWSYznFl3FceRlF0Cb/X8ZjVvDB5JJQBJz0hyiBly8w
        yOCOR5XRaZF1I8KkcOt4Hbc+OJ65AHitFSqGQW0=
X-Google-Smtp-Source: AFSGD/VzGp4AWn8aUYGsRr3FuNcOvEdh0p4lTQSHeIZSCNr27Bt9w6CcVqUN23Z8/X+enVx4I/x/FNkcuhNxWXiClK4=
X-Received: by 2002:a9d:74c3:: with SMTP id a3mr22294777otl.107.1543419498113;
 Wed, 28 Nov 2018 07:38:18 -0800 (PST)
MIME-Version: 1.0
References: <20181121150709.6030-1-TheSven73@googlemail.com>
 <20181121150709.6030-7-TheSven73@googlemail.com> <20181126220804.GA23069@bogus>
In-Reply-To: <20181126220804.GA23069@bogus>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 28 Nov 2018 10:38:07 -0500
Message-ID: <CAGngYiWBBe7P80ASQJnS8woe6SKLgNUmqKxOHMeyV1fGSCpY_w@mail.gmail.com>
Subject: Re: [PATCH anybus v4 6/7] dt-bindings: anybuss-host: document
 devicetree binding
To:     Rob Herring <robh@kernel.org>
Cc:     Sven Van Asbroeck <svendev@arcx.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org,
        john.garry@huawei.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob, thank you so much for the review !

On Mon, Nov 26, 2018 at 5:08 PM Rob Herring <robh@kernel.org> wrote:

> Unit-addresses are based on 'reg'. So this should either be '89' or
> based on a definition for the bus (e.g. PCI uses dev and func).
>
>> +                     reg = <0x0089>;
>
> Is fieldbus type how one addresses a device on the bus?

I'm afraid not. Anybus cards don't have an address, because only a single card
can be connected to an anybus at a time.

Fieldbus type defines the type/functionality of the connected card. Like pci
device ids.

The current patchset allows devicetree nodes to be provided depending on
the type of card connected to the bus. It identifies the card by type,
not location.

Is this not desired / allowed ?

> I'm still not clear what a bridge vs. host is. Both examples are on WEIM
> bus CS0?

I agree that the terminology is too confusing. I'm looking to change it.

Let's compare current anybus with a well-established bus architecture like pci:

                                pci                     anybus
--------------------------------------------------------------------------------
Common bus code (spec),         pci/pci_driver.c        fieldbus/anybuss-host.c
  calls bus_register()                                  must be parallel bus
                                                        subnode
                                no of compatible        has of compatible
--------------------------------------------------------------------------------
Device on bus, calls
  XXX_client_driver_register()  hwmon/k8temp.c          fieldbus/hms-profinet.c
--------------------------------------------------------------------------------
Controller, silicon driver      pci/pcie-tango.c        fieldbus/anybus-bridge.c
                                platform_driver calls   platform_driver does not
                                pci_host_probe()        register with anybus

I should probably rework this so it conforms more closely to the way it's done
on pci. Would the following look any better?

                                pci                     anybus
--------------------------------------------------------------------------------
Common bus code (spec),         pci/pci_driver.c        anybus/anybus_driver.c
  calls bus_register()          no of compatible        no of compatible
--------------------------------------------------------------------------------
Device on bus, calls
  XXX_client_driver_register()  hwmon/k8temp.c          fieldbus/hms-profinet.c
--------------------------------------------------------------------------------
Controller, silicon driver      pci/pcie-tango.c        anybus/arcx-controller.c
                                platform_driver calls   platform_driver calls
                                pci_host_probe()        anybus_host_probe()

Of course, the analogy is not perfect, as there can only be a single card
(device) connected to an anybus at a time.
