Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC0AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A7122504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 18:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKVnz3lq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A7122504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbeKMD76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:59:58 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37705 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbeKMD76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 22:59:58 -0500
Received: by mail-ot1-f66.google.com with SMTP id 40so8813551oth.4;
        Mon, 12 Nov 2018 10:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W45tdmnTUMqJa9S+3GFX4jmGWxMPKZsZBREyPZUn6OQ=;
        b=VKVnz3lqAebX8s68kNQwwTdiTQmkhapCtmsVJqRhbgEMIJei1cRjJ05qWRJ/EcesxX
         TLtTzRTHMoyg6PFLjnlJ4xab1DUgFjR5W5t3dxMG8IpeevYVgcNGk6oEkUcfhOBmc7YN
         nFdQjW87UxdIfz6JBQFuoY1FWjSo/gGXdbLZsiFPev4V3/cT3hcoU7gAXlZU/tezJ6ko
         Nn7D2l+DUgxAHoeQ19XWChWzs2GjteIs+rmmv3ehPr35gvnAMdZ0PplMatfMLozoWn3/
         33Nc2Yx335MdlWj82ddjQQ5mw6n9z6F9akdfd6zkKq8T0yu6abMAs6qfikOe5YCz10kL
         +0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W45tdmnTUMqJa9S+3GFX4jmGWxMPKZsZBREyPZUn6OQ=;
        b=Me93jD2aLgFBPGUXfQOdeRsDd/xVFv5TMddzWE9CckmnsEeRyOlF4TpwdsLCNCA/hm
         bwbA/Smmg2c9w5q95UK+lONithLWBbfkLYrrMJ+KDdDMP23A/gRMuFny0ls/o4riR/qP
         ANDmCsVOtxD8vM4HHCMA4RLMSuQOc9pSlk6jGAWFesHFmViFJy5350htdfgtQlNoXOJx
         yXhsWaK+uDwmvAHOGJi2B/EGMXIDVqwsUKP6Z1TyMQmsFGjxoJcvkwz9m0/rEAaN+cbn
         qJWpLQ+oBhzv7MseO9OhXVo+FV2YXv9VYF6oseuASfTr1hgp1tr67H0TFDPCTpmRQexN
         /XWw==
X-Gm-Message-State: AGRZ1gLUP3ICbWB8nhhdGOgqLh2uUPuuKaf6q9I1MYRJTljMKV69LH4K
        uxhFvVu1hfngjauqnNAU7U3JKKJyHy4gSo5CPLQ=
X-Google-Smtp-Source: AJdET5ew5+ooa50hfsd/ftys6+5CGfTgfVgQztSl2V+KrYMhMKE8UmIQKPtAsBMW3/8T2WYdJhHvtEGodtgYYfZ9FA4=
X-Received: by 2002:a9d:2c65:: with SMTP id f92mr1213759otb.18.1542045938038;
 Mon, 12 Nov 2018 10:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-6-TheSven73@googlemail.com> <CAK8P3a1ZUaxJzfzYoqAK+_ZBazHzF6nG1V2aiZSoiQr6nDhiSQ@mail.gmail.com>
 <CAGngYiW5=oc486wq15yLbRLvO243PNALmouTDEh7QpO6GLO9Mg@mail.gmail.com> <CAK8P3a3QvQrOKeUs-9sFjDdzfesK27VP6fH7KVUjMW-gkmq-=Q@mail.gmail.com>
In-Reply-To: <CAK8P3a3QvQrOKeUs-9sFjDdzfesK27VP6fH7KVUjMW-gkmq-=Q@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 12 Nov 2018 13:05:26 -0500
Message-ID: <CAGngYiUzA-GGOyX3+joUvf53zTELjiCU_TFLwaWAFgJXM4VHQQ@mail.gmail.com>
Subject: Re: [PATCH anybus v3 5/6] dt-bindings: anybuss-host: document
 devicetree binding
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

On Thu, Nov 8, 2018 at 9:27 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> We do the same thing on PCI and USB, where normally everything
> is probed through hardware access, but a device driver can look
> at dev->of_node to see if that contains any further properties.
>

This is very interesting. Spent some time trying to find an example of this
for pci/usb, but drew a blank. Could you point me to an example?

One of our products has pcie ethernet, but we have to patch it so it can
grab its mac address from the bootloader. You are saying that there is
a standard way to accomplish this?
