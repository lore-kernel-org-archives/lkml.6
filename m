Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78DBC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7590220892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXP02Z9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7590220892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbeLFSc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 13:32:27 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33249 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbeLFSc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 13:32:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id i20so1377850otl.0;
        Thu, 06 Dec 2018 10:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gh7ZUgbqrm9SKh0ksdnDI4M+/U5pKyJCDXFkPytmxoM=;
        b=bXP02Z9Gb28E8s2oQwdlkV1NSnxuPgDJcJcA0ztO6hK/ntk2OWocyJMFxXJaEUdwZN
         opZYmWQJ1hZOWN+HSQyiXeax50rFsT5E0G4vvhfq3sUqgUtGLcPGDWIVjKCkfA+iGMuz
         aeN1pEi2NEGrOr2AL1wFQPQu+hqKVGFDvVrTXQZH6n3pUceZPItp18WO3gwyUnX6+cRA
         QyxK9kliQ0EgKg9VKYhdL4VFhUOA9o5VGDAshwrUXLDmKPb286Y2UjX5bDZhaBQzsja+
         HCH5v0+f+8PK3fu+WruUOjiv/ugznYs4xpvRDHJRzPOiO/nnhQJBp/A0o+MKArUtFaNC
         8a0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gh7ZUgbqrm9SKh0ksdnDI4M+/U5pKyJCDXFkPytmxoM=;
        b=lyo1/64KjSPQ5NCORy177GZGmB01H9zgKpj+3JZgQEfQ8BaL39L1eZh8R8iaAVqxFq
         Gb9g3hiZdHurfXcMYJNzH+ppfvXwOqh5qgh2M2uW7qH7g2WDMvPwaYcPU3PNWFFsEmb+
         APeSwK7aBmCoxNcugNvmphdV7YDpxvVJd56BLjKgyG6uYnI224GYPCq0EWdbBYtOcdbT
         s3ACkV7iHmkjPZfnzXFoxQiylNsFj/P0KQNZNo95TyNpQ/wMbvu4Dv1GtAQFbquCJzOz
         vvOUrlKp/rhb8jSk4mjh8rRFsy19Str714MH9bzPOahuerKS3/e50P++rj4OErQ1iiAT
         0LIw==
X-Gm-Message-State: AA+aEWb7unCsEGEBc8/egwHHE/3Ck23HjJJucDcZa7q5AeZIWbkfA2vw
        9pvP3aMfgL+b/TqvpedNwOjq4n5qL5llKc8lhTE=
X-Google-Smtp-Source: AFSGD/XAXaOzUlzLzW4Q3pqEbZGvEFfcps3PNFp2YjS1BV70GmcedZD2mvJpC3mKwvXxIlh0MDsHje8pY/uKvQVXinQ=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr17687346oth.279.1544121146030;
 Thu, 06 Dec 2018 10:32:26 -0800 (PST)
MIME-Version: 1.0
References: <20181204220224.27324-1-TheSven73@googlemail.com>
 <20181204220224.27324-2-TheSven73@googlemail.com> <20181205101659.GA27058@kroah.com>
 <CAGngYiXXrrqGxTt339EP53tschLgZ82eRGvGifHQw6pg=C88+Q@mail.gmail.com>
 <20181205191724.GA434@kroah.com> <CAGngYiWG74nDt1_hN0-bKCDRxm-f=N-Rnjtk02Vd7dgKtGRaBA@mail.gmail.com>
 <20181206140750.GB18947@kroah.com>
In-Reply-To: <20181206140750.GB18947@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Thu, 6 Dec 2018 13:32:14 -0500
Message-ID: <CAGngYiWY2hz2uXEEsEQJuF3vhF6w6TnxyzgGk9TXse0=iPmT6A@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] fieldbus_dev: add Fieldbus Device subsystem.
To:     gregkh@linuxfoundation.org
Cc:     Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Dec 6, 2018 at 9:07 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> And as these are really devices, why not make them a "device" and a bus?
> What type of topology do you have on these busses?  Are everything
> "flat" and connected directly to a PCI/USB/platform device?  Or are
> there multiple devices attached to a single controller?
>
> It really feels like you want to use 'struct device' and a bus_type and
> not a class here to me...
>

I don't believe that the bus/device abstraction is appropriate for fieldbus
peripherals. But obviously I'm not a fieldbus or kernel expert, so I keep an
open mind to any elegant solutions I may have missed.

The name FieldBUS is misleading - it's an industrial network, not a bus. The
underlying network technology varies: Profinet runs over Ethernet,
Profibus over RS485. The topology is typical for networks AFAIK.

The actual layout of the raw packets exchanged over the network is proprietary;
fieldbus cards will typically implement this internally, and hide the details.

To the user, a fieldbus card typically exposes shared memory regions.
For example, a robotic arm may store its arm angle at offset 27 of its memory
region. The PC controlling the arm writes a new value to offset 27 in the
memory of its own fieldbus card. The cards then communicate over the network,
the memory in the arm's fieldbus card is updated, and the arm is notified of
the data change by an interrupt.

Like I said, I'm by no means a fieldbus expert. But this 'feels' unlike a
device/bus abstraction. And it also doesn't 'feel' right to make this part
of the network stack. But I keep an open mind.

Sven
