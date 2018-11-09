Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA2FC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C634020825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnxR7hbP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C634020825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbeKJCGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:06:38 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35138 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbeKJCGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:06:37 -0500
Received: by mail-ot1-f67.google.com with SMTP id 81so2127921otj.2;
        Fri, 09 Nov 2018 08:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfF83R8kiYCtes9WsD5mhVTfsobu4W8GmVo7P/uUuo4=;
        b=YnxR7hbPboET5Y3M/NuPc/Mty9DEOmlMV7SA1h2Y4/9ISdll3OYV3pQZ4X5lUZ4ZGc
         JczsX+wlxkrVZGcvdC8X8tSqwHJ2loR1r4sF/sXz79UjtmxP/iX6+k3wyZEFgX67Rpu+
         HOXJxDn0/3Snvj5lHxJwdYkhS7B5iHswiJCrIx79Dt7edAkkUUIn2/pKtILpMvKdWjRI
         qS2E3TgOCGO3rv32lWQL6zJSzg+oYAG37Mh9+OfgW1kygMfIyxhVx4jZ8RU1/+I5YaJs
         GfzUwejgywTvVeTzALVIyns+t4hhRM6a7S7G4YdYBO7gGPbax0f0Kj7Ptz2t6CqQbKJ6
         OKRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfF83R8kiYCtes9WsD5mhVTfsobu4W8GmVo7P/uUuo4=;
        b=IySi67jPGuauiTYyFSRl1xUEeZz1PUe7A6sNMaX48zOPTaLrTgz7gxBv05ShFyZTYz
         bnAm9xVqd4ugcCT2K3BJTJw1IdwqZbXkJOW9EDlTe/tp+/jjFSNYnM6y9crNlOlRcpiJ
         TeHBVJ4uAc/pitrMCrzKgC7ROqptEEiVNg0ydqAXZ0n9a7zpNcKyRYM/mO2VKccemm0e
         a9vTt5YG6PmfwxcH8rUo7al2hKBlW3388ekPDdQJXQJVR1cC3IpWAXV6RJ5OrjoG4RMR
         qcDn0nJAqjLvxBhxzNC+w/6FF4iOXsZEZpn4l2+OaKfR5UnegDLCwVJOQRqxHAq8YA2r
         kQAQ==
X-Gm-Message-State: AGRZ1gLa0nqz6cN3pBtV76fjWJRQyQHMVeuVzLn6PUWqvL6lFlTgPdJE
        PzJeuuD4LrOAFfwcY03suBVgsx4Iw1NvnYMUMuA=
X-Google-Smtp-Source: AJdET5dg3puUTZmiHvPSYNGEl0v3VDFGiu22Z2bzxwO/1vS3R/Hg8/RAF03iHHT3X/rnX5mbQb4xY0A3UtsRIOqRR14=
X-Received: by 2002:a9d:41ef:: with SMTP id v44mr5272265oti.95.1541780720918;
 Fri, 09 Nov 2018 08:25:20 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-5-TheSven73@googlemail.com> <CAK8P3a3DnKcRxL5dG_pvBVTngFh5eDL2JdEqZzgL0RXJy5dZGw@mail.gmail.com>
In-Reply-To: <CAK8P3a3DnKcRxL5dG_pvBVTngFh5eDL2JdEqZzgL0RXJy5dZGw@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Fri, 9 Nov 2018 11:25:09 -0500
Message-ID: <CAGngYiWxhSbLLsPaRZ90wEMhhF7e1jt06ZhhRcuhjM53-RYRwg@mail.gmail.com>
Subject: Re: [PATCH anybus v3 4/6] bus: support HMS Anybus-S bus
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        gregkh@linuxfoundation.org, john.garry@huawei.com,
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

On Thu, Nov 8, 2018 at 9:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> > +struct anybus_mbox_hdr {
> > +       u16 id;
> > +       u16 info;
> > +       u16 cmd_num;
> > +       u16 data_size;
> > +       u16 frame_count;
> > +       u16 frame_num;
> > +       u16 offset_high;
> > +       u16 offset_low;
> > +       u16 extended[8];
> > +} __packed;
>
> I don't think you want this to be __packed, it won't change the layout
> but instead force byte accesses on architectures that don't have
> fast unaligned load/store instructions.
>
> Instead of the __packed, it's almost always better to ensure that
> the structure itself is aligned to a 16-bit address.
>

A general question about __packed.

My current understanding is this:
(please tell me if it's incorrect or incomplete)

+ without __packed, the compiler is free to pad the struct in whatever
way it feels is best.
+ with __packed, the fields have to be laid out EXACTLY as specified.

Is it possible that someone will compile this on an architecture that 'likes'
16-bit ints to be 32-bit aligned? If such an architecture does not currently
exist, could it appear in the future?

If the compiler changes the padding in the struct, the driver will
break, as the struct layout is tightly defined by the anybus spec.

Would it be better to stay safe, and keep __packed in case of such
tightly defined structures?
