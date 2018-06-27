Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97465C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468B6241C7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K15VMvJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 468B6241C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754825AbeF0QfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:35:06 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36317 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753490AbeF0QfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:35:04 -0400
Received: by mail-ua0-f194.google.com with SMTP id y8-v6so1671722uan.3;
        Wed, 27 Jun 2018 09:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zRM2eK/e14vpHImXXDo3lolH9QLHB9HcoIK7duj7jLA=;
        b=K15VMvJiuc6kDNIX/dFA6D3dcoCNP5t/2E0tEqMxDTZOTcarjtLi+6odavG00YIWt8
         wis7iThJelEwPVHyf9SN/EJd08njrEkuQc1YhqAY1KkKuKEDM1xUc0/KgWRb+mo/ruNF
         K92kHEBSgzkYp7EQCHHCgxFdP3qAJUrE8U5e5V2sUdfauLnru/GgLHkQA5zdZKvJswb2
         O/59YxVM6h9USUOfUqn70OE04Dul55BcWz4L3TkoDxGVLJTuI0qjjVlnTF/rCqXdJUUQ
         1PhAYmgJVMd9QGy8C5yyptAleAPQ2lwmqShqFIUJ2PjwUfWbHpHUfGj3AUSemvILS5wY
         byag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zRM2eK/e14vpHImXXDo3lolH9QLHB9HcoIK7duj7jLA=;
        b=Nnhn1olCtxXMdbE7qeJf6sIFWlkH68Z9O3a8vvKy1QUxW8D6vKPfs3Z7rKmtMvFAkb
         qUFBquBj6vKNzFg8+7X/ZER6ah7Tmhq/sSrWPSQutByVZ+gpPqX85GNhBkjnhWNAhNyP
         Knq359is+nFtd6rITD61uAX0J1X+hDRG4UVjuyhYOLdY3Ot2gs2ASPtuat7MhI7boRaU
         u7mo7ypSKuBOnHyxsUJE873/N8FY8LOg4swc8YmAZj5Fp2g2dLkPrcVHgsCsk71bkkQN
         mcx6xMeSJBUWyJLP/+bKmGCoL65qJAE1pQ5gHrCXaW2jOcrGYxSpMWwRA+ZMh0mn4btl
         6t0w==
X-Gm-Message-State: APt69E1CIIF21YeI5aFMZ6J0WeDh52nPaUE1Vk41Tk9yDY/450oaU4xN
        y612MQUUXf6ht9p5K7s2SkEmVMCePaJxAWGLrlNQhiTF
X-Google-Smtp-Source: AAOMgpfrXxeKZfNU95F2JnEPnBhUP9aBwfQih4e80hYV1TOVOxMLVv6E7adJHO9K4W9pp2ELQ1qcZVezJeDf4LP+OLU=
X-Received: by 2002:ab0:1b9b:: with SMTP id k27-v6mr4274664uai.122.1530117303975;
 Wed, 27 Jun 2018 09:35:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 09:35:03
 -0700 (PDT)
In-Reply-To: <1530091298-28120-2-git-send-email-honghui.zhang@mediatek.com>
References: <1530091298-28120-1-git-send-email-honghui.zhang@mediatek.com> <1530091298-28120-2-git-send-email-honghui.zhang@mediatek.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Jun 2018 19:35:03 +0300
Message-ID: <CAHp75Ve2N_Bt8FvX8xCx3JtQ+ozZE=isfsKp9swY+86Cg-78XQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] PCI: mediatek: fixup mtk_pcie_find_port logical
To:     Honghui Zhang <honghui.zhang@mediatek.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        yingjoe.chen@mediatek.com, Eddie Huang <eddie.huang@mediatek.com>,
        ryder.lee@mediatek.com, hongkun.cao@mediatek.com,
        youlin.pei@mediatek.com, yong.wu@mediatek.com,
        YT Shen <yt.shen@mediatek.com>, sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 12:21 PM,  <honghui.zhang@mediatek.com> wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
>
> Mediatek's host controller have two slots, each have it's own control
> registers. The host driver need to identify which slot was connected
> in order to access the device's configuration space. There's problem
> for current host driver to find out which slot was connected to for
> a given EP device.
>
> Assuming each slot have connect with one EP device as below:
>
>                 host bridge
>   bus 0 --> __________|_______
>            |                  |
>            |                  |
>          slot 0             slot 1
>   bus 1 -->|        bus 2 --> |
>            |                  |
>          EP 0               EP 1
>
> While PCI emulation, system software will scan all the PCI device
> starting from devfn 0. So it will get the proper port for slot0 and
> slot1 device when using PCI_SLOT(devfn) for match. But it will get
> the wrong slot for EP1: The devfn will be start from 0 when scanning
> EP1 behind slot1, it will get port0 since the PCI_SLOT(EP1) is match
> for port0's slot value. So the host driver should not using EP's devfn
> but the slot's devfn(the slot which EP was connected to) for match.
>
> This patch fix the mtk_pcie_find_port's logical by using the slot's
> devfn for match.


> +       list_for_each_entry(port, &pcie->ports, list) {
> +               if (bus->number == 0 && port->slot == PCI_SLOT(devfn)) {
>                         return port;
> +               } else if (bus->number != 0) {

You can do it like (no need 'else')

if (...)
 return ...;
if (bus->number) {
 ...
}

> +                       pbus = bus;
> +                       do {
> +                               dev = pbus->self;
> +                               if (port->slot == PCI_SLOT(dev->devfn))
> +                                       return port;
> +
> +                               pbus = dev->bus;
> +                       } while (dev->bus->number != 0);

This can be rewritten like

pbus = bus;
while (pbus->number) {
 dev = ...;
 ...
 pbus = dev->bus;
}

and no need for if (bus->number) anymore.

> +               }
> +       }
>
>         return NULL;
>  }
> --
> 2.6.4
>



-- 
With Best Regards,
Andy Shevchenko
